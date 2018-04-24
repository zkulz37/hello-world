<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data" %>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%  
    string p_nation, p_org_pk;
    p_nation = Request["p_nation"].ToString();
    p_org_pk = Request["p_org"].ToString();
    string p_from=Request.QueryString["p_1"].ToString() ;
    string p_to=Request.QueryString["p_2"].ToString();
    string SQL
    = "select 1 " + 
        ",F_GET_ORG_LEVEL(a.tco_org_pk,'01','NAME') plant " +
        ",(select v.code_nm from vhr_hr_code v where v.id = 'HR0017' and v.code = decode(A.EMPLOYEE_TYPE , '03' , '02', A.EMPLOYEE_TYPE )) emp_type " +
        ",sum(case when A.JOIN_DT <= '20111001' and A.STATUS = 'A' then 1 else 0 end  ) col_3 " +
        ",sum(case when A.JOIN_DT <= '20111031' and A.STATUS = 'A' then 1 else 0 end  ) col_4 " +
        ",sum(case when A.JOIN_DT between '20111001' and '20111031'   then 1 else 0 end  ) col_5 " +
        ",sum(case when A.LEFT_DT between '"+ p_from +"' and '"+ p_to +"'   then 1 else 0 end  ) col_6 " +
        ",sum(case when A.LEFT_DT between '"+ p_from +"' and '"+ p_to +"'  and 1 = (select nvl(num_1,0) from vhr_hr_code where id ='HR0004' and code= A.RESIGN_TYPE )  then 1 else 0 end  ) col_7 " +
        ",sum(case when A.LEFT_DT between '"+ p_from +"' and '"+ p_to +"'  and 2 = (select nvl(num_1,0) from vhr_hr_code where id ='HR0004' and code= A.RESIGN_TYPE )  then 1 else 0 end  ) col_8 " +
        ",sum(case when A.LEFT_DT between '"+ p_from +"' and '"+ p_to +"'  and 3 = (select nvl(num_1,0) from vhr_hr_code where id ='HR0004' and code= A.RESIGN_TYPE )  then 1 else 0 end  ) col_9 " +
        ",sum(case when A.LEFT_DT between '"+ p_from +"' and '"+ p_to +"'  and 4 = (select nvl(num_1,0) from vhr_hr_code where id ='HR0004' and code= A.RESIGN_TYPE )  then 1 else 0 end  ) col_10 " +
        ",sum(case when A.LEFT_DT between '"+ p_from +"' and '"+ p_to +"'  and 5 = (select nvl(num_1,0) from vhr_hr_code where id ='HR0004' and code= A.RESIGN_TYPE )  then 1 else 0 end  ) col_11 " +
        ",sum(case when A.LEFT_DT between '"+ p_from +"' and '"+ p_to +"'  and 6 = (select nvl(num_1,0) from vhr_hr_code where id ='HR0004' and code= A.RESIGN_TYPE )  then 1 else 0 end  ) col_12 " +
        ",sum(case when A.LEFT_DT between '"+ p_from +"' and '"+ p_to +"'  and 7 = (select nvl(num_1,0) from vhr_hr_code where id ='HR0004' and code= A.RESIGN_TYPE )  then 1 else 0 end  ) col_13 " +
        "from thr_employee a, comm.tco_org c " +
        "where a.del_if=0 and c.del_if=0 and A.TCO_ORG_PK = c.pk " +
        "and F_GET_ORG_LEVEL(a.tco_org_pk,'01','NAME') is not null " +
        " and decode('" + p_nation + "','ALL','ALL',a.nation)='" + p_nation + "' " +
             " AND (   a.tco_org_pk IN ( " +
             "                         SELECT     g.pk " +
             "                               FROM comm.tco_org g " +
             "                              WHERE g.del_if = 0 " +
             "                         START WITH g.pk = " +
             "                                       DECODE ('" + p_org_pk + "', " +
             "                                               'ALL', 0, " +
             "                                               '" + p_org_pk + "'" +
             "                                              ) " +
             "                         CONNECT BY PRIOR g.pk = g.p_pk) " +
             "                   OR '" + p_org_pk + "' = 'ALL') " +
        "group by F_GET_ORG_LEVEL(a.tco_org_pk,'01','NAME'), decode(A.EMPLOYEE_TYPE , '03' , '02', A.EMPLOYEE_TYPE ) " +
        "order by 2 " ;


        DataTable dt_emp = ESysLib.TableReadOpen(SQL);
        int irow_emp = dt_emp.Rows.Count;
        if (dt_emp.Rows.Count == 0)
        {
            Response.Write("There is no data to show");
            Response.End();
        } 

 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_recruit_resign_all_hs_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_recruit_resign_all_hs_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_recruit_resign_all_hs_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Compaq-500B</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-11-01T03:41:20Z</o:LastPrinted>
  <o:Created>2011-05-17T02:12:57Z</o:Created>
  <o:LastSaved>2011-11-01T03:42:24Z</o:LastSaved>
  <o:Company>HP</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.25in .2in 0in .2in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style2635
	{mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	mso-style-name:Comma;
	mso-style-id:3;}
