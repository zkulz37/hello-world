﻿<%@ Page Language="C#"%>
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
    = "select nvl(round(sum(decode(S.WORK_MON,'" + month1 + "', nvl(S.SALARY_SI,0),0))*0.2),0) c01 " +
        "        ,nvl(round(sum(decode(S.WORK_MON,'" + month2 + "', nvl(S.SALARY_SI,0),0))*0.2),0) c02 " +
        "        ,nvl(round(sum(decode(S.WORK_MON,'" + month3 + "', nvl(S.SALARY_SI,0),0))*0.2),0) c03 " +
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
<link rel=File-List href="quyettoanquy1_files/filelist.xml">
<link rel=Edit-Time-Data href="quyettoanquy1_files/editdata.mso">
<link rel=OLE-Object-Data href="quyettoanquy1_files/oledata.mso">
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
  <o:Created>2013-01-21T08:48:29Z</o:Created>
  <o:LastSaved>2013-01-21T08:51:13Z</o:LastSaved>
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
.font10
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font17
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font18
	{color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font19
	{color:#33CCCC;
	font-size:11.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font20
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
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl26
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:VNI-Helve-Condense;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	text-align:left;}
.xl27
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl28
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl31
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl32
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl33
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";}
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl48
	{mso-style-parent:style16;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$USD\]\\ \#\,\#\#0\.00";}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0";}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl56
	{mso-style-parent:style0;
	font-size:22.0pt;}
.xl57
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0";
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl58
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0";
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl59
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Wingdings 2", serif;
	mso-font-charset:2;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$USD\]\\ \#\,\#\#0\.00";}
.xl62
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0";}
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	white-space:normal;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Wingdings 2", serif;
	mso-font-charset:2;}
.xl66
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$VND\]\\ \#\,\#\#0";
	text-align:left;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:left;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$USD\]\\ \#\,\#\#0\.00";
	text-align:left;
	white-space:normal;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\[$USD\]\\ \#\,\#\#0\.00";
	text-align:left;}
