<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">




<%
    string p_mon = Request.QueryString["p_mon"].ToString();

    string SQL_Com
    = "select v.CODE_NM " +
        "from vhr_hr_code v " +
        "where v.ID='HR0049' ";

    DataTable dt_com = ESysLib.TableReadOpen(SQL_Com);
    if (dt_com.Rows.Count == 0)
    {
        Response.Write("There is no data of regulation to show");
        Response.End();            
    }
    //Response.Write(p_mon.Insert(4, "-") + "-01");
    //Response.End();
    string SQL_Sum
= "select count(*),sum(decode(b.sex,'F',1,0)),sum(luong_cb)  " +
    "from thr_insurance_month a,thr_employee b " +
    "where a.del_if=0 and b.del_if=0 and a.thr_emp_pk=b.pk " +
    "and a.work_mon='" + p_mon + "' and nvl(b.SOCIAL_YN,'N')='Y' ";
    double dtotal_lb = 0, dtotal_lb_femail = 0, dtotal_sal = 0;
    DataTable dt_sum = ESysLib.TableReadOpen(SQL_Sum);
    if (dt_sum.Rows.Count != 0)
    {
        dtotal_lb = double.Parse(dt_sum.Rows[0][0].ToString());
        dtotal_lb_femail = double.Parse(dt_sum.Rows[0][1].ToString());
        dtotal_sal = double.Parse(dt_sum.Rows[0][2].ToString());
    }
    string SQL
    = "select v.CODE_NM, ti.FULL_NAME, ti.SOCIAL_NO, ti.CONDITION,'' progressive " +
        "    ,nvl(ti.DAYS,0) nghi_tai_nha,'' nghi_tap_trung  " +
        "    ,round(nvl(ti.INS_AMT,0),0),to_char(to_date(ti.FROM_DT,'yyyymmdd'),'dd/mm/yyyy'),"+
        "    to_char(to_date(ti.TO_DT,'yyyymmdd'),'dd/mm/yyyy'), ti.REMARK, v.NUM_1 " +
        "from THR_INS_REGULATION ti, vhr_hr_code v  " +
        "where ti.DEL_IF=0 " +
        "and ti.INS_MONTH='"+p_mon+"' " +
        "and v.ID='HR0055' " +
        "and ti.INS_REG_TYPE='03' " +
        "and v.CODE=ti.DETAIL_INS_REG_TYPE " +
        "order by v.NUM_1, ti.FULL_NAME,ti.from_dt ";

    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if(dt_emp.Rows.Count==0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }    
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="Copy%20of%20Mau%20C68%2069%2070%20a-HD%20(nghi%20duong%20suc)_files/filelist.xml">
<link rel=Edit-Time-Data
href="Copy%20of%20Mau%20C68%2069%2070%20a-HD%20(nghi%20duong%20suc)_files/editdata.mso">
<link rel=OLE-Object-Data
href="Copy%20of%20Mau%20C68%2069%2070%20a-HD%20(nghi%20duong%20suc)_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>nhut_k</o:Author>
  <o:LastAuthor>nhut_k</o:LastAuthor>
  <o:Created>2010-09-17T03:46:41Z</o:Created>
  <o:LastSaved>2010-09-17T03:48:30Z</o:LastSaved>
  <o:Company>AS</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .5in 1.0in .5in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-page-orientation:landscape;
	mso-horizontal-page-align:center;}
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
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
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
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl26
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl29
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
	
.xl34
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl35
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl38
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl39
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl43
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl44
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl45
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl46
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl47
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl48
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:normal;}
.xl49
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl50
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl51
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl52
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl53
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid black;
	border-bottom:.5pt solid black;
	border-left:none;
	white-space:normal;}
.xl54
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl55
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl56
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl57
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl58
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl59
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl60
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl61
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl62
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
.xl63
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl64
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl65
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;}
.xl67
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl68
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl69
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl71
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl72
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl73
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl74
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl75
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl76
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-top:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl77
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl78
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl79
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl80
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl81
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl82
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl83
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\@";}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl86
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl87
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl88
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>330</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>74</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>28</x:ActiveRow>
       <x:ActiveCol>4</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet2</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
   <x:ExcelWorksheet>
    <x:Name>Sheet3</x:Name>
    <x:WorksheetOptions>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>12270</x:WindowHeight>
  <x:WindowWidth>19035</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl33>

