<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>



<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string emp_pk;
    
    emp_pk       = Request["emp_pk"].ToString();
    string SQL = " select  " 
        + "a.FULL_NAME  "//0
        + ",a.Social_no " //1
        + ",a.health_no " //2
        + ",(select v.code_nm from vhr_hr_code v where v.id='HR0132' and v.code=b.content ) " //3 noi dung thay doi
        + ",b.old " //5 cu 
        + ",b.new " //6 moi
        + ",b.reason " //7 ly do dieu chinh
        + "from thr_employee a,thr_ins_modify b "
        + "where a.del_if=0 and b.del_if=0 and b.thr_emp_pk =a.pk "
       + "and b.pk in (" + emp_pk + ") " ;
        
//Response.Write(SQL);
//Response.End();
    DataTable dt_total = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_total.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    //getting employeer
    SQL
    = "select code_nm " +
        "from vhr_hr_code " +
        "where id='HR0049' order by code  ";
    DataTable dt_name = ESysLib.TableReadOpen(SQL);
    int irow_name;
    irow_name = dt_name.Rows.Count;
    
        
   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Copy%20of%2003b-TBH_files/filelist.xml">
<link rel=Edit-Time-Data href="Copy%20of%2003b-TBH_files/editdata.mso">
<link rel=OLE-Object-Data href="Copy%20of%2003b-TBH_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>TLT</o:Author>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:Created>2010-02-09T07:56:25Z</o:Created>
  <o:LastSaved>2010-06-07T02:11:28Z</o:LastSaved>
  <o:Company>BHXH</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&R\000A";
	margin:.47in 0in .39in 0in;
	mso-header-margin:0in;
	mso-footer-margin:.44in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
.font6
	{color:windowtext;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font15
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font16
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
.font17
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"\.VnTime", sans-serif;
	mso-font-charset:0;}
