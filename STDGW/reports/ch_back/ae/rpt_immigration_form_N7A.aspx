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
    string emp_pk, p_sal_security;
    emp_pk = Request["emp_pk"].ToString();
    p_sal_security = Request["p_sal_security"].ToString();
    string SQL
    = "select to_char(sysdate,'dd') c00 " +
        "        ,to_char(sysdate,'mm') c01 " +
        "        ,to_char(sysdate,'yyyy') c02 " +
        "        , E.FULL_NAME c03 " +
        "        , to_char(to_date(E.BIRTH_DT,'yyyymmdd'), 'dd/mm/yyyy') c04 " +
        "        ,(select code_fnm from vhr_hr_code v where E.JOB_TYPE=v.code and v.id='HR0010') c05 " +
        "        , E.FULL_FNAME c06 " +
        "        ,(select code_nm from vhr_hr_code v where E.JOB_TYPE=v.code and v.id='HR0010') c07 " +
        "from thr_employee e   " +
        "where e.del_if=0 "+
        "and e.PK in ( " + emp_pk + " )        ";
        
    DataTable dt_emp = ESysLib.TableReadOpen(SQL);
    if (dt_emp.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    //Response.Write(dt_emp.Rows.Count);
    //Response.End();
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_immigration_form_N7A_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_immigration_form_N7A_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_immigration_form_N7A_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Dell</o:Author>
  <o:LastAuthor>cun</o:LastAuthor>
  <o:LastPrinted>2013-01-20T03:57:31Z</o:LastPrinted>
  <o:Created>2013-01-18T17:17:55Z</o:Created>
  <o:LastSaved>2013-01-20T04:15:52Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.66in .34in .39in .48in;
	mso-header-margin:.31in;
	mso-footer-margin:.31in;}
