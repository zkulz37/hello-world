<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
    ESysLib.SetUser("acnt"); 
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns="http://www.w3.org/TR/REC-html40" xmlns:o = 
"urn:schemas-microsoft-com:office:office" xmlns:x = 
"urn:schemas-microsoft-com:office:excel">
<%
  string l_pk=Request["pk_req"]; 
  string l_num="";
  string l_t_num="";
  
  string SQL
    = "select to_char(to_date(a.VOUCHER_DATE,'yyyymmdd'),'dd') v_dd " + 
        ",to_char(to_date(a.VOUCHER_DATE,'yyyymmdd'),'mm') v_mm " +
        ",to_char(to_date(a.VOUCHER_DATE,'yyyymmdd'),'yyyy') v_yy  " +
        ",B1.FULL_NAME,B.FULL_NAME, B.PERMANENT_ADDR,A.TR_AMT,a.L_DESCRIPTION " +
        ",to_char(to_date(a.REQ_DATE,'yyyymmdd'),'dd-mm-yyyy') " +
        ",a.REQ_CCY,c.PARTNER_LNAME,d.org_NM " +
        "from ACNT.TAC_EMPADVREQ A,HR.THR_EMPLOYEE B, HR.THR_EMPLOYEE B1, comm.TCO_company c, comm.tco_org d " +
        "WHERE A.DEL_IF=0 AND B.DEL_IF(+)=0 AND B1.DEL_IF(+)=0  and c.DEL_IF(+)=0 and d.del_if(+)=0 " +
        "        AND A.CHARGER_PK= B.PK(+) " +
        "        AND A.CHARGER_APPR=B1.PK(+) " +
        "        and a.TCO_COMPANY_PK=c.pk(+) " +
        "        and a.TCO_org_PK=d.pk(+) " +      
        "        and a.PK='" + l_pk + "' " ;
  //Response.Write(SQL);
  //Response.End();
  DataTable dt = ESysLib.TableReadOpen(SQL);
  %>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META content=Excel.Sheet name=ProgId>
<META content="MSHTML 6.00.2900.2180" name=GENERATOR><LINK 
href="adv_request_main_files/filelist.xml" rel=File-List><LINK 
href="adv_request_main_files/editdata.mso" rel=Edit-Time-Data><LINK 
href="adv_request_main_files/oledata.mso" rel=OLE-Object-Data><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Thu Hien</o:Author>
  <o:LastAuthor>Thu Hien</o:LastAuthor>
  <o:LastPrinted>2009-04-01T10:02:17Z</o:LastPrinted>
  <o:Created>2009-03-23T09:09:53Z</o:Created>
  <o:LastSaved>2009-04-01T10:02:43Z</o:LastSaved>
  <o:Company>Vina Genuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<STYLE>@page  {margin: 0in 0in 0in .5in; mso-header-margin: 0in; mso-footer-margin: 0in; mso-page-orientation: landscape; }
