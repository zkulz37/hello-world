<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html 
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string bz_pk;
       
    bz_pk = Request["p_biz_trip_pk"].ToString(); 
    
    
    string SQL
	= "select a.APPLICATION_NO " + 
        ",to_char(a.SUBMIT_TIME,'dd/mm/yyyy') " +
        ",b.emp_id " +
        ",b.full_name " +
        ",c.org_nm " +
        ",(select code_nm from vhr_hr_code where id='HR0008' and code=b.pos_type)  " +
        ",to_char(a.DEPT_SIGN_DT,'dd/mm/yyyy') " +
        ",to_char(a.GA_STAFF_SIGN_DT,'dd/mm/yyyy') " +
        ",to_char(a.GA_dept_SIGN_DT,'dd/mm/yyyy') " +
        ",(select code_nm from vhr_hr_code where id='HR0059' and code=a.B_OBJECT ) " +
        ",(select thr_photo_pk from THR_MANAGER_SIGNATURE g where del_if=0 and a.manager_pk=g.thr_emp_pk ) " +
        ",(select thr_photo_pk from THR_MANAGER_SIGNATURE g where del_if=0 and a.ga_staff_pk=g.thr_emp_pk ) " +
        ",(select thr_photo_pk from THR_MANAGER_SIGNATURE g where del_if=0 and a.ga_manager_pk=g.thr_emp_pk ) " +
        "from thr_biz_trip a,thr_employee b,comm.tco_org c " +
        "where a.del_if=0  and c.del_if=0 " +
        "and b.del_if=0 and a.THR_EMP_PK=b.pk " +
        "and b.tco_org_pk=c.pk " +
        "and a.pk=" + bz_pk ;


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
        
        //-------------------companion 
        string SQL_Com
	    = " select " + 
        "        a.COMPANER_ID, " +
        "        a.COMPANER_NM, " +
        "        c.org_nm, " +
        "        (select code_nm from vhr_hr_code where id='HR0008' and code=a.POS_TYPE) " +
        "        from thr_biz_companion a,comm.tco_org c " +
        "        where a.del_if=0 and c.del_if=0 " +
        "        and a.tco_dept_pk=c.pk " +
        "        and a.THR_BIZ_TRIP_PK=" + bz_pk + 
        "        order by a.companer_id " ;
        
        DataTable dt_Com = ESysLib.TableReadOpen(SQL_Com);
        int irow_com;
        irow_com = dt_Com.Rows.Count;
        //----------------Schedule 
        string SQL_Sch
	    = "select " + 
        "        to_char(to_date(a.S_FROM,'yyyymmdd'),'dd/mm/yyyy'), " +
        "        to_char(to_date(a.S_to,'yyyymmdd'),'dd/mm/yyyy'), " +
        "        a.DEPARTURE_COUNTRY, " +
        "        a.DEPARTTURE_CITY, " +
        "        a.ARRIVAL_COUNTRY, " +
        "        a.ARRIVAL_CITY, " +
        "        a.PLAN " +
        "        from THR_BIZ_SCHEDULE a " +
        "        where a.del_if=0 " +
        "        and a.THR_BIZ_TRIP_PK=" + bz_pk + 
        "        order by a.s_from " ;
        DataTable dt_Sch = ESysLib.TableReadOpen(SQL_Sch);
        int irow_sch;
        irow_sch = dt_Sch.Rows.Count;

        
        //----------------Transportation 
        string SQL_Tra
	    = " select " + 
        "        T_DEPARTURE, " +
        "        T_ARRIVAL, " +
        "         (select code_nm from vhr_hr_code where id='HR0063' and code=a.T_BY), " +
        "        nvl(T_AMOUNT,0), " +
        "        (SELECT char_1 FROM VHR_HR_CODE B,THR_BIZ_TRIP C WHERE  C.DEL_IF=0 AND B.CODE=C.CURRENCY AND ID='HR0040'  and c.pk=" + bz_pk + " ) , " +
        "        REMARK " +
        "        from THR_biz_TRANS a " +
        "        where a.del_if=0 " +
        "        and a.THR_BIZ_TRIP_PK=" + bz_pk + 
        "      order by T_DEPARTURE " ;
        DataTable dt_Tra = ESysLib.TableReadOpen(SQL_Tra);
        int irow_tra;
        irow_tra= dt_Tra.Rows.Count;
         //----------------Other Expense
        string SQL_Oth
	    = "select " + 
        "         (select code_nm from vhr_hr_code where id='HR0062' and code=a.O_TYPE), " +
        "        O_DESCRIPTION, " +
        "        nvl(O_AMOUNT,0), " +
        "        (SELECT char_1 FROM VHR_HR_CODE B,THR_BIZ_TRIP C WHERE  C.DEL_IF=0 AND B.CODE=C.CURRENCY AND ID='HR0040' and c.pk=" + bz_pk + " ) , " +
        "        REMARK " +
        "        from THR_biz_OTHER a " +
        "        where a.del_if=0 " +
        "        and a.THR_BIZ_TRIP_PK=" + bz_pk + 
        "      order by O_TYPE " ;
        DataTable dt_Oth = ESysLib.TableReadOpen(SQL_Oth);
        int irow_oth;
        irow_oth= dt_Oth.Rows.Count;
        double sum_tra=0;
        double sum_oth=0;
        
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_business_trip_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_business_trip_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_business_trip_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>tyml</o:Author>
  <o:LastAuthor>tyml</o:LastAuthor>
  <o:Created>2009-05-25T05:52:01Z</o:Created>
  <o:LastSaved>2009-05-25T07:29:48Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"&R&P \/ &N";
	margin:.98in .75in .98in .75in;
	mso-header-margin:.51in;
	mso-footer-margin:.51in;}
