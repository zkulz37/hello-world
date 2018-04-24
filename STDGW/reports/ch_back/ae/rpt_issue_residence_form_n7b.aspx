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
    = "select E.FULL_NAME c00 " +
        "    , substr(E.BIRTH_DT,-2) c01 " +
        "    , substr(E.BIRTH_DT,5,2) c02 " +
        "    , substr(E.BIRTH_DT,1,4) c03 " +
        "    , decode(E.SEX,'M','x','') c04 " +
        "    , decode(E.SEX,'F','x','') c05 " +
        "    , (select code_fnm from vhr_hr_code v where V.CODE=E.NATION and V.ID='HR0009') c06 " +
        "    , (select code_fnm from vhr_hr_code v where V.CODE=E.RELIG_TYPE  and V.ID='HR0016') c07 " +
        "    , (select code_fnm from vhr_hr_code v where V.CODE=E.POS_TYPE    and V.ID='HR0008') c08 " +
        "    , (select code_fnm from vhr_hr_code v where V.CODE=E.POS_TYPE    and V.ID='HR0008') c09 " +
        "    , A.PASSPORT_NO c10 " +
        "    , to_char(to_date(A.TO_DT,'yyyymmdd'),'dd/mm/yyyy') c11 " +
        "    , E.PERMANENT_ADDR c12 " +
        "    , to_char(to_date(nvl(b.from_dt,c.FROM_DT),'yyyymmdd'),'dd/mm/yyyy') c13 " +
        "    , to_char(to_date(nvl(b.to_dt,c.to_DT),'yyyymmdd'),'dd/mm/yyyy') c14 " +
        "    , E.PRESENT_ADDR c15 " +
        "    , E.FULL_FNAME c16 " +
        "    , (select code_nm from vhr_hr_code v where V.CODE=E.NATION and V.ID='HR0009') c17 " +
        "    , (select code_nm from vhr_hr_code v where V.CODE=E.RELIG_TYPE  and V.ID='HR0016') c18 " +
        "    , (select code_nm from vhr_hr_code v where V.CODE=E.POS_TYPE    and V.ID='HR0008') c19 " +
        "    , (select code_nm from vhr_hr_code v where V.CODE=E.POS_TYPE    and V.ID='HR0008') c20 " +
        "    , E.PERMANENT_ADDR_ENG c21 " +
        "    , E.PRESENT_ADDR_ENG c22 " +
        "from thr_employee e, thr_f_passport a, thr_f_residence b, thr_f_visa c " +
        "where E.DEL_IF=0 " +
        "and B.DEL_IF(+)=0 and c.del_if(+)=0 and e.pk=c.thr_emp_pk(+) " +
        "and A.DEL_IF(+)=0 " +
        "and e.pk=b.THR_EMP_PK(+) " +
        "and E.PK=A.THR_EMP_PK(+) " +
        "and e.PK in ( " + emp_pk + " )        ";

        
        //Response.Write(SQL);
    //Response.End();
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
<link rel=File-List href="rpt_immigration_form_n7b_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_immigration_form_n7b_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_immigration_form_n7b_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Dell</o:Author>
  <o:LastAuthor>cun</o:LastAuthor>
  <o:LastPrinted>2013-01-20T06:15:59Z</o:LastPrinted>
  <o:Created>2013-01-18T17:17:55Z</o:Created>
  <o:LastSaved>2013-01-20T06:31:11Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.63in .17in .49in .59in;
	mso-header-margin:.3in;
	mso-footer-margin:.3in;}