TABLE {
	mso-displayed-decimal-separator: "."; mso-displayed-thousand-separator: ","
}
TR {
	mso-height-source: auto
}
COL {
	mso-width-source: auto
}
BR {
	mso-data-placement: same-cell
}
.style16 {
	mso-number-format: "_(* #,##0.00_);_(* \(#,##0.00\);_(* "-"??_);_(@_)"; mso-style-name: Comma; mso-style-id: 3
}
.style0 {
	BORDER-RIGHT: medium none; BORDER-TOP: medium none; FONT-WEIGHT: 400; FONT-SIZE: 10pt; VERTICAL-ALIGN: bottom; BORDER-LEFT: medium none; COLOR: windowtext; BORDER-BOTTOM: medium none; FONT-STYLE: normal; FONT-FAMILY: Arial; WHITE-SPACE: nowrap; TEXT-DECORATION: none; mso-number-format: General; mso-style-name: Normal; mso-style-id: 0; mso-rotate: 0; mso-background-source: auto; mso-pattern: auto; mso-generic-font-family: auto; mso-font-charset: 0; mso-protection: locked visible
}
TD {
	BORDER-RIGHT: medium none; PADDING-RIGHT: 1px; BORDER-TOP: medium none; PADDING-LEFT: 1px; FONT-WEIGHT: 400; FONT-SIZE: 10pt; VERTICAL-ALIGN: bottom; BORDER-LEFT: medium none; COLOR: windowtext; PADDING-TOP: 1px; BORDER-BOTTOM: medium none; FONT-STYLE: normal; FONT-FAMILY: Arial; WHITE-SPACE: nowrap; TEXT-DECORATION: none; mso-ignore: padding; mso-number-format: General; mso-rotate: 0; mso-background-source: auto; mso-pattern: auto; mso-generic-font-family: auto; mso-font-charset: 0; mso-protection: locked visible; mso-style-parent: style0
}
.xl24 {
	FONT-WEIGHT: 700; FONT-SIZE: 16pt; FONT-FAMILY: Arial, sans-serif; mso-font-charset: 0; mso-style-parent: style0
}
.xl25 {
	BORDER-RIGHT: medium none; BORDER-TOP: medium none; BORDER-LEFT: medium none; BORDER-BOTTOM: windowtext 0.5pt dotted; mso-style-parent: style0
}
.xl26 {
	BORDER-RIGHT: medium none; BORDER-TOP: windowtext 0.5pt dotted; BORDER-LEFT: medium none; BORDER-BOTTOM: windowtext 0.5pt dotted; mso-style-parent: style0
}
.xl27 {
	FONT-SIZE: 12pt; mso-style-parent: style0
}
.xl28 {
	BORDER-RIGHT: medium none; BORDER-TOP: medium none; FONT-SIZE: 12pt; BORDER-LEFT: medium none; BORDER-BOTTOM: windowtext 0.5pt dotted; mso-style-parent: style0
}
.xl29 {
	BORDER-RIGHT: medium none; BORDER-TOP: windowtext 0.5pt dotted; FONT-SIZE: 12pt; BORDER-LEFT: medium none; BORDER-BOTTOM: windowtext 0.5pt dotted; mso-style-parent: style0
}
.xl30 {
	BORDER-RIGHT: medium none; BORDER-TOP: windowtext 0.5pt dotted; FONT-SIZE: 12pt; BORDER-LEFT: medium none; BORDER-BOTTOM: medium none; mso-style-parent: style0
}
.xl31 {
	FONT-SIZE: 12pt; TEXT-ALIGN: right; mso-style-parent: style0
}
.xl32 {
	BORDER-RIGHT: medium none; BORDER-TOP: windowtext 0.5pt dotted; FONT-SIZE: 12pt; BORDER-LEFT: medium none; BORDER-BOTTOM: windowtext 0.5pt dotted; mso-number-format: "Short Date"; mso-style-parent: style0
}
.xl33 {
	BORDER-RIGHT: medium none; BORDER-TOP: windowtext 0.5pt dotted; FONT-SIZE: 12pt; BORDER-LEFT: medium none; BORDER-BOTTOM: windowtext 0.5pt dotted; WHITE-SPACE: nowrap; TEXT-ALIGN: center; mso-style-parent: style0; mso-text-control: shrinktofit
}
.xl34 {
	BORDER-RIGHT: medium none; BORDER-TOP: windowtext 0.5pt dotted; FONT-SIZE: 12pt; BORDER-LEFT: medium none; BORDER-BOTTOM: windowtext 0.5pt dotted; WHITE-SPACE: nowrap; TEXT-ALIGN: left; mso-style-parent: style0; mso-text-control: shrinktofit
}
.xl35 {
	BORDER-RIGHT: medium none; BORDER-TOP: medium none; FONT-SIZE: 12pt; BORDER-LEFT: medium none; BORDER-BOTTOM: windowtext 0.5pt dotted; TEXT-ALIGN: left; mso-style-parent: style0
}
.xl36 {
	BORDER-RIGHT: medium none; BORDER-TOP: windowtext 0.5pt dotted; FONT-WEIGHT: 700; FONT-SIZE: 12pt; BORDER-LEFT: medium none; BORDER-BOTTOM: windowtext 0.5pt dotted; FONT-FAMILY: Arial, sans-serif; mso-number-format: "\#\,\#\#0"; mso-font-charset: 0; mso-style-parent: style16
}
</STYLE>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>11</x:PaperSizeIndex>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Zoom>85</x:Zoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>3</x:ActiveRow>
       <x:ActiveCol>11</x:ActiveCol>
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
  <x:WindowHeight>8445</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>45</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]--></HEAD>
