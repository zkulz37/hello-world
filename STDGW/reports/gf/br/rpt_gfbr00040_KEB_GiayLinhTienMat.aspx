<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_Seq = Request["Seq"];
    string p_Date = "";
    string p_Month = "";
    string p_Year = "";
    string p_D_Acc_No = "";
    string p_D_Acc_Nm = "";
    string p_D_Add = "";
    string p_D_Bank = "";
    string p_C_Acc_No = "";
    string p_C_Acc_Nm = "";
    string p_C_Add = "";
    string p_C_Bank = "";
    string p_Remark = "";
    string p_So = "";
    
    DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
        p_Date = dt.Rows[0][10].ToString();
        p_Month = dt.Rows[0][16].ToString();
        p_Year = dt.Rows[0][17].ToString();
        p_D_Acc_No = dt.Rows[0][24].ToString();
        //p_D_Acc_No = dt.Rows[0][8].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        //p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        //p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();
        p_So = dt.Rows[0][11].ToString();
    }

    string _str = "";
    char[] _ch = p_C_Acc_No.ToCharArray();
    for (int _j = 0; _j < _ch.Length; _j++)
    {
        _str += _ch[_j] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";
    }
    string _str_Cr = "";
    char[] _ch_Cr = p_C_Acc_No.ToCharArray();
    for (int _k = 0; _k < _ch_Cr.Length; _k++)
    {
        _str_Cr += _ch_Cr[_k] ;
    }
    //Response.Write(_str_Dr[0]);
    //Response.End();
    string p_Amt = "";
    string p_Ccy = "";
    string Inword = "";
    string _str_Amt = "";
    string p_Amt1 = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][11].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][14].ToString();

        string _ch_Amt = p_Amt.ToString();

        int p = _ch_Amt.Length % 3;
        
        if (p > 0)
        {
            _str_Amt = _ch_Amt.Substring(0, p) + "     ";
        }
        
        int z = _ch_Amt.Length / 3;
        int r;
        for (r = 0; r < z; r++)
        {
            _str_Amt = _str_Amt + _ch_Amt.Substring(p, 3) + " ";
            p = p + 3;
            
        }
        //if (p_Ccy == "VND")
        //{
        //    Inword = CommondLib.Num2VNText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        //}
        //else
        //{
            Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        //}
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();
        }
        //Response.Write(p_Amt1);
        //Response.End();
        //p_Ccy = "USD";
        //p_Amt1 = "123456789012.00";
        //p_D_Acc_No = "3456789012";
        //Response.Write(p_Amt1[p_Amt1.Length - 11]);
        //Response.End();
    }
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="KEB_RFW_files/filelist.xml">
<link rel=Edit-Time-Data href="KEB_RFW_files/editdata.mso">
<link rel=OLE-Object-Data href="KEB_RFW_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>KENZIE</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2012-01-18T06:25:20Z</o:LastPrinted>
  <o:Created>2012-01-16T10:21:46Z</o:Created>
  <o:LastSaved>2012-01-18T06:54:40Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.38in .57in .51in .69in;
	mso-header-margin:.4in;
	mso-footer-margin:.5in;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font10
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
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
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl26
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:15.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:top;}
.xl36
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	vertical-align:top;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;}
.xl41
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl42
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl43
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid black;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-diagonal-down:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-diagonal-down:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl60
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;}
.xl61
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl62
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl63
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl64
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl66
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl68
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;}
.xl69
	{mso-style-parent:style0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl70
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid black;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl72
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl74
	{mso-style-parent:style0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl75
	{mso-style-parent:style0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl76
	{mso-style-parent:style0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
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
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
     
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>65</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>5</x:ActiveRow>
       <x:ActiveCol>17</x:ActiveCol>
       <x:RangeSelection>$R$6:$U$15</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>15315</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1042"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=980 style='border-collapse:
 collapse;table-layout:fixed;width:736pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=23 span=14 style='mso-width-source:userset;mso-width-alt:
 841;width:17pt'>
 <col class=xl24 width=54 span=8 style='mso-width-source:userset;mso-width-alt:
 1974;width:41pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 width=79 style='height:12.75pt;width:59pt'></td>
  <td class=xl24 width=50 style='width:38pt'></td>
  <td class=xl24 width=76 style='width:57pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=23 style='width:17pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td class=xl24 width=54 style='width:41pt'></td>
  <td colspan=2 class=xl40 width=108 style='width:82pt'>Bank copy</td>
  <td class=xl24 width=21 style='width:16pt'></td>
 </tr>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=25 height=36 class=xl41 style='height:27.0pt'>REQUEST FOR
  WITHDRAWAL / GIẤY LĨNH TIỀN MẶT</td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td colspan=22 height=29 class=xl42 style='height:21.75pt'>Please withdraw
  following amount from my / our account with you<font class="font7"> /</font><font
  class="font8"> (Hãy rút số tiền như sau từ tài khoản của tôi / chúng tôi tại
  Ngân Hàng)</font></td>
  <td class=xl26>Date / <font class="font10">N</font><span style='display:none'><font
  class="font10">gày:</font><font class="font9">&nbsp;<%=p_Date%></font></span></td>
  <td colspan=2 height=29 class=xl24 width=108 style='mso-ignore:colspan-rowspan;
  height:21.75pt;width:82pt'><!--[if gte vml 1]><v:line id="_x0000_s1025"
   style='position:absolute;z-index:1' from="12.75pt,15.75pt" to="75pt,15.75pt"
   strokecolor="windowText [64]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=16 height=20></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=85 height=2 src="KEB_RFW_files/image001.gif" v:shapes="_x0000_s1025"></td>
    <td width=7></td>
   </tr>
   <tr>
    <td height=7></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:81.0pt;height:21.75pt'></span><![endif]--></td>
  <td class=xl24></td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.95pt'>
  <td height=53 class=xl27 width=79 style='height:39.95pt;width:59pt'>Account
  No.<br>
    <font class="font11">Số tài khoản</font></td>
  <td colspan=16 class=xl44 width=448 style='border-right:.5pt solid black;
  border-left:none;width:333pt'><%=p_D_Acc_No %></td>
  <td colspan=2 class=xl47 width=108 style='border-right:.5pt solid black;
  border-left:none;width:82pt'>Serect No.<br>
    Số mã khóa</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td colspan=2 class=xl49 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=66 style='mso-height-source:userset;height:50.1pt'>
  <td rowspan=2 height=84 class=xl51 width=79 style='border-bottom:.5pt solid black;
  height:63.6pt;width:59pt'>Name<br>
    <font class="font11">Tên</font></td>
  <td colspan=16 rowspan=2 class=xl53 width=448 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:333pt'><%=p_D_Acc_Nm %></td>
  <td colspan=4 class=xl47 width=216 style='border-right:.5pt solid black;
  border-left:none;width:164pt'>Signature<br>
    <font class="font11">Chữ ký</font></td>
  <td colspan=4 class=xl47 width=216 style='border-right:.5pt solid black;
  border-left:none;width:164pt'>Seal<br>
    <font class="font11">Dấu</font></td>
  <td class=xl24></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td colspan=4 rowspan=10 height=213 class=xl59 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;height:159.75pt'>&nbsp;</td>
  <td colspan=4 rowspan=10 class=xl63 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td rowspan=2 height=49 class=xl70 width=79 style='height:36.75pt;border-top:
  none;width:59pt'>Amount<br>
    <font class="font11">Số tiền</font></td>
  <td class=xl24></td>
  <td class=xl28 width=76 style='width:57pt'>In Figures<br>
    <font class="font11">Bằng số</font></td>
    <%if (p_Ccy == "VND")
      { %>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 12){%><%=p_Amt1[p_Amt1.Length - 12]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 11){%><%=p_Amt1[p_Amt1.Length - 11]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 10){%><%=p_Amt1[p_Amt1.Length - 10]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 9){%><%=p_Amt1[p_Amt1.Length - 9]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 8){%><%=p_Amt1[p_Amt1.Length - 8]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 7){%><%=p_Amt1[p_Amt1.Length - 7]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 6){%><%=p_Amt1[p_Amt1.Length - 6]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 5){%><%=p_Amt1[p_Amt1.Length - 5]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 4){%><%=p_Amt1[p_Amt1.Length - 4]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 3){%><%=p_Amt1[p_Amt1.Length - 3]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 2){%><%=p_Amt1[p_Amt1.Length - 2]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >= 1){%><%=p_Amt1[p_Amt1.Length - 1]%><%}%></td>
  <td class=xl32 x:num>0</td>
  <td class=xl32 x:num>0</td>
  <%}
      else
      { %>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=15 ){%><%=p_Amt1[p_Amt1.Length - 15]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=14 ){%><%=p_Amt1[p_Amt1.Length - 14]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=13 ){%><%=p_Amt1[p_Amt1.Length - 13]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=12 ){%><%=p_Amt1[p_Amt1.Length - 12]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=11 ){%><%=p_Amt1[p_Amt1.Length - 11]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=10 ){%><%=p_Amt1[p_Amt1.Length - 10]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=9 ){%><%=p_Amt1[p_Amt1.Length - 9]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=8 ){%><%=p_Amt1[p_Amt1.Length - 8]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=7 ){%><%=p_Amt1[p_Amt1.Length - 7]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=6 ){%><%=p_Amt1[p_Amt1.Length - 6]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=5 ){%><%=p_Amt1[p_Amt1.Length - 5]%><%}%></td>
  <td rowspan=2 class=xl71 style='border-bottom:.5pt solid black;border-top:  none' x:num><%if(p_Amt1.Length >=4 ){%><%=p_Amt1[p_Amt1.Length - 4]%><%}%></td>
  <td class=xl32 x:num><%if(p_Amt1.Length >=2 ){%><%=p_Amt1[p_Amt1.Length - 2]%><%}%></td>
  <td class=xl32 x:num><%if(p_Amt1.Length >=1 ){%><%=p_Amt1[p_Amt1.Length - 1]%><%}%></td>
  <%} %>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl31></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl34 style='height:21.75pt'>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;
   margin-left:15.75pt;margin-top:2.25pt;width:3pt;height:4.5pt;z-index:2'>
   <v:imagedata src="KEB_RFW_files/image002.png" o:title="Untitled"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:21px;margin-top:3px;width:4px;
  height:6px'><img width=4 height=6 src="KEB_RFW_files/image003.gif" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=29 class=xl35 width=23 style='height:21.75pt;width:17pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 height=29 class=xl24 width=46 style='mso-ignore:colspan-rowspan;
  height:21.75pt;width:34pt'><!--[if gte vml 1]><v:shape id="_x0000_s1027"
   type="#_x0000_t75" style='position:absolute;margin-left:16.5pt;margin-top:2.25pt;
   width:3pt;height:4.5pt;z-index:3'>
   <v:imagedata src="KEB_RFW_files/image002.png" o:title="Untitled"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=22 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=4 height=6 src="KEB_RFW_files/image003.gif" v:shapes="_x0000_s1027"></td>
    <td width=20></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:34.5pt;height:21.75pt'></span><![endif]--></td>
  <td class=xl24></td>
  <td colspan=2 height=29 class=xl24 width=46 style='mso-ignore:colspan-rowspan;
  height:21.75pt;width:34pt'><!--[if gte vml 1]><v:shape id="_x0000_s1028"
   type="#_x0000_t75" style='position:absolute;margin-left:15.75pt;
   margin-top:2.25pt;width:3pt;height:4.5pt;z-index:4'>
   <v:imagedata src="KEB_RFW_files/image002.png" o:title="Untitled"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=21 height=3></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=4 height=6 src="KEB_RFW_files/image003.gif" v:shapes="_x0000_s1028"></td>
    <td width=21></td>
   </tr>
   <tr>
    <td height=20></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:34.5pt;height:21.75pt'></span><![endif]--></td>
  <td class=xl24></td>
  <td colspan=2 height=29 class=xl24 width=46 style='mso-ignore:colspan-rowspan;
  height:21.75pt;width:34pt'><!--[if gte vml 1]><v:shape id="_x0000_s1041"
   type="#_x0000_t75" style='position:absolute;margin-left:16.5pt;margin-top:1.5pt;
   width:3.75pt;height:3.75pt;z-index:14'>
   <v:imagedata src="KEB_RFW_files/image004.jpg" o:title="led"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=22 height=2></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=5 height=5 src="KEB_RFW_files/image005.jpg" v:shapes="_x0000_s1041"></td>
    <td width=19></td>
   </tr>
   <tr>
    <td height=22></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:34.5pt;height:21.75pt'></span><![endif]--></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl34 style='height:18.0pt'>&nbsp;</td>
  <td class=xl24></td>
  <td rowspan=2 height=41 width=76 style='height:30.75pt;width:57pt'
  align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1030" style='position:absolute;
   flip:y;z-index:5' from="57pt,30pt" to="298.5pt,30pt" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:5;margin-left:75px;
  margin-top:39px;width:324px;height:2px'><img width=324 height=2
  src="KEB_RFW_files/image006.gif" v:shapes="_x0000_s1030"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=2 height=41 class=xl28 width=76 style='height:30.75pt;
    width:57pt'>In Words<br>
        <font class="font11">Bằng chữ</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=13 class=xl37 style='mso-ignore:colspan'></td>
  <td class=xl38 width=23 style='width:17pt'>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt'>&nbsp;</td>
  <td class=xl24></td>
  <td colspan=14 rowspan=3 class=xl73 width=322 style='border-right:.5pt solid black;
  width:238pt'><%=Inword %></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt'>&nbsp;</td>
  <td class=xl24></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1031"
   style='position:absolute;z-index:6' from="57pt,12pt" to="297.75pt,12pt"
   strokecolor="windowText [64]" strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:6;margin-left:75px;
  margin-top:15px;width:323px;height:2px'><img width=323 height=2
  src="KEB_RFW_files/image007.gif" v:shapes="_x0000_s1031"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=17 class=xl24 width=76 style='height:12.75pt;width:57pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
 </tr>
 <tr height=5 style='mso-height-source:userset;height:3.75pt'>
  <td height=5 class=xl34 style='height:3.75pt'>&nbsp;</td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl34 style='height:12.75pt'>&nbsp;</td>
  <td colspan=15 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl39 style='height:27.75pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=17 rowspan=4 height=233 class=xl77 width=527 style='border-right:
  .5pt solid black;border-bottom:.5pt solid black;height:174.75pt;width:392pt'>Remarks:<span
  style='mso-spacerun:yes'>  </span><font class="font9"><%=p_Remark %></font></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 style='height:18.0pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="_x0000_s1034" style='position:absolute;margin-left:22.5pt;margin-top:18pt;
   width:100.5pt;height:24.75pt;z-index:9;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:5.625pt'><font class="font0">Prepared</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1036" style='position:absolute;margin-left:123pt;
   margin-top:18pt;width:100.5pt;height:24.75pt;z-index:10;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:5.625pt'><font class="font0">Checked</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1037" style='position:absolute;margin-left:223.5pt;
   margin-top:18pt;width:100.5pt;height:24.75pt;z-index:11;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:5.625pt'><font class="font0">Approved</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1038" style='position:absolute;margin-left:22.5pt;
   margin-top:42.75pt;width:100.5pt;height:108pt;z-index:12' fillcolor="window [65]"
   strokecolor="windowText [64]" o:insetmode="auto"/><v:rect id="_x0000_s1039"
   style='position:absolute;margin-left:123pt;margin-top:42.75pt;width:100.5pt;
   height:108pt;z-index:13' fillcolor="window [65]" strokecolor="windowText [64]"
   o:insetmode="auto"/><v:line id="_x0000_s1033" style='position:absolute;
   z-index:8' from="260.25pt,174.75pt" to="309.75pt,174.75pt" strokecolor="windowText [64]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:9;margin-left:29px;margin-top:23px;width:404px;
  height:211px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=317></td>
    <td width=68></td>
    <td width=19></td>
   </tr>
   <tr>
    <td height=179></td>
    <td colspan=3 align=left valign=top><img width=404 height=179
    src="KEB_RFW_files/image008.gif" v:shapes="_x0000_s1034 _x0000_s1036 _x0000_s1037 _x0000_s1038 _x0000_s1039"></td>
   </tr>
   <tr>
    <td height=30></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=68 height=2
    src="KEB_RFW_files/image009.gif" v:shapes="_x0000_s1033"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=24 class=xl24 width=54 style='height:18.0pt;width:41pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl36>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td height=33 colspan=2 class=xl24 style='height:24.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl31></td>
  <td colspan=2 class=xl31></td>
  <td colspan=2 class=xl31 style='border-right:.5pt solid black'></td>
  <td class=xl24></td>
 </tr>
 <tr height=144 style='mso-height-source:userset;height:108.0pt'>
  <td height=144 class=xl25 style='height:108.0pt'>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl25>&nbsp;</td>
  <td class=xl29>&nbsp;</td>
  <td class=xl24></td>
 </tr>
 <tr height=48 style='mso-height-source:userset;height:36.0pt'>
  <td height=48 style='height:36.0pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="Picture_x0020_1" o:spid="_x0000_s1032" type="#_x0000_t75" alt="CI"
   style='position:absolute;margin-left:2.25pt;margin-top:1.5pt;width:81.75pt;
   height:52.5pt;z-index:7;visibility:visible'>
   <v:imagedata src="KEB_RFW_files/image010.png" o:title="CI"/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:7;margin-left:3px;margin-top:2px;width:109px;
  height:70px'><img width=109 height=70 src="KEB_RFW_files/image011.jpg"
  alt=CI v:shapes="Picture_x0020_1"></span><![endif]><span style='mso-ignore:
  vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=48 class=xl24 width=79 style='height:36.0pt;width:59pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=19 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl75 width=162 style='width:123pt'
  x:str="DP - ASL002 (1/2)        ">DP - ASL002 (1/2)<span
  style='mso-spacerun:yes'>        </span></td>
  <td colspan=2 class=xl76 width=108 style='width:82pt'>(<span
  style='mso-spacerun:yes'>  </span>AUG.24',99 )<br>
    210 X 125</td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=26 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=26 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=79 style='width:59pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=21 style='width:16pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
