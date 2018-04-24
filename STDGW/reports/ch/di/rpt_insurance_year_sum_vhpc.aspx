<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
string p_year,p_include;
     
    p_year = Request["p_year"].ToString();
	p_include = Request["p_include"].ToString();
    string[] mon = new string[12]{"01","02","03","04","05","06","07","08","09","10","11","12"};
    
    string SQL
    = "select decode(b.NATION,'02','Foreigner',decode(b.EMPLOYEE_TYPE,'01','Office','Factory')) as c0 " ;
    for(int i=0; i<12; i++)
    {
        SQL= SQL +
        ",sum(case when ins.work_mon = '" + p_year + "'||'" + mon[i] + "' then nvl(ins.LUONG_BHXH,0)*(nvl(ins.social_rate,0)+nvl(ins.social_com_rate,0))/100    " +
        "   + nvl(ins.LUONG_BHYT,0)*(nvl(ins.health_com_rate,0) +nvl(ins.health_rate,0) )/100   " +
        "   + nvl(ins.LUONG_BHTN,0) * (nvl(ins.unemp_rate,0)+nvl(ins.unemp_com_rate,0))/100 " +
        "   else 0 end) " +
        "   as c1 " +
        ",sum(case when ins.WORK_MON ='" + p_year + "'||'" + mon[i] + "' then 1 else 0 end) c2 " +
        ",sum(case when ins.WORK_MON ='" + p_year + "'||'" + mon[i] + "' and nvl(ins.xh_yn,'N')='N' and nvl(ins.yt_yn,'N')='N' and nvl(ins.tn_yn,'N')='N' and nvl(m.so_thang,0)>0 then 1 " +
        "    else 0 end) as c37 " ;
     }
     SQL= SQL +
        ",sum( nvl(ins.LUONG_BHXH,0)*(nvl(ins.social_rate,0)+nvl(ins.social_com_rate,0))/100     " +
        "   + nvl(ins.LUONG_BHYT,0)*(nvl(ins.health_com_rate,0) +nvl(ins.health_rate,0) )/100    " +
        "   + nvl(ins.LUONG_BHTN,0) * (nvl(ins.unemp_rate,0)+nvl(ins.unemp_com_rate,0))/100  " +
        "    ) as c4 " +
        ",sum(case when substr(ins.WORK_MON,1,4) ='" + p_year + "' then 1 else 0 end) c38 " +
        ",sum(case when substr(ins.WORK_MON,1,4) ='" + p_year + "'  and nvl(ins.xh_yn,'N')='N' and nvl(ins.yt_yn,'N')='N' and nvl(ins.tn_yn,'N')='N' and nvl(ins.health_rate,0)>0 then 1  " +
        "    else 0 end) as c39  " +
        " from thr_insurance_month ins, thr_employee b, thr_insurance_manage m " +
        "where ins.del_if=0 and b.del_if=0 and m.del_if(+)=0 " +
		" and ins.thr_emp_pk = m.thr_emp_pk(+) and ins.work_mon = m.thang_bc(+)	" +
		"   and ((('"+ p_include +"' ='2') and (nvl(ins.xh_yn,'N')='Y' or nvl (ins.tn_yn,'N')='Y' or nvl (ins.yt_yn,'N')='Y' " +
        "         OR (NVL(ins.XH_YN,'N')='N' AND NVL(ins.YT_YN,'N')='N' AND NVL(ins.TN_YN,'N')='N' AND nvl(m.so_thang,0)>0) " +
        "       )) " +
        "       or " +
        "       (('"+ p_include +"'='1') and (nvl(ins.xh_yn,'N')='Y' or nvl (ins.tn_yn,'N')='Y' or nvl (ins.yt_yn,'N')='Y'))) " +
        "and ins.THR_EMP_PK = b.pk " +
        "and substr(ins.work_mon,1,4)='" + p_year + "' " +
        "group by b.EMPLOYEE_TYPE, b.NATION " ;

    
