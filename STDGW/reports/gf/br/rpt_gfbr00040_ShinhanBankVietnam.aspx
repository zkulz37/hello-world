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
    string p_Phone = "";
    DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
        p_Date = dt.Rows[0][15].ToString();
        p_Month = dt.Rows[0][16].ToString();
        p_Year = dt.Rows[0][17].ToString();
        p_D_Acc_No = dt.Rows[0][24].ToString();
        //p_D_Acc_No = dt.Rows[0][8].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        //p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();
        p_So = dt.Rows[0][11].ToString();
        p_Phone = dt.Rows[0][23].ToString();
		
	p_D_Acc_No = p_D_Acc_No.Replace("-","");
	p_D_Acc_No = p_D_Acc_No.Replace(".","");
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
    string p_Amt1 = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][13].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][14].ToString();

        
        
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
<link rel=File-List href="SBV_files/filelist.xml">
<link rel=Edit-Time-Data href="SBV_files/editdata.mso">
<link rel=OLE-Object-Data href="SBV_files/oledata.mso">
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
  <o:LastPrinted>2012-01-19T04:10:47Z</o:LastPrinted>
  <o:Created>2012-01-18T08:27:42Z</o:Created>
  <o:LastSaved>2012-01-19T04:17:16Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:0in .18in .35in .38in;
	mso-header-margin:0in;
	mso-footer-margin:.36in;}
.font0
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Arial;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.font6
	{color:#333399;
	font-size:22.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font7
	{color:#333399;
	font-size:10.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font8
	{color:#333399;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:#333399;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:#333399;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:#333399;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:#333399;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:#333399;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;}
.font15
	{color:#333399;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font16
	{color:#333399;
	font-size:24.0pt;
	font-weight:400;
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
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl27
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:none;}
.xl28
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid navy;}
.xl29
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:none;}
.xl30
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;}
.xl31
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:none;}
.xl32
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:.5pt solid navy;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:.5pt solid navy;
	border-bottom:.5pt solid navy;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;}
.xl36
	{mso-style-parent:style0;
	color:#333399;
	font-size:22.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl37
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid navy;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:none;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid navy;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid navy;
	border-bottom:.5pt solid navy;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:none;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid navy;
	border-right:.5pt solid navy;
	border-bottom:.5pt solid navy;
	border-left:none;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;}
