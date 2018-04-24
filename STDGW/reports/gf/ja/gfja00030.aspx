<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser("acnt");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_Company_pk = Request["Company"];
    string p_Voucher_No = Request["Voucherno"];
    string p_Acc_pk = Request["Acc_pk"];
    
    string p_Month_fr = Request["Month_fr"];    
  string p_Month_to = Request["Month_to"];    

    string l_parameter = "'" + p_Company_pk + "', ";
    l_parameter += "'" + p_Voucher_No + "', ";
    l_parameter += "'" + p_Acc_pk + "', ";
    l_parameter += "'" + p_Month_fr + "', ";  
    l_parameter += "'" + p_Month_to + "' ";  
   //Response.Write(l_parameter);
   //Response.End();
    string p_company_name = "";
    string p_tax_code = "";
    string p_cmp_add = "";
    string SQL = " SELECT partner_lname, tax_code, ADDR1, ADDR2, ADDR3  FROM tco_company  WHERE pk = '" + p_Company_pk + "'";
    DataTable dt2 = ESysLib.TableReadOpen(SQL);
    p_company_name = dt2.Rows[0][0].ToString();
    p_tax_code = dt2.Rows[0][1].ToString();
    p_cmp_add = dt2.Rows[0][2].ToString() + " " + dt2.Rows[0][3].ToString();

    DataTable dt = ESysLib.TableReadOpenCursor("acnt.sp_sel_gfja00030_report1", l_parameter);
    //Response.Write(dt.Rows.Count.ToString());
    //Response.End();
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is no data!!");
        Response.End();
    }

   p_Month_to = p_Month_to.Substring(4, 2) + "/" + p_Month_to.Substring(0, 4);   
          
 %>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List