<BODY vLink=purple link=blue>
<TABLE style="TABLE-LAYOUT: fixed; WIDTH: 571pt; BORDER-COLLAPSE: collapse" 
cellSpacing=0 cellPadding=0 width=759 border=0 x:str>
  <COLGROUP>
  <COL style="WIDTH: 59pt; mso-width-source: userset; mso-width-alt: 2852" 
  width=78>
  <COL style="WIDTH: 10pt; mso-width-source: userset; mso-width-alt: 475" 
  width=13>
  <COL style="WIDTH: 23pt; mso-width-source: userset; mso-width-alt: 1133" 
  width=31>
  <COL style="WIDTH: 28pt; mso-width-source: userset; mso-width-alt: 1353" 
  width=37>
  <COL style="WIDTH: 36pt; mso-width-source: userset; mso-width-alt: 1755" 
  width=48>
  <COL style="WIDTH: 20pt; mso-width-source: userset; mso-width-alt: 987" 
  width=27>
  <COL style="WIDTH: 96pt; mso-width-source: userset; mso-width-alt: 4681" 
  width=128>
  <COL style="WIDTH: 21pt; mso-width-source: userset; mso-width-alt: 1024" 
  width=28>
  <COL style="WIDTH: 41pt; mso-width-source: userset; mso-width-alt: 1974" 
  width=54>
  <COL style="WIDTH: 22pt; mso-width-source: userset; mso-width-alt: 1060" 
  width=29>
  <COL style="WIDTH: 31pt; mso-width-source: userset; mso-width-alt: 1499" 
  width=41>
  <COL style="WIDTH: 35pt; mso-width-source: userset; mso-width-alt: 1682" 
  width=46>
  <COL style="WIDTH: 48pt" span=2 width=64>
  <COL style="WIDTH: 53pt; mso-width-source: userset; mso-width-alt: 2596" 
  width=71>
  <TBODY>
  <TR style="HEIGHT: 15pt" height=20>
    <TD class=xl27 style="WIDTH: 59pt; HEIGHT: 15pt" width=78 height=20>&#272;&#416;N 
    V&#7882;</TD>
    <TD class=xl27 style="WIDTH: 10pt" width=13>:</TD>
    <TD class=xl27 style="WIDTH: 203pt; mso-ignore: colspan" width=271 
      colSpan=5><%=dt.Rows[0][10].ToString() %></TD>
    <TD style="WIDTH: 21pt" width=28></TD>
    <TD style="WIDTH: 41pt" width=54></TD>
    <TD style="WIDTH: 22pt" width=29></TD>
    <TD style="WIDTH: 31pt" width=41></TD>
    <TD style="WIDTH: 35pt" width=46></TD>
    <TD style="WIDTH: 48pt" width=64></TD>
    <TD style="WIDTH: 48pt" width=64></TD>
    <TD style="WIDTH: 53pt" width=71></TD></TR>
  <TR style="HEIGHT: 15pt" height=20>
    <TD class=xl27 style="HEIGHT: 15pt" height=20>B&#7896; PH&#7852;N</TD>
    <TD class=xl27>:</TD>
    <TD class=xl27 style="mso-ignore: colspan" colSpan=5> <%=dt.Rows[0][11].ToString() %></TD>
    <TD style="mso-ignore: colspan" colSpan=8></TD></TR>
  <TR style="HEIGHT: 12.75pt" height=17>
    <TD style="HEIGHT: 12.75pt; mso-ignore: colspan" colSpan=15 
  height=17></TD></TR>
  <TR style="HEIGHT: 20.25pt" height=27>
    <TD style="HEIGHT: 20.25pt; mso-ignore: colspan" colSpan=5 height=27></TD>
    <TD class=xl24 style="mso-ignore: colspan" colSpan=5>GI&#7844;Y &#272;&#7872;<SPAN 
      style="mso-spacerun: yes">&nbsp; </SPAN>NGH&#7882; T&#7840;M &#7912;NG</TD>
    <TD style="mso-ignore: colspan" colSpan=5></TD></TR>
  <TR style="HEIGHT: 15pt" height=20>
    <TD style="HEIGHT: 15pt; mso-ignore: colspan" colSpan=6 height=20></TD>
    <TD class=xl31>Ngày</TD>
    <TD class=xl27 x:str><%= dt.Rows[0][0].ToString() %></TD>
    <TD class=xl27>Tháng</TD>
    <TD class=xl27 x:str><%= dt.Rows[0][1].ToString() %></TD>
    <TD class=xl27>N&#259;m</TD>
    <TD class=xl27 align=right x:str><%= dt.Rows[0][2].ToString() %></TD>
    <TD style="mso-ignore: colspan" colSpan=3></TD></TR>
  <TR style="HEIGHT: 12.75pt" height=17>
    <TD style="HEIGHT: 12.75pt; mso-ignore: colspan" colSpan=15 
  height=17></TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt" height=22>Kính g&#7917;i :</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28 style="mso-ignore: colspan" colSpan=5><%= dt.Rows[0][3].ToString() %></TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl25>&nbsp;</TD>
    <TD></TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt" height=22 x:str="Tôi tên là : ">Tôi 
      tên là :<SPAN style="mso-spacerun: yes">&nbsp;</SPAN></TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28 style="mso-ignore: colspan" colSpan=4><%= dt.Rows[0][4].ToString() %></TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl28>&nbsp;</TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl26 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl26>&nbsp;</TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt" height=22 x:str="&#272;&#7883;a ch&#7881; : ">&#272;&#7883;a ch&#7881; 
      :<SPAN style="mso-spacerun: yes">&nbsp;</SPAN></TD>
    <TD class=xl34 colSpan=14><%= dt.Rows[0][5].ToString() %></TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt; mso-ignore: colspan" colSpan=4 
    height=22 x:str="&#272;&#7873; ngh&#7883; cho t&#7841;m &#7913;ng s&#7889; ti&#7873;n: ">&#272;&#7873; ngh&#7883; cho t&#7841;m &#7913;ng s<SPAN 
      style="DISPLAY: none">&#7889; ti&#7873;n:<SPAN 
      style="mso-spacerun: yes">&nbsp;</SPAN></SPAN></TD>
    <TD class=xl30 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl30 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl36 colSpan=3 x:num><%= dt.Rows[0][6].ToString() %>
      </TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl26 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl26 style="BORDER-TOP: medium none">&nbsp;</TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt; mso-ignore: colspan" colSpan=3 
    height=22 x:str="Vi&#7871;t b&#7857;ng ch&#7919;: ">Vi&#7871;t b&#7857;ng ch&#7919;:<SPAN 
      style="mso-spacerun: yes">&nbsp;</SPAN></TD>
    <TD class=xl35 colSpan=12>
       <%
        l_num=CommondLib.Num2VNText(dt.Rows[0][6].ToString(),dt.Rows[0][9].ToString());
       %>
       <%=l_num%></TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt; mso-ignore: colspan" colSpan=3 
    height=22 x:str="Lý do t&#7841;m &#7913;ng: ">Lý do t&#7841;m &#7913;ng:<SPAN 
      style="mso-spacerun: yes">&nbsp;</SPAN></TD>
    <TD class=xl33 colSpan=12>&nbsp;<%=dt.Rows[0][7].ToString() %></TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt; mso-ignore: colspan" colSpan=4 
    height=22>Th&#7901;i h&#7841;n thanh toán:</TD>
    <TD class=xl32 style="mso-ignore: colspan" colSpan=3 
      x:str><%=dt.Rows[0][8].ToString() %></TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl29 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl26 style="BORDER-TOP: medium none">&nbsp;</TD>
    <TD class=xl26 style="BORDER-TOP: medium none">&nbsp;</TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt; mso-ignore: colspan" colSpan=13 
    height=22></TD>
    <TD style="mso-ignore: colspan" colSpan=2></TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt; mso-ignore: colspan" colSpan=13 
    height=22></TD>
    <TD style="mso-ignore: colspan" colSpan=2></TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt; mso-ignore: colspan" colSpan=13 
    height=22></TD>
    <TD style="mso-ignore: colspan" colSpan=2></TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt; mso-ignore: colspan" colSpan=13 
    height=22></TD>
    <TD style="mso-ignore: colspan" colSpan=2></TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt; mso-ignore: colspan" colSpan=13 
    height=22></TD>
    <TD style="mso-ignore: colspan" colSpan=2></TD></TR>
  <TR style="HEIGHT: 17.1pt; mso-height-source: userset" height=22>
    <TD class=xl27 style="HEIGHT: 17.1pt; mso-ignore: colspan" colSpan=4 
    height=22>Th&#7911; tr&#432;&#7903;ng &#273;&#417;n v&#7883;</TD>
    <TD class=xl27 style="mso-ignore: colspan" colSpan=3>K&#7871; toán tr&#432;&#7903;ng</TD>
    <TD class=xl27></TD>
    <TD class=xl27 style="mso-ignore: colspan" colSpan=4>Ph&#7909; trách b&#7897; ph&#7853;n</TD>
    <TD class=xl27 style="mso-ignore: colspan" colSpan=3>Ng&#432;&#7901;i &#273;&#7873; ngh&#7883; t&#7841;m 
    &#7913;ng</TD></TR>
  <TR style="HEIGHT: 191.25pt; mso-xlrowspan: 15" height=255>
    <TD style="HEIGHT: 191.25pt; mso-ignore: colspan" colSpan=15 
  height=255></TD></TR>
  <TR style="HEIGHT: 11.25pt; mso-height-source: userset" height=15>
    <TD class=xl27 style="HEIGHT: 11.25pt; mso-ignore: colspan" colSpan=7 
    height=15></TD>
    <TD style="mso-ignore: colspan" colSpan=8></TD></TR><![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=78 style='width:59pt'></td>
  <td width=13 style='width:10pt'></td>
  <td width=31 style='width:23pt'></td>
  <td width=37 style='width:28pt'></td>
  <td width=48 style='width:36pt'></td>
  <td width=27 style='width:20pt'></td>
  <td width=128 style='width:96pt'></td>
  <td width=28 style='width:21pt'></td>
  <td width=54 style='width:41pt'></td>
  <td width=29 style='width:22pt'></td>
  <td width=41 style='width:31pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=71 style='width:53pt'></td>
 </tr>
 <![endif]></TBODY></TABLE></BODY></HTML>
