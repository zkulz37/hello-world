<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%   ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%

    string p_work_mon = Request.QueryString[0].ToString();
    string l_tco_org_pk = Request.QueryString[1].ToString();    
    int month = int.Parse(p_work_mon.Substring(4, 2));
    int year = int.Parse(p_work_mon.Substring(0, 4));
    string _name = "";
    //Response.Write(year+ " " +month);
    //Response.End();
    string quy = "", month1,month2,month3;
    if (month > 9)
    {
        month1 = year + "10";
        month2 = year + "11";
        month3 = year + "12";
        quy = "IV";
        _name = "fourth";
    }
    else if (month > 6)
    {
        month1 = year + "07";
        month2 = year + "08";
        month3 = year + "09";
        quy = "III";
        _name = "third";
    }
    else if (month > 3)
    {
        month1 = year + "04";
        month2 = year + "05";
        month3 = year + "06";
        quy = "II";
        _name = "second";
    }
    else
    {
        month1 = year + "01";
        month2 = year + "02";
        month3 = year + "03";
        quy = "I";
        _name = "first";
    }
    
    string SQL1
    = "select nvl(round(sum(decode(A.INS_REG_TYPE,'01',nvl(A.INS_AMT,0),0)),0),0) c01 " +
        "        ,nvl(round(sum(decode(A.INS_REG_TYPE,'02',nvl(A.INS_AMT,0),0)),0),0) c02 " +
        "        ,nvl(round(sum(decode(A.INS_REG_TYPE,'03',nvl(A.INS_AMT,0),0)),0),0) c03 " +
        "        ,nvl(round(sum(decode(A.INS_REG_TYPE,'04',nvl(A.INS_AMT,0),0)),0),0) c04 " +
        "        ,to_char(sysdate,'dd') c05 " +
        "        ,to_char(sysdate,'mm') c06 " +
        "        ,to_char(sysdate,'yyyy') c07 " +
        "        ,to_char(to_date('" + month1 + "','yyyymm'),'MON-YYYY') c08    " +
        "        ,to_char(to_date('" + month2 + "','yyyymm'),'MON-YYYY') c09   " +
        "        ,to_char(to_date('" + month3 + "','yyyymm'),'MON-YYYY') c10   " +
        "from thr_ins_regulation a " +
        "where A.DEL_IF=0 " +
        "and A.INS_MONTH in ('" + month1 + "','" + month2 + "','" + month3 + "') " +
        "group by to_char(sysdate,'dd'),to_char(sysdate,'mm'),to_char(sysdate,'yyyy') " +
        "        ,to_char(to_date('" + month1 + "','yyyymm'),'MON-YYYY')    " +
        "        ,to_char(to_date('" + month2 + "','yyyymm'),'MON-YYYY')    " +
        "        ,to_char(to_date('" + month3 + "','yyyymm'),'MON-YYYY')    " +
        "order by c01 ";
    //Response.Write(SQL1);
    //Response.End();
    DataTable dt1 = ESysLib.TableReadOpen(SQL1);
    if (dt1.Rows.Count == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }
    
    string SQL2
    = "select nvl(round(sum(decode(S.WORK_MON,'" + month1 + "', nvl(S.SALARY_SI,0),0))*0.02),0) c01 " +
        "        ,nvl(round(sum(decode(S.WORK_MON,'" + month2 + "', nvl(S.SALARY_SI,0),0))*0.02),0) c02 " +
        "        ,nvl(round(sum(decode(S.WORK_MON,'" + month3 + "', nvl(S.SALARY_SI,0),0))*0.02),0) c03 " +
        "from thr_month_salary s " +
        "where S.DEL_IF=0 " +
        "and s.work_mon in ('" + month1 + "','" + month2 + "','" + month3 + "') " +
        "and nvl(S.SOCIAL_AMT,0) > 0 ";

    DataTable dt2 = ESysLib.TableReadOpen(SQL2);

    //lấy chữ ký của tổng giám đốc
    string SQLSign
    = "select V.CHAR_1 char_1, V.CHAR_2 char_2, V.CODE_NM code_nm, V.CODE_KNM code_nm2 " +
        "from vhr_hr_code v " +
        "where V.ID='HR0048' " +
        "and V.CODE='08' ";

    DataTable dt_sign = ESysLib.TableReadOpen(SQLSign);

    string SQL_Com
    = "select  a.PARTNER_LNAME,a.ADDR1,a.PHONE_NO,a.TCO_BPPHOTO_PK,to_char(to_date('" + p_work_mon + "','yyyymm'),'MON-YYYY'),to_char(to_date('" + p_work_mon + "','yyyymm'),'MM-YYYY') " +
        "from tco_company a " +
        "where a.DEL_IF=0 " +
        "and a.pk in ( select tco_company_pk from  " +
        "               tco_org  f " +
        "               where  f.pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM tco_org g " +
        "                                   WHERE g.del_if = 0 " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + l_tco_org_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + l_tco_org_pk + "' " +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + l_tco_org_pk + "' = 'ALL') " +
        "and rownum=1 ";


    DataTable dt_com = ESysLib.TableReadOpen(SQL_Com);
    int irow_com;
    irow_com = dt_com.Rows.Count;
    if (irow_com == 0)
    {
        Response.Write("There is no data of company");
        Response.End();
    }
    /**/
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="quyettoanquy2_files/filelist.xml">
<link rel=Edit-Time-Data href="quyettoanquy2_files/editdata.mso">
<link rel=OLE-Object-Data href="quyettoanquy2_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>cun</o:Author>
  <o:LastAuthor>cun</o:LastAuthor>
  <o:Created>2013-01-21T08:49:41Z</o:Created>
  <o:LastSaved>2013-01-21T09:01:20Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
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
.font5
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:#33CCCC;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:#33CCCC;
	font-size:11.0pt;
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
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl33
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl35
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl38
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl42
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl44
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl45
	{mso-style-parent:style16;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl46
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl47
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl48
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl51
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$USD\]\\ \#\,\#\#0\.00";
	text-align:left;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$USD\]\\ \#\,\#\#0\.00";
	text-align:left;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:StandardWidth>2011</x:StandardWidth>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:RangeSelection>$4:$4</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8490</x:WindowHeight>
  <x:WindowWidth>19875</x:WindowWidth>
  <x:WindowTopX>360</x:WindowTopX>
  <x:WindowTopY>375</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1180 style='border-collapse:
 collapse;table-layout:fixed;width:884pt'>
 <col class=xl24 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl24 width=175 style='mso-width-source:userset;mso-width-alt:6400;
 width:131pt'>
 <col class=xl24 width=118 style='mso-width-source:userset;mso-width-alt:4315;
 width:89pt'>
 <col class=xl24 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl24 width=223 style='mso-width-source:userset;mso-width-alt:8155;
 width:167pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl24 width=99 style='mso-width-source:userset;mso-width-alt:3620;
 width:74pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=119 style='mso-width-source:userset;mso-width-alt:4352;
 width:89pt'>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 width=31 style='height:25.5pt;width:23pt' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
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
  </v:shapetype><v:shape id="Picture_x0020_4" o:spid="_x0000_s1028" type="#_x0000_t75"
   alt="posco ss-vina logo" style='position:absolute;margin-left:0;
   margin-top:0;width:107.25pt;height:56.25pt;z-index:4;visibility:visible'>
   <v:imagedata src="quyettoanquy2_files/image001.jpg" o:title="posco ss-vina logo"/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:4;margin-left:0px;margin-top:0px;width:143px;
  height:75px'><img width=143 height=75 src="quyettoanquy2_files/image002.jpg"
  alt="posco ss-vina logo" v:shapes="Picture_x0020_4"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=34 class=xl24 width=31 style='height:25.5pt;width:23pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 colspan=3 width=400 style='mso-ignore:colspan;width:300pt'><span
  style='mso-spacerun:yes'>                                               
  </span><%=dt_com.Rows[0][0].ToString() %></td>
  <td class=xl24 width=223 style='width:167pt'></td>
  <td class=xl24 width=45 style='width:34pt'></td>
  <td class=xl24 width=99 style='width:74pt'></td>
  <td class=xl24 width=63 style='width:47pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=90 style='width:68pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=119 style='width:89pt'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl24 style='height:23.25pt'></td>
  <td class=xl26 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                                          
  </span><%=dt_com.Rows[0][1].ToString() %></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 colspan=12 class=xl24 style='height:19.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=5 height=27 class=xl51 style='height:20.25pt'>Settlement of sick
  allowance, maternity allowance in the <%=_name %> quarter</td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td height=27 colspan=5 class=xl28 style='height:20.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl27 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl29><span style='mso-spacerun:yes'> </span>Ngày <font
  class="font9">(day) <%=dt1.Rows[0]["c05"].ToString() %> </font><font class="font5">tháng </font><font
  class="font9">(month) <%=dt1.Rows[0]["c06"].ToString() %> </font><font class="font5">năm </font><font
  class="font9">(year)</font><font class="font5"> <%=dt1.Rows[0]["c07"].ToString() %></font></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=28 style='mso-height-source:userset;height:21.0pt'>
  <td height=28 class=xl30 style='height:21.0pt'>I.</td>
  <td class=xl30 colspan=4 style='mso-ignore:colspan'>Social Insurance paid
  amount of sick allowance, maternity allowance in the <%=_name %> quarter:</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl24>Sickness :</td>
  <td class=xl24></td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'>          
  </span><%=dt1.Rows[0]["c01"].ToString() %> </td>
  <td class=xl32></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Pregnancy :</td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'>          
  </span><%=dt1.Rows[0]["c02"].ToString() %> </td>
  <td class=xl32></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Convalescence(maternity):</td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'>          
  </span><%=dt1.Rows[0]["c03"].ToString() %> </td>
  <td class=xl32></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl24 colspan=2 style='mso-ignore:colspan'>Convalescence(sickness):</td>
  <td class=xl31 x:num><span style='mso-spacerun:yes'>          
  </span><%=dt1.Rows[0]["c04"].ToString() %> </td>
  <td class=xl32></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=3 class=xl24 style='height:6.0pt;mso-ignore:colspan'></td>
  <td class=xl33>&nbsp;</td>
  <td class=xl32></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
     double subttl = double.Parse(dt1.Rows[0]["c01"].ToString())
                    + double.Parse(dt1.Rows[0]["c02"].ToString())
                    + double.Parse(dt1.Rows[0]["c03"].ToString())
                    + double.Parse(dt1.Rows[0]["c04"].ToString());
      %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl34>Total:</td>
  <td class=xl24></td>
  <td class=xl35 x:num><span
  style='mso-spacerun:yes'>        </span><%=subttl %></td>
  <td class=xl36>VND.</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl37></td>
  <td class=xl38></td>
  <td class=xl39></td>
  <td class=xl32></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl30 style='height:20.25pt'>II.</td>
  <td class=xl30 colspan=3 style='mso-ignore:colspan'
  x:str="The company keep 2% in the fourth quarter: ">The company keep 2% in
  the fourth quarter:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl41></td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl24>In <%=dt1.Rows[0]["c08"].ToString() %>:</td>
  <td class=xl24></td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'>       
  </span><%=dt2.Rows[0]["c01"].ToString() %> </td>
  <td class=xl32></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl24>In <%=dt1.Rows[0]["c09"].ToString() %>:</td>
  <td class=xl24></td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'>       
  </span><%=dt2.Rows[0]["c02"].ToString() %> </td>
  <td class=xl32></td>
  <td class=xl24></td>
  <td class=xl43></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt' align=left valign=top></td>
  <td class=xl24>In <%=dt1.Rows[0]["c10"].ToString() %>:</td>
  <td class=xl24></td>
  <td class=xl42 x:num><span style='mso-spacerun:yes'>       
  </span><%=dt2.Rows[0]["c03"].ToString() %> </td>
  <td class=xl32></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=3 class=xl24 style='height:5.25pt;mso-ignore:colspan'></td>
  <td class=xl44>&nbsp;</td>
  <td class=xl32></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <%
     double subttl2 = double.Parse(dt2.Rows[0]["c01"].ToString()) + double.Parse(dt2.Rows[0]["c02"].ToString()) + double.Parse(dt2.Rows[0]["c03"].ToString());  %>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl34>Total:</td>
  <td class=xl24></td>
  <td class=xl45 x:num ><span
  style='mso-spacerun:yes'>      </span><%=subttl2%> </td>
  <td class=xl36>VND.</td>
  <td class=xl24></td>
  <td class=xl43></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl24 style='height:20.25pt'></td>
  <td class=xl37></td>
  <td class=xl46></td>
  <td class=xl39></td>
  <td class=xl32></td>
  <td class=xl24></td>
  <td class=xl43></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl30 style='height:20.25pt'>III.</td>
  <td class=xl30 colspan=3 style='mso-ignore:colspan'>
  <%
      if (subttl2 > subttl)
      {     %>Our company must pay for Social Insurance :
          <%}
      else
      { %> Social Insurance must pay for Our company <%} %> </td>
  <td class=xl41></td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 style='height:20.25pt' align=left valign=top></td>
  <td class=xl47 colspan=1 style='mso-ignore:colspan'><%
                                                          if (subttl2 > subttl)
                                                          {     %> [II] - [I] = <%=subttl2 %> -  <%=subttl %> = 
      <%}
                                                          else
                                                          { %>
      [I] - [II] = <%=subttl %> -  <%=subttl2 %> = 
      <%} %>
       </td>
  <td class=xl36></td>
  <td class=xl45 x:num>
  <%
                                                          if (subttl2 > subttl)
                                                          {     %>  <%=subttl2-subttl %>
      <%}
                                                          else
                                                          { %>
       <%=subttl-subttl2 %>
      <%} %>
  </td>
  <td class=xl36>VND.</td>
  <td colspan=2 class=xl30 style='mso-ignore:colspan'></td>
  <td class=xl49></td>
  <td class=xl30></td>
  <td class=xl49></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 colspan=3 class=xl24 style='height:20.25pt;mso-ignore:colspan'></td>
  <td class=xl39></td>
  <td class=xl32></td>
  <td class=xl24></td>
  <td class=xl43></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=53 style='mso-height-source:userset;height:39.75pt'>
  <td colspan=2 height=53 class=xl52 width=206 style='height:39.75pt;
  width:154pt'><span style='mso-spacerun:yes'>  </span>Người lập <font
  class="font12">(Proposed by):</font></td>
  <td colspan=2 class=xl53 width=225 style='width:169pt'>Người kiểm tra<font
  class="font12"> (Checked by):</font></td>
  <td class=xl50 width=223 style='width:167pt'>Người ký duyệt <font
  class="font13">(</font><font class="font12">Approved by):</font></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=52 style='mso-height-source:userset;height:39.0pt'>
  <td height=52 class=xl24 style='height:39.0pt'></td>
  <td class=xl26></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl24 style='height:16.5pt'></td>
  <td class=xl26></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl29 style='height:15.0pt'>_____________________</td>
  <td class=xl26 colspan=2 style='mso-ignore:colspan'>_____________________</td>
  <td class=xl24><span style='mso-spacerun:yes'>      
  </span>______________________</td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl37 style='height:15.0pt'>Nguyen Thi Van</td>
  <td colspan=2 class=xl25><span style='mso-spacerun:yes'>        </span><%=dt_sign.Rows[0]["code_nm"].ToString() %></td>
  <td class=xl37><%=dt_sign.Rows[0]["code_nm2"].ToString() %></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl26></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl29></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl29></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl29></td>
  <td colspan=10 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=12 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>

 </tr>
 <![endif]>
</table>

</body>

</html>