href="So%20chi%20tiet%20chi%20phi%20tra%20truoc_files/filelist.xml">
<link rel=Edit-Time-Data
href="So%20chi%20tiet%20chi%20phi%20tra%20truoc_files/editdata.mso">
<link rel=OLE-Object-Data
href="So%20chi%20tiet%20chi%20phi%20tra%20truoc_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Phan Thi Thanh Tuyen</o:Author>
  <o:LastAuthor>LONG</o:LastAuthor>
  <o:LastPrinted>2010-08-06T09:41:13Z</o:LastPrinted>
  <o:Created>2010-04-27T06:54:12Z</o:Created>
  <o:LastSaved>2010-08-06T09:41:30Z</o:LastSaved>
  <o:Company>Vina</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{mso-footer-data:"Page &P of &N";
	margin:.75in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;
	mso-page-orientation:landscape;}
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
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	text-align:center;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"dd\/mm\/yyyy";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl34
	{mso-style-parent:style0;
	font-size:18.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0";
	vertical-align:middle;
	border:.5pt solid windowtext;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Bảng phân bổ chi phí</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>315</x:DefaultRowHeight>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>76</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>6</x:SplitHorizontal>
     <x:TopRowBottomPane>6</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>13</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>18795</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>345</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>_FilterDatabase</x:Name>
  <x:Hidden/>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>='Bảng phân bổ chi phí'!$A$6:$L$6</x:Formula>
 </x:ExcelName>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="2049"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="1"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl28>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1277 style='border-collapse:
 collapse;table-layout:fixed;width:958pt'>
 <col class=xl28 width=64 style='width:48pt'>
 <col class=xl28 width=81 style='mso-width-source:userset;mso-width-alt:2962;
 width:61pt'>
 <col class=xl28 width=79 style='mso-width-source:userset;mso-width-alt:2889;
 width:59pt'>
 <col class=xl28 width=301 style='mso-width-source:userset;mso-width-alt:11008;
 width:226pt'>
 <col class=xl28 width=107 style='mso-width-source:userset;mso-width-alt:3913;
 width:80pt'>
 <col class=xl28 width=68 style='mso-width-source:userset;mso-width-alt:2486;
 width:51pt'>
 <col class=xl28 width=64 style='width:48pt'>
 <col class=xl28 width=76 style='mso-width-source:userset;mso-width-alt:2779;
 width:57pt'>
 <col class=xl28 width=105 style='mso-width-source:userset;mso-width-alt:3840;
 width:79pt'>
 <col class=xl28 width=103 style='mso-width-source:userset;mso-width-alt:3766;
 width:77pt'>
 <col class=xl28 width=115 style='mso-width-source:userset;mso-width-alt:4205;
 width:86pt'>
 <col class=xl28 width=114 style='mso-width-source:userset;mso-width-alt:4169;
 width:86pt'>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 colspan=2 width=145 style='height:15.75pt;
  mso-ignore:colspan;width:109pt'><%=p_company_name%></td>
  <td class=xl24 width=79 style='width:59pt'></td>
  <td class=xl28 width=301 style='width:226pt'></td>
  <td class=xl29 width=107 style='width:80pt'></td>
  <td class=xl29 width=68 style='width:51pt'></td>
  <td class=xl29 width=64 style='width:48pt'></td>
  <td class=xl29 width=76 style='width:57pt'></td>
  <td class=xl29 width=105 style='width:79pt'></td>
  <td class=xl29 width=103 style='width:77pt'></td>
  <td class=xl29 width=115 style='width:86pt'></td>
  <td class=xl28 width=114 style='width:86pt'></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 colspan=2 style='height:15.75pt;mso-ignore:colspan'><%=p_cmp_add%></td>
  <td class=xl24></td>
  <td class=xl28></td>
  <td colspan=7 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr height=30 style='height:22.5pt'>
  <td height=30 class=xl34 colspan=4 style='height:22.5pt;mso-ignore:colspan'>BẢNG
  PHÂN BỔ CHI PHÍ 142 THÁNG <%=p_Month_to%></td>
  <td class=xl30></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 colspan=2 class=xl28 style='height:15.75pt;mso-ignore:colspan'></td>
  <td class=xl24></td>
  <td class=xl28></td>
  <td class=xl30></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl28 style='height:15.75pt'>.</td>
  <td class=xl28></td>
  <td class=xl24></td>
  <td class=xl28></td>
  <td colspan=7 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl28></td>
 </tr>
 <tr class=xl24 height=42 style='height:31.5pt'>
  <td height=42 class=xl25 id="_x0000_s1025" x:autofilter="all"
  x:autofilterrange="$A$6:$L$6" style='height:31.5pt'>STT</td>
  <td class=xl25 id="_x0000_s1026" x:autofilter="all" style='border-left:none'>Mã</td>
  <td class=xl25 id="_x0000_s1027" x:autofilter="all" style='border-left:none'>Ngày</td>
  <td class=xl25 id="_x0000_s1028" x:autofilter="all" style='border-left:none'>Nội
  dung</td>
  <td class=xl26 id="_x0000_s1029" x:autofilter="all" style='border-left:none'>Số
  tiền</td>
  <td class=xl27 id="_x0000_s1030" x:autofilter="all" width=68
  style='border-left:none;width:51pt'>Số tháng</td>
  <td class=xl27 id="_x0000_s1031" x:autofilter="all" width=64
  style='border-left:none;width:48pt'>Tháng đã PB</td>
  <td class=xl26 id="_x0000_s1032" x:autofilter="all" style='border-left:none'>TK
  chi phí</td>
  <td class=xl26 id="_x0000_s1033" x:autofilter="all" style='border-left:none'>TK
  trích trước</td>
  <td class=xl26 id="_x0000_s1034" x:autofilter="all" style='border-left:none'>Mức
  phân bổ</td>
  <td class=xl26 id="_x0000_s1035" x:autofilter="all" style='border-left:none'>Lũy
  kế</td>
  <td class=xl26 id="_x0000_s1036" x:autofilter="all" style='border-left:none'>Giá
  trị còn lại</td>
 </tr>
 <%int k=0;
        decimal sotien = 0;
        decimal mucpb = 0;
       decimal luyke = 0;
       decimal gtconlai = 0;
    
                for(int  i = 0;i<dt.Rows.Count;i++)
                {
                    
                  if(dt.Rows[i][3].ToString().Trim() != "")
                  {
                            sotien += decimal.Parse(dt.Rows[k][3].ToString());
                  }  
                  else
                  {
                        sotien=0;
                  }
                  
                  if(dt.Rows[i][8].ToString().Trim() != "")
                  {
                            mucpb += decimal.Parse(dt.Rows[k][8].ToString());
                  }  
                  else
                  {
                        mucpb =0;
                  }
                  
                  if(dt.Rows[i][9].ToString().Trim() != "")
                  {
                            luyke += decimal.Parse(dt.Rows[k][9].ToString());
                  }  
                  else
                  {
                        luyke=0;
                  }
                  
                  if(dt.Rows[i][10].ToString().Trim() != "")
                  {
                            gtconlai += decimal.Parse(dt.Rows[k][10].ToString());
                  }  
                  else
                  {
                        gtconlai=0;
                  }
             
%> 

 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl40 style='height:15.75pt;border-top:none' x:num><%=k+1%></td>
  <td class=xl31 style='border-top:none;border-left:none'><%=dt.Rows[i][0]%></td>
  <td class=xl32 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][1]%></td>
  <td class=xl33 style='border-top:none;border-left:none'><%=dt.Rows[i][2]%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][3]%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4]%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5]%></td>
  <td class=xl36 style='border-top:none;border-left:none' ><%=dt.Rows[i][6]%></td>
  <td class=xl37 style='border-top:none;border-left:none' ><%=dt.Rows[i][7]%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][8]%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][9]%></td>
  <td class=xl35 align=right style='border-top:none;border-left:none'  x:num><%=dt.Rows[i][10]%></td>
 </tr>
<%
 k+=1;
} %>  
 <tr height=21 style='height:15.75pt'>
  <td height=21 class=xl33 style='height:15.75pt;border-top:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl33 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>Tổng cộng</td>
  <td class=xl39 align=right style='border-top:none;border-left:none'  x:num><%=sotien%></td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl38 style='border-top:none;border-left:none'>&nbsp;</td>
  <td class=xl39 align=right style='border-top:none;border-left:none'  x:num><%=mucpb%></td>
  <td class=xl39 align=right style='border-top:none;border-left:none'  x:num><%=luyke%></td>
  <td class=xl39 align=right style='border-top:none;border-left:none'  x:num><%=gtconlai%></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=81 style='width:61pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=301 style='width:226pt'></td>
  <td width=107 style='width:80pt'></td>
  <td width=68 style='width:51pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=76 style='width:57pt'></td>
  <td width=105 style='width:79pt'></td>
  <td width=103 style='width:77pt'></td>
  <td width=115 style='width:86pt'></td>
  <td width=114 style='width:86pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