.xl70
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl71
	{mso-style-parent:style0;
	font-size:16.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl72
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:StandardWidth>2011</x:StandardWidth>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:RangeSelection>$A$5:$E$5</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8775</x:WindowHeight>
  <x:WindowWidth>20115</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>90</x:WindowTopY>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=1213 style='border-collapse:
 collapse;table-layout:fixed;width:909pt'>
 <col class=xl24 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col class=xl24 width=224 style='mso-width-source:userset;mso-width-alt:8192;
 width:168pt'>
 <col class=xl24 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl24 width=104 style='mso-width-source:userset;mso-width-alt:3803;
 width:78pt'>
 <col class=xl24 width=207 style='mso-width-source:userset;mso-width-alt:7570;
 width:155pt'>
 <col class=xl24 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl24 width=71 style='mso-width-source:userset;mso-width-alt:2596;
 width:53pt'>
 <col class=xl24 width=63 style='mso-width-source:userset;mso-width-alt:2304;
 width:47pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:68pt'>
 <col class=xl24 width=55 style='mso-width-source:userset;mso-width-alt:2011;
 width:41pt'>
 <col class=xl24 width=171 style='mso-width-source:userset;mso-width-alt:6253;
 width:128pt'>
 <tr height=34 style='mso-height-source:userset;height:25.5pt'>
  <td height=34 width=23 style='height:25.5pt;width:17pt' align=left
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
  </v:shapetype><v:shape id="Picture_x0020_6" o:spid="_x0000_s1025" type="#_x0000_t75"
   alt="posco ss-vina logo" style='position:absolute;margin-left:2.25pt;
   margin-top:0;width:90.75pt;height:49.5pt;z-index:1;visibility:visible'>
   <v:imagedata src="quyettoanquy1_files/image001.jpg" o:title="posco ss-vina logo"/>
   <x:ClientData ObjectType="Pict">
    <x:CF>Bitmap</x:CF>
    <x:AutoPict/>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:3px;margin-top:0px;width:121px;
  height:66px'><img width=121 height=66 src="quyettoanquy1_files/image002.jpg"
  alt="posco ss-vina logo" v:shapes="Picture_x0020_6"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=34 class=xl24 width=23 style='height:25.5pt;width:17pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl25 colspan=2 width=329 style='mso-ignore:colspan;width:247pt'><span
  style='mso-spacerun:yes'>                                               
  </span><%=dt_com.Rows[0][0].ToString() %></td>
  <td class=xl24 width=104 style='width:78pt'></td>
  <td class=xl24 width=207 style='width:155pt'></td>
  <td class=xl24 width=45 style='width:34pt'></td>
  <td class=xl24 width=71 style='width:53pt'></td>
  <td class=xl24 width=63 style='width:47pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=90 style='width:68pt'></td>
  <td class=xl24 width=55 style='width:41pt'></td>
  <td class=xl24 width=171 style='width:128pt'></td>
 </tr>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl24 style='height:23.25pt'></td>
  <td class=xl26 colspan=3 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                                          
  </span><%=dt_com.Rows[0][1].ToString() %></td>
  <td colspan=8 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=16 style='mso-height-source:userset;height:12.0pt'>
  <td height=16 colspan=12 class=xl24 style='height:12.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=5 height=27 class=xl70 style='height:20.25pt'>GIẤY ĐỀ NGHỊ THANH
  TOÁN / TẠM ỨNG</td>
  <td class=xl27></td>
  <td colspan=6 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='height:20.25pt'>
  <td colspan=5 height=27 class=xl71 style='height:20.25pt'>(PAYMENT / ADVANCE
  PAYMENT REQUEST)</td>
  <td colspan=3 class=xl28 style='mso-ignore:colspan'></td>
  <td colspan=4 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=2 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl29><span style='mso-spacerun:yes'>         </span>Ngày <font
  class="font11">(day) <%=dt1.Rows[0]["c05"].ToString() %> </font><font class="font10">tháng </font><font
  class="font11">(month) <%=dt1.Rows[0]["c06"].ToString() %> </font><font class="font10">năm </font><font
  class="font11">(year)</font><font class="font10"> <%=dt1.Rows[0]["c07"].ToString() %></font></td>
  <td colspan=7 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=19 style='height:14.25pt'>
  <td height=19 colspan=12 class=xl24 style='height:14.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 colspan=2 style='height:15.0pt;mso-ignore:colspan'>Họ
  và tên<font class="font11"> (Full name)</font><font class="font10">: Nguyen
  Thi Van</font></td>
  <td class=xl30></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>Mã nhân viên: <font
  class="font11">(Employee code)</font><font class="font10">: 200240</font></td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl30 colspan=2 style='height:20.25pt;mso-ignore:colspan'>Phòng
  <font class="font11">(Dept.)</font><font class="font10">: A &amp; S Dept.</font></td>
  <td class=xl30></td>
  <td class=xl32></td>
  <td class=xl33></td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=4 class=xl30 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl32>Unit: VND</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl29 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl34 style='height:18.0pt'>Stt</td>
  <td class=xl35 style='border-left:none'>Nội dung</td>
  <td class=xl35 style='border-left:none'>Số hóa đơn</td>
  <td class=xl35 style='border-left:none'>Số tiền</td>
  <td class=xl35 style='border-left:none'>Ghi rõ mục đích</td>
  <td colspan=7 class=xl29 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl39 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl36 style='height:20.25pt'>No.</td>
  <td class=xl37 style='border-left:none'>Description</td>
  <td class=xl37 style='border-left:none'>Invoice no.</td>
  <td class=xl37 style='border-left:none'>Amount</td>
  <td class=xl38 width=207 style='border-left:none;width:155pt'>Specified
  purposes</td>
  <td colspan=7 class=xl39 style='mso-ignore:colspan'></td>
 </tr>
 <%
     double subttl = double.Parse(dt1.Rows[0]["c01"].ToString())
                    + double.Parse(dt1.Rows[0]["c02"].ToString())
                    + double.Parse(dt1.Rows[0]["c03"].ToString())
                    + double.Parse(dt1.Rows[0]["c04"].ToString());
      %>
  <%
     double subttl2 = double.Parse(dt2.Rows[0]["c01"].ToString()) + double.Parse(dt2.Rows[0]["c02"].ToString()) + double.Parse(dt2.Rows[0]["c03"].ToString());  %>
 <tr class=xl30 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl40 style='height:26.25pt' x:num>1</td>
  <td class=xl41 style='border-left:none'>Payment for SI dept amount 2% in</td>
  <td class=xl42 width=105 style='border-left:none;width:79pt'>&nbsp;</td>
  <td class=xl43 style='border-left:none' x:num><span
  style='mso-spacerun:yes'>        </span><% if (subttl2 > subttl)
                                             { %> <%=subttl2-subttl %> <%} %> </td>
  <td class=xl41 style='border-left:none'>Payment for SI dept.</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=35 style='mso-height-source:userset;height:26.25pt'>
  <td height=35 class=xl40 style='height:26.25pt'>&nbsp;</td>
  <td class=xl41 style='border-left:none'>the fourth quarter.</td>
  <td class=xl42 width=105 style='border-left:none;width:79pt'>&nbsp;</td>
  <td class=xl43 style='border-left:none'>&nbsp;</td>
  <td class=xl44 width=207 style='border-left:none;width:155pt'>&nbsp;</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl45 style='height:17.25pt'>&nbsp;</td>
  <td class=xl46 style='border-left:none'>&nbsp;</td>
  <td class=xl47 width=105 style='border-left:none;width:79pt'>&nbsp;</td>
  <td class=xl48 style='border-left:none'>&nbsp;</td>
  <td class=xl47 width=207 style='border-left:none;width:155pt'>&nbsp;</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl31 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=2 height=23 class=xl72 style='border-right:.5pt solid black;
  height:17.25pt'>TỔNG CỘNG <font class="font13">(TOTAL)</font></td>
  <td class=xl49>&nbsp;</td>
  <td class=xl50 align=right style='border-left:none' x:num><% if (subttl2 > subttl)
                                             { %> <%=subttl2-subttl %> <%} %></td>
  <td class=xl51 style='border-left:none'>&nbsp;</td>
  <td class=xl31></td>
  <td class=xl52></td>
  <td colspan=5 class=xl31 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 colspan=2 class=xl30 style='height:10.5pt;mso-ignore:colspan'></td>
  <td class=xl53></td>
  <td class=xl54></td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl30 colspan=5 style='height:18.75pt;mso-ignore:colspan'>Vui
  lòng đính kèm giấy đề nghị tạm ứng khi thanh toán tạm ứng (nếu có) và các
  chứng từ có liên quan.</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl55 colspan=5 style='height:15.0pt;mso-ignore:colspan'>(Please
  attach the propose for advance (if any) and relevant invoices, documents)</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 colspan=2 class=xl30 style='height:9.75pt;mso-ignore:colspan'></td>
  <td class=xl53></td>
  <td class=xl54></td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl56 style='height:17.25pt'>□</td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>Số tiền đã tạm ứng <font class="font11">(Advanced
  amount)</font><font class="font10">:</font></td>
  <td class=xl57 align=right x:num="0">VND 0</td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl56 style='height:17.25pt'>□</td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>Số tiền còn phải trả <font class="font11">(Payment
  amount):</font></td>
  <td class=xl58 align=right style='border-top:none' x:num="0">VND 0</td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl56 style='height:17.25pt'>□</td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>    </span>Số tiền trả lại cho công ty <font
  class="font11">(Return to company)</font><font class="font10">:</font></td>
  <td class=xl58 align=right style='border-top:none' x:num="0">VND 0</td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl30 colspan=2 style='height:17.25pt;mso-ignore:colspan'>Hình
  thức thanh toán <font class="font11">(Payment term):</font></td>
  <td class=xl53></td>
  <td class=xl54></td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl56 style='height:17.25pt'>□</td>
  <td class=xl30><span style='mso-spacerun:yes'>      </span>Tiền mặt <font
  class="font11">(cash)</font><font class="font10">:</font></td>
  <td class=xl53></td>
  <td class=xl54></td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl59 style='height:17.25pt'>R</td>
  <td class=xl30><span style='mso-spacerun:yes'>      </span>Chuyển khoản <font
  class="font11">(transfer):</font></td>
  <td class=xl53></td>
  <td class=xl54></td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl30 style='height:17.25pt'></td>
  <td class=xl30 colspan=2 style='mso-ignore:colspan'>Thông tin chuyển khoản <font
  class="font11">(Transfer information)</font><font class="font10">:</font></td>
  <td colspan=2 class=xl66>&nbsp;</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl30 style='height:17.25pt'></td>
  <td class=xl30>Đính Kèm</td>
  <td class=xl53></td>
  <td colspan=2 class=xl67>&nbsp;</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=2 class=xl30 style='height:17.25pt;mso-ignore:colspan'></td>
  <td class=xl53></td>
  <td colspan=2 class=xl67>&nbsp;</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl60 colspan=2 style='height:17.25pt;mso-ignore:colspan'>Ghi
  chú <font class="font18">(note)</font><font class="font17">:</font></td>
  <td class=xl53></td>
  <td class=xl54></td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl30 colspan=6 style='height:17.25pt;mso-ignore:colspan'
  x:str="Phòng kế toán tài chính chỉ chấp nhận những hóa đơn, chứng từ hợp lệ với đầy đủ các thông tin về công ty (Tên ">Phòng
  kế toán tài chính chỉ chấp nhận những hóa đơn, chứng từ hợp lệ với đầy đủ các
  thông tin về công ty (Tên<span style='mso-spacerun:yes'> </span></td>
  <td colspan=6 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl30 colspan=5 style='height:17.25pt;mso-ignore:colspan'>công
  ty, địa chỉ, MST). Nội dung hóa đơn phải rõ ràng, không tẩy xóa và có đầy đủ
  chữ ký.</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl55 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl55 colspan=5 style='height:17.25pt;mso-ignore:colspan'
  x:str="(The Accountant &amp; Financial Dept. accepts only the red invoices with fully information about company ">(The
  Accountant &amp; Financial Dept. accepts only the red invoices with fully
  information about company<span style='mso-spacerun:yes'> </span></td>
  <td colspan=7 class=xl55 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl55 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl55 colspan=5 style='height:17.25pt;mso-ignore:colspan'>(Name,
  address, tax code).<span style='mso-spacerun:yes'>  </span>Contents of
  invoice must be clear, not erased and all signatures.</td>
  <td colspan=7 class=xl55 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 colspan=2 class=xl30 style='height:17.25pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl53 style='mso-ignore:colspan'></td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=2 height=26 class=xl63 width=247 style='height:19.5pt;width:185pt'><span
  style='mso-spacerun:yes'>  </span>Người lập <font class="font19">(Proposed
  by):</font></td>
  <td colspan=2 class=xl68 width=209 style='width:157pt'>Người kiểm tra<font
  class="font19"> (Checked by):</font></td>
  <td class=xl63 width=207 style='width:155pt'>Người ký duyệt <font
  class="font20">(</font><font class="font19">Approved by):</font></td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'></td>
  <td class=xl64></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=52 style='mso-height-source:userset;height:39.0pt'>
  <td height=52 class=xl30 style='height:39.0pt'></td>
  <td class=xl64></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl30 style='height:16.5pt'></td>
  <td class=xl64></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 colspan=2 style='height:15.0pt;mso-ignore:colspan'>_____________________</td>
  <td class=xl64 colspan=2 style='mso-ignore:colspan'>_____________________</td>
  <td class=xl30><span style='mso-spacerun:yes'> </span>______________________</td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl64 style='height:15.0pt'></td>
  <td class=xl64>Nguyen Thi Van</td>
  <td colspan=2 class=xl64><span style='mso-spacerun:yes'>        </span><%=dt_sign.Rows[0]["code_nm"].ToString() %></td>
  <td class=xl30><span style='mso-spacerun:yes'>            </span><%=dt_sign.Rows[0]["code_nm2"].ToString() %></td>
  <td colspan=7 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'></td>
  <td class=xl64></td>
  <td class=xl30></td>
  <td class=xl65></td>
  <td colspan=8 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'></td>
  <td class=xl64></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'></td>
  <td class=xl29></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'></td>
  <td class=xl29></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl30 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl30 style='height:15.0pt'></td>
  <td class=xl29></td>
  <td colspan=10 class=xl30 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=12 class=xl24 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=23 style='width:17pt'></td>
  <td width=224 style='width:168pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=104 style='width:78pt'></td>
  <td width=207 style='width:155pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=71 style='width:53pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=55 style='width:41pt'></td>
  <td width=171 style='width:128pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