//Response.Write(StrSQL);
//Response.End();  
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    
    int irow_emp = dt_emp.Rows.Count;
    int icol_emp = dt_emp.Columns.Count;
    
    if(irow_emp==0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
   
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_insurance_year_sum_vhpc_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_insurance_year_sum_vhpc_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_insurance_year_sum_vhpc_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>admin</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-04-15T06:26:09Z</o:LastPrinted>
  <o:Created>2007-09-12T06:11:29Z</o:Created>
  <o:LastSaved>2011-04-15T06:26:25Z</o:LastSaved>
  <o:Company>Hewlett-Packard Company</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in 0in .75in 0in;
	mso-header-margin:.55in;
	mso-footer-margin:.3in;
	mso-page-orientation:landscape;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style50
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
	font-family:VNI-Times;
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
	font-family:VNI-Times;
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
.xl90
	{mso-style-parent:style0;
	color:black;
	font-size:14.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl91
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl92
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl93
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl94
	{mso-style-parent:style50;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl95
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl96
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl97
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl99
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl100
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"\[ENG\]\[$-409\]mmm\\-yy\;\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl101
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl102
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl104
	{mso-style-parent:style50;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl105
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl106
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl108
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl109
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl110
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl111
	{mso-style-parent:style50;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl112
	{mso-style-parent:style50;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl113
	{mso-style-parent:style50;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl114
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl115
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl116
	{mso-style-parent:style0;
	color:black;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl117
	{mso-style-parent:style0;
	color:black;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>summarize</x:Name>
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
       <x:ActiveRow>16</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11640</x:WindowHeight>
  <x:WindowWidth>15480</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>135</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:SupBook>
  <x:Path>\\Mr. loc\sharing\tridung\tender\Beaute garment\Autocadfile\Project\Mekong Flour Mill\CD WRITE\Boq\MEKONG_FLOURMILL(3rd-submission-netcost).xls</x:Path>
  <x:SheetName>breakdown</x:SheetName>
  <x:SheetName>Sheet2</x:SheetName>
  <x:SheetName>Sheet3</x:SheetName>
  <x:SheetName>XL4Poppy</x:SheetName>
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
 </x:SupBook>
 <x:ExcelName>
  <x:Name>_Fill</x:Name>
  <x:Hidden/>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>ádf</x:Name>
  <x:Formula>='\\Mr. loc\sharing\tridung\tender\Beaute garment\Autocadfile\Project\Mekong Flour Mill\CD WRITE\Boq\[MEKONG_FLOURMILL(3rd-submission-netcost).xls]breakdown'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>grand_total</x:Name>
  <x:Formula>='\\Mr. loc\sharing\tridung\tender\Beaute garment\Autocadfile\Project\Mekong Flour Mill\CD WRITE\Boq\[MEKONG_FLOURMILL(3rd-submission-netcost).xls]breakdown'!#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGHIEU4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGKHANH</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGLONG5</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGLUU4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGMINH4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGNGHIEM4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGPHU</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGQUAN4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGSON4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGTHANH4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGTRI</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NGTUAN4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NHIEU4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NKHANH</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NLONG5</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NLUU4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NMINH4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNGHIEM4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNHIEU4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNKHANH</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNLUU4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNMINH4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNNGHIEM4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNPHU</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNQUAN4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNSON4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNTHANH4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNTRI</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NNTUAN4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NPHU</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NQUAN4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NSON4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NTHANH4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NTRI</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>NTUAN4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PHIEU4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PKHANH</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PLONG4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PLUU4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PMINH4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PNGHIEM4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PPHU</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PQUAN4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PSON4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PTHANH4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PTRI</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>PTUAN4</x:Name>
  <x:Formula>=#REF!</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3073"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl91>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1322 style='border-collapse:
 collapse;table-layout:fixed;width:997pt'>
 <col class=xl91 width=35 style='mso-width-source:userset;mso-width-alt:1280;
 width:26pt'>
 <col class=xl91 width=159 style='mso-width-source:userset;mso-width-alt:5814;
 width:119pt'>
 <col class=xl91 width=86 span=12 style='mso-width-source:userset;mso-width-alt:
 3145;width:65pt'>
 <col class=xl91 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl91 width=35 style='height:18.0pt;width:26pt'></td>
  <td colspan=14 height=24 width=1287 style='height:18.0pt;width:971pt'
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s1028" type="#_x0000_t75"
   style='position:absolute;margin-left:0;margin-top:1.5pt;width:153.75pt;
   height:42.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_insurance_year_sum_vhpc_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:0px;margin-top:2px;width:205px;
  height:57px'><img width=205 height=57
  src="rpt_insurance_year_sum_vhpc_files/image002.jpg" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=14 height=24 class=xl90 width=1287 style='height:18.0pt;
    width:971pt'>POSCO VIETNAM<span style='mso-spacerun:yes'> 
    </span>PROCESSING CENTER CO., LTD</td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=24 style='height:18.0pt'>
  <td height=24 class=xl91 style='height:18.0pt'></td>
  <td colspan=14 class=xl90>SOCIAL INSURANCE SUMMARIZE IN <%= p_year %></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl91 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=15 class=xl91 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl100 style='height:29.25pt'>No</td>
  <td class=xl99 style='border-left:none'>Department/Monthly</td>
  <td class=xl100 style='border-left:none' x:str>Jan-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>Feb-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>Mar-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>Apr-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>May-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>Jun-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>Jul-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>Aug-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>Sep-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>Oct-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>Nov-<%= p_year.Substring(2,2) %></td>
  <td class=xl100 style='border-left:none' x:str>Dec-<%= p_year.Substring(2,2) %></td>
  <td class=xl101 style='border-left:none'>Total</td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=15 height=32 class=xl102 style='border-right:.5pt solid black;
  height:24.0pt'>I. Amount ( Paid for social insurance)</td>
 </tr>
 <%
    int count=1;
    double[] total = new double[39];
    for (int k = 0; k < 39; k++)
        total[k] = 0;
    for(int i=0; i< irow_emp; i++)
    {
        for (int j = 1; j < icol_emp; j++)
            total[j - 1] += Double.Parse(dt_emp.Rows[i][j].ToString());
  %>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl104 style='height:29.25pt' x:num><span
  style='mso-spacerun:yes'>    </span><%= count %> </td>
  <td class=xl103 style='border-left:none'><%= dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%= dt_emp.Rows[i][1].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%= dt_emp.Rows[i][4].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%= dt_emp.Rows[i][7].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][10].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][13].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][16].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][19].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][22].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][25].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][28].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][31].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][34].ToString() %> </td>
  <td class=xl111 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][37].ToString() %> </td>
 </tr>
 <%
    count++;
    } %>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl94 style='height:5.25pt;border-top:none'>&nbsp;</td>
  <td class=xl95 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl112 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=2 height=43 class=xl107 width=194 style='border-right:.5pt solid black;
  height:32.25pt;width:145pt'>Total Paid Of Social Insurance</td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= total[0] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= total[3] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>   </span><%= total[6] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[9] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[12] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[15] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[18] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[21] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[24] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[27] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[30] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[33] %> </td>
  <td class=xl113 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[36] %> </td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=15 height=32 class=xl102 style='border-right:.5pt solid black;
  height:24.0pt'>II. Manpower</td>
 </tr>
 <%
    count=1;
    for(int i=0; i< irow_emp; i++)
    {
       
  %>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 class=xl97 style='height:25.5pt;border-top:none' x:num><%= count %></td>
  <td class=xl93 style='border-top:none;border-left:none'><span
  style='mso-spacerun:yes'> </span><%= dt_emp.Rows[i][0].ToString() %></td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                 </span><%= dt_emp.Rows[i][2].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                 </span><%= dt_emp.Rows[i][5].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                 </span><%= dt_emp.Rows[i][8].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][11].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][14].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][17].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][20].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][23].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][26].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][29].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][32].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][35].ToString() %> </td>
  <td class=xl114 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= dt_emp.Rows[i][38].ToString() %> </td>
 </tr>
  <%
    count++;
    } %>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 class=xl98 style='height:5.25pt;border-top:none'>&nbsp;</td>
  <td class=xl96 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl116 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=2 height=43 class=xl105 style='border-right:.5pt solid black;
  height:32.25pt'>Total Manpower</td>
  <td class=xl117 style='border-left:none' x:num=><span
  style='mso-spacerun:yes'>              </span><%= total[1] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= total[4] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= total[7] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[10] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[13] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[16] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[19] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[22] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[25] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[28] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[31] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[34] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[37] %> </td>
 </tr>
 <tr height=43 style='mso-height-source:userset;height:32.25pt'>
  <td colspan=2 height=43 class=xl109 width=194 style='border-right:.5pt solid black;
  height:32.25pt;width:145pt'>III. Not return medical card</td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[2] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                 </span><%= total[5] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                 </span><%= total[8] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[11] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[14] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[17] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[20] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[23] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[26] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[29] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[32] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                  </span><%= total[35] %> </td>
  <td class=xl117 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                    </span><%= total[38] %> </td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=35 style='width:26pt'></td>
  <td width=159 style='width:119pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=96 style='width:72pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