.xl52
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl53
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid navy;}
.xl54
	{mso-style-parent:style0;
	color:#333399;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;}
.xl55
	{mso-style-parent:style0;
	color:#333399;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:none;}
.xl56
	{mso-style-parent:style0;
	color:#333399;
	font-size:16.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl57
	{mso-style-parent:style0;
	color:#333399;
	font-size:16.0pt;
	font-family:Wingdings;
	mso-generic-font-family:auto;
	mso-font-charset:2;
	text-align:right;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:.5pt solid navy;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	color:#333399;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl60
	{mso-style-parent:style0;
	color:#333399;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	white-space:normal;}
.xl61
	{mso-style-parent:style0;
	color:#333399;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl62
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;
	white-space:normal;}
.xl63
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:none;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid navy;
	border-right:.5pt solid navy;
	border-bottom:.5pt solid navy;
	border-left:none;
	white-space:normal;}
.xl65
	{mso-style-parent:style0;
	color:#333399;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl66
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:.5pt solid #333399;
	border-bottom:.5pt solid #333399;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid #333399;}
.xl69
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:Scientific;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid #333399;
	border-right:none;
	border-bottom:.5pt solid #333399;
	border-left:.5pt solid #333399;}
.xl70
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:top;
	border-top:.5pt solid navy;
	border-right:.5pt solid navy;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl72
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:.5pt solid navy;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl73
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:none;
	border-bottom:.5pt solid navy;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	color:#333399;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid navy;
	border-right:.5pt solid navy;
	border-bottom:.5pt solid navy;
	border-left:none;
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
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
     
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>78</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
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
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=957 style='border-collapse:
 collapse;table-layout:fixed;width:718pt'>
 <col class=xl24 width=64 span=5 style='width:48pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=64 span=4 style='width:48pt'>
 <col class=xl24 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=16 style='mso-width-source:userset;mso-width-alt:585;
 width:12pt'>
 <col class=xl24 width=1 style='mso-width-source:userset;mso-width-alt:36;
 width:1pt'>
 <col class=xl24 width=0 style='display:none;mso-width-source:userset;
 mso-width-alt:438'>
 <col class=xl24 width=64 style='width:48pt'>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=9 height=36 width=583 style='height:27.0pt;width:437pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
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
  </v:shapetype><v:shape id="_x0000_s1067" type="#_x0000_t75" style='position:absolute;
   margin-left:13.5pt;margin-top:2.25pt;width:27pt;height:26.25pt;z-index:35'>
   <v:imagedata src="SBV_files/image001.gif" o:title="20111201055919_viipipdotcom_1185shinhan_bank_logo_2792"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:35;margin-left:18px;margin-top:3px;width:36px;
  height:35px'><img width=36 height=35 src="SBV_files/image002.jpg" v:shapes="_x0000_s1067"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=9 height=36 class=xl36 width=583 style='height:27.0pt;
    width:437pt'><span style='mso-spacerun:yes'>        </span><font
    class="font16">S</font><font class="font15">HINHAN </font><font
    class="font16">B</font><font class="font15">ANK</font><font class="font6"> </font><font
    class="font13">VIETNAM</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl61 width=64 style='width:48pt'>Mở/Open:</td>
  <td width=21 style='width:16pt' align=left valign=top><!--[if gte vml 1]><v:rect
   id="_x0000_s1025" style='position:absolute;margin-left:.75pt;margin-top:1.5pt;
   width:15pt;height:11.25pt;z-index:1' fillcolor="window [65]" strokecolor="#339 [62]"
   o:insetmode="auto"/><v:rect id="_x0000_s1026" style='position:absolute;
   margin-left:.75pt;margin-top:15pt;width:15pt;height:11.25pt;z-index:2'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:1;margin-left:0px;
  margin-top:1px;width:22px;height:35px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=22></td>
   </tr>
   <tr>
    <td height=17></td>
    <td align=left valign=top><img width=22 height=17
    src="SBV_files/image003.gif" v:shapes="_x0000_s1025"></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
   <tr>
    <td height=17></td>
    <td align=left valign=top><img width=22 height=17
    src="SBV_files/image003.gif" v:shapes="_x0000_s1026"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=36 class=xl24 width=21 style='height:27.0pt;width:16pt'></td>
   </tr>
  </table>
  </span></td>
  <td colspan=4 class=xl60 width=208 style='width:156pt'><span
  style='mso-spacerun:yes'> </span>TGCKH/<font class="font10">Time
  Deposit<br>
    <span style='mso-spacerun:yes'> </span></font><font class="font9">TKCKH/</font><font
  class="font10">Time Savings</font></td>
  <td class=xl24 width=16 style='width:12pt'></td>
  <td class=xl24 width=1 style='width:1pt'></td>
  <td class=xl24 width=0></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=10 class=xl24 style='height:14.1pt;mso-ignore:colspan'></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1028"
   style='position:absolute;margin-left:.75pt;margin-top:2.25pt;width:15pt;
   height:11.25pt;z-index:3' fillcolor="window [65]" strokecolor="#339 [62]"
   o:insetmode="auto"/><v:rect id="_x0000_s1030" style='position:absolute;
   margin-left:.75pt;margin-top:15.75pt;width:15pt;height:11.25pt;z-index:4'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto"/><v:rect
   id="_x0000_s1031" style='position:absolute;margin-left:.75pt;margin-top:29.25pt;
   width:15pt;height:11.25pt;z-index:5' fillcolor="window [65]" strokecolor="#339 [62]"
   o:insetmode="auto"/><v:rect id="_x0000_s1059" style='position:absolute;
   margin-left:.75pt;margin-top:42.75pt;width:15pt;height:11.25pt;z-index:27'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout;position:absolute;z-index:3;margin-left:0px;
  margin-top:2px;width:22px;height:71px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=22></td>
   </tr>
   <tr>
    <td height=17></td>
    <td align=left valign=top><img width=22 height=17
    src="SBV_files/image003.gif" v:shapes="_x0000_s1028"></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
   <tr>
    <td height=17></td>
    <td align=left valign=top><img width=22 height=17
    src="SBV_files/image003.gif" v:shapes="_x0000_s1030"></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
   <tr>
    <td height=17></td>
    <td align=left valign=top><img width=22 height=17
    src="SBV_files/image003.gif" v:shapes="_x0000_s1031"></td>
   </tr>
   <tr>
    <td height=1></td>
   </tr>
   <tr>
    <td height=17></td>
    <td align=left valign=top><img width=22 height=17
    src="SBV_files/image003.gif" v:shapes="_x0000_s1059"></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=18 class=xl24 width=21 style='height:14.1pt;width:16pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl61 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>TGTL/<font class="font10">Installment
  Deposit</font></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=11 class=xl24 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl61 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>TKTL/<font class="font10">Installment
  Saving</font></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=11 class=xl24 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl61 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>TKTLLH/<font class="font10">Flexi
  Installment</font></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:14.1pt'>
  <td height=18 colspan=11 class=xl24 style='height:14.1pt;mso-ignore:colspan'></td>
  <td class=xl61 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>TKKKH/<font class="font10">Demand Savings</font></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=10 class=xl24 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl24 colspan=5 style='mso-ignore:colspan'>Ngày/Date:….<%=p_Date %>…./…<%=p_Month %>…./….<%=p_Year %>….</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:22.5pt'>
  <td colspan=2 rowspan=2 height=44 class=xl38 width=128 style='border-bottom:
  .5pt solid navy;height:33.0pt;width:96pt'>Tên tài khoản/<br>
    Account Name</td>
  <td colspan=4 rowspan=2 class=xl70 width=263 style='border-right:.5pt solid navy;
  border-bottom:.5pt solid navy;width:197pt'><%=p_D_Acc_Nm %></td>
  <td class=xl53 colspan=2 style='mso-ignore:colspan'>Loại tiền/ <font
  class="font8">Currency</font></td>
  <td class=xl56 colspan=7 style='mso-ignore:colspan'><%if (p_Ccy == "VND")
                                                        { %>þ<%}
                                                        else
                                                        { %>¨<%} %><font class="font7">VND<span
  style='mso-spacerun:yes'>         </span></font><font class="font14"><%if (p_Ccy == "USD")
                                                                         { %>þ<%}
                                                                         else
                                                                         { %>¨<%} %></font><font
  class="font7">USD</font><span style='display:none'><font class="font7"><span
  style='mso-spacerun:yes'>         </span></font><font class="font14"><%if (p_Ccy != "USD" && p_Ccy != "VND")
                                                                         {%>þ<%}
                                                                         else
                                                                         { %>¨<%} %></font><font
  class="font7">Khác/ Other ........…<span
  style='mso-spacerun:yes'>       </span></font></span></td>
  <td class=xl58>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Số
  tiền/ <font class="font8">Amount:</font></td>
  <td class=xl68><%=p_Ccy %></td>
  <td colspan=7 class=xl69 style='border-right:.5pt solid #333399;border-left:
  none'><%=p_Amt %></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Điện
  thoại/ <font class="font8">Tel:</font></td>
  <td class=xl33 colspan=2 style='mso-ignore:colspan'><%=p_Phone %></td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1035"
   style='position:absolute;z-index:6' from="53.25pt,15pt" to="429pt,15pt"
   coordsize="21600,21600" strokecolor="#339 [62]" o:insetmode="auto">
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     6, 0, 9, 0, 15, 63, 9, 0</x:Anchor>
   </x:ClientData>
  </v:line><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:6;margin-left:70px;margin-top:19px;width:503px;height:2px'><img
  width=503 height=2 src="SBV_files/image004.gif" v:shapes="_x0000_s1035"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl33 width=71 style='height:15.0pt;border-top:none;
    width:53pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td colspan=10 rowspan=2 class=xl42 width=501 style='border-right:.5pt solid navy;
  border-bottom:.5pt solid navy;width:376pt'>Số tiền bằng chữ/ <font
  class="font8">Amount in words: </font><font class="font7"><%=Inword %></font></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=6 height=20 class=xl72 style='border-right:.5pt solid navy;
  height:15.0pt'>Địa chỉ/ <font class="font8">Address: </font><font
  class="font7"><%=p_D_Add %></font></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 colspan=3 style='height:15.0pt;mso-ignore:colspan'>CMND/HC/<font
  class="font8">ID/Passport:</font></td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none'>&nbsp;</td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'>Phương thức nộp tiền/ <font
  class="font8">Deposit Method:</font></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl35 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Ngày
  cấp/ <font class="font8">Issued date:</font></td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none'>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1036"
   style='position:absolute;margin-left:6pt;margin-top:1.5pt;width:14.25pt;
   height:12pt;z-index:7' fillcolor="window [65]" strokecolor="#339 [62]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:7;margin-left:7px;margin-top:1px;width:21px;
  height:18px'><img width=21 height=18 src="SBV_files/image005.gif" v:shapes="_x0000_s1036"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl24 width=64 style='height:15.0pt;width:48pt'><span
    style='mso-spacerun:yes'>          </span>Tiền mặt/ <font class="font8">Cash</font></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24></td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1037"
   style='position:absolute;margin-left:44.25pt;margin-top:1.5pt;width:14.25pt;
   height:12pt;z-index:8' fillcolor="window [65]" strokecolor="#339 [62]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:8;margin-left:58px;margin-top:1px;width:21px;
  height:18px'><img width=21 height=18 src="SBV_files/image005.gif" v:shapes="_x0000_s1037"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl24 width=64 style='height:15.0pt;width:48pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 colspan=6 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>        </span>Từ tài khoản số/ <font class="font8">Transfer
  from AC no.:</font></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl35 colspan=2 style='height:19.5pt;mso-ignore:colspan'>Nơi
  cấp/ <font class="font8">Issued place:</font></td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td colspan=4 height=26 class=xl31 width=213 style='mso-ignore:colspan-rowspan;
  height:19.5pt;width:160pt'><!--[if gte vml 1]><v:rect id="_x0000_s1038"
   style='position:absolute;margin-left:45pt;margin-top:1.5pt;width:18pt;
   height:15.75pt;z-index:9;mso-wrap-style:tight' fillcolor="window [65]"
   strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=12){%><%=p_D_Acc_No[p_D_Acc_No.Length - 12]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1039" style='position:absolute;margin-left:63pt;
   margin-top:1.5pt;width:18pt;height:15.75pt;z-index:10;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=11){%><%=p_D_Acc_No[p_D_Acc_No.Length - 11]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1040" style='position:absolute;margin-left:81pt;
   margin-top:1.5pt;width:18pt;height:15.75pt;z-index:11;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=10){%><%=p_D_Acc_No[p_D_Acc_No.Length - 10]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1042" style='position:absolute;margin-left:109.5pt;
   margin-top:1.5pt;width:14.25pt;height:15.75pt;z-index:13;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=9){%><%=p_D_Acc_No[p_D_Acc_No.Length - 9]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1043" style='position:absolute;margin-left:123.75pt;
   margin-top:1.5pt;width:16.5pt;height:15.75pt;z-index:14;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=8){%><%=p_D_Acc_No[p_D_Acc_No.Length - 8]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1044" style='position:absolute;margin-left:140.25pt;
   margin-top:1.5pt;width:18pt;height:15.75pt;z-index:15;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=7){%><%=p_D_Acc_No[p_D_Acc_No.Length - 7]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:line id="_x0000_s1041" style='position:absolute;z-index:12'
   from="102.75pt,9pt" to="105pt,9pt" coordsize="21600,21600" strokecolor="windowText [64]"
   strokeweight="1pt" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=59 height=1></td>
    <td width=74></td>
    <td width=3></td>
    <td width=5></td>
    <td width=4></td>
    <td width=67></td>
    <td width=1></td>
   </tr>
   <tr>
    <td height=10></td>
    <td rowspan=3 align=left valign=top><img width=74 height=23
    src="SBV_files/image006.gif" v:shapes="_x0000_s1038 _x0000_s1039 _x0000_s1040"></td>
    <td colspan=3></td>
    <td rowspan=3 align=left valign=top><img width=67 height=23
    src="SBV_files/image007.gif" v:shapes="_x0000_s1042 _x0000_s1043 _x0000_s1044"></td>
   </tr>
   <tr>
    <td height=2></td>
    <td></td>
    <td align=left valign=top><img width=5 height=2 src="SBV_files/image008.gif"
    v:shapes="_x0000_s1041"></td>
   </tr>
   <tr>
    <td height=11></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:159.75pt;height:19.5pt'></span><![endif]--></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1045"
   style='position:absolute;z-index:16' from="2.25pt,9.75pt" to="4.5pt,9.75pt"
   coordsize="21600,21600" strokecolor="windowText [64]" strokeweight="1pt"
   o:insetmode="auto"/><v:rect id="_x0000_s1046" style='position:absolute;
   margin-left:9pt;margin-top:1.5pt;width:18pt;height:15.75pt;z-index:17;
   mso-wrap-style:tight' fillcolor="window [65]" strokecolor="#339 [62]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=6){%><%=p_D_Acc_No[p_D_Acc_No.Length - 6]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1047" style='position:absolute;margin-left:27pt;
   margin-top:1.5pt;width:18pt;height:15.75pt;z-index:18;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=5){%><%=p_D_Acc_No[p_D_Acc_No.Length - 5]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1048" style='position:absolute;margin-left:45pt;
   margin-top:1.5pt;width:18pt;height:15.75pt;z-index:19;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=4){%><%=p_D_Acc_No[p_D_Acc_No.Length - 4]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1049" style='position:absolute;margin-left:63pt;
   margin-top:1.5pt;width:18pt;height:15.75pt;z-index:20;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=3){%><%=p_D_Acc_No[p_D_Acc_No.Length - 3]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1050" style='position:absolute;margin-left:81pt;
   margin-top:1.5pt;width:18pt;height:15.75pt;z-index:21;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=2){%><%=p_D_Acc_No[p_D_Acc_No.Length - 2]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><v:rect id="_x0000_s1051" style='position:absolute;margin-left:99pt;
   margin-top:1.5pt;width:18pt;height:15.75pt;z-index:22;mso-wrap-style:tight'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center;padding-top:1.125pt'><font class="font0"><%if(p_D_Acc_No.Length >=1){%><%=p_D_Acc_No[p_D_Acc_No.Length - 1]%><%}%></font></div>
   </v:textbox>
   <x:ClientData ObjectType="Rect">
    <x:TextHAlign>Center</x:TextHAlign>
    <x:TextVAlign>Center</x:TextVAlign>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout;position:
  absolute;z-index:16;margin-left:2px;margin-top:1px;width:155px;height:23px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=5></td>
    <td width=4></td>
    <td width=146></td>
   </tr>
   <tr>
    <td height=11></td>
    <td colspan=2></td>
    <td rowspan=3 align=left valign=top><img width=146 height=23
    src="SBV_files/image009.gif" v:shapes="_x0000_s1046 _x0000_s1047 _x0000_s1048 _x0000_s1049 _x0000_s1050 _x0000_s1051"></td>
   </tr>
   <tr>
    <td height=2></td>
    <td align=left valign=top><img width=5 height=2 src="SBV_files/image008.gif"
    v:shapes="_x0000_s1045"></td>
   </tr>
   <tr>
    <td height=10></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=26 class=xl31 width=64 style='height:19.5pt;width:48pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=6 height=35 class=xl62 width=391 style='border-right:.5pt solid navy;
  height:26.25pt;width:293pt'>Chữ ký của chủ tài khoản và Dấu (nếu có) /<br>
    <font class="font8">Account Holder's signature and stamp (if any)</font></td>
  <td colspan=10 class=xl48 width=501 style='border-right:.5pt solid navy;
  border-left:none;width:376pt'>Nội dung/ <font class="font8">Content: </font><font
  class="font7"><%=p_Remark %></font></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl28 style='height:19.5pt'>&nbsp;</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl51 colspan=2 style='mso-ignore:colspan'>Kỳ hạn/ <font
  class="font8">Term…………</font><span style='display:none'><font class="font8">…….<span
  style='mso-spacerun:yes'>          </span></font><font class="font7">tháng/</font><font
  class="font8">Month (s),<span style='mso-spacerun:yes'>          </span></font><font
  class="font7">tuần/</font><font class="font8">week (s)</font></span></td>
  <td height=26 class=xl33 width=64 style='height:19.5pt;border-top:none;
  width:48pt'><!--[if gte vml 1]><v:rect id="_x0000_s1052" style='position:absolute;
   margin-left:19.5pt;margin-top:5.25pt;width:14.25pt;height:12pt;z-index:23'
   fillcolor="window [65]" strokecolor="#339 [62]" o:insetmode="auto"/><![endif]--><![if !vml]><span
  style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=25 height=6></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=21 height=18 src="SBV_files/image005.gif" v:shapes="_x0000_s1052"></td>
    <td width=18></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:48.0pt;height:19.5pt'></span><![endif]--></td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td colspan=2 height=26 class=xl33 width=85 style='mso-ignore:colspan-rowspan;
  height:19.5pt;border-top:none;width:64pt'><!--[if gte vml 1]><v:rect id="_x0000_s1053"
   style='position:absolute;margin-left:15.75pt;margin-top:5.25pt;width:11.25pt;
   height:12pt;z-index:24' fillcolor="window [65]" strokecolor="#339 [62]"
   o:insetmode="auto">
   <x:ClientData ObjectType="Rect">
    <x:Anchor>
     10, 24, 14, 7, 11, 15, 14, 23</x:Anchor>
   </x:ClientData>
  </v:rect><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=20 height=6></td>
   </tr>
   <tr>
    <td></td>
    <td><img width=17 height=18 src="SBV_files/image010.gif" v:shapes="_x0000_s1053"></td>
    <td width=48></td>
   </tr>
   <tr>
    <td height=2></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:63.75pt;height:19.5pt'></span><![endif]--></td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none'>&nbsp;</td>
  <td class=xl34 style='border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td class=xl24 colspan=4 style='mso-ignore:colspan'>Phương thức đáo hạn/ <font
  class="font8">Rollover type:</font></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl28 style='height:16.5pt'>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1055"
   style='position:absolute;margin-left:5.25pt;margin-top:2.25pt;width:14.25pt;
   height:12pt;z-index:25' fillcolor="window [65]" strokecolor="#339 [62]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:25;margin-left:6px;margin-top:2px;width:21px;
  height:18px'><img width=21 height=18 src="SBV_files/image005.gif" v:shapes="_x0000_s1055"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=22 class=xl24 width=64 style='height:16.5pt;width:48pt'><span
    style='mso-spacerun:yes'>         </span>Tự động gia hạn gốc và lãi / <font
    class="font8">Auto renewal of the principal and interest</font></td>
   </tr>
  </table>
  </span></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 style='height:15.0pt'>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td align=left valign=top><!--[if gte vml 1]><v:rect id="_x0000_s1058"
   style='position:absolute;margin-left:5.25pt;margin-top:3pt;width:14.25pt;
   height:12pt;z-index:26' fillcolor="window [65]" strokecolor="#339 [62]"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:26;margin-left:6px;margin-top:3px;width:21px;
  height:18px'><img width=21 height=18 src="SBV_files/image005.gif" v:shapes="_x0000_s1058"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=20 class=xl25 width=64 style='height:15.0pt;width:48pt'
    x:str="         Tự động gia hạn gốc, lãi trả vào tài khoản không kỳ hạn/ "><span
    style='mso-spacerun:yes'>         </span>Tự động gia hạn gốc, lãi trả vào
    tài khoản không kỳ hạn/<span style='mso-spacerun:yes'> </span></td>
   </tr>
  </table>
  </span></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl28 style='height:18.75pt'>&nbsp;</td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl52 colspan=6 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>          </span><font class="font8">Auto renewal of
  the principal only, credit interest to DDA</font></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='mso-height-source:userset;height:14.25pt'>
  <td colspan=12 height=19 class=xl54 style='height:14.25pt'>Dành cho ngân
  hàng/ <font class="font10">Bank use only</font></td>
  <td align=left valign=top><!--[if gte vml 1]><v:line id="_x0000_s1060"
   style='position:absolute;z-index:28' from="28.5pt,.75pt" to="28.5pt,150pt"
   coordsize="21600,21600" strokecolor="#339 [62]" strokeweight="1pt"
   o:insetmode="auto"/><v:line id="_x0000_s1061" style='position:absolute;
   z-index:29' from="28.5pt,51pt" to="120pt,51pt" coordsize="21600,21600"
   strokecolor="#339 [62]" strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1062"
   style='position:absolute;z-index:30' from="28.5pt,63.75pt" to="120pt,63.75pt"
   coordsize="21600,21600" strokecolor="#339 [62]" strokeweight="1pt"
   o:insetmode="auto"/><v:line id="_x0000_s1063" style='position:absolute;
   z-index:31' from="28.5pt,100.5pt" to="120pt,100.5pt" coordsize="21600,21600"
   strokecolor="#339 [62]" strokeweight="1pt" o:insetmode="auto"/><v:line id="_x0000_s1066"
   style='position:absolute;z-index:34' from="28.5pt,113.25pt" to="120pt,113.25pt"
   coordsize="21600,21600" strokecolor="#339 [62]" strokeweight="1pt"
   o:insetmode="auto"/><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:28;margin-left:37px;margin-top:0px;width:124px;
  height:201px'><img width=124 height=201 src="SBV_files/image011.gif" v:shapes="_x0000_s1060 _x0000_s1061 _x0000_s1062 _x0000_s1063 _x0000_s1066"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=19 class=xl33 width=64 style='height:14.25pt;width:48pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td colspan=3 class=xl33 style='border-right:.5pt solid navy'><span
  style='mso-spacerun:yes'>     </span>Giám đốc</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>&nbsp;</td>
  <td colspan=11 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl27 style='border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='border-right:.5pt solid navy'><span
  style='mso-spacerun:yes'>     </span>Kế toán</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>&nbsp;</td>
  <td colspan=12 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl24 style='border-right:.5pt solid navy'><span
  style='mso-spacerun:yes'>     </span>Thủ quỹ</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl28 style='height:12.0pt'>&nbsp;</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 class=xl30 style='height:12.0pt'>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=16 height=33 class=xl65 width=892 style='height:24.75pt;
  width:669pt'>Khi quý khách ký tên vào mẫu đơn này, quý khách đồng ý rằng mọi
  giao dịch của quý khách tuân thủ theo Các Điều khoản và Điều kiện chung của
  ngân hàng TNHH MTV Shinhan Việt nam./<br>
    <font class="font12">By signing on this form, you agree that you are
  binding to General Term and Conditions of Shinhan Bank Vietnam Ltd.</font></td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=15 style='mso-height-source:userset;height:11.25pt'>
  <td height=15 class=xl59 colspan=5 style='height:11.25pt;mso-ignore:colspan'>Form
  code: 1.1.3 - Effective from 28th November 2011</td>
  <td colspan=14 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td height=17 class=xl24 width=1 style='height:12.75pt;width:1pt'><!--[if gte vml 1]><v:line
   id="_x0000_s1064" style='position:absolute;z-index:32' from=".75pt,10.5pt"
   to=".75pt,10.5pt" coordsize="21600,21600" strokecolor="#339 [62]"
   o:insetmode="auto">
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     17, 0, 55, 14, 17, 0, 55, 14</x:Anchor>
   </x:ClientData>
  </v:line><![endif]--></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=19 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=16 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td height=17 class=xl24 width=1 style='height:12.75pt;width:1pt'><!--[if gte vml 1]><v:line
   id="_x0000_s1065" style='position:absolute;z-index:33' from=".75pt,10.5pt"
   to=".75pt,10.5pt" coordsize="21600,21600" strokecolor="#339 [62]"
   o:insetmode="auto">
   <x:ClientData ObjectType="Line">
    <x:Anchor>
     17, 0, 57, 14, 17, 0, 57, 14</x:Anchor>
   </x:ClientData>
  </v:line><![endif]--></td>
  <td class=xl24></td>
  <td class=xl24></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=21 style='width:16pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=16 style='width:12pt'></td>
  <td width=1 style='width:1pt'></td>
  <td width=0></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
