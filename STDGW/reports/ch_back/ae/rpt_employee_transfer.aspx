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
    string pk_list = Request.QueryString["pk_list"].ToString();
     pk_list = pk_list.Substring(0, pk_list.Length - 1);
    
string SQL
    = "select a.pk " + 
        ",(select e.FULL_NAME from thr_employee e where e.del_if=0 and e.pk = a.FROM_MANAGER_PK ) as from_name_manager_1  " +
        ",(select code_nm from vhr_hr_code where id='HR0008' and code = a.FROM_MANAGER_POS_PK ) as from_pos_manager_2 " +
        ",(select c.ORG_NM from comm.tco_org c where c.del_if=0 and c.PK = a.FROM_MANAGER_ORG_PK ) as from_org_manager_3 " +
        ",(select e.FULL_NAME from thr_employee e where e.del_if=0 and e.pk = a.TO_MANAGER_PK ) as to_name_manager_4  " +
        ",(select code_nm from vhr_hr_code where id='HR0008' and code = a.TO_MANAGER_POS_PK ) as to_pos_manager_5 " +
        ",(select c.ORG_NM from comm.tco_org c where c.del_if=0 and c.PK = a.TO_MANAGER_ORG_PK ) as to_org_manager_6 " +
        ",b.FULL_NAME as fullname_7 " +
        ",b.EMP_ID as emp_id_8 " +
        ",to_char(to_date(b.JOIN_DT,'YYYYMMDD'),'DD/MM/YYYY') as join_dt_9 " +
        ",decode(length(b.BIRTH_DT),4,b.BIRTH_DT, to_char(to_date(b.BIRTH_DT,'YYYYMMDD'),'DD/MM/YYYY')) as birth_dt_10 " +
         ",(select code_fnm from vhr_hr_code where id='HR0008' and code = a.FROM_POS_TYPE ) as old_pos_manager_V_11 " +
        ",(select code_nm from vhr_hr_code where id='HR0008' and code = a.FROM_POS_TYPE ) as old_pos_manager_E_12 " +
        ",(select c.ORG_LNM from comm.tco_org c where c.del_if=0 and c.PK = a.FROM_ORG_PK ) as old_org_manager_V_13 " +
        ",(select c.ORG_NM from comm.tco_org c where c.del_if=0 and c.PK = a.FROM_ORG_PK ) as old_org_manager_E_14 " +
        ",(select code_fnm from vhr_hr_code where id='HR0008' and code = nvl(a.TO_POS_TYPE,a.FROM_POS_TYPE) ) as new_pos_manager_V_15 " +
        ",(select code_nm from vhr_hr_code where id='HR0008' and code = nvl(a.TO_POS_TYPE,a.FROM_POS_TYPE) ) as new_pos_manager_E_16 " +
        ",(select c.ORG_LNM from comm.tco_org c where c.del_if=0 and c.PK = a.TO_ORG_PK ) as new_org_manager_17 " +
        ",(select c.ORG_NM from comm.tco_org c where c.del_if=0 and c.PK = a.TO_ORG_PK ) as new_org_manager_18 " +
        ",to_char(nvl(a.OLD_SALARY,0),'99,999,999') old_salary_19 " +
        ",to_char(nvl(a.NEW_SALARY,0),'99,999,999') new_salary_20 " +
        ",substr(a.APPOINT_DATE,7,2) as dt_21 " +
        ",substr(a.APPOINT_DATE,5,2) as mon_22 " +
        ",substr(a.APPOINT_DATE,1,4) as year_23 " +
        "from thr_appointment_detail a, thr_employee b " +
        "where a.DEL_IF=0 and b.DEL_IF=0 and   " +
        "a.THR_EMPLOYEE_PK = b.PK " +
        "and a.pk in (" + pk_list + ") " ;

       
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
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
<link rel=File-List href="rpt_employee_transfer_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_employee_transfer_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_employee_transfer_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>HR_PHU</o:Author>
  <o:LastAuthor>welcome</o:LastAuthor>
  <o:LastPrinted>2011-05-11T03:44:25Z</o:LastPrinted>
  <o:Created>2011-02-08T01:52:52Z</o:Created>
  <o:LastSaved>2011-05-11T03:44:59Z</o:LastSaved>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.57in 0in .27in .54in;
	mso-header-margin:.3in;
	mso-footer-margin:.16in;
	mso-horizontal-page-align:center;}
