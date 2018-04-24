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
    
    string p_times,p_rpt_month;
     
    p_times       = Request["l_times"].ToString();
    p_rpt_month  = Request["l_rpt_month"].ToString();
     /*nhung loai duoc the hien tren 02 a */
    string SQL_1 = " select code  from vhr_hr_code where id='HR0041' and num_2 = '2' ";
    DataTable dt_type = ESysLib.TableReadOpen(SQL_1);
    
    
    int row_type;
    row_type = dt_type.Rows.Count;
    string ins_type ="01";
    if (row_type == 0)
    {
        ins_type = "01";
    }
    else
    {
        ins_type = "";
        for (int i = 0; i < row_type; i++)
        {
            ins_type = ins_type + dt_type.Rows[i][0].ToString() +",";
            
        }
        ins_type = ins_type.ToString().Substring(0, ins_type.ToString().Length -1);
    }
    string SQL
     = "SELECT    " +
         " initcap(A.FULL_NAME)  c2   " +
         ",A.SO_BHXH c3   " +
         ",DECODE(LENGTH(A.BIRTH_DT),4,A.BIRTH_DT,TO_CHAR(TO_DATE(A.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')) AS NGAYSINH4    " +
         ",DECODE(A.SEX,'F','X','') AS SEXc5   " +
         ",e.PERMANENT_ADDR c7   " +
         ",(SELECT CHAR_1 FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE)  AS TINH8   " +
         ",(SELECT CHAR_2 FROM VHR_HR_CODE V WHERE V.ID='HR0012' AND V.CODE=A.HEALTH_PLACE) AS BENHVIEN9   " +
         ",(select code_fnm from vhr_hr_code v where v.id='HR008' and v.code=e.POS_TYPE )  c10 " +
         ",nvl(A.LUONG_MOI,0) c11   " +
         ",0  c12 " +
         ",0 c13 " +
         ",0 c14 " +
         ",0 c15 " +
         ",a.TU_THANG c16 " +
         ",'' ghi_chuc17 " +
         ",'TM' c18 " +
         ",'28.5' c19 " +
         ",(select max(g.ORG_ID) from comm.tco_org g where g.del_if=0 and nvl(g.p_pk,0)=0 start with g.pk=nvl(e.POS_TYPE,' ') connect by prior g.p_pk=g.pk )||'/'||(select v.char_1 from vhr_hr_code v where v.id='HR008' and v.code=e.POS_TYPE )||'-'||e.emp_id  c20 " +
         ",e.PERSON_ID c21 " +
         ",case when length(e.ISSUE_DT)=8 then to_char(to_date(e.ISSUE_DT,'yyyymmdd'),'dd/mm/yyyy') end c22 " +
         ",(select code_nm from vhr_hr_code v where v.id='HR014' and v.code=nvl(e.PLACE_PER_ID,' ') ) c23 " +
         ",(select nvl(char_1,'') from vhr_hr_code v where v.id='HR014' and v.code=nvl(e.PLACE_PER_ID,' ') ) c24 " +
         ",e.PERMANENT_ADDR c25 " +
         ",substr(e.BIRTH_DT,1,4) c26 " +
         ",''  c27 " +
         ",(select code_fnm from vhr_hr_code v where v.id='HR0015' and v.code=e.ETHNIC_TYPE ) c28 " +
         ",(select code_fnm from vhr_hr_code v where v.id='HR0009' and v.code=e.nation ) c29 " +
         ",case when e.BEGIN_CONTRACT is not null and substr(e.BEGIN_CONTRACT,-2) > '16' then to_char(to_char(TU_THANG,'yyyymm'),'16/mm/yyyy') else to_char(to_char(e.BEGIN_CONTRACT,'yyyymmdd'),'dd/mm/yyyy') end  c30    " +
         ",3  c31 " +
         "FROM THR_INSURANCE_MANAGE A,thr_employee e,(select code,num_1,CHAr_3 from vhr_hr_code where id='HR0041') ins_type " +
        "WHERE A.DEL_IF=0 and a.LOAI_BH=ins_type.code AND A.THANG_BC='" + p_rpt_month + "' " +
        "AND A.LOAI_BH in (" + ins_type + ") " +
        "AND e.del_if=0 and e.pk=a.thr_emp_pk and  A.LAN_BAO='" + p_times + "' " +
        "ORDER BY ins_type.num_1, A.EMP_ID ";

   

