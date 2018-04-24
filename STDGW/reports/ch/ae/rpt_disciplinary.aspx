<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/msword";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>

<html>
<%
    string p_user;
    p_user = Request["p_user"].ToString();
    string dis_pk = Request["dis_pk"].ToString();
    dis_pk = dis_pk.Substring(0, dis_pk.Length - 1);
    
    string SQL
    = " select a.FULL_NAME, a.EMP_ID " +
        "    ,(select code_fnm from vhr_hr_code where id='HR0008' and code= a.pos_type ) position " +
        "    , b.org_NM,  " +
        "    to_char(to_date(d.DIS_DT,'yyyymmdd'),'dd-mm-yyyy'),  " +
        "    to_char(sysdate,'dd-mm-yyyy'),  " +
        "    d.REASON, d.REMARK " +
        "    ,(select code_fnm from vhr_hr_code where id='HR0025' and code= d.dis_level ) levelfnm " +
        "    ,(select code_nm from vhr_hr_code where id='HR0025' and code= d.dis_level ) levelnm   " +
        " from thr_employee a, tco_org b, thr_discipline d  " +
        " where a.DEL_IF=0  " +
        "    and b.DEL_IF=0  " +
        "    and d.DEL_IF=0   " +
        "    and a.TCO_org_PK=b.PK  " +
        "    and a.PK=d.THR_EMP_PK  " +
        "    and d.PK in (" + dis_pk + ") " +
        "    order by org_nm,d.dis_dt,a.emp_id ";
    
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=Generator content="Microsoft Word 11 (filtered)">
<title>YOUL CHON VINA PLASTIC JSC</title>

<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Webdings;
	panose-1:5 3 1 2 1 5 9 6 7 3;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
@page Section1
	{size:595.45pt 841.7pt;
	margin:.3in .6in 16.55pt .6in;}
div.Section1
	{page:Section1;}
 /* List Definitions */
 ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=EN-US>