.font12
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:windowtext;
	font-size:12.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font16
	{color:windowtext;
	font-size:20.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font18
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font20
	{color:windowtext;
	font-size:16.0pt;
	font-weight:400;
	font-style:italic;
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
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style60
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
	mso-style-name:"Normal 2 2";}
td
	{mso-style-parent:style0;
	padding:0px;
	mso-ignore:padding;
	color:black;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:Calibri, sans-serif;
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
.xl68
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style60;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl71
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style60;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl73
	{mso-style-parent:style60;
	color:windowtext;
	font-size:18.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl74
	{mso-style-parent:style60;
	color:windowtext;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl75
	{mso-style-parent:style60;
	color:windowtext;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl76
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl77
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl78
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl79
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:2.0pt double windowtext;}
.xl82
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt hairline windowtext;}
.xl83
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl84
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl85
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl86
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:.5pt hairline windowtext;}
.xl87
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl88
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl89
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl90
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl91
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl92
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl93
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl94
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl95
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;}
.xl96
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl97
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl98
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl99
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl100
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:2.0pt double windowtext;}
.xl101
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl102
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl103
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl104
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:none;}
.xl105
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:2.0pt double windowtext;}
.xl106
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl107
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl108
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl109
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:2.0pt double windowtext;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl110
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl111
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl112
	{mso-style-parent:style60;
	color:windowtext;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl113
	{mso-style-parent:style60;
	color:windowtext;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl114
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl115
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl116
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
.xl117
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:.5pt dotted windowtext;
	border-left:.5pt solid windowtext;}
.xl118
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	vertical-align:middle;
	border-top:.5pt dotted windowtext;
	border-right:none;
	border-bottom:2.0pt double windowtext;
	border-left:none;}