.style0
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style2780
	{mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	mso-style-name:"\C27C\D45C \[0\] 9";}
.style2830
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\BC14\D0D5\CCB4, serif;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"\D45C\C900 5";}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl2866
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl2867
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl2868
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	background:white;
	mso-pattern:auto none;}
.xl2869
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2870
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2871
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2872
	{mso-style-parent:style2780;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2873
	{mso-style-parent:style2635;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:left;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2874
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2875
	{mso-style-parent:style2780;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2876
	{mso-style-parent:style2635;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022??_-\;_-\@_-";
	text-align:left;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2877
	{mso-style-parent:style2780;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0_-\;\\-* \#\,\#\#0_-\;_-* \0022-\0022_-\;_-\@_-";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2878
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl2879
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl2880
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl2881
	{mso-style-parent:style0;
	font-weight:700;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:bottom;}
.xl2882
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:bottom;}
.xl2883
	{mso-style-parent:style2635;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_-* \#\,\#\#0\.00_-\;\\-* \#\,\#\#0\.00_-\;_-* \0022-\0022??_-\;_-\@_-";
	background:white;
	mso-pattern:auto none;}
.xl2884
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl2885
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2886
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl2887
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2888
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl2889
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2890
	{mso-style-parent:style0;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl2891
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl2892
	{mso-style-parent:style0;
	color:#0066CC;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl2893
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;}
.xl2894
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl2895
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;}
.xl2896
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:top;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl2897
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl2898
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	background:white;
	mso-pattern:auto none;}
.xl2899
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl2900
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:white;
	mso-pattern:auto none;}
.xl2901
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl2902
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2903
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;}
.xl2904
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:bottom;
	white-space:normal;}
.xl2905
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yy\;\@";
	text-align:center;
	vertical-align:top;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl2906
	{mso-style-parent:style2830;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$-1010000\]d\/m\/yy\;\@";
	text-align:center;
	vertical-align:top;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:white;
	mso-pattern:auto none;
	white-space:normal;}