tr
	{mso-height-source:auto;}
col
	{mso-width-source:auto;}
br
	{mso-data-placement:same-cell;}
.style0
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
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
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
.xl24
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl29
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-style:italic;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl37
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl39
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl44
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl45
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl48
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl52
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl53
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl54
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl55
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl56
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;
	mso-text-control:shrinktofit;}
.xl59
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl60
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl61
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
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
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>79</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1028"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=846 style='border-collapse:
 collapse;table-layout:fixed;width:636pt'>
 <col class=xl24 width=126 style='mso-width-source:userset;mso-width-alt:3584;
 width:95pt'>
 <col class=xl24 width=104 span=3 style='mso-width-source:userset;mso-width-alt:
 2958;width:78pt'>
 <col class=xl24 width=137 style='mso-width-source:userset;mso-width-alt:3896;
 width:103pt'>
 <col class=xl24 width=125 style='mso-width-source:userset;mso-width-alt:3555;
 width:94pt'>
 <col class=xl24 width=146 style='mso-width-source:userset;mso-width-alt:4152;
 width:110pt'>
 <col class=xl24 width=104 span=249 style='mso-width-source:userset;mso-width-alt:
 2958;width:78pt'>
 <tr height=24 style='height:18.0pt'>
  <td colspan=7 height=24 class=xl59 width=846 style='height:18.0pt;width:636pt'
  x:str="Business Trip Application ">Business Trip Application<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=7 class=xl26 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl26></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>Application No.</td>
  <td class=xl24><% = dt_total.Rows[0][0].ToString()%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td class=xl28>Dept. Manager</td>
  <td class=xl28 style='border-left:none'>GA Staff Review</td>
  <td class=xl28 style='border-left:none'>GA Dept. Manager</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>Application Date</td>
  <td class=xl24><% = dt_total.Rows[0][1].ToString()%></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
  <td rowspan=4 height=68 width=137 style='border-bottom:.5pt solid black;
  height:51.0pt;width:103pt' align=left valign=top><!--[if gte vml 1]><v:shapetype
   id="_x0000_t75" coordsize="21600,21600" o:spt="75" o:preferrelative="t"
   path="m@4@5l@4@11@9@11@9@5xe" filled="f" stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:2.25pt;margin-top:2.25pt;width:98.25pt;height:48pt;z-index:1'>
   <v:imagedata  o:title="84"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
   
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:3px;width:131px;
  height:64px'><img width=131 height=64
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[0][10].ToString()%>&table_name=TC_FSBINARY" v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=4 height=68 class=xl29 width=137 style='border-bottom:.5pt solid black;
    height:51.0pt;border-top:none;width:103pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td rowspan=4 height=68 width=125 style='border-bottom:.5pt solid black;
  height:51.0pt;width:94pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1026" type="#_x0000_t75" style='position:absolute;margin-left:2.25pt;
   margin-top:2.25pt;width:90pt;height:48pt;z-index:2'>
   <v:imagedata src="" o:title="84"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
   
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:2;margin-left:3px;margin-top:3px;width:120px;
  height:64px'><img width=120 height=64
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[0][11].ToString()%>&table_name=TC_FSBINARY" v:shapes="_x0000_s1026"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=4 height=68 class=xl29 width=125 style='border-bottom:.5pt solid black;
    height:51.0pt;border-top:none;width:94pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
  <td rowspan=4 height=68 width=146 style='border-bottom:.5pt solid black;
  height:51.0pt;width:110pt' align=left valign=top><!--[if gte vml 1]><v:shape
   id="_x0000_s1027" type="#_x0000_t75" style='position:absolute;margin-left:2.25pt;
   margin-top:2.25pt;width:104.25pt;height:48pt;z-index:3'>
   <v:imagedata src="" o:title="84"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
   
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:3;margin-left:3px;margin-top:3px;width:139px;
  height:64px'><img width=139 height=64
  src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt_total.Rows[0][12].ToString()%>&table_name=TC_FSBINARY" v:shapes="_x0000_s1027"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td rowspan=4 height=68 class=xl29 width=146 style='border-bottom:.5pt solid black;
    height:51.0pt;border-top:none;width:110pt'>&nbsp;</td>
   </tr>
  </table>
  </span></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl27 style='height:12.75pt'>Applicant</td>
  <td class=xl30>Emp ID</td>
  <td class=xl24><% = dt_total.Rows[0][2].ToString()%></td>
  <td class=xl24></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl30>Name</td>
  <td colspan=2 class=xl60 style='border-right:.5pt solid black'><% = dt_total.Rows[0][3].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl30>Department</td>
  <td colspan=2 class=xl60 style='border-right:.5pt solid black'><% = dt_total.Rows[0][4].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td class=xl30>Position</td>
  <td colspan=2 class=xl60 style='border-right:.5pt solid black'><% = dt_total.Rows[0][5].ToString()%></td>
  <td class=xl33 style='border-top:none;border-left:none'><% = dt_total.Rows[0][6].ToString()%></td>
  <td class=xl33 style='border-top:none'><% = dt_total.Rows[0][7].ToString()%></td>
  <td class=xl34 style='border-top:none'><% = dt_total.Rows[0][8].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=4 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl36 style='height:15.0pt'>Companion</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>No</td>
  <td class=xl28 style='border-left:none'>EMP ID</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>Name</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>Department</td>
  <td class=xl38 x:str="Position ">Position<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <%
    if (irow_com==0)
    {
    
  %>
 <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl43 style='height:20.1pt;border-top:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black;border-left:
  none'>&nbsp;</td>
  <td class=xl42 style='border-top:none'>&nbsp;</td>
 </tr>
  <%
    }
    else
    { %>
 <%
        for (int i = 0; i < irow_com; i++) 
        {
  %> 
  <tr height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl39 style='height:20.1pt;border-top:none'><% = i+1%></td>
  <td class=xl39 style='border-top:none;border-left:none'><% = dt_Com.Rows[i][0].ToString()%></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'><% = dt_Com.Rows[i][1].ToString()%></td>
  <td colspan=2 class=xl40 style='border-right:.5pt solid black;border-left:
  none'><% = dt_Com.Rows[i][2].ToString()%></td>
  <td class=xl42 style='border-top:none'><% = dt_Com.Rows[i][3].ToString()%></td>
 </tr>
  <%
        }
  } %>

 
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl36 style='height:15.0pt'>Object</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=28 style='mso-height-source:userset;height:21.0pt'>
  <td colspan=7 height=28 class=xl46 style='border-right:.5pt solid black;
  height:21.0pt'><% = dt_total.Rows[0][9].ToString()%></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl36 style='height:15.0pt'>Schedule</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td rowspan=2 height=34 class=xl49 style='border-bottom:.5pt solid black;
  height:25.5pt' x:str="From ">From<span style='mso-spacerun:yes'> </span></td>
  <td rowspan=2 class=xl49 style='border-bottom:.5pt solid black'>To</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>Deaprture</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>Arrival</td>
  <td rowspan=2 class=xl49 style='border-bottom:.5pt solid black'>Plan</td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt;border-top:none;border-left:
  none'>Country</td>
  <td class=xl28 style='border-top:none;border-left:none'>City</td>
  <td class=xl28 style='border-top:none;border-left:none'>Country</td>
  <td class=xl28 style='border-top:none;border-left:none'>City</td>
 </tr>
 <%
    if (irow_sch==0)
    {
    
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 style='height:12.75pt;border-top:none'></td>
  <td class=xl39 style='border-top:none;border-left:none'></td>
  <td class=xl43 style='border-top:none;border-left:none'></td>
  <td class=xl43 style='border-top:none;border-left:none'></td>
  <td class=xl43 style='border-top:none;border-left:none'></td>
  <td class=xl43 style='border-top:none;border-left:none'></td>
  <td class=xl51 width=146 style='border-top:none;border-left:none;width:110pt'></td>
 </tr>
 <%
    }
    else
    { %>
 <%
        for (int i = 0; i < irow_sch; i++) 
        {
  %> 
  <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl39 style='height:12.75pt;border-top:none'><% = dt_Sch.Rows[i][0].ToString()%></td>
  <td class=xl39 style='border-top:none;border-left:none'><% = dt_Sch.Rows[i][1].ToString()%></td>
  <td class=xl43 style='border-top:none;border-left:none'><% = dt_Sch.Rows[i][2].ToString()%></td>
  <td class=xl43 style='border-top:none;border-left:none'><% = dt_Sch.Rows[i][3].ToString()%></td>
  <td class=xl43 style='border-top:none;border-left:none'><% = dt_Sch.Rows[i][4].ToString()%></td>
  <td class=xl43 style='border-top:none;border-left:none'><% = dt_Sch.Rows[i][5].ToString()%></td>
  <td class=xl51 width=146 style='border-top:none;border-left:none;width:110pt'><% = dt_Sch.Rows[i][6].ToString()%></td>
 </tr>
  <%
        }
  } %>

 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl36 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Transporation
  Fee</td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Deaprture</td>
  <td class=xl28 style='border-left:none'>Arrival</td>
  <td colspan=2 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>Transportation By</td>
  <td class=xl28 style='border-left:none'>Amount</td>
  <td class=xl28 style='border-left:none'>Currency</td>
  <td class=xl28 style='border-left:none'>Remark</td>
 </tr>
  <%
    
    if (irow_tra==0)
    {
    
  %>
 <tr class=xl35 height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'></td>
  <td class=xl39 style='border-top:none'></td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black;border-left:
  none'></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl39 style='border-top:none;border-left:none'></td>
  <td class=xl53 width=146 style='border-top:none;width:110pt'></td>
 </tr>
 <%
    }
    else
    { %>
 <%
        
        for (int i = 0; i < irow_tra; i++) 
        {
            sum_tra +=double.Parse(dt_Tra.Rows[i][3].ToString());
  %> 
  <tr class=xl35 height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'><% = dt_Tra.Rows[i][0].ToString()%></td>
  <td class=xl39 style='border-top:none'><% = dt_Tra.Rows[i][1].ToString()%></td>
  <td colspan=2 class=xl44 style='border-right:.5pt solid black;border-left:
  none'><% = dt_Tra.Rows[i][2].ToString()%></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><% = dt_Tra.Rows[i][3].ToString()%></td>
  <td class=xl39 style='border-top:none;border-left:none'><% = dt_Tra.Rows[i][4].ToString()%></td>
  <td class=xl53 width=146 style='border-top:none;width:110pt'><% = dt_Tra.Rows[i][5].ToString()%></td>
 </tr>
  <%
        }
  } %>

 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl27>Sum</td>
  <td class=xl52 style='border-top:none' x:num><%=sum_tra %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl36 style='height:15.0pt'>Other Expense</td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt'>Type</td>
  <td colspan=3 class=xl37 style='border-right:.5pt solid black;border-left:
  none'>Descirption</td>
  <td class=xl28 style='border-left:none'>Amount</td>
  <td class=xl28 style='border-left:none'>Currency</td>
  <td class=xl28 style='border-left:none'>Remark</td>
 </tr>
 <%
    if (irow_oth==0)
    {
    
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'></td>
  <td colspan=3 class=xl55 width=312 style='border-right:.5pt solid black;
  width:234pt'></td>
  <td class=xl52 style='border-top:none;border-left:none'></td>
  <td class=xl39 style='border-top:none;border-left:none'></td>
  <td class=xl58 width=146 style='border-top:none;width:110pt'></td>
 </tr>
 <%
    }
    else
    { %>
 <%
        
        for (int i = 0; i < irow_oth; i++) 
        {
            sum_oth+=double.Parse(dt_Oth.Rows[i][2].ToString());
  %> 
   <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl44 style='height:12.75pt;border-top:none'><%=dt_Oth.Rows[i][0].ToString() %></td>
  <td colspan=3 class=xl55 width=312 style='border-right:.5pt solid black;
  width:234pt'><%=dt_Oth.Rows[i][1].ToString() %></td>
  <td class=xl52 style='border-top:none;border-left:none' x:num><%=dt_Oth.Rows[i][2].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'><%=dt_Oth.Rows[i][3].ToString() %></td>
  <td class=xl58 width=146 style='border-top:none;width:110pt'><%=dt_Oth.Rows[i][4].ToString() %></td>
 </tr>
 <%
        }
  } %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=3 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl27>Sum</td>
  <td class=xl52 style='border-top:none'  x:num><%=sum_oth %></td>
  <td colspan=2 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=126 style='width:95pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=137 style='width:103pt'></td>
  <td width=125 style='width:94pt'></td>
  <td width=146 style='width:110pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