.xl119
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:2.0pt double windowtext;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;}
.xl120
	{mso-style-parent:style60;
	color:windowtext;
	font-size:20.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl121
	{mso-style-parent:style60;
	color:windowtext;
	font-size:20.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl122
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl123
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:2.0pt double windowtext;}
.xl124
	{mso-style-parent:style60;
	color:windowtext;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:2.0pt double windowtext;
	border-bottom:none;
	border-left:none;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>6. Transfer form</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>74</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
       <x:RangeSelection>$A$3:$J$3</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
     
                    <x:RowBreak>
                        <x:Row>49</x:Row>
                    </x:RowBreak>
               
			   <%
        int irow=0;
        
        for (int k=0;k<dt_emp.Rows.Count;k++)
        {
            irow+=49;
            
            if (k<dt_emp.Rows.Count-1)
            {
                
                %>
                    <x:RowBreak>
                        <x:Row><%=irow %></x:Row>
                    </x:RowBreak>
                <%
               
                
            }    
                
        }  
      %>
      
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>11760</x:WindowHeight>
  <x:WindowWidth>19095</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="5"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl71>

<table x:str border=0 cellpadding=0 cellspacing=0 width=837 style='border-collapse:
 collapse;table-layout:fixed;width:629pt'>
 <col class=xl71 width=133 style='mso-width-source:userset;mso-width-alt:4864;
 width:100pt'>
 <col class=xl71 width=144 style='mso-width-source:userset;mso-width-alt:5266;
 width:108pt'>
 <col class=xl71 width=56 style='mso-width-source:userset;mso-width-alt:2048;
 width:42pt'>
 <col class=xl71 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 <col class=xl71 width=22 style='mso-width-source:userset;mso-width-alt:804;
 width:17pt'>
 <col class=xl71 width=101 style='mso-width-source:userset;mso-width-alt:3693;
 width:76pt'>
 <col class=xl71 width=70 style='mso-width-source:userset;mso-width-alt:2560;
 width:53pt'>
 <col class=xl71 width=64 style='width:48pt'>
 <col class=xl71 width=128 style='mso-width-source:userset;mso-width-alt:4681;
 width:96pt'>
 <col class=xl71 width=96 style='mso-width-source:userset;mso-width-alt:3510;
 width:72pt'>
  <%
    for(int i=0; i< dt_emp.Rows.Count; i++)
    {
  %>
 <tr height=31 style='height:23.25pt'>
  <td height=31 width=133 style='height:23.25pt;width:100pt' align=left
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
  </v:shapetype><v:shape id="Picture_x0020_1" o:spid="_x0000_s5121" type="#_x0000_t75"
   style='position:absolute;margin-left:3pt;margin-top:3.75pt;width:94.5pt;
   height:39.75pt;z-index:1;visibility:visible'>
   <v:imagedata src="rpt_employee_transfer_files/image001.png" o:title=""/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:4px;margin-top:5px;width:126px;
  height:53px'><img width=126 height=53
  src="rpt_employee_transfer_files/image002.jpg" v:shapes="Picture_x0020_1"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=31 class=xl70 width=133 style='height:23.25pt;width:100pt'></td>
   </tr>
  </table>
  </span></td>
  <td class=xl71 width=144 style='width:108pt'>POSCO VIETNAM<span
  style='mso-spacerun:yes'>  </span>P<span style='display:none'>ROCESSING
  CENTER CO., LTD</span></td>
  <td class=xl70 width=56 style='width:42pt'></td>
  <td class=xl70 width=23 style='width:17pt'></td>
  <td class=xl71 width=22 style='width:17pt'></td>
  <td class=xl72 width=101 style='width:76pt'></td>
  <td class=xl72 width=70 style='width:53pt'></td>
  <td class=xl70 width=64 style='width:48pt'></td>
  <td class=xl70 width=128 style='width:96pt'></td>
  <td class=xl70 width=96 style='width:72pt'></td>
 </tr>
 <tr height=31 style='height:23.25pt'>
  <td height=31 colspan=4 class=xl70 style='height:23.25pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
  <td class=xl70></td>
  <td class=xl74></td>
  <td class=xl70></td>
 </tr>
 <tr height=67 style='mso-height-source:userset;height:50.25pt'>
  <td colspan=10 height=67 class=xl120 width=837 style='height:50.25pt;
  width:629pt'>&#272;I&#7872;U CHY&#7874;N NHÂN S&#7920; <font class="font16"><br>
    </font><font class="font18"><span style='mso-spacerun:yes'> </span></font><font
  class="font20">EMPLOYEE TRANSFERMENT</font></td>
 </tr>
 <tr height=18 style='mso-height-source:userset;height:13.5pt'>
  <td height=18 colspan=4 class=xl70 style='height:13.5pt;mso-ignore:colspan'></td>
  <td colspan=3 class=xl73 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl75 style='height:15.0pt'></td>
  <td colspan=9 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=10 height=33 class=xl111 style='height:24.75pt'>&#272;&#7891;ng ý
  hai bên/ Agreement Between</td>
 </tr>
 <tr class=xl68 height=22 style='height:16.5pt'>
  <td height=22 colspan=10 class=xl76 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl77 style='height:24.95pt'>Ng&#432;&#7901;i
  chuy&#7875;n/<font class="font13">Transf</font><span style='display:none'><font
  class="font13">er : </font><font class="font14"><%= dt_emp.Rows[i][1].ToString() %></font></span></td>
  <td class=xl78>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
  <td colspan=3 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl77>Ng&#432;&#7901;i nh&#7853;<span style='display:none'>n/<font
  class="font13">Transfee<span style='mso-spacerun:yes'>  </span>: </font><font
  class="font14"><%= dt_emp.Rows[i][4].ToString() %></font></span></td>
  <td class=xl78>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl79>&nbsp;</td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl81 style='height:24.95pt;border-top:none'>Ch&#7913;c
  v&#7909;<font class="font13">/Position :</font></td>
  <td class=xl82 style='border-top:none'><%= dt_emp.Rows[i][2].ToString() %></td>
  <td class=xl83 style='border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl123 style='border-right:2.0pt double black;border-left:
  none'>và/and</td>
  <td class=xl81 style='border-top:none;border-left:none'>Ch&#7913;c v&#7909;/<font
  class="font13">P</font><span style='display:none'><font class="font13">osition
  :</font></span></td>
  <td class=xl82 style='border-top:none'>&nbsp;</td>
  <td class=xl84 style='border-top:none'><%= dt_emp.Rows[i][5].ToString() %></td>
  <td class=xl83 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl85 style='height:24.95pt;border-top:none'>B&#7897;
  ph&#7853;n/<font class="font13">Operation </font><font class="font12">:</font></td>
  <td class=xl86 style='border-top:none'><%= dt_emp.Rows[i][3].ToString() %></td>
  <td class=xl87 style='border-top:none'>&nbsp;</td>
  <td colspan=3 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl85 style='border-top:none'>B&#7897; ph&#7853;n/<font
  class="font13">O</font><span style='display:none'><font class="font13">peration
  : </font><font class="font12"><%= dt_emp.Rows[i][6].ToString() %></font></span></td>
  <td class=xl86 style='border-top:none'>&nbsp;</td>
  <td class=xl88 style='border-top:none'>&nbsp;</td>
  <td class=xl87 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=22 style='height:16.5pt'>
  <td height=22 colspan=10 class=xl76 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td colspan=10 height=21 class=xl111 style='height:15.75pt'>Ng&#432;&#7901;i
  &#273;&#432;&#7907;c &#273;i&#7873;u chuy&#7875;n/ Transferment Person</td>
 </tr>
 <tr class=xl68 height=22 style='height:16.5pt'>
  <td height=22 colspan=9 class=xl76 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl115>&nbsp;</td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl77 style='height:24.95pt'>H&#7885; và tên</td>
  <td class=xl80><%= dt_emp.Rows[i][7].ToString() %></td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl89>MSNV/ <font class="font13">Code</font></td>
  <td class=xl119 x:str><%= dt_emp.Rows[i][8].ToString() %></td>
  <td class=xl89 colspan=2 style='mso-ignore:colspan'>Ngày vào<font
  class="font13">/Date of joining :<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl116><%= dt_emp.Rows[i][9].ToString() %></td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl90 style='height:24.95pt'>Full Name</td>
  <td colspan=4 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl91>&nbsp;</td>
  <td class=xl76></td>
  <td class=xl92 colspan=2 style='mso-ignore:colspan'>N&#259;m sinh/<font
  class="font13">Date of Birth:<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl94><%= dt_emp.Rows[i][10].ToString() %></td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl95 colspan=2 style='height:24.95pt;mso-ignore:colspan;
  border-right:.5pt solid black'>Ch&#7913;c v&#7909; hi&#7879;n t&#7841;i/ <font
  class="font13">Current Position<span style='mso-spacerun:yes'> </span></font></td>
  <td class=xl97 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span><%= dt_emp.Rows[i][11].ToString() %>/ <font class="font13"><%= dt_emp.Rows[i][12].ToString() %></font></td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl98>&nbsp;</td>
  <td class=xl99>&nbsp;</td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl100 colspan=2 style='height:24.95pt;mso-ignore:colspan;
  border-right:.5pt solid black'>B&#7897; ph&#7853;n hi&#7879;n t&#7841;i /<font
  class="font13">Current Operation</font></td>
  <td class=xl102 colspan=3 style='mso-ignore:colspan'><%= dt_emp.Rows[i][13].ToString() %>/ <font
  class="font13"><%= dt_emp.Rows[i][14].ToString() %></font><font class="font12"><span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl100 colspan=2 style='height:24.95pt;mso-ignore:colspan;
  border-right:.5pt solid black'>Ch&#7913;c v&#7909; m&#7899;i/ <font
  class="font13">New Position</font></td>
  <td class=xl102 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span><%= dt_emp.Rows[i][15].ToString() %>/ <font class="font13"><%= dt_emp.Rows[i][16].ToString() %></font></td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl100 colspan=2 style='height:24.95pt;mso-ignore:colspan;
  border-right:.5pt solid black'>B&#7897; ph&#7853;n m&#7899;i/ <font
  class="font13">New Operation</font></td>
  <td class=xl102 colspan=3 style='mso-ignore:colspan'><%= dt_emp.Rows[i][17].ToString() %>/ <font
  class="font13"><%= dt_emp.Rows[i][18].ToString() %></font></td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl100 colspan=2 style='height:24.95pt;mso-ignore:colspan;
  border-right:.5pt solid black'>M&#7913;c l&#432;&#417;ng hi&#7879;n
  t&#7841;i/<font class="font13">Current Basic Salary</font></td>
  <td class=xl117 colspan=2 style='mso-ignore:colspan'><%= dt_emp.Rows[i][19].ToString() %></td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>VND</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl102 style='border-top:none'>&nbsp;</td>
  <td class=xl103 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=33 style='mso-height-source:userset;height:24.95pt'>
  <td height=33 class=xl105 colspan=2 style='height:24.95pt;mso-ignore:colspan;
  border-right:.5pt solid black'>M&#7913;c l&#432;&#417;ng m&#7899;i/ <font
  class="font13">New Basic Salary</font></td>
  <td class=xl118 colspan=2 style='mso-ignore:colspan'><%= dt_emp.Rows[i][20].ToString() %></td>
  <td class=xl107 style='border-top:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none'>VND</td>
  <td class=xl107 style='border-top:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none'>&nbsp;</td>
  <td class=xl107 style='border-top:none'>&nbsp;</td>
  <td class=xl109 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr class=xl68 height=22 style='height:16.5pt'>
  <td height=22 colspan=10 class=xl76 style='height:16.5pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td colspan=10 height=21 class=xl111 style='height:15.75pt'>Hi&#7879;u
  l&#7921;c t&#7915; ngày <%= dt_emp.Rows[i][21].ToString() %> tháng <%= dt_emp.Rows[i][22].ToString() %> n&#259;m <%= dt_emp.Rows[i][23].ToString() %> / <font class="font13">Effective
  on the date : <%= dt_emp.Rows[i][21].ToString() %>/<%= dt_emp.Rows[i][22].ToString() %>/<%= dt_emp.Rows[i][23].ToString() %></font></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 class=xl76 colspan=9 style='height:15.75pt;mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span>Tôi xin &#273;&#7891;ng ý v&#7899;i
  vi&#7879;c &#273;i&#7873;u chuy&#7875;n này, và s&#7869; th&#7921;c
  hi&#7879;n &#273;úng v&#7899;i n&#7897;i qui, qui &#273;&#7883;nh c&#7911;a
  công ty TNNH Trung tâm gia công <span style='display:none'>POSCO Vi&#7879;t
  Nam.</span></td>
  <td class=xl68></td>
 </tr>
 <tr class=xl68 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td colspan=10 height=23 class=xl122 style='height:17.25pt'>I am agree and
  accept all of employee condition, rule and regulation of company,</td>
 </tr>
 <tr class=xl68 height=23 style='mso-height-source:userset;height:17.25pt'>
  <td height=23 class=xl110 style='height:17.25pt'></td>
  <td class=xl110 x:str="   "><span style='mso-spacerun:yes'>   </span></td>
  <td class=xl110 colspan=7 style='mso-ignore:colspan'>POSCO -VHPC VietNam
  Processing Center Co., Ltd</td>
  <td class=xl68></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl68 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl68 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl68 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl76 colspan=2 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>                  </span>(<span style='display:none'>……………………………………….)</span></td>
  <td class=xl68></td>
  <td colspan=5 class=xl76 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td height=21 colspan=2 class=xl76 style='height:15.75pt;mso-ignore:colspan'><%= dt_emp.Rows[i][7].ToString() %></td>
  <td height=21 colspan=3 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl76 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>       </span>…………../……………./ 20……..</td>
  <td colspan=2 class=xl76 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl76 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 colspan=10 class=xl68 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 class=xl68 style='height:15.75pt'><span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=9 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 class=xl76 colspan=3 style='height:15.75pt;mso-ignore:colspan'>Ch&#7919;
  ký ng&#432;&#7901;i chuy&#7875;n(<span style='mso-spacerun:yes'> 
  </span>……………………)</td>
  <td colspan=3 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl76 colspan=2 style='mso-ignore:colspan'>Ch&#7919; ký
  ng&#432;&#7901;i nh&#7853;n ( <span style='display:none'>……………………… )</span></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 class=xl110 style='height:15.75pt'>Signature Transfer</td>
  <td class=xl111></td>
  <td colspan=4 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl110 colspan=2 style='mso-ignore:colspan'>Signature Transfee</td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 class=xl110 style='height:15.75pt'></td>
  <td class=xl111><%= dt_emp.Rows[i][1].ToString() %></td>
  <td colspan=4 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl110 colspan=2 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'><%= dt_emp.Rows[i][4].ToString() %></td>
 </tr>
 <tr class=xl68 height=21 style='height:15.75pt'>
  <td height=21 class=xl76 style='height:15.75pt'></td>
  <td class=xl76 colspan=4 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>    </span>…………../……………./ 20…..</td>
  <td colspan=2 class=xl76 style='mso-ignore:colspan'></td>
  <td class=xl76><span style='mso-spacerun:yes'>               </span><span
  style='display:none'><span
  style='mso-spacerun:yes'>       </span>…………../……………./ 20……</span></td>
  <td colspan=2 class=xl68 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl71 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=5 class=xl70 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl112></td>
  <td class=xl70></td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=5 class=xl71 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl69 colspan=3 style='mso-ignore:colspan'>Ký Duy&#7879;t/<span
  style='mso-spacerun:yes'>    </span>Approved by</td>
  <td colspan=2 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl71 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=10 class=xl71 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl70 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl112></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl70 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl71></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=4 class=xl70 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl113><span style='mso-spacerun:yes'> </span></td>
  <td class=xl114 colspan=2 style='mso-ignore:colspan'>(…………………………)</td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=4 class=xl70 style='height:15.0pt;mso-ignore:colspan'></td>
  <td class=xl112></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl71 style='mso-ignore:colspan'></td>
 </tr>
  <%
    }
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=133 style='width:100pt'></td>
  <td width=144 style='width:108pt'></td>
  <td width=56 style='width:42pt'></td>
  <td width=23 style='width:17pt'></td>
  <td width=22 style='width:17pt'></td>
  <td width=101 style='width:76pt'></td>
  <td width=70 style='width:53pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=96 style='width:72pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