.xl2907
	{mso-style-parent:style2830;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	background:#99CC00;
	mso-pattern:auto none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Recruit &amp; resign (All)</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>96</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>19</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>7995</x:WindowHeight>
  <x:WindowWidth>14955</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Recruit &amp; resign (All)'!$P$5:$P$11</x:Formula>
 </x:ExcelName>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Recruit &amp; resign (All)'!$4:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl2866>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1041 style='border-collapse:
 collapse;table-layout:fixed;width:783pt'>
 <col class=xl2866 width=95 style='mso-width-source:userset;mso-width-alt:3474;
 width:71pt'>
 <col class=xl2866 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl2866 width=70 span=2 style='mso-width-source:userset;mso-width-alt:
 2560;width:53pt'>
 <col class=xl2866 width=61 span=2 style='mso-width-source:userset;mso-width-alt:
 2230;width:46pt'>
 <col class=xl2866 width=56 span=2 style='mso-width-source:userset;mso-width-alt:
 2048;width:42pt'>
 <col class=xl2866 width=64 style='width:48pt'>
 <col class=xl2866 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl2866 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl2866 width=44 style='mso-width-source:userset;mso-width-alt:1609;
 width:33pt'>
 <col class=xl2866 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl2866 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl2866 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl2866 width=89 style='mso-width-source:userset;mso-width-alt:3254;
 width:67pt'>
 <tr class=xl2866 height=38 style='mso-height-source:userset;height:28.5pt'>
  <td colspan=15 height=38 class=xl2897 width=952 style='height:28.5pt;
  width:716pt'>WEEKLY/ MONTHLY REPORT</td>
  <td class=xl2866 width=89 style='width:67pt'></td>
 </tr>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td colspan=15 height=25 class=xl2898 style='height:18.75pt'>(RECRUITMENT AND
  RESIGNATION)</td>
  <td class=xl2866></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl2867 style='height:16.5pt'>Month:</td>
  <td class=xl2883 colspan=3 style='mso-ignore:colspan'
  x:str><span
  style='mso-spacerun:yes'> </span>From <%= p_from.Substring(6,2).ToString() %>/<%= p_from.Substring(4,2).ToString() %>/<%= p_from.Substring(0,4).ToString() %> to <%= p_to.Substring(6,2).ToString() %>/<%= p_to.Substring(4,2).ToString() %>/<%= p_to.Substring(0,4).ToString() %><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=8 class=xl2868 style='mso-ignore:colspan;border-bottom:.5pt solid black'>&nbsp;</td>
  <td class=xl2891>&nbsp;</td>
  <td class=xl2891>&nbsp;</td>
  <td class=xl2891>&nbsp;</td>
  <td class=xl2884>Unit: Person</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td rowspan=2 height=97 class=xl2869 style='border-bottom:.5pt solid black;
  height:72.75pt'>Plant</td>
  <td rowspan=2 class=xl2902 style='border-bottom:.5pt solid black'>Position</td>
  <td rowspan=2 class=xl2894 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td rowspan=2 class=xl2894 style='border-bottom:.5pt solid black'>&nbsp;</td>
  <td rowspan=2 class=xl2905 width=61 style='border-bottom:.5pt solid black;
  width:46pt'><br>
    <br>
    <%= p_from.Substring(6,2).ToString() %>/<%= p_from.Substring(4,2).ToString() %></td>
  <td rowspan=2 class=xl2905 width=61 style='border-bottom:.5pt solid black;
  width:46pt'><br>
    <br>
    <%= p_to.Substring(6,2).ToString() %>/<%= p_to.Substring(4,2).ToString() %></td>
  <td rowspan=2 class=xl2902 style='border-bottom:.5pt solid black'>Recruit</td>
  <td rowspan=2 class=xl2902 style='border-bottom:.5pt solid black'>Resign</td>
  <td colspan=7 class=xl2869 style='border-right:.5pt solid black;border-left:
  none;border-top:.5pt solid black'>Main reason of resignation</td>
  <td rowspan=2 class=xl2901 style='border-top:none'>Remark</td>
 </tr>
 <tr height=73 style='mso-height-source:userset;height:54.75pt'>
  <td height=73 class=xl2879 width=64 style='height:54.75pt;border-left:none;
  width:48pt'>Hard work/ Noisy/ Toxic/ Hot</td>
  <td class=xl2878 width=45 style='border-left:none;width:34pt'>Low salary</td>
  <td class=xl2878 width=50 style='border-left:none;width:38pt'>Family/ Home
  land</td>
  <td class=xl2878 width=44 style='border-left:none;width:33pt'>Study</td>
  <td class=xl2879 width=82 style='border-left:none;width:62pt'>Not pass
  probation/ Dismiss/ Con. Terminate</td>
  <td class=xl2879 width=63 style='border-left:none;width:47pt'>Health/
  Unsuitable job</td>
  <td class=xl2878 width=52 style='border-left:none;width:39pt'>Other</td>
 </tr>
  <% 
    
    int g = 0;
    Boolean flag = true;
    Boolean flag_total = false;
    string emp_type_old, emp_type_new;
    
    double[] total = new double[15];
    double[] gtotal = new double[15];
    double[] worker_total = new double[15];
    double[] staff_total = new double[15];
    for (int k = 0; k < 15; k++)
    {
        total[k] = 0;
        gtotal[k] = 0;
        worker_total[k] = 0;
        staff_total[k] = 0;
    }  

    
    for(int i=0;i<dt_emp.Rows.Count;i++)
    { 
        emp_type_old = dt_emp.Rows[i][1].ToString();
       
        
        for(int j=3; j< dt_emp.Columns.Count; j++)
        {
            total[j-3] += Double.Parse(dt_emp.Rows[i][j].ToString());
            gtotal[j-3] += Double.Parse(dt_emp.Rows[i][j].ToString());
            if(i%2 ==0) 
            {
                staff_total[j-3] +=  Double.Parse(dt_emp.Rows[i][j].ToString());
            }
            else
                worker_total[j-3] +=  Double.Parse(dt_emp.Rows[i][j].ToString());
        }
        
  %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
            <%
                if (flag)
                {   
            %>
  <td height=27 class=xl2869 style='height:20.25pt;border-top:none'><%=dt_emp.Rows[i][1].ToString() %></td>
            <%  }
                else 
                {
             %>    
  <td height=27 class=xl2869 style='height:20.25pt;border-top:none'>&nbsp;</td>
            <%  } %>
  <td class=xl2869 ><%=dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl2885 >&nbsp;</td>
  <td class=xl2886 >&nbsp;</td>
  <td class=xl2872 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_emp.Rows[i][3].ToString() %> </td>
  <td class=xl2872 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_emp.Rows[i][4].ToString() %> </td>
  <td class=xl2872 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%=dt_emp.Rows[i][5].ToString() %> </td>
  <td class=xl2872 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%=dt_emp.Rows[i][6].ToString() %> </td>
  <td class=xl2873 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%=dt_emp.Rows[i][7].ToString() %> </td>
  <td class=xl2873 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%=dt_emp.Rows[i][8].ToString() %><span style='mso-spacerun:yes'>  
  </span></td>
  <td class=xl2873 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%=dt_emp.Rows[i][9].ToString() %> </td>
  <td class=xl2873 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%=dt_emp.Rows[i][10].ToString() %> </td>
  <td class=xl2873 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%=dt_emp.Rows[i][11].ToString() %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl2873 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%=dt_emp.Rows[i][12].ToString() %> </td>
  <td class=xl2873 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%=dt_emp.Rows[i][13].ToString() %><span style='mso-spacerun:yes'>  
  </span></td>
  <td rowspan=3 class=xl2896 width=89 style='border-top:none;width:67pt'>&nbsp;</td>
 </tr>
 <%
     flag = false;
     if (i < irow_emp - 1)
     {
         emp_type_new = dt_emp.Rows[i + 1][1].ToString();
         if (emp_type_new != emp_type_old)
         {
             flag = true;
             flag_total = true;
         }
     }
     else
     {
         flag = true;
         flag_total = true;
     }
     if (flag_total)
     {
  %>
 
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl2871 style='height:20.25pt'>&nbsp;</td>
  <td class=xl2893 >Total</td>
  <td class=xl2889 style='border-left:none'>&nbsp;</td>
  <td class=xl2890>&nbsp;</td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= total[0] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= total[1] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= total[2] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[3] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= total[4] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= total[5] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%= total[6] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= total[7] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= total[8] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= total[9] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= total[10] %> </td>
 </tr>
 <% 
     for (int k = 0; k < 15; k++)
     {
        total[k] = 0;
        
     }  
     flag_total = false;
     }
 
  } %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl2870 style='height:20.25pt'>Total</td>
  <td class=xl2869 style='border-top:none'>Staff</td>
  <td class=xl2872 style='border-top:none'>&nbsp;</td>
  <td class=xl2872 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl2872 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= staff_total[0] %> </td>
  <td class=xl2872 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= staff_total[1] %> </td>
  <td class=xl2872 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= staff_total[2] %> </td>
  <td class=xl2872 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= staff_total[3] %> </td>
  <td class=xl2873 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= staff_total[4] %> </td>
  <td class=xl2873 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%= staff_total[5] %><span style='mso-spacerun:yes'>  
  </span></td>
  <td class=xl2873 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%= staff_total[6] %> </td>
  <td class=xl2873 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= staff_total[7] %> </td>
  <td class=xl2873 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>              </span><%= staff_total[8] %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl2873 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= staff_total[9] %> </td>
  <td class=xl2873 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= staff_total[10] %><span style='mso-spacerun:yes'>  
  </span></td>
  <td rowspan=3 class=xl2896 width=89 style='border-top:none;width:67pt'>&nbsp;</td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl2870 style='height:20.25pt'>&nbsp;</td>
  <td class=xl2874>Worker</td>
  <td class=xl2875>&nbsp;</td>
  <td class=xl2875 style='border-left:none'>&nbsp;</td>
  <td class=xl2875 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= worker_total[0] %> </td>
  <td class=xl2875 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= worker_total[1] %> </td>
  <td class=xl2875 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= worker_total[2] %> </td>
  <td class=xl2875 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= worker_total[3] %> </td>
  <td class=xl2876 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= worker_total[4] %><span style='mso-spacerun:yes'>  
  </span></td>
  <td class=xl2876 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%= worker_total[5] %><span style='mso-spacerun:yes'>  
  </span></td>
  <td class=xl2876 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= worker_total[6] %><span style='mso-spacerun:yes'>  
  </span></td>
  <td class=xl2876 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>     </span><%= worker_total[7] %><span style='mso-spacerun:yes'>  
  </span></td>
  <td class=xl2876 style='border-left:none' x:num"><span
  style='mso-spacerun:yes'>              </span><%= worker_total[8] %><span
  style='mso-spacerun:yes'>   </span></td>
  <td class=xl2876 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= worker_total[9] %><span style='mso-spacerun:yes'>  
  </span></td>
  <td class=xl2876 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= worker_total[10] %><span style='mso-spacerun:yes'>  
  </span></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl2871 style='height:20.25pt'>&nbsp;</td>
  <td class=xl2907 style='border-top:none'>Total</td>
  <td class=xl2877 style='border-left:none'>&nbsp;</td>
  <td class=xl2877 style='border-left:none'>&nbsp;</td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= gtotal[0] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= gtotal[1] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>          </span><%= gtotal[2] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[3] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= gtotal[4] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>       </span><%= gtotal[5] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><%= gtotal[6] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>      </span><%= gtotal[7] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>                </span><%= gtotal[8] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>           </span><%= gtotal[9] %> </td>
  <td class=xl2877 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>         </span><%= gtotal[10] %> </td>
 </tr>
 
 
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=95 style='width:71pt'></td>
  <td width=83 style='width:62pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=61 style='width:46pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=44 style='width:33pt'></td>
  <td width=82 style='width:62pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=52 style='width:39pt'></td>
  <td width=89 style='width:67pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