<table x:str border=0 cellpadding=0 cellspacing=0 width=16910 style='border-collapse:
 collapse;table-layout:fixed;width:12683pt'>
 <col class=xl88 width=43 style='mso-width-source:userset;mso-width-alt:1572;
 width:32pt'>
 <col class=xl36 width=240 style='mso-width-source:userset;mso-width-alt:8777;
 width:180pt'>
 <col class=xl88 width=122 style='mso-width-source:userset;mso-width-alt:4461;
 width:92pt'>
 <col class=xl88 width=163 style='mso-width-source:userset;mso-width-alt:5961;
 width:122pt'>
 <col class=xl88 width=158 style='mso-width-source:userset;mso-width-alt:5778;
 width:119pt'>
 <col class=xl88 width=92 style='mso-width-source:userset;mso-width-alt:3364;
 width:69pt'>
 <col class=xl88 width=91 style='mso-width-source:userset;mso-width-alt:3328;
 width:68pt'>
 <col class=xl88 width=97 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl88 width=77 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl88 width=77 style='mso-width-source:userset;mso-width-alt:3547;
 width:73pt'>
 <col class=xl33 width=83 style='mso-width-source:userset;mso-width-alt:3035;
 width:62pt'>
 <col class=xl33 width=64 span=245 style='width:48pt'>
 <tr class=xl28 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl24 colspan=2 width=283 style='height:14.25pt;
  mso-ignore:colspan;width:212pt'>Tên c&#417; quan (&#273;&#417;n
  v&#7883;) <%=dt_com.Rows[0][0].ToString() %>.</td>
  <td class=xl24 width=122 style='width:92pt'></td>
  <td class=xl24 width=163 style='width:122pt'></td>
  <td class=xl24 width=158 style='width:119pt'></td>
  <td class=xl26 width=92 style='width:69pt'></td>
  <td class=xl26 width=91 style='width:68pt'></td>
  <td colspan=3 class=xl27 width=238 style='width:179pt'>M&#7851;u s&#7889;: C
  69a- HD</td>
  <td class=xl28 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl28 height=17 style='height:12.75pt'>
  <td height=17 class=xl24 colspan=2 style='height:12.75pt;mso-ignore:colspan'>Mã
  &#273;&#417;n v&#7883;:<%=dt_com.Rows[1][0].ToString() %>.</td>
  <td colspan=3 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26></td>
  <td class=xl27></td>
  <td colspan=246 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=19 style='height:14.25pt'>
  <td height=19 class=xl24 style='height:14.25pt'></td>
  <td class=xl29></td>
  <td colspan=5 class=xl24 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl26></td>
  <td colspan=247 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl28 height=20 style='height:15.0pt'>
  <td height=20 class=xl24 style='height:15.0pt'></td>
  <td class=xl30></td>
  <td colspan=254 class=xl28 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td colspan=9 height=22 class=xl31 style='height:16.5pt'>DANH SÁCH
  NG&#431;&#7900;I LAO &#272;&#7896;NG<span style='mso-spacerun:yes'> 
  </span>&#272;&#7872; NGH&#7882; H&#431;&#7902;NG TR&#7906; C&#7844;P
  NGH&#7880; DSPHSK SAU THAI S&#7842;N</td>
  <td colspan=247 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <%
     string w = "I";
     if (p_mon.Substring(4, 2) == "04" || p_mon.Substring(4, 2) == "05" || p_mon.Substring(4, 2) == "06")
         w = "II";
     if (p_mon.Substring(4, 2) == "07" || p_mon.Substring(4, 2) == "08" || p_mon.Substring(4, 2) == "09")
         w = "III";
     if (p_mon.Substring(4, 2) == "10" || p_mon.Substring(4, 2) == "11" || p_mon.Substring(4, 2) == "12")
         w = "IV";
         
  %>
 <tr class=xl35 height=20 style='height:15.0pt'>
  <td colspan=9 height=20 class=xl34 style='height:15.0pt'>Tháng <%=p_mon.Substring(4,2) %> quý <%=w %> năm <%= p_mon.Substring(0,4) %> .</td>
  <td colspan=247 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=20 style='height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl36></td>
  <td class=xl34></td>
  <td class=xl37 colspan=4 style='mso-ignore:colspan'>Số hiệu tài khoản:<%=dt_com.Rows[8][0].ToString() %> mở
  tại: <%=dt_com.Rows[9][0].ToString() %></td>
  <td class=xl34></td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=245 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2  style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl34 x:str="Tổng số lao động: ">Tổng số lao động:<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl35 x:num><%=dtotal_lb %></td>
  <td colspan=2 class=xl25 style='mso-ignore:colspan'>&nbsp;</td>
  <td class=xl34 colspan=2 style='mso-ignore:colspan' x:str="Trong đó nữ: ">Trong
  đó nữ:<span style='mso-spacerun:yes'> </span></td>
  <td class=xl35 x:num><%=dtotal_lb_femail %></td>
  <td class=xl29>&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'>&nbsp;</td>
  <td >&nbsp;</td>
 </tr>
 <tr class=xl27 height=17 style='height:12.75pt'>
  <td height=17 colspan=2 class=xl25 style='height:12.75pt;mso-ignore:colspan'>&nbsp;</td>
  <td class=xl34 x:str="Tổng quỹ lương trong tháng:  ">Tổng quỹ lương trong
  tháng:<span style='mso-spacerun:yes'>  </span></td>
  <td class=xl35 x:num><%=dtotal_sal %></td>
  <td >&nbsp;</td>
  <td >&nbsp;</td>
  <td >&nbsp;</td>
  <td colspan=2 style='mso-ignore:colspan'>&nbsp;</td>
  <td >&nbsp;</td>
  <td colspan=2  style='mso-ignore:colspan'>&nbsp;</td>
  <td >&nbsp;</td>
 </tr>
 <tr class=xl35 height=20 style='height:15.0pt'>
  <td height=20 class=xl34 style='height:15.0pt'></td>
  <td class=xl36></td>
  <td class=xl34></td>
  <td class=xl37 colspan=4 style='mso-ignore:colspan'>&#272;&#7883;a ch&#7881;
  :<%=dt_com.Rows[2][0].ToString() %>.&#272;i&#7879;n tho&#7841;i :<%=dt_com.Rows[12][0].ToString() %>.</td>
  <td class=xl34></td>
  <td colspan=3 class=xl37 style='mso-ignore:colspan'></td>
  <td colspan=245 class=xl34 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl35 height=20 style='height:15.0pt'>
  <td height=20 class=xl38 style='height:15.0pt'></td>
  <td class=xl39></td>
  <td colspan=6 class=xl38 style='mso-ignore:colspan'></td>
  <td class=xl34>S&#7889;:……….</td>
  <td colspan=247 class=xl35 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl48 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=3 height=77 class=xl40 width=43 style='border-bottom:.5pt solid black;
  height:57.75pt;width:32pt'>STT</td>
  <td rowspan=3 class=xl41 style='border-bottom:.5pt solid black'>H&#7885; và
  tên</td>
  <td rowspan=3 class=xl40 width=122 style='border-bottom:.5pt solid black;
  width:92pt'>S&#7889; s&#7893; BHXH</td>
  <td rowspan=3 class=xl40 width=163 style='border-bottom:.5pt solid black;
  width:122pt'>&#272;i&#7873;u ki&#7879;n tính h&#432;&#7903;ng</td>
  <td rowspan=3 class=xl40 width=158 style='border-bottom:.5pt solid black;
  width:119pt'>Lu&#7929; k&#7871; s&#7889; ngày h&#432;&#7903;ng DSPHSK
  &#273;&#7889;i v&#7899;i s&#7849;y thai, hút thai, thai ch&#7871;t l&#432;u</td>
  <td colspan=3 class=xl42 width=280 style='border-right:.5pt solid black;
  border-left:none;width:210pt'>S&#7889; &#273;&#417;n v&#7883; &#273;&#7873;
  ngh&#7883;</td>
  <td colspan=3 rowspan=2 class=xl45 width=224 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:168pt'>Chi chú</td>
  <td colspan=245 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl48 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=2 height=20 class=xl42 width=183 style='border-right:.5pt solid black;
  height:15.0pt;border-left:none;width:137pt'>S&#7889; ngày ngh&#7881; trong
  k&#7923;</td>
  <td rowspan=2 class=xl40 width=97 style='border-bottom:.5pt solid black;
  border-top:none;width:73pt' x:str="S&#7889; ti&#7873;n ">S&#7889;
  ti&#7873;n<span style='mso-spacerun:yes'> </span></td>
  <td colspan=245 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl48 height=37 style='mso-height-source:userset;height:27.75pt'>
  <td height=37 class=xl57 width=92 style='height:27.75pt;width:69pt'>Ngh&#7881;
  t&#7841;i gia &#273;ình</td>
  <td class=xl49 width=91 style='width:68pt'>Ngh&#7881; t&#7853;p trung</td>
  <td class=xl58 width=77 style='width:58pt'>T&#7915; ngày<br>
    /tháng/n&#259;m</td>
  <td class=xl59 width=64 style='width:48pt'>&#272;&#7871;n ngày<br>
    /tháng/n&#259;m</td>
  <td class=xl59 width=83 style='width:62pt'>Khác</td>
  <td colspan=245 class=xl48 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl65 height=19 style='height:14.25pt'>
  <td height=19 class=xl60 style='height:14.25pt;border-top:none'>A</td>
  <td class=xl61 style='border-top:none'>B</td>
  <td class=xl62 style='border-top:none'>C</td>
  <td class=xl63>D</td>
  <td class=xl62 style='border-top:none' x:num>1</td>
  <td class=xl62 x:num>2</td>
  <td class=xl62 x:num>3</td>
  <td class=xl63 x:num>4</td>
  <td class=xl63>E</td>
  <td class=xl64>F</td>
  <td class=xl64>G</td>
  <td colspan=245 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <%             
        string[] seq = new string[10] { "I", "II", "III", "IV","V","VI","VII","VIII","IX","X" };
        
        double[] sum = new Double[11] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        double[] total = new Double[11] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
        string code_nm="";
        int t = 0;
  %>
 <% for (int i = 0; i < dt_emp.Rows.Count; i++)
    {%>
 <% if (code_nm != dt_emp.Rows[i][0].ToString())
    {
         code_nm = dt_emp.Rows[i][0].ToString(); %>
 <tr  class=xl71 height=20 style='mso-height-source:userset;height:15.0pt<%=(dt_emp.Rows[i][0].ToString()!="")?";display:none":"" %>'>
  <td height=20 class=xl66 style='height:15.0pt'><b><%=seq[t++]%></b></td>
  <td class=xl67 colspan=9 style="text-align:left"><b><%=code_nm%></b></td>
  <td colspan=245 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <%} %>
 <tr class=xl71 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl66 style='height:15.0pt'><%=i + 1%></td>
  <td class=xl67><%=dt_emp.Rows[i][1].ToString()%></td>
  <td class=xl68><%=dt_emp.Rows[i][2].ToString()%></td>
  <td class=xl68><%=dt_emp.Rows[i][3].ToString()%></td>
  <td class=xl68><%=dt_emp.Rows[i][4].ToString()%></td>
  <td class=xl68><%=dt_emp.Rows[i][5].ToString()%></td>
  <td class=xl68><%=dt_emp.Rows[i][6].ToString()%></td>
  <td class=xl69 x:num><%=dt_emp.Rows[i][7].ToString()%></td>
  <td class=xl68><%=dt_emp.Rows[i][8].ToString()%></td>
  <td class=xl67><%=dt_emp.Rows[i][9].ToString()%></td>
  <td class=xl67><%=dt_emp.Rows[i][10].ToString()%></td>
  <td colspan=245 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <%  sum[5] += Double.Parse(dt_emp.Rows[i][5].ToString());
     sum[7] += Double.Parse(dt_emp.Rows[i][7].ToString());
     total[7] += Double.Parse(dt_emp.Rows[i][7].ToString());
     total[5] += Double.Parse(dt_emp.Rows[i][5].ToString());
     if (dt_emp.Rows.Count-1 == i  || code_nm != dt_emp.Rows[i + 1][0].ToString())
     { %>
 
 <tr height=20 style='mso-height-source:userset;height:15.0pt<%=(dt_emp.Rows[i][0].ToString()!="")?";display:none":"" %>'>
  <td height=20 class=xl72 style='height:15.0pt'>&nbsp;</td>
  <td class=xl76>C&#7897;ng</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77 x:num><%=sum[5]%></td>
  <td class=xl77>&nbsp;</td>
  <td class=xl79 x:num><%=sum[7]%> </td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td colspan=245 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 
 <%}
   sum[5] = 0; sum[7] = 0;
} %>

<tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl72 style='height:15.0pt'>&nbsp;</td>
  <td class=xl76>C&#7897;ng</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl78>&nbsp;</td>
  <td class=xl77>&nbsp;</td>
  <td class=xl77 x:num><%=total[5]%></td>
  <td class=xl77>&nbsp;</td>
  <td class=xl79 x:num><%=total[7]%> </td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td class=xl80>&nbsp;</td>
  <td colspan=245 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl81 style='height:15.0pt'></td>
  <td class=xl82></td>
  <td colspan=251 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl81 style='height:15.0pt'></td>
  <td class=xl83 colspan=5 >Ghi chú:
  Tr&#432;&#7901;ng h&#7907;p ngh&#7881; t&#7853;p trung ph&#7843;i ghi rõ
  &#273;&#7883;a ch&#7881; c&#417; s&#7903; ngh&#7881; và th&#7901;i gian
  ngh&#7881; t&#7915; ngày .....&#273;&#7871;n ngày.....</td>
  <td class=xl83></td>
  <td colspan=246 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl81 style='height:15.0pt'></td>
  <td class=xl82></td>
  <td colspan=251 class=xl81 style='mso-ignore:colspan'></td>
  <td colspan=3 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl84 style='height:16.5pt'></td>
  <td class=xl36></td>
  <td colspan=5 class=xl84 style='mso-ignore:colspan'></td>
  <td class=xl85>Ngày <%=DateTime.Now.Day.ToString() %> tháng <%=DateTime.Now.Month.ToString() %> năm <%=DateTime.Now.Year.ToString() %></td>
  <td colspan=3 class=xl85 style='mso-ignore:colspan'></td>
  <td colspan=245 class=xl32 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl71 height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 class=xl31 style='height:23.25pt'></td>
  <td class=xl29>Xác nh&#7853;n phòng thu</td>
  <td class=xl70></td>
  <td class=xl31>Ng&#432;&#7901;i l&#7853;p</td>
  <td class=xl70></td>
  <td class=xl31>Công &#273;oàn c&#417; s&#7903;</td>
  <td class=xl70></td>
  <td class=xl31>K&#7871; toán tr&#432;&#7903;ng</td>
  <td class=xl31></td>
  <td class=xl31>Th&#7911; tr&#432;&#7903;ng &#273;&#417;n v&#7883;</td>
  <td class=xl70></td>
  <td class=xl31></td>
  <td colspan=244 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl87 height=19 style='mso-height-source:userset;height:14.25pt'>
  <td height=19 class=xl85 style='height:14.25pt'></td>
  <td class=xl82>(Ký, h&#7885; tên)</td>
  <td class=xl86></td>
  <td class=xl85 x:str="  (Ký, h&#7885; tên) "><span style='mso-spacerun:yes'> 
  </span>(Ký, h&#7885; tên)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl86></td>
  <td class=xl85>(Ký, &#273;óng d&#7845;u)</td>
  <td class=xl86></td>
  <td class=xl85 x:str="  (Ký, h&#7885; tên) "><span style='mso-spacerun:yes'> 
  </span>(Ký, h&#7885; tên)<span style='mso-spacerun:yes'> </span></td>
  <td class=xl85></td>
  <td class=xl85><span style='mso-spacerun:yes'> </span>(Ký, &#273;óng
  d&#7845;u)</td>
  <td class=xl86></td>
  <td class=xl85></td>
  <td colspan=244 class=xl86 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl88 style='height:16.5pt'></td>
  <td class=xl36></td>
  <td colspan=9 class=xl88 style='mso-ignore:colspan'></td>
  <td colspan=245 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl88 style='height:16.5pt'></td>
  <td class=xl36></td>
  <td colspan=9 class=xl88 style='mso-ignore:colspan'></td>
  <td colspan=245 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl88 style='height:16.5pt'></td>
  <td class=xl36></td>
  <td colspan=8 class=xl88 style='mso-ignore:colspan'></td>
  <td colspan=246 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl88 style='height:16.5pt'></td>
  <td class=xl36></td>
  <td colspan=8 class=xl88 style='mso-ignore:colspan'></td>
  <td colspan=246 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl88 style='height:16.5pt'></td>
  <td class=xl36></td>
  <td class=xl88></td>
  <td class=xl88><%=dt_com.Rows[5][0].ToString() %></td>
  <td colspan=3 class=xl88 style='mso-ignore:colspan'></td>
  <td class=xl88><%=dt_com.Rows[7][0].ToString() %></td>
  <td class=xl88></td>
  <td class=xl88><%=dt_com.Rows[6][0].ToString() %></td>
  <td colspan=246 class=xl33 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=43 style='width:32pt'></td>
  <td width=240 style='width:180pt'></td>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