<div class=Section1>
<%
    for (int i = 0; i < dt_emp.Rows.Count; i++)
    {        
 %>
<p class=MsoNormal align=center style='text-align:center'><b><span
style='font-family:Tahoma'></span></b></p>

<p class=MsoNormal align=center style='text-align:center'><b><span
style='font-size:16.0pt;font-family:Tahoma'>BIÊN BẢN KỶ LUẬT – DISCIPLINARY
MINUTE</span></b></p>

<p class=MsoNormal align=center style='text-align:center'><b><span
style='font-size:11.0pt;font-family:Tahoma'>Số: </span></b><b><span style='font-size:11.0pt;font-family:Tahoma'>QD</span></b><b><span
style='font-size:11.0pt;font-family:Tahoma'></span></b></p>

<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=703
 style='width:527.4pt;border-collapse:collapse;border:none'>
 <tr>
  <td width=211  colspan=4  valign=top style='width:2.2in;border:solid windowtext 1.0pt;
  border-right:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span style='font-size:10.0pt;font-family:Tahoma'>Nhân
  viên vi phạm - <i>Emp. Name: </i></span><%=dt_emp.Rows[i][0].ToString() %></p>
  </td>
  
  <td width=136 colspan=2 valign=top style='width:101.75pt;border-top:solid windowtext 1.0pt;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:none;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span style='font-size:10.0pt;font-family:Tahoma'>MSNV
  - <i>Emp. Code: </i></span></p>
  </td>
  <td width=132 valign=top style='width:99.0pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span style='font-size:10.0pt;font-family:Tahoma'>
  <%=dt_emp.Rows[i][1].ToString() %></span></p>
  </td>
 </tr>
 <tr>
  <td width=211 valign=top style='width:2.2in;border-top:none;border-left:solid windowtext 1.0pt;
  border-bottom:solid windowtext 1.0pt;border-right:none;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span lang=FR style='font-size:10.0pt;font-family:
  Tahoma'>Vị trí / Chức vụ – <i>Position:</i></span></p>
  </td>
  <td width=224 colspan=3 style='width:168.25pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span lang=FR style='font-size:10.0pt;font-family:Tahoma'> </span><span
  style='font-size:10.0pt;font-family:Tahoma'><%=dt_emp.Rows[i][2].ToString() %></span></p>
  </td>
  <td width=136 colspan=2 valign=top style='width:101.75pt;border:none;
  border-bottom:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal style='margin-top:6.0pt;margin-right:0in;margin-bottom:
  6.0pt;margin-left:0in'><span style='font-size:10.0pt;font-family:Tahoma'>Bộ
  phận - <i>Dept.:</i></span></p>
  </td>
  <td width=132 style='width:99.0pt;border-top:none;border-left:none;
  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Tahoma'><%=dt_emp.Rows[i][3].ToString() %></span></p>
  </td>
 </tr>
 <tr style='height:39.0pt'>
  <td width=211 valign=top style='width:2.2in;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:39.0pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Tahoma'>Ngày vi
  phạm</span><span style='font-size:11.0pt;font-family:Tahoma'>: <%=dt_emp.Rows[i][4].ToString() %></span></p>
  <p class=MsoNormal style='margin-right:-5.55pt'><i><span style='font-size:
  10.0pt;font-family:Tahoma'>Date of Violation</span></i></p>
  <p class=MsoNormal align=center style='text-align:center'><i><span
  style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></i></p>
  <p class=MsoNormal align=center style='text-align:center'><i><span
  style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></i></p>
  </td>
  <td width=492 colspan=6 rowspan=2 valign=top style='width:369.0pt;border-top:
  none;border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:39.0pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Hành
  vi vi phạm</span></b><span style='font-size:10.0pt;font-family:Tahoma'> / <b><i>Violations</i></b></span></p>
  <p class=MsoNormal style='margin-left:.3in'><span style='font-size:10.0pt;
  font-family:Tahoma'><%=dt_emp.Rows[i][6].ToString() %></span></p>
  <p class=MsoNormal style='margin-left:1.8in;text-indent:-.25in'>
  </p>
  <p class=MsoNormal style='margin-left:.3in'><i><span style='font-size:10.0pt;
  font-family:Tahoma'>&nbsp;</span></i></p>
  <p class=MsoNormal style='margin-left:.3in'><i><span style='font-size:10.0pt;
  font-family:Tahoma'>&nbsp;</span></i></p>
  <p class=MsoNormal style='margin-left:.3in'><i><span style='font-size:10.0pt;
  font-family:Tahoma'>&nbsp;</span></i></p>
  <p class=MsoNormal style='margin-left:.3in'><i><span style='font-size:10.0pt;
  font-family:Tahoma'>&nbsp;</span></i></p>
  </td>
 </tr>
 <tr style='height:49.45pt'>
  <td width=211 valign=top style='width:2.2in;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:49.45pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Tahoma'>Ngày lập
  biên bản:</span><span style='font-size:11.0pt;font-family:Tahoma'>  <%=dt_emp.Rows[i][5].ToString() %></span></p>
  <p class=MsoNormal style='margin-right:-5.55pt'><i><span style='font-size:
  10.0pt;font-family:Tahoma'>Issued date</span></i></p>
  </td>
 </tr>
 <tr style='height:70.6pt'>
  <td width=703 colspan=7 valign=top style='width:527.4pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:70.6pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ý
  kiến &amp; lời cam kết của nhân viên vi phạm – <i>Violator’s statement</i>: </span></b><span
  style='font-size:10.0pt;font-family:Tahoma'></span></p>
  </td>
 </tr>
 <tr style='height:6.75pt'>
  <td width=703 colspan=7 valign=top style='width:527.4pt;border-top:none;
  border-left:solid windowtext 1.0pt;border-bottom:none;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:6.75pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Theo
  Nội quy Công ty và Luật Lao động của nước CHXHCN Việt Nam, quyết định xử lý
  kỷ luật:</span></b></p>
  <p class=MsoNormal style='margin-bottom:6.0pt'><b><span style='font-size:
  10.0pt;font-family:Tahoma'>– <i>Disciplinary Action applied in accordance
  with Company Regulations and Labour Code of Vietnam</i></span></b></p>
  </td>
 </tr>
<tr style='mso-yfti-irow:6;height:48.1pt'>
  <td width=703 colspan=7 valign=top style='width:527.4pt;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:48.1pt'>
  <p class=MsoNormal><span style='mso-spacerun:yes'>      </span><%=dt_emp.Rows[i][8].ToString() %> -
  <%=dt_emp.Rows[i][9].ToString() %></p>
  </td>
 </tr>
 <tr style='height:67.0pt'>
  <td width=331 colspan=3 valign=top style='width:3.45in;border-top:none;
  border-left:solid windowtext 1.0pt;border-bottom:none;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:67.0pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Xác
  nhận &amp; ý kiến của Giám sát Trực tiếp</span></b></p>
  <p class=MsoNormal><b><i><span style='font-size:10.0pt;font-family:Tahoma'>Direct
  Supervisor’s statement</span></i></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b><i><span
  style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></i></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b><i><span
  style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></i></b></p>
  <p class=MsoNormal align=center style='text-align:center'><b><i><span
  style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></i></b></p>
  <p class=MsoNormal><b><i><span style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></i></b></p>
  </td>
  <td width=372 colspan=4 valign=top style='width:279.0pt;border:none;
  border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;height:67.0pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Xác
  nhận &amp; ý kiến của Giám đốc Phụ trách</span></b></p>
  <p class=MsoNormal><b><i><span style='font-size:10.0pt;font-family:Tahoma'>Manager
  in Charge’s statement</span></i></b></p>
  </td>
 </tr>
 <tr>
  <td width=331 colspan=3 valign=top style='width:3.45in;border-top:none;
  border-left:solid windowtext 1.0pt;border-bottom:solid windowtext 1.5pt;
  border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ngày<i>
  / Date </i></span></b><i><span style='font-size:10.0pt;font-family:Tahoma'>………………………………………..</span></i></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ký
  tên, Họ tên /<i> Signature &amp; Name</i></span></b></p>
  </td>
  <td width=372 colspan=4 valign=top style='width:279.0pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.5pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ngày<i>
  / Date </i></span></b><i><span style='font-size:10.0pt;font-family:Tahoma'>………………………………………..</span></i></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ký
  tên, Họ tên /<i> Signature &amp; Name</i></span></b></p>
  </td>
 </tr>
 <tr style='height:78.7pt'>
  <td width=331 colspan=3 valign=top style='width:3.45in;border:none;
  border-left:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;height:78.7pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ý
  kiến của Trưởng Phòng Hành Chánh Nhân Sự:</span></b><i><span
  style='font-size:10.0pt;font-family:Tahoma'> </span></i></p>
  <p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Tahoma'>HRA
  Manager’s comment</span></i></p>
  </td>
  <td width=372 colspan=4 valign=top style='width:279.0pt;border:none;
  border-right:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt;height:78.7pt'>
  <p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></i></p>
  </td>
 </tr>
 <tr style='height:19.5pt'>
  <td width=331 colspan=3 valign=top style='width:3.45in;border-top:none;
  border-left:solid windowtext 1.0pt;border-bottom:solid windowtext 1.0pt;
  border-right:none;padding:0in 5.4pt 0in 5.4pt;height:19.5pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ngày<i>
  / Date </i></span></b><i><span style='font-size:10.0pt;font-family:Tahoma'>………………………………………..</span></i></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ký
  tên, Họ tên /<i> Signature &amp; Name</i></span></b></p>
  </td>
  <td width=372 colspan=4 valign=top style='width:279.0pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:19.5pt'>
  <p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></i></p>
  </td>
 </tr>
 <tr>
  <td width=703 colspan=7 valign=top style='width:527.4pt;border:solid windowtext 1.0pt;
  border-top:none;background:#CCFFFF;padding:0in 5.4pt 0in 5.4pt'>
  <p class=MsoNormal><b><i><span style='font-family:Tahoma'>Trong trường hợp
  nhân viên vi phạm ở mức độ 2 hoặc 3 - In case of violation of category 2 or 3</span></i></b></p>
  </td>
 </tr>
 <tr style='height:63.85pt'>
  <td width=703 colspan=7 valign=top style='width:527.4pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:63.85pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Quyết
  Định của Tổng Giám Đốc </span></b></p>
  <p class=MsoNormal><i><span style='font-size:10.0pt;font-family:Tahoma'>Decision
  Of General Director</span></i></p>
  </td>
 </tr>
 <tr style='height:46.9pt'>
  <td width=331 colspan=3 valign=top style='width:3.45in;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:46.9pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ngày<i>
  / Date </i></span></b><i><span style='font-size:10.0pt;font-family:Tahoma'>………………………………………..</span></i></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ký
  tên, đóng dấu /<i> Signature &amp; stamp</i></span></b></p>
  <p class=MsoNormal><span style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></p>
  </td>
  <td width=372 colspan=4 valign=top style='width:279.0pt;border-top:none;
  border-left:none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:46.9pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Ngày
  / Date: </span></b><span style='font-size:10.0pt;font-family:Tahoma'>……………………………………………………………………..</span></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Chữ
  ký của Nhân viên / <i>Signature of the Violator</i></span></b></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></b></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></b></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></b></p>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>&nbsp;</span></b></p>
  </td>
 </tr>
 <tr style='height:29.2pt'>
  <td width=703 colspan=7 valign=top style='width:527.4pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:29.2pt'>
  <p class=MsoNormal><b><span style='font-size:10.0pt;font-family:Tahoma'>Các
  văn bản đính kèm – <i>Documents attached</i>:</span></b></p>
  </td>
 </tr>
 <tr height=0>
  <td width=211 style='border:none'></td>
  <td width=84 style='border:none'></td>
  <td width=36 style='border:none'></td>
  <td width=104 style='border:none'></td>
  <td width=100 style='border:none'></td>
  <td width=36 style='border:none'></td>
  <td width=132 style='border:none'></td>
 </tr>
</table>



<%
     if (i == dt_emp.Rows.Count - 1)//nhan vien cuoi cung 
     { 
         %>
         

<span style='font-size:12.0pt;font-family:Tahoma;mso-fareast-font-family:Batang;
mso-ansi-language:EN-US;mso-fareast-language:KO;mso-bidi-language:AR-SA'>
</span>

         <%
     }
     else
     {   
  %>
    

<span style='font-size:12.0pt;font-family:Tahoma;mso-fareast-font-family:Batang;
mso-ansi-language:EN-US;mso-fareast-language:KO;mso-bidi-language:AR-SA'><br
clear=all style='mso-special-character:line-break;page-break-before:always'>
</span>

<% 
     }
    }
%>
</div>

</body>

</html>