//Response.Write(SQL);
//Response.End();
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow_emp,icol_emp;
    irow_emp = dt_Emp.Rows.Count;
        if (irow_emp == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
  
    %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Copy%20of%2002tbh_files/filelist.xml">
<link rel=Edit-Time-Data href="Copy%20of%2002tbh_files/editdata.mso">
<link rel=OLE-Object-Data href="Copy%20of%2002tbh_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HAINX</o:Author>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:Created>2007-12-27T05:35:09Z</o:Created>
  <o:LastSaved>2011-09-19T08:52:33Z</o:LastSaved>
  <o:Company>FBSOFT</o:Company>
  <o:Version>11.5606</o:Version>
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
.font6
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
.font7
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
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
.style20
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
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
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	color:red;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	color:red;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:yellow;
	mso-pattern:auto none;
	white-space:normal;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl37
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl38
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl39
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl44
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl45
	{mso-style-parent:style20;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl46
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt hairline windowtext;}
.xl48
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", sans-serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border-top:.5pt solid windowtext;
	border-right:.5pt hairline windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:LeftColumnVisible>1</x:LeftColumnVisible>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>1</x:SplitHorizontal>
     <x:TopRowBottomPane>1</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveCol>8</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5805</x:WindowHeight>
  <x:WindowWidth>15345</x:WindowWidth>
  <x:WindowTopX>-45</x:WindowTopX>
  <x:WindowTopY>3300</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="3098" fillcolor="none [9]">
  <v:fill color="none [9]"/>
 </o:shapedefaults></xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="2"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2172 style='border-collapse:
 collapse;table-layout:fixed;width:1629pt'>
 <col class=xl25 width=49 style='mso-width-source:userset;mso-width-alt:1792;
 width:37pt'>
 <col class=xl24 width=113 style='mso-width-source:userset;mso-width-alt:4132;
 width:85pt'>
 <col class=xl24 width=87 style='mso-width-source:userset;mso-width-alt:3181;
 width:65pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl26 width=165 style='mso-width-source:userset;mso-width-alt:6034;
 width:124pt'>
 <col class=xl24 width=66 style='mso-width-source:userset;mso-width-alt:2413;
 width:50pt'>
 <col class=xl24 width=60 style='mso-width-source:userset;mso-width-alt:2194;
 width:45pt'>
 <col class=xl24 width=86 style='mso-width-source:userset;mso-width-alt:3145;
 width:65pt'>
 <col class=xl24 width=102 style='mso-width-source:userset;mso-width-alt:3730;
 width:77pt'>
 <col class=xl24 width=35 span=4 style='mso-width-source:userset;mso-width-alt:
 1280;width:26pt'>
 <col class=xl24 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl24 width=72 style='mso-width-source:userset;mso-width-alt:2633;
 width:54pt'>
 <col class=xl24 width=29 style='mso-width-source:userset;mso-width-alt:1060;
 width:22pt'>
 <col class=xl24 width=38 style='mso-width-source:userset;mso-width-alt:1389;
 width:29pt'>
 <col class=xl24 width=79 span=4 style='mso-width-source:userset;mso-width-alt:
 2889;width:59pt'>
 <col class=xl24 width=93 style='mso-width-source:userset;mso-width-alt:3401;
 width:70pt'>
 <col class=xl24 width=79 span=3 style='mso-width-source:userset;mso-width-alt:
 2889;width:59pt'>
 <col class=xl24 width=64 style='width:48pt'>
 <col class=xl24 width=74 style='mso-width-source:userset;mso-width-alt:2706;
 width:56pt'>
 <col class=xl24 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl24 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <tr class=xl27 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td class=xl29 width=113 style='border-left:none;width:85pt'>STT</td>
  <td class=xl29 width=113 style='border-left:none;width:85pt'>HOTEN</td>
  <td class=xl29 width=87 style='border-left:none;width:65pt'>SOBHXH</td>
  <td class=xl29 width=79 style='border-left:none;width:59pt'>NGAYSINH</td>
  <td class=xl29 width=64 style='border-left:none;width:48pt'>GIOITINH</td>
  <td class=xl29 width=165 style='border-left:none;width:124pt'>DIACHI</td>
  <td class=xl29 width=66 style='border-left:none;width:50pt'>MA_TINH</td>
  <td class=xl29 width=60 style='border-left:none;width:45pt'>MA_BV</td>
  <td class=xl29 width=86 style='border-left:none;width:65pt'>MACV</td>
  <td class=xl29 width=35 style='border-left:none;width:26pt'>ML</td>
  <td class=xl29 width=35 style='border-left:none;width:26pt'>PC1</td>
  <td class=xl29 width=35 style='border-left:none;width:26pt'>PC2</td>
  <td class=xl29 width=35 style='border-left:none;width:26pt'>PC3</td>
  <td class=xl29 width=35 style='border-left:none;width:26pt'>PC4</td>
  <td class=xl29 width=76 style='border-left:none;width:57pt'>TUTHANG</td>
  <td class=xl29 width=72 style='border-left:none;width:54pt'>GHICHU</td>
  <td class=xl29 width=29 style='border-left:none;width:22pt'>PA</td>
  <td class=xl29 width=38 style='border-left:none;width:29pt'>TYLE</td>
  <td class=xl29 width=79 style='border-left:none;width:59pt'>MAPB</td>
  <td class=xl29 width=79 style='border-left:none;width:59pt'>SOCMND</td>
  <td class=xl29 width=79 style='border-left:none;width:59pt'>NGAYCMND</td>
  <td class=xl29 width=79 style='border-left:none;width:59pt'>NOICAP</td>
  <td class=xl29 width=93 style='border-left:none;width:70pt'>MA_TINHCMT</td>
  <td class=xl29 width=79 style='border-left:none;width:59pt'>NOIKHAI</td>
  <td class=xl29 width=79 style='border-left:none;width:59pt'>NAMSINH</td>
  <td class=xl29 width=79 style='border-left:none;width:59pt'>MADT</td>
  <td class=xl29 width=64 style='border-left:none;width:48pt'>DANTOC</td>
  <td class=xl29 width=74 style='border-left:none;width:56pt'>QUOCTICH</td>
  <td class=xl30 width=79 style='border-left:none;width:59pt'>TUNGAY</td>
  <td class=xl31 width=83 style='border-left:none;width:62pt'>SOTHANG</td>
 </tr>
 <% for (int i = 0; i < dt_Emp.Rows.Count; i++)
    {%>
 <tr class=xl28 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl34 style='height:18.0pt;border-top:none' x:num><%=i+1 %></td>
  <td class=xl35 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][0].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][3].ToString() %></td>
  <td class=xl36 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][5].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][6].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][7].ToString() %></td>
  <td class=xl48 align=right style='border-top:none;border-left:none'  x:num><%=dt_Emp.Rows[i][8].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][9].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][10].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][11].ToString() %></td>
  <td class=xl38 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][12].ToString() %></td>
  <td class=xl39 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][13].ToString() %></td>
  <td class=xl37 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][14].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][15].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][16].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][17].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none' x:str><%=dt_Emp.Rows[i][18].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][19].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][20].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][21].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][22].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][23].ToString() %></td>
  <td class=xl32 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][24].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][25].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][26].ToString() %></td>
  <td class=xl35 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][27].ToString() %></td>
  <td class=xl40 style='border-top:none;border-left:none'x:str><%=dt_Emp.Rows[i][28].ToString() %></td>
 </tr>
 <%} %>
 <tr class=xl28 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl41 style='height:18.0pt;border-top:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl43 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl45 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl46 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl44 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl42 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl47 style='border-top:none;border-left:none'>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=49 style='width:37pt'></td>
  <td width=113 style='width:85pt'></td>
  <td width=87 style='width:65pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=165 style='width:124pt'></td>
  <td width=66 style='width:50pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=86 style='width:65pt'></td>
  <td width=102 style='width:77pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=35 style='width:26pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=38 style='width:29pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=93 style='width:70pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=74 style='width:56pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=83 style='width:62pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
