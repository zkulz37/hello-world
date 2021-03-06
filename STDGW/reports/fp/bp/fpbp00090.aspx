<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("sale");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
  	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string so_pk = "";
    so_pk = Request["SO_PK"];
    string SQL
	= "select   " + 
        "b.ITEM_NAME,b.UOM,SALE.sf_get_dsbs00010_1 ('SIZE', a.MAT_ITEM_PK) tsize " +
        ",SALE.sf_get_dsbs00010_1 ('COLOR', a.MAT_ITEM_PK) color " +
        ",sum(a.PRODUCT_QTY), a.BOM_QTY, sum (a.AFTER_ADJUST_QTY), to_char(sysdate,'dd/mm/yyyy') " +
        "from TPR_MATCONS a , tco_stitem b,TCO_ITEM d " +
        "where  " +
        "a.DEL_IF =0 and  a.MASTER_PK = '" + so_pk + "' " +
        "and b.DEL_IF =0 and d.DEL_IF =0  " +
        "and a.MAT_ITEM_PK = d.PK " +
        "and b.pk = d.TCO_STITEM_PK " +
        "group by b.ITEM_NAME,b.UOM,SALE.sf_get_dsbs00010_1 ('COLOR', a.MAT_ITEM_PK)  " +
        ",SALE.sf_get_dsbs00010_1 ('SIZE', a.MAT_ITEM_PK), a.BOM_QTY " +
        "  " ;
  DataTable dt = ESysLib.TableReadOpen(SQL);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=unicode">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fpbp00090_files/filelist.xml">
<link rel=Edit-Time-Data href="fpbp00090_files/editdata.mso">
<link rel=OLE-Object-Data href="fpbp00090_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Window XP Service Pack 2</o:Author>
  <o:LastAuthor>tuyen</o:LastAuthor>
  <o:LastPrinted>2008-11-12T01:44:40Z</o:LastPrinted>
  <o:Created>2008-11-11T06:30:33Z</o:Created>
  <o:LastSaved>2008-11-12T01:48:46Z</o:LastSaved>
  <o:Company>Microsoft</o:Company>
  <o:Version>11.6360</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .5in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	color:navy;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl28
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:right;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl30
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl31
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	color:navy;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;}
.xl33
	{mso-style-parent:style0;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;}
.xl34
	{mso-style-parent:style0;
	color:navy;
	font-size:12.0pt;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl36
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl37
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl38
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:Fixed;
	border:.5pt solid windowtext;}
.xl39
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	mso-number-format:"0\.00000";
	border:.5pt solid windowtext;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Sheet1</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:Scale>80</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>7</x:ActiveCol>
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
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=900 style='border-collapse:
 collapse;table-layout:fixed;width:680pt'>
 <col class=xl24 width=90 span=10 style='mso-width-source:userset;mso-width-alt:
 3291;width:68pt'>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=3 height=32 class=xl26 width=270 style='height:24.0pt;width:204pt'>HOCHANG
  VINA CO.LTD</td>
  <td colspan=6 class=xl27 width=540 style='width:408pt'>CONSUMPTION OF
  MATERIAL SHEET</td>
  <td class=xl34 width=90 style='width:68pt'></td>
 </tr>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td height=32 colspan=3 class=xl24 style='height:24.0pt;mso-ignore:colspan'></td>
  <td colspan=6 class=xl27>B&#7842;NG T&#205;NH &#272;&#7882;NH M&#7912;C V&#7852;T T&#431;</td>
  <td class=xl34></td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
 <%
    if (dt.Rows.Count > 0)
   {
  %>
  <td height=20 class=xl28 style='height:15.0pt' x:str="Date : ">Date :<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=2 class=xl33><%=dt.Rows[0][7]%></td>
  <td colspan=7 class=xl27 style='mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td colspan=4 height=20 class=xl29 style='height:15.0pt'>ITEM</td>
  <td class=xl29 style='border-left:none'>UNIT</td>
  <td class=xl29 style='border-left:none'>SIZE</td>
  <td class=xl29 style='border-left:none'>COLOR</td>
  <td class=xl29 style='border-left:none'>ORD QTY</td>
  <td class=xl29 style='border-left:none'>CONS QTY</td>
  <td class=xl29 style='border-left:none'>TOTAL</td>
 </tr>
 <% 
      int count =1;
      string stValue ="";
      for (int i =0 ; i< dt.Rows.Count; i++)
      {
      
       
     %>
        
        
          <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
          <% 
              if (!stValue.Equals(dt.Rows[i][0].ToString()))
             {  
                count =1;
                stValue = dt.Rows[i][0].ToString();
                for(int j =i+1 ; j< dt.Rows.Count ; j ++ )
                    {
                        
                         if (dt.Rows[i][0].Equals(dt.Rows[j][0]))
                         {
                            count ++;
                         }else
                         {
                            break;
                         }
                          
                    }
              %>
                   <td colspan=4 rowspan=<%=count %> height=20 class=xl31 style='height:15.0pt'><%=dt.Rows[i][0].ToString()%></td>
              <%
             }
                 
                    
          %>
          <td class=xl31 style='border-top:none;border-left:none;' align="center"><%=dt.Rows[i][1].ToString()%></td>
          <td class=xl30 style='border-top:none;border-left:none' align="center"><%=dt.Rows[i][2].ToString()%></td>
          <td class=xl31 style='border-top:none;border-left:none' align="center"><%=dt.Rows[i][3].ToString()%></td>
          <td class=xl38 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][4].ToString()%></td>
          <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][5].ToString()%></td>
          <td class=xl39 style='border-top:none;border-left:none' x:num><%=dt.Rows[i][6].ToString()%></td>
         </tr>
     <%
      }
   }
 %>
 <tr class=xl26 height=27 style='mso-height-source:userset;height:20.25pt'>
  <td colspan=3 height=27 class=xl32 style='height:20.25pt'>Charger</td>
  <td colspan=3 class=xl32>Production Charger</td>
  <td colspan=4 class=xl32>Manager</td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=10 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=10 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=10 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=10 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=10 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=10 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl25 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=10 class=xl25 style='height:15.0pt;mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=90 style='width:68pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