.font8
	{color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:black;
	font-size:14.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font12
	{color:black;
	font-size:14.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font13
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:black;
	font-size:12.0pt;
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
.xl65
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;
	vertical-align:middle;}
.xl67
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl68
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl69
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl71
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl73
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl74
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl75
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl76
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl77
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl78
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl79
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl80
	{mso-style-parent:style0;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl81
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl82
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl83
	{mso-style-parent:style0;
	font-size:10.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl84
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl85
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl86
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"Short Date";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl88
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl89
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl90
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl91
	{mso-style-parent:style0;
	font-size:12.0pt;
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
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>92</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>47</x:ActiveRow>
       <x:ActiveCol>13</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
      <x:RowBreak>
      <%
      int _row=27;
      for(int k=0; k < dt_emp.Rows.Count; k++)
      {
      _row++;
       %>
        <%
               } %>
       <x:Row><%=_row %></x:Row>

       
      </x:RowBreak>
     </x:RowBreaks>
    </x:PageBreaks>
   </x:ExcelWorksheet>
   
  </x:ExcelWorksheets>
  <x:WindowHeight>7995</x:WindowHeight>
  <x:WindowWidth>20115</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl65>

<table x:str border=0 cellpadding=0 cellspacing=0 width=716 style='border-collapse:
 collapse;table-layout:fixed;width:537pt'>
 <col class=xl65 width=12 style='mso-width-source:userset;mso-width-alt:438;
 width:9pt'>
 <col class=xl65 width=64 span=4 style='width:48pt'>
 <col class=xl65 width=52 style='mso-width-source:userset;mso-width-alt:1901;
 width:39pt'>
 <col class=xl65 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl65 width=64 style='width:48pt'>
 <col class=xl65 width=51 style='mso-width-source:userset;mso-width-alt:1865;
 width:38pt'>
 <col class=xl65 width=82 style='mso-width-source:userset;mso-width-alt:2998;
 width:62pt'>
 <col class=xl65 width=64 style='width:48pt'>
 <col class=xl65 width=53 style='mso-width-source:userset;mso-width-alt:1938;
 width:40pt'>
 <col class=xl65 width=23 style='mso-width-source:userset;mso-width-alt:841;
 width:17pt'>
 
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl65 width=12 style='height:16.5pt;width:9pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=52 style='width:39pt'></td>
  <td class=xl65 width=59 style='width:44pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=51 style='width:38pt'></td>
  <td class=xl65 width=82 style='width:62pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=53 style='width:40pt'></td>
  <td class=xl66 width=23 style='width:17pt'>Mẫu N7A</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl67 colspan=5 style='mso-ignore:colspan'>Tên cơ quan/ tổ chức:
  Công ty TNHH POSCO SS VINA</td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl67 colspan=6 style='mso-ignore:colspan'>Trụ sở tại:<font
  class="font8"> </font><font class="font9">Đường N1, KCN Phú Mỹ II, H. Tân
  Thành, T. BR-VT</font></td>
  <td class=xl69 colspan=5 style='mso-ignore:colspan'>Tân Thành, ngày <%=dt_emp.Rows[0]["c00"].ToString() %>
  tháng <%=dt_emp.Rows[0]["c01"].ToString() %> năm <%=dt_emp.Rows[0]["c02"].ToString() %></td>
  <td class=xl65></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl67 colspan=3 style='mso-ignore:colspan'>Điện thoại : <font
  class="font9">064-3892-044</font></td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl71 colspan=2 style='mso-ignore:colspan'>Số :<font class="font9"><span
  style='mso-spacerun:yes'>              </span>/PSSV-NS</font></td>
  <td colspan=10 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td class=xl71 colspan=4 style='mso-ignore:colspan'>V/v: Đề nghị cấp thẻ tạm
  trú cho người nước ngoài</td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=12 height=25 class=xl84 style='height:18.75pt'>Kính gửi<font
  class="font12"> </font><font class="font11">: CỤC QUẢN LÝ XUẤT NHẬP CẢNH – BỘ
  CÔNG AN</font><font class="font12"> (1)</font></td>
  <td class=xl65></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=12 height=21 class=xl91 style='height:15.75pt'>Đề nghị quý cơ
  quan xem xét cấp thẻ tạm trú cho <font class="font14"><%=dt_emp.Rows.Count %></font><font
  class="font13"> người nước ngoài sau đây :</font></td>
  <td class=xl65></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=62 style='mso-height-source:userset;height:46.5pt'>
  <td height=62 class=xl65 style='height:46.5pt'></td>
  <td class=xl72 width=64 style='width:48pt'>Số<br>
    TT</td>
  <td colspan=4 class=xl86 style='border-left:none'>Họ và tên</td>
  <td colspan=3 class=xl72 width=174 style='border-left:none;width:130pt'>Ngày
  tháng <br>
    năm sinh</td>
  <td colspan=3 class=xl72 width=199 style='border-left:none;width:150pt'>Công
  việc<br>
    đang đảm nhận</td>
  <td class=xl65></td>
 </tr>
 <%
    for (int i = 0; i < dt_emp.Rows.Count; i++)
    { %>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl65 style='height:33.75pt'></td>
  <td class=xl74 style='border-top:none' x:num><%=i+1 %></td>
  <td colspan=4 class=xl74 style='border-left:none'><%=dt_emp.Rows[i]["c03"].ToString() %></td>
  <td colspan=3 class=xl87 style='border-left:none' x:str><%=dt_emp.Rows[i]["c04"].ToString() %></td>
  <td colspan=3 class=xl88 width=199 style='border-right:.5pt solid black;
  border-left:none;width:150pt'><%=dt_emp.Rows[i]["c05"].ToString() %></td>
  <td class=xl65></td>
 </tr>
 <%} %>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=3 class=xl65 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl73>(Thông tin chi tiết từng người kèm theo)</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=13 class=xl65 style='height:8.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl65 style='height:16.5pt'></td>
  <td colspan=2 class=xl83 x:str="Nơi nhận :   ">Nơi nhận :<span
  style='mso-spacerun:yes'>   </span></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl75>Giám Đốc Nhân Sự - Tổng Vụ</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl65 style='height:16.5pt'></td>
  <td class=xl77 x:str="'- Như trên">- Như trên</td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl76>( ký, đóng dấu, ghi rõ họ tên, chức vụ)</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td class=xl77 colspan=2 style='mso-ignore:colspan' x:str="'- Lưu văn phòng">-
  Lưu văn phòng</td>
  <td colspan=10 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=9 class=xl65 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl78>HONG SOONWON</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='page-break-before:always;height:16.5pt'>
  <td height=22 colspan=2 class=xl65 style='height:16.5pt;mso-ignore:colspan'></td>
  <td></td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl82>Form N7A</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl68 colspan=4 style='mso-ignore:colspan'>Name of enterprise: POSCO
  SS-VINA Co., Ltd</td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl68 colspan=6 style='mso-ignore:colspan'>Location : <font
  class="font9">N1 Street, Phú Mỹ II Industrial Zone, Tân Thành, District<span
  style='mso-spacerun:yes'> </span></font></td>
  <td class=xl80 colspan=5 style='mso-ignore:colspan'>Tan Thanh,
  Date <%=dt_emp.Rows[0]["c00"].ToString() %> month <%=dt_emp.Rows[0]["c01"].ToString() %> year <%=dt_emp.Rows[0]["c02"].ToString() %></td>
  <td class=xl65></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl79 colspan=2 style='mso-ignore:colspan'>BR-VT Province</td>
  <td colspan=10 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl68 colspan=2 style='mso-ignore:colspan'>Tell : <font class="font9">064-3892-044</font></td>
  <td colspan=10 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 style='height:15.0pt'></td>
  <td class=xl70 colspan=2 style='mso-ignore:colspan'>No :<font class="font9"><span
  style='mso-spacerun:yes'>              </span>/PSSV-NS</font></td>
  <td colspan=10 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td class=xl70 colspan=5 style='mso-ignore:colspan'>About: Suggestion for
  issuance of temporary residence card</td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=12 height=25 class=xl84 style='height:18.75pt'>To : IMMIGRATION
  BUREAU-</td>
  <td class=xl65></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td colspan=12 height=25 class=xl84 style='height:18.75pt'>MINISTRY OF PUBLIC
  SECURITY (1)</td>
  <td class=xl65></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td colspan=12 height=21 class=xl85 style='height:15.75pt'>We would like to
  request for considering to issue of temporary residence card for <%=dt_emp.Rows.Count %> foreigner
  as follow:</td>
  <td class=xl65></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=60 style='mso-height-source:userset;height:45.0pt'>
  <td height=60 class=xl65 style='height:45.0pt'></td>
  <td class=xl72 width=64 style='width:48pt'>No</td>
  <td colspan=4 class=xl86 style='border-left:none'>Full name</td>
  <td colspan=3 class=xl72 width=174 style='border-left:none;width:130pt'>Date
  of birth</td>
  <td colspan=3 class=xl72 width=199 style='border-left:none;width:150pt'>Job
  assignment</td>
  <td class=xl65></td>
 </tr>
 <%
     for (int j = 0; j < dt_emp.Rows.Count; j++)
     { %>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td height=45 class=xl65 style='height:33.75pt'></td>
  <td class=xl74 style='border-top:none' x:num><%=j+1 %></td>
  <td colspan=4 class=xl74 style='border-left:none'><%=dt_emp.Rows[j]["c06"].ToString() %></td>
  <td colspan=3 class=xl87 style='border-left:none' x:str><%=dt_emp.Rows[j]["c04"].ToString() %></td>
  <td colspan=3 class=xl88 width=199 style='border-right:.5pt solid black;
  border-left:none;width:150pt'><%=dt_emp.Rows[j]["c07"].ToString() %></td>
  <td class=xl65></td>
 </tr>
 <%} %>
 <tr height=22 style='height:16.5pt'>
  <td height=22 colspan=3 class=xl65 style='height:16.5pt;mso-ignore:colspan'></td>
  <td class=xl73>(Details of each person enclosed)</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=11 style='mso-height-source:userset;height:8.25pt'>
  <td height=11 colspan=13 class=xl65 style='height:8.25pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl65 style='height:16.5pt'></td>
  <td class=xl81 colspan=2 style='mso-ignore:colspan'>Received place :</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl75>GENERAL DIRECTOR</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=22 style='height:16.5pt'>
  <td height=22 class=xl65 style='height:16.5pt'></td>
  <td class=xl77 x:str="'- As above">- As above</td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl76>(Signature, seal, full name and designation)</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl65 style='height:15.0pt'></td>
  <td class=xl77 x:str="'- Office">- Office</td>
  <td colspan=11 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 colspan=13 class=xl65 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='height:18.75pt'>
  <td height=25 colspan=9 class=xl65 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl78>RYU JU YEOL</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>

 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
 
 </tr>
 <![endif]>
</table>

</body>

</html>