.font7
	{color:black;
	font-size:12.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font9
	{color:black;
	font-size:8.0pt;
	font-weight:400;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font10
	{color:black;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font11
	{color:blue;
	font-size:12.0pt;
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl66
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl67
	{mso-style-parent:style0;
	font-size:14.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl68
	{mso-style-parent:style0;
	font-size:13.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl69
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl70
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	white-space:normal;}
.xl71
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl72
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl73
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl74
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl75
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl76
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl77
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl78
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl79
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl80
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl81
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
.xl82
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl83
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl84
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl85
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl86
	{mso-style-parent:style0;
	color:blue;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl87
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	white-space:normal;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>96</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Zoom>90</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>42</x:ActiveRow>
       <x:RangeSelection>$43:$43</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
    <x:PageBreaks>
     <x:RowBreaks>
<%
      int irow=0;
      for(int k=0; k < dt_emp.Rows.Count; k++)
      {
          irow+=43;
%>  
      <x:RowBreak>      
           <x:Row><%=irow %></x:Row>           
      </x:RowBreak>
      <%
      irow+=34;
       %>
       <x:RowBreak>      
           <x:Row><%=irow %></x:Row>           
      </x:RowBreak>
<%        
        } 
%>
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

<table x:str border=0 cellpadding=0 cellspacing=0 width=695 style='border-collapse:
 collapse;table-layout:fixed;width:522pt'>
 <col class=xl65 width=21 style='mso-width-source:userset;mso-width-alt:768;
 width:16pt'>
 <col class=xl65 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl65 width=64 span=2 style='width:48pt'>
 <col class=xl65 width=62 style='mso-width-source:userset;mso-width-alt:2267;
 width:47pt'>
 <col class=xl65 width=64 span=4 style='width:48pt'>
 <col class=xl65 width=21 span=2 style='mso-width-source:userset;mso-width-alt:
 768;width:16pt'>
 <col class=xl65 width=31 style='mso-width-source:userset;mso-width-alt:1133;
 width:23pt'>
 <col class=xl65 width=39 style='mso-width-source:userset;mso-width-alt:1426;
 width:29pt'>
 <col class=xl65 width=20 style='mso-width-source:userset;mso-width-alt:731;
 width:15pt'>
 <col class=xl65 width=28 style='mso-width-source:userset;mso-width-alt:1024;
 width:21pt'>
 <col class=xl65 width=7 style='mso-width-source:userset;mso-width-alt:256;
 width:5pt'>
 <%
    for (int i = 0; i < dt_emp.Rows.Count; i++)
    { %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl65 width=21 style='height:18.75pt;width:16pt'></td>
  <td class=xl65 width=68 style='width:51pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=62 style='width:47pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=64 style='width:48pt'></td>
  <td class=xl65 width=21 style='width:16pt'></td>
  <td class=xl68 width=21 style='width:16pt'></td>
  <td class=xl68 colspan=3 width=90 style='mso-ignore:colspan;width:67pt'><span
  style='mso-spacerun:yes'> </span>Mẫu N7B</td>
  <td class=xl65 width=28 style='width:21pt'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=5 class=xl65 style='height:22.5pt;mso-ignore:colspan'></td>
  <td class=xl67>THÔNG TIN VỀ NGƯỜI NƯỚC NGOÀI</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=4 rowspan=6 class=xl76 width=118 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:88pt'>Ảnh<br>
    (3)</td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=5 class=xl65 style='height:22.5pt;mso-ignore:colspan'></td>
  <td class=xl67>ĐỀ NGHỊ CẤP THẺ TẠM TRÚ (1)</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=5 class=xl65 style='height:22.5pt;mso-ignore:colspan'></td>
  <td class=xl66>(kèm theo công văn số…… ……………ngày………/………/……….....</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=5 class=xl65 style='height:22.5pt;mso-ignore:colspan'></td>
  <td class=xl66>của…………………………………………….……………………) (2)</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl65 colspan=6 style='height:15.75pt;mso-ignore:colspan'>1
  - Họ và tên ( viết chữ in hoa) : <font class="font11"><%=dt_emp.Rows[i]["c00"].ToString() %></font></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=8 style='mso-height-source:userset;height:6.0pt'>
  <td height=8 colspan=9 class=xl65 style='height:6.0pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 colspan=5 style='height:20.25pt;mso-ignore:colspan'>2-
  Sinh ngày <font class="font11"><%=dt_emp.Rows[i]["c01"].ToString() %></font><font class="font7"> tháng </font><font
  class="font11"><%=dt_emp.Rows[i]["c02"].ToString() %></font><font class="font7"> năm </font><font class="font11"><%=dt_emp.Rows[i]["c03"].ToString() %></font></td>
  <td class=xl65></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'>3. Giới tính :</td>
  <td class=xl65>nam</td>
  <td class=xl85><%=dt_emp.Rows[i]["c04"].ToString() %></td>
  <td class=xl71></td>
  <td class=xl65></td>
  <td class=xl65>nữ</td>
  <td class=xl85><%=dt_emp.Rows[i]["c05"].ToString() %></td>
  <td class=xl65></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 colspan=4 style='height:20.25pt;mso-ignore:colspan'>4-
  Quốc tịch gốc :<font class="font11"> <%=dt_emp.Rows[i]["c06"].ToString() %></font></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl65 colspan=4 style='mso-ignore:colspan'>5- Quốc tịch hiện nay: <font
  class="font11"><%=dt_emp.Rows[i]["c06"].ToString() %></font></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 colspan=3 style='height:20.25pt;mso-ignore:colspan'>6-
  Tôn giáo : <font class="font11"><%=dt_emp.Rows[i]["c07"].ToString() %></font></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'>7- Nghề nghiệp : <font
  class="font11"><%=dt_emp.Rows[i]["c08"].ToString() %></font></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 colspan=3 style='height:20.25pt;mso-ignore:colspan'>8-
  Chức vụ : <font class="font11"><%=dt_emp.Rows[i]["c09"].ToString() %></font></td>
  <td colspan=12 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 colspan=7 style='height:20.25pt;mso-ignore:colspan'>9-
  Hộ chiếu/ giấy tờ có giá trị thay hộ chiếu số :<font class="font11"> <%=dt_emp.Rows[i]["c10"].ToString() %></font></td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'>loại (4) : <font
  class="font11">Phổ thông</font></td>
  <td colspan=12 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=9 style='mso-ignore:colspan'>cơ quan cấp :Bộ Ngoại
  giao và<span style='mso-spacerun:yes'>  </span>Thương mại <font class="font11"><%=dt_emp.Rows[i]["c06"].ToString() %></font><font class="font7"> có giá trị đến ngày: </font><font
  class="font11"><%=dt_emp.Rows[i]["c11"].ToString() %></font></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 colspan=8 style='height:20.25pt;mso-ignore:colspan'>10-
  Địa chỉ cư trú, nơi làm việc ở nước ngoài trước khi nhập cảnh Việt Nam :</td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'
  x:str>- Địa chỉ cư trú : <%=dt_emp.Rows[i]["c12"].ToString() %></td>
  <td colspan=11 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan' x:str="'- Nơi làm việc :">-
  Nơi làm việc :</td>
  <td colspan=12 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 colspan=9 style='height:20.25pt;mso-ignore:colspan'>11-
  Nhập cảnh Việt Nam ngày : <%=dt_emp.Rows[i]["c13"].ToString() %> với mục đích làm việc</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 colspan=7 style='height:20.25pt;mso-ignore:colspan'>12-
  Đã được chứng nhận tạm trú đến ngày : <font class="font11"><%=dt_emp.Rows[i]["c14"].ToString() %></font></td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 colspan=6 style='height:20.25pt;mso-ignore:colspan'>13-
  Địa chỉ đang tạm trú và làm việc ở Việt Nam :</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=8 style='mso-ignore:colspan'
  x:str>-
  Địa chỉ tạm trú : <font class="font11"><%=dt_emp.Rows[i]["c15"].ToString() %></font></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=7 style='mso-ignore:colspan'
  x:str>- Làm
  việc với cơ quan/ tổ chức : <font class="font11">Công ty TNHH POSCO SS-VINA</font></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=8 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>Địa chỉ : <font class="font11">Đường N1,
  KCN Phú Mỹ II, Huyện Tân Thành, Tỉnh Bà Rịa –Vũng Tàu</font></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 colspan=4 style='height:20.25pt;mso-ignore:colspan'>14-
  Đề nghị cấp thẻ tạm trú :</td>
  <td colspan=11 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=6 style='mso-ignore:colspan'
  x:str>- Thời hạn từ
  ngày : <font class="font11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font><font class="font7"><span
  style='mso-spacerun:yes'>  </span>đến ngày : </font><font class="font11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=8 style='mso-ignore:colspan'
  x:str>-
  Địa chỉ tạm trú : <font class="font11"><%=dt_emp.Rows[i]["c15"].ToString() %></font></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'
  x:str="'- Mục đích tạm trú (5) :">- Mục đích tạm trú (5) :</td>
  <td colspan=11 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=7 style='mso-ignore:colspan'
  x:str>+ Làm
  việc với cơ quan/ tổ chức : Công ty TNHH POSCO SS-VINA</td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=8 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>   </span>Địa chỉ : Đường N1, KCN Phú Mỹ II, Huyện
  Tân Thành, Tỉnh Bà Rịa –Vũng Tàu</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=27 style='mso-height-source:userset;height:20.25pt'>
  <td height=27 class=xl65 style='height:20.25pt'></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'
  x:str="'+ Sống cùng ông/bà : Không">+ Sống cùng ông/bà : Không</td>
  <td colspan=11 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl65>quan hệ :</td>
  <td colspan=12 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl75 colspan=3 style='height:15.75pt;mso-ignore:colspan'><font
  class="font10">Ghi chú</font><font class="font9"> (1), (2), (3), (4), (5) :</font></td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
  <td class=xl74>&nbsp;</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl72 colspan=7 style='height:15.75pt;mso-ignore:colspan'>(1)
  Đóng dấu treo của cơ quan/ tổ chức vào phía trái bên cạnh tiêu đề này.</td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl72 colspan=3 style='height:15.75pt;mso-ignore:colspan'>(2)
  Công văn theo mẫu N7A</td>
  <td colspan=12 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl72 colspan=15 style='height:15.75pt;mso-ignore:colspan'>(3)
  Dán 01 ảnh mới chụp, cỡ 3x4cm, phông nền trắng, mặt nhìn thẳng, đầu để trần,
  không đeo kính màu, có đóng dấu giáp lai của cơ quan/ tổ chức</td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl72 colspan=6 style='height:15.75pt;mso-ignore:colspan'>đề
  nghị cấp thẻ tạm trú; kèm theo một ảnh mới cùng kiểu để cấp thẻ.</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl72 colspan=12 style='height:15.75pt;mso-ignore:colspan'>(4)<span
  style='mso-spacerun:yes'>             </span>Nếu là hộ chiếu thì ghi rõ phổ
  thông, công vụ hay ngoại giao; nếu là giấy tờ thay hộ chiếu thì ghi rõ tên
  giấy tờ đó.</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl72 height=15 style='height:11.25pt'>
  <td height=15 class=xl72 colspan=15 style='height:11.25pt;mso-ignore:colspan'
  x:str>(5)<span
  style='mso-spacerun:yes'>             </span>Nộp kèm giấy tờ chứng minh mục
  đích ở lại Việt Nam (tuỳ trường hợp mà nộp giấy tờ thích hợp như : giấy phép
  lao động; quyết định<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl72 height=15 style='height:11.25pt'>
  <td height=15 class=xl72 colspan=15 style='height:11.25pt;mso-ignore:colspan'>bổ
  nhiệm chức danh trong doanh nghiệp; người thuộc biên chế Văn phòng đại<span
  style='mso-spacerun:yes'>  </span>diện, Chi nhánh công ty nước ngoài tại Việt
  Nam; giấy đăng ký kết</td>
 </tr>
 <tr class=xl72 height=15 style='height:11.25pt'>
  <td height=15 class=xl72 colspan=3 style='height:11.25pt;mso-ignore:colspan'>hôn;
  giấy khai sinh…).</td>
  <td colspan=12 class=xl72 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=15 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr height=25 style='page-break-before:always;mso-height-source:userset;
  height:18.75pt'>
  <td height=25 colspan=10 class=xl65 style='height:18.75pt;mso-ignore:colspan'></td>
  <td class=xl68></td>
  <td class=xl68 colspan=3 style='mso-ignore:colspan'>Form N7B</td>
  <td class=xl65></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=5 class=xl65 style='height:22.5pt;mso-ignore:colspan'></td>
  <td class=xl67>IMFORMATION OF FOREIGNER</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td colspan=4 rowspan=5 class=xl76 width=118 style='border-right:.5pt solid black;
  border-bottom:.5pt solid black;width:88pt'>Photo<br>
    (3)</td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=5 class=xl65 style='height:22.5pt;mso-ignore:colspan'></td>
  <td class=xl67>REQUEST FOR ISSUANCE OF</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=5 class=xl65 style='height:22.5pt;mso-ignore:colspan'></td>
  <td class=xl67>TEMPORARY RESIDENCE CARD (1)</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=5 class=xl65 style='height:22.5pt;mso-ignore:colspan'></td>
  <td class=xl66>(Included with document No…………date……/……/……....</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:22.5pt'>
  <td height=30 colspan=5 class=xl65 style='height:22.5pt;mso-ignore:colspan'></td>
  <td class=xl66>of………………………………) (2)</td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=9 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl70 style='mso-ignore:colspan'></td>
  <td class=xl87 width=31 style='border-top:none;width:23pt'>&nbsp;</td>
  <td class=xl87 width=39 style='border-top:none;width:29pt'>&nbsp;</td>
  <td class=xl87 width=20 style='border-top:none;width:15pt'>&nbsp;</td>
  <td class=xl87 width=28 style='border-top:none;width:21pt'>&nbsp;</td>
 </tr>
 <tr height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 class=xl65 colspan=7 style='height:18.0pt;mso-ignore:colspan'>1
  – Full name (written in capital letters) : <font class="font11"><%=dt_emp.Rows[i]["c16"].ToString() %></font></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td colspan=6 class=xl70 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=7 style='mso-height-source:userset;height:5.25pt'>
  <td height=7 colspan=9 class=xl65 style='height:5.25pt;mso-ignore:colspan'></td>
  <td colspan=5 class=xl69 style='mso-ignore:colspan'></td>
  <td class=xl65></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl65 colspan=6 style='height:15.75pt;mso-ignore:colspan'>2-
  Date of birth: Date <font class="font11"><%=dt_emp.Rows[i]["c01"].ToString() %></font><font class="font7"><span
  style='mso-spacerun:yes'>  </span>month </font><font class="font11"><%=dt_emp.Rows[i]["c02"].ToString() %></font><font
  class="font7"> year </font><font class="font11"><%=dt_emp.Rows[i]["c03"].ToString() %></font></td>
  <td class=xl65>3. Sex<span style='mso-spacerun:yes'>  </span>:</td>
  <td class=xl65></td>
  <td class=xl65>Male</td>
  <td class=xl85><%=dt_emp.Rows[i]["c04"].ToString() %></td>
  <td class=xl71></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'>Female</td>
  <td class=xl86><%=dt_emp.Rows[i]["c05"].ToString() %></td>
  <td class=xl65></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 colspan=4 style='height:21.75pt;mso-ignore:colspan'>4-
  Origin nationality : <font class="font11"><%=dt_emp.Rows[i]["c17"].ToString() %><span
  style='mso-spacerun:yes'> </span></font></td>
  <td colspan=2 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'>5- Current nationality: <font
  class="font11"><%=dt_emp.Rows[i]["c17"].ToString() %></font></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 colspan=3 style='height:21.75pt;mso-ignore:colspan'>6-
  Religion : <font class="font11"><%=dt_emp.Rows[i]["c18"].ToString() %></font></td>
  <td colspan=3 class=xl65 style='mso-ignore:colspan'></td>
  <td class=xl65 colspan=3 style='mso-ignore:colspan'>7- Occupation : <font
  class="font11"><%=dt_emp.Rows[i]["c19"].ToString() %></font></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 colspan=5 style='height:21.75pt;mso-ignore:colspan'>8-
  Job assignment:<font class="font11"> <%=dt_emp.Rows[i]["c20"].ToString() %></font></td>
  <td colspan=10 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 colspan=7 style='height:21.75pt;mso-ignore:colspan'>9-
  Passport/ documents valid as passport number: <font class="font11"><%=dt_emp.Rows[i]["c10"].ToString() %></font></td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=5 style='mso-ignore:colspan'>Type(4) : PM (Passport of
  multiple purposes)</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=8 style='mso-ignore:colspan'>Issuing Authority :
  Ministry of foreign affairs and trade valid until: <font class="font11"><%=dt_emp.Rows[i]["c11"].ToString() %></font></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 colspan=8 style='height:21.75pt;mso-ignore:colspan'>10-
  Permanent place of residence, working before enter to Viet Nam:</td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=8 style='mso-ignore:colspan'
  x:str>-
  Permanent address : <font class="font11"><%=dt_emp.Rows[i]["c21"].ToString() %></font></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan' x:str="'- Working place :">-
  Working place :</td>
  <td colspan=12 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 colspan=9 style='height:21.75pt;mso-ignore:colspan'>11-
  Date of entering Viet Nam : <%=dt_emp.Rows[i]["c13"].ToString() %> with purpose of working</td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 colspan=6 style='height:21.75pt;mso-ignore:colspan'>12-
  Has been certified for residence until : <font class="font11">23/03 /2013</font></td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 colspan=6 style='height:21.75pt;mso-ignore:colspan'>13-
  Temporary residence and working in Viet Nam :</td>
  <td colspan=9 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=8 style='mso-ignore:colspan'
  x:str>-
  Temporary residence : <font class="font11">1615 Seaview 2,<span
  style='mso-spacerun:yes'>  </span>Chí Linh Center, Vung Tau City</font></td>
  <td colspan=6 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=7 style='mso-ignore:colspan'
  x:str>- Work
  with agencies / organizations:<font class="font11"> POSCO SS-VINA Co Ltd.</font></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=9 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>  </span>Address : <font class="font11">N1 Street,
  Phu My II Industrial Zone, Tan Thanh District, BR-VT Province</font></td>
  <td colspan=5 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 colspan=7 style='height:21.75pt;mso-ignore:colspan'>14-
  Requesting for issuance of temporary residence card:</td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=4 style='mso-ignore:colspan'
  x:str>- From :<font class="font11"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   </font><font
  class="font7"><span style='mso-spacerun:yes'>  </span>To: </font><font
  class="font11">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
  <td colspan=10 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=7 style='mso-ignore:colspan'
  x:str>-
  Temporary address:<font class="font11"> <%=dt_emp.Rows[i]["c22"].ToString() %></font></td>
  <td colspan=7 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'
  x:str="'- With purpose (5) :">- With purpose (5) :</td>
  <td colspan=12 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=6 style='mso-ignore:colspan'
  x:str="'  + Working for company : POSCO SS-VINA Co., Ltd"><span
  style='mso-spacerun:yes'>  </span>+ Working for company : <font class="font11">POSCO
  SS-VINA Co., Ltd</font></td>
  <td colspan=8 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=10 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'>     </span>Address : <font class="font11">N1
  Street, Phu My II Industrial Zone, Tan Thanh District, BR-VT Province</font></td>
  <td colspan=4 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=29 style='mso-height-source:userset;height:21.75pt'>
  <td height=29 class=xl65 style='height:21.75pt'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan'
  x:str="'  + Living with : "><span style='mso-spacerun:yes'>  </span>+ Living
  with :<span style='mso-spacerun:yes'> </span></td>
  <td colspan=12 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl65 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl65 colspan=2 style='mso-ignore:colspan' x:str>Relationship
  :<span style='mso-spacerun:yes'> </span></td>
  <td colspan=11 class=xl65 style='mso-ignore:colspan'></td>
 </tr>
 <tr></tr>
  <%} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  
 </tr>
 <![endif]>
</table>

</body>

</html>