.font18
	{color:windowtext;
	font-size:10.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.font19
	{color:windowtext;
	font-size:10.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style26
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
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center-across;
	vertical-align:middle;
	white-space:normal;}
.xl42
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl43
	{mso-style-parent:style26;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl44
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl45
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;}
.xl48
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;}
.xl55
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl58
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl59
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"\.VnTimeH", sans-serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>03b-TBH</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>81</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:DoNotDisplayGridlines/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>27</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8775</x:WindowHeight>
  <x:WindowWidth>15360</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1560</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path>\My Documets\Dung chung\HUONG DAN BH THAT NGHIEP-BHXHVN\HUONG DAN BH THAT NGHIEP\BIEU MAU THU\My Documents\VietHung\Luu_DL\Luu02\SuaQ§Thu\Gui PT.xls</x:Path>
  <x:SheetName>C45_BH</x:SheetName>
  <x:SheetName>C47_BH</x:SheetName>
  <x:SheetName>C48_BH</x:SheetName>
  <x:SheetName>S53_BH</x:SheetName>
  <x:SheetName>C46_BH</x:SheetName>
  <x:SheetName>7_BCT</x:SheetName>
  <x:SheetName>8_BCT</x:SheetName>
  <x:SheetName>2_TBH</x:SheetName>
  <x:SheetName>4_KHT</x:SheetName>
  <x:SheetName>5_KHT</x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>0</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>1</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>2</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>3</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>6</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>7</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>8</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>9</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
 <x:SupBook>
  <x:Path>\My Documents\VietHung\Luu_DL\Luu02\SuaQ§Thu\Gui PT.xls</x:Path>
  <x:SheetName>C45_BH</x:SheetName>
  <x:SheetName>C47_BH</x:SheetName>
  <x:SheetName>C48_BH</x:SheetName>
  <x:SheetName>S53_BH</x:SheetName>
  <x:SheetName>C46_BH</x:SheetName>
  <x:SheetName>7_BCT</x:SheetName>
  <x:SheetName>8_BCT</x:SheetName>
  <x:SheetName>2_TBH</x:SheetName>
  <x:SheetName>4_KHT</x:SheetName>
  <x:SheetName>5_KHT</x:SheetName>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>0</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>1</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>2</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>3</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>4</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>5</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>6</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>7</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>8</x:SheetIndex>
  </x:Xct>
  <x:Xct>
   <x:Count>0</x:Count>
   <x:SheetIndex>9</x:SheetIndex>
  </x:Xct>
 </x:SupBook>
 <x:ExcelName>
  <x:Name>_Fill</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>_Fill</x:Name>
  <x:Hidden/>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>EmployeeName</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRCode_No</x:Name>
  <x:Macro>Command</x:Macro>
  <x:FunctionGroup>14</x:FunctionGroup>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRDaysTaken</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LREmployeeName</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRFromDate</x:Name>
  <x:Macro>Command</x:Macro>
  <x:FunctionGroup>14</x:FunctionGroup>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRMinus_YN</x:Name>
  <x:Macro>Command</x:Macro>
  <x:FunctionGroup>14</x:FunctionGroup>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRNoOfDays</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>LRToDate</x:Name>
  <x:Macro>Command</x:Macro>
  <x:FunctionGroup>14</x:FunctionGroup>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='03b-TBH'!$4:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl42>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1211 style='border-collapse:
 collapse;table-layout:fixed;width:909pt'>
 <col class=xl42 width=34 style='mso-width-source:userset;mso-width-alt:1243;
 width:26pt'>
 <col class=xl42 width=199 style='mso-width-source:userset;mso-width-alt:7277;
 width:149pt'>
 <col class=xl42 width=122 span=2 style='mso-width-source:userset;mso-width-alt:
 4461;width:92pt'>
 <col class=xl42 width=171 span=3 style='mso-width-source:userset;mso-width-alt:
 6253;width:128pt'>
 <col class=xl42 width=221 style='mso-width-source:userset;mso-width-alt:8082;
 width:166pt'>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td colspan=7 height=36 width=990 style='height:27.0pt;width:743pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t202"
   coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
   <v:stroke joinstyle="miter"/>
   <v:path gradientshapeok="t" o:connecttype="rect"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t202" style='position:absolute;
   margin-left:726.75pt;margin-top:3pt;width:185.25pt;height:45.75pt;z-index:1;
   mso-wrap-style:tight' filled="f" fillcolor="white [9]" stroked="f"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font15">M&#7851;u s&#7889;:
    03b-TBH<br>
        </font><font class="font11">(Ban hành kèm theo CV s&#7889;
    1615/BHXH-CSXH ngày 02/6/2009 c&#7911;a BHXH VN)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:SizeWithCells/>
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1026" type="#_x0000_t202" style='position:absolute;
   margin-left:1.5pt;margin-top:2.25pt;width:240.75pt;height:57pt;z-index:2;
   mso-wrap-style:tight' filled="f" fillcolor="white [9]" stroked="f"
   strokecolor="windowText [64]" o:insetmode="auto">
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Justify</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]-->
      <!--[if gte vml 1]><v:shapetype 
      id="_x0000_t202" path="m,l,21600r21600,l21600,xe" o:spt="202" 
      coordsize="21600,21600"><v:stroke joinstyle="miter"></v:stroke><v:path 
      o:connecttype="rect" gradientshapeok="t"></v:path></v:shapetype><v:shape 
      style="MARGIN-TOP: 3pt; Z-INDEX: 1; MARGIN-LEFT: 726.75pt; WIDTH: 185.25pt; POSITION: absolute; HEIGHT: 45.75pt; mso-wrap-style: tight" 
      id="_x0000_s1025" o:insetmode="auto" strokecolor="windowText [64]" 
      stroked="f" fillcolor="white [9]" filled="f" 
      type="#_x0000_t202"><v:textbox style="mso-direction-alt: auto"><DIV 
      style="TEXT-ALIGN: center"><FONT class="font15">M&#7851;u s&#7889;: 03b-TBH<BR 
      /></FONT><FONT class="font11">(Ban hành kèm theo CV s&#7889; 1615/BHXH-CSXH ngày 
      02/6/2009 c&#7911;a BHXH VN)</FONT></DIV></v:textbox><x:ClientData 
      ObjectType="Text"><x:SizeWithCells></x:SizeWithCells><x:TextHAlign>Center</x:TextHAlign> 
      </x:ClientData></v:shape><v:shape 
      style="MARGIN-TOP: 2.25pt; Z-INDEX: 2; MARGIN-LEFT: 1.5pt; WIDTH: 240.75pt; POSITION: absolute; HEIGHT: 57pt; mso-wrap-style: tight" 
      id="_x0000_s1026" o:insetmode="auto" strokecolor="windowText [64]" 
      stroked="f" fillcolor="white [9]" filled="f" 
      type="#_x0000_t202"><v:textbox style="mso-direction-alt: auto"><DIV 
      style="TEXT-ALIGN: justify"><FONT class="font16"></FONT><FONT class="font17"><BR /><BR /><BR 
      /></FONT></DIV></v:textbox><x:ClientData 
      ObjectType="Text"><x:TextHAlign>Justify</x:TextHAlign> 
      </x:ClientData></v:shape><![endif]-->
      <!--[if gte vml 1]><v:shapetype 
      id="_x0000_t202" path="m,l,21600r21600,l21600,xe" o:spt="202" 
      coordsize="21600,21600"><v:stroke joinstyle="miter"></v:stroke><v:path 
      o:connecttype="rect" gradientshapeok="t"></v:path></v:shapetype><v:shape 
      style="MARGIN-TOP: 3pt; Z-INDEX: 1; MARGIN-LEFT: 726.75pt; WIDTH: 185.25pt; POSITION: absolute; HEIGHT: 45.75pt; mso-wrap-style: tight" 
      id="_x0000_s1025" o:insetmode="auto" strokecolor="windowText [64]" 
      stroked="f" fillcolor="white [9]" filled="f" 
      type="#_x0000_t202"><v:textbox style="mso-direction-alt: auto"><DIV 
      style="TEXT-ALIGN: center"><FONT class="font15">Mẫu số: 03b-TBH<BR 
      /></FONT><FONT class="font11">(Ban hành kèm theo CV số 1615/BHXH-CSXH ngày 
      02/6/2009 của BHXH VN)</FONT></DIV></v:textbox><x:ClientData 
      ObjectType="Text"><x:SizeWithCells></x:SizeWithCells><x:TextHAlign>Center</x:TextHAlign> 
      </x:ClientData></v:shape><v:shape 
      style="MARGIN-TOP: 2.25pt; Z-INDEX: 2; MARGIN-LEFT: 1.5pt; WIDTH: 240.75pt; POSITION: absolute; HEIGHT: 57pt; mso-wrap-style: tight" 
      id="_x0000_s1026" o:insetmode="auto" strokecolor="windowText [64]" 
      stroked="f" fillcolor="white [9]" filled="f" 
      type="#_x0000_t202"><v:textbox style="mso-direction-alt: auto"><DIV 
      style="TEXT-ALIGN: justify"><FONT class="font16"><SPAN 
      style="FONT-FAMILY: Times New Roman">Tên đơn vị:<%=dt_name.Rows[0][0].ToString() %><BR />Mã đơn vị:<%=dt_name.Rows[1][0].ToString() %><BR />Địa chỉ:<span style="font-size:smaller"><%=dt_name.Rows[2][0].ToString() %></span></SPAN></FONT><FONT 
      class="font17"><BR /><BR /><BR /></FONT></DIV></v:textbox><x:ClientData 
      ObjectType="Text"><x:TextHAlign>Justify</x:TextHAlign> 
      </x:ClientData></v:shape><![endif]-->
      <![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:2px;margin-top:3px;width:1214px;
  height:76px'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=0></td>
    <td width=321></td>
    <td width=646></td>
    <td width=247><span style="font-size:smaller"></span></td>
   </tr>
   <tr>
    <td height=1></td>
    <td rowspan=3 align=left valign=top></td>
   </tr>
   <tr>
    <td height=61></td>
    <td></td>
    <td align=left valign=top></td>
   </tr>
   <tr>
    <td height=14></td>
   </tr>
  </table>
  </span><![endif]><span style='mso-ignore:vglayout2'><table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=7 height=36 class=xl59 width=990 style='height:27.0pt;
    width:743pt'>
        <span style="font-family: Times New Roman">DANH SÁCH LAO ÐỘNG ÐIỀU CHỈNH HỒ SƠ ÐÓNG <font class="font6">
    BHXH, BHYT, BHTN</font></span></td>
   </tr>
  </table>
  </span></td>
  <td class=xl41 width=221 style='width:166pt'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl43 style='height:20.25pt'></td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
  <td class=xl44>(Kèm công v&#259;n s&#7889; ………… ngày … tháng … n&#259;m …… )</td>
  <td class=xl45></td>
  <td class=xl46></td>
  <td class=xl47></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl43 style='height:20.25pt'></td>
  <td colspan=2 class=xl42 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl45 style='mso-ignore:colspan'></td>
  <td class=xl48></td>
  <td class=xl49></td>
 </tr>
 <tr class=xl50 height=42 style='height:31.5pt'>
  <td height=42 class=xl55 width=34 style='height:31.5pt;width:26pt'>STT</td>
  <td class=xl55 width=199 style='border-left:none;width:149pt'>H&#7885; tên</td>
  <td class=xl55 width=122 style='border-left:none;width:92pt'>S&#7889;
  s&#7893; BHXH</td>
  <td class=xl55 width=122 style='border-left:none;width:92pt'>S&#7889;
  th&#7867; BHYT</td>
  <td class=xl55 width=171 style='border-left:none;width:128pt'>N&#7897;i dung
  thay &#273;&#7893;i <br>
    (&#273;i&#7873;u ch&#7881;nh)</td>
  <td class=xl55 width=171 style='border-left:none;width:128pt'>C&#361;</td>
  <td class=xl55 width=171 style='border-left:none;width:128pt'>M&#7899;i</td>
  <td class=xl55 width=221 style='border-left:none;width:166pt'>Lý do
  &#273;i&#7873;u ch&#7881;nh</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl56 style='height:20.25pt;border-top:none' x:num>1</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>2</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>3</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>4</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>5</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>6</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>7</td>
  <td class=xl56 style='border-top:none;border-left:none' x:num>8</td>
 </tr>
<% for (int i=0 ;i< dt_total.Rows.Count;i++) {%>
 <tr height=36 style='mso-height-source:userset;height:27.0pt'>
  <td height=36 class=xl57 style='height:27.0pt'><%=i+1 %></td>
  <td class=xl58 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_total.Rows[i][0].ToString() %></td>
  <td class=xl58 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_total.Rows[i][1].ToString() %></td>
  <td class=xl58 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_total.Rows[i][2].ToString() %></td>
  <td class=xl58 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_total.Rows[i][3].ToString() %></td>
  <td class=xl58 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_total.Rows[i][4].ToString() %></td>
  <td class=xl58 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_total.Rows[i][5].ToString() %></td>
  <td class=xl58 style='border-left:none;white-space:nowrap;mso-text-control:shrinktofit;'><%=dt_total.Rows[i][6].ToString() %></td>
 </tr>
 <%} %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl51 style='height:20.25pt;border-top:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl51 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=8 class=xl42 style='height:20.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl42 style='height:20.25pt'></td>
  <td class=xl52>&#272;&#7872; NGH&#7882; GIA H&#7840;N TH&#7866; BHYT:</td>
  <td colspan=6 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl42 style='height:20.25pt'></td>
  <td class=xl53 colspan=3 style='mso-ignore:colspan'
  x:str="'- S&#7889; th&#7867; BHYT gia h&#7841;n:.............. th&#7867;; Trong &#273;ó ngo&#7841;i t&#7881;nh:............... th&#7867;.">-
  S&#7889; th&#7867; BHYT gia h&#7841;n:.............. th&#7867;; Trong &#273;ó
  ngo&#7841;i t&#7881;nh:............... th&#7867;.</td>
  <td colspan=4 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl42 style='height:20.25pt'></td>
  <td class=xl54 colspan=4 style='mso-ignore:colspan'>Th&#7901;i h&#7841;n
  s&#7917; d&#7909;ng c&#7911;a th&#7867; BHYT t&#7915; ngày __/__/____
  &#273;&#7871;n ngày __/__/____</td>
  <td colspan=3 class=xl42 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td colspan=8 class=xl42 style="height:12pt;mso-ignore:colspan"></td>
 </tr>
<tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=4 rowspan=5 height=85 class=xl24 width=614 style='mso-ignore:
  colspan-rowspan;height:63.75pt;width:461pt'><!--[if gte vml 1]><v:shape id="_x0000_s1028"
   type="#_x0000_t202" style='position:absolute;margin-left:0;margin-top:.75pt;
   width:162.75pt;height:46.5pt;z-index:4;mso-wrap-style:tight' filled="f"
   fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font18"><br>
        Cán b&#7897; thu<br>
        </font><font class="font19">(ký ghi rõ h&#7885; tên)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1027" type="#_x0000_t202" style='position:absolute;
   margin-left:210pt;margin-top:.75pt;width:180pt;height:53.25pt;z-index:3;
   mso-wrap-style:tight' filled="f" fillcolor="window [65]" stroked="f"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">Ngày..... tháng......
    n&#259;m..........</font><font class="font18"><br>
        Ph&#7909; trách thu<br>
        </font><font class="font19">(ký và &#273;óng d&#7845;u)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=0 height=1></td>
    <td width=217></td>
    <td width=63></td>
    <td width=240></td>
    <td width=94></td>
   </tr>
   <tr>
    <td height=62></td>
    <td align=left valign=top><img width=217 height=62
    src="Copy%20of%2003b-TBH_files/image009.gif"
    alt="Text Box: Cán b&#7897; thu&#10;(ký ghi rõ h&#7885; tên)" v:shapes="_x0000_s1028"></td>
    <td></td>
    <td rowspan=2 align=left valign=top><img width=240 height=71
    src="Copy%20of%2003b-TBH_files/image004.gif"
    alt="Text Box: Ngày..... tháng...... n&#259;m..........&#10;Ph&#7909; trách thu&#10;(ký và &#273;óng d&#7845;u)"
    v:shapes="_x0000_s1027"></td>
   </tr>
   <tr>
    <td height=9></td>
   </tr>
   <tr>
    <td height=13></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:460.5pt;height:63.75pt'></span><![endif]--></td>
  <td colspan=3 rowspan=5 height=85 class=xl24 width=563 style='mso-ignore:
  colspan-rowspan;height:63.75pt;width:422pt'><!--[if gte vml 1]><v:shape id="_x0000_s1029"
   type="#_x0000_t202" style='position:absolute;margin-left:8.25pt;
   margin-top:.75pt;width:158.25pt;height:57.75pt;z-index:5;mso-wrap-style:tight'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font18"><br>
        Ng&#432;&#7901;i l&#7853;p bi&#7875;u<br>
        </font><font class="font19">(Ký ghi rõ h&#7885; tên)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1030" type="#_x0000_t202" style='position:absolute;
   margin-left:214.5pt;margin-top:.75pt;width:160.5pt;height:51.75pt;z-index:6;
   mso-wrap-style:tight' filled="f" fillcolor="window [65]" stroked="f"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font19">Ngày <%= DateTime.Today.Day%> tháng <%= DateTime.Today.Month%> n&#259;m  <%= DateTime.Today.Year%></font><font class="font18"><br>
        Ng&#432;&#7901;i s&#7917; d&#7909;ng lao &#273;&#7897;ng<br>
        </font><font class="font19">(Ký và &#273;óng d&#7845;u)</font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=11 height=1></td>
    <td width=211></td>
    <td width=64></td>
    <td width=214></td>
    <td width=63></td>
   </tr>
   <tr>
    <td height=69></td>
    <td rowspan=2 align=left valign=top><img width=211 height=77
    src="Copy%20of%2003b-TBH_files/image005.gif"
    alt="Text Box: Ng&#432;&#7901;i l&#7853;p bi&#7875;u&#10;(Ký ghi rõ h&#7885; tên)"
    v:shapes="_x0000_s1029"></td>
    <td></td>
    <td align=left valign=top><img width=214 height=69
    src="Copy%20of%2003b-TBH_files/image006.gif"
    alt="Text Box: Ngày..... tháng...... n&#259;m..........&#10;Ng&#432;&#7901;i s&#7917; d&#7909;ng lao &#273;&#7897;ng&#10;(Ký và &#273;óng d&#7845;u)"
    v:shapes="_x0000_s1030"></td>
   </tr>
   <tr>
    <td height=8></td>
   </tr>
   <tr>
    <td height=7></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:422.25pt;height:63.75pt'></span><![endif]--></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=8 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=4 rowspan=4 height=68 class=xl24 width=614 style='mso-ignore:
  colspan-rowspan;height:51.0pt;width:461pt'><!--[if gte vml 1]><v:shape id="_x0000_s1032"
   type="#_x0000_t202" style='position:absolute;margin-left:12pt;margin-top:10.5pt;
   width:162.75pt;height:26.25pt;z-index:8;mso-wrap-style:tight' filled="f"
   fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font18"><br>
        <b><%=dt_name.Rows[3][0].ToString() %></b><br>
        </font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1031" type="#_x0000_t202" style='position:absolute;
   margin-left:222pt;margin-top:10.5pt;width:180pt;height:30pt;z-index:7;
   mso-wrap-style:tight' filled="f" fillcolor="window [65]" stroked="f"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font18"><br>
        <b><%=dt_name.Rows[4][0].ToString() %></b><br>
        </font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=16 height=14></td>
    <td width=217></td>
    <td width=63></td>
    <td width=240></td>
    <td width=78></td>
   </tr>
   <tr>
    <td height=35></td>
    <td align=left valign=top><img width=217 height=35
    src="Copy%20of%2003b-TBH_files/image010.gif" alt="Text Box: aaaaa&#10;"
    v:shapes="_x0000_s1032"></td>
    <td></td>
    <td rowspan=2 align=left valign=top><img width=240 height=40
    src="Copy%20of%2003b-TBH_files/image011.gif" alt="Text Box: bbbbbbb&#10;"
    v:shapes="_x0000_s1031"></td>
   </tr>
   <tr>
    <td height=5></td>
   </tr>
   <tr>
    <td height=14></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:460.5pt;height:51.0pt'></span><![endif]--></td>
  <td colspan=3 rowspan=3 height=51 class=xl24 width=563 style='mso-ignore:
  colspan-rowspan;height:38.25pt;width:422pt'><!--[if gte vml 1]><v:shape id="_x0000_s1033"
   type="#_x0000_t202" style='position:absolute;margin-left:20.25pt;
   margin-top:10.5pt;width:158.25pt;height:27.75pt;z-index:9;mso-wrap-style:tight'
   filled="f" fillcolor="window [65]" stroked="f" strokecolor="windowText [64]"
   o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font18"><br>
        <b><%=dt_name.Rows[5][0].ToString() %></b><br>
        </font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><v:shape id="_x0000_s1034" type="#_x0000_t202" style='position:absolute;
   margin-left:226.5pt;margin-top:10.5pt;width:160.5pt;height:25.5pt;z-index:10;
   mso-wrap-style:tight' filled="f" fillcolor="window [65]" stroked="f"
   strokecolor="windowText [64]" o:insetmode="auto">
   <v:textbox style='mso-direction-alt:auto'>
    <div style='text-align:center'><font class="font18"><br>
        <b><%=dt_name.Rows[6][0].ToString() %></b><br>
        </font></div>
   </v:textbox>
   <x:ClientData ObjectType="Text">
    <x:TextHAlign>Center</x:TextHAlign>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td width=27 height=14></td>
    <td width=211></td>
    <td width=64></td>
    <td width=214></td>
    <td width=47></td>
   </tr>
   <tr>
    <td height=34></td>
    <td rowspan=2 align=left valign=top><img width=211 height=37
    src="Copy%20of%2003b-TBH_files/image012.gif" alt="Text Box: ccccc&#10;"
    v:shapes="_x0000_s1033"></td>
    <td></td>
    <td align=left valign=top><img width=214 height=34
    src="Copy%20of%2003b-TBH_files/image013.gif" alt="Text Box: ddddd&#10;"
    v:shapes="_x0000_s1034"></td>
   </tr>
   <tr>
    <td height=3></td>
   </tr>
   <tr>
    <td height=0></td>
   </tr>
  </table>
  </span><![endif]><!--[if !mso & vml]><span style='width:422.25pt;height:38.25pt'></span><![endif]--></td>
 </tr>
      <tr>
         <td height=17 class=xl42 style='height:12.75pt'>
         </td>
     </tr>
     <tr>
         <td height=17 class=xl42 style='height:12.75pt'>
         </td>
     </tr>
     <tr>
         <td height=17 class=xl42 style='height:12.75pt'>
         </td>
     </tr>
     <tr>
         <td class=xl42 style="height:13pt">
         </td>
     </tr>
 </table>

</body>

</html>
