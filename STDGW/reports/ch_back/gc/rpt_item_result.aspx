﻿<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("hr");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_tco_dept_pk,p_thr_group_pk,p_month,p_tco_item_pk,p_itemcode,p_itemname;
    
    p_tco_dept_pk = Request["p_tco_dept_pk"].ToString();
    p_thr_group_pk = Request["p_thr_group_pk"].ToString();
    p_month = Request["p_month"].ToString();
    p_tco_item_pk = Request["p_tco_item_pk"].ToString();
    p_itemcode = Request["p_itemcode"].ToString();
    p_itemname = Request["p_itemname"].ToString();
    
    
    string SQL
	= "select b.pk,b.group_nm,a.SO_NO,a.LABOUR_PRICE,a.PROD_QTY,a.AMOUNT " + 
        "    from prod.VPROD_MONTHLY_RESULT a,thr_group b,tco_dept c " +
        "    where b.del_if=0 and c.del_if=0  " +
        "    and a.THR_GROUP_PK=b.pk " +
        "    and b.TCO_DEPT_PK=c.pk " +
        "    AND (   b.tco_dept_pk IN ( " +
        "                              SELECT     g.pk " +
        "                                    FROM comm.tco_dept g " +
        "                                   WHERE g.del_if = 0 " +
        "                                     AND NVL (g.child_yn, 'Y') = 'N' " +
        "                              START WITH g.pk = " +
        "                                            DECODE ('" + p_tco_dept_pk + "', " +
        "                                                    'ALL', 0, " +
        "                                                    '" + p_tco_dept_pk + "'" +
        "                                                   ) " +
        "                              CONNECT BY PRIOR g.pk = g.p_pk) " +
        "                        OR '" + p_tco_dept_pk + "' = 'ALL') " +
        "   and decode('" + p_thr_group_pk + "','ALL','ALL',a.thr_group_pk )='" + p_thr_group_pk + "'" +
        "   and ('" + p_tco_item_pk + "' is null or a.TCO_ITEM_PK='" + p_tco_item_pk + "') " +
        "   and a.ITEM_CODE like '%" + p_itemcode + "%' " +
        "   and a.ITEM_NAME like '%" + p_itemname + "%' " +
        "   and prod_month='" + p_month + "'" ;

    
    DataTable dt_Emp = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_Emp.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data");
        Response.End();
    }    
    
    
   
 %>


<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="rpt_item_result_files/filelist.xml">
<link rel=Edit-Time-Data href="rpt_item_result_files/editdata.mso">
<link rel=OLE-Object-Data href="rpt_item_result_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>ty-ml</o:Author>
  <o:LastAuthor>ty-ml</o:LastAuthor>
  <o:LastPrinted>2008-12-17T03:35:57Z</o:LastPrinted>
  <o:Created>2008-12-17T03:27:13Z</o:Created>
  <o:LastSaved>2008-12-17T03:53:14Z</o:LastSaved>
  <o:Company>hr</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.38in .23in .35in .24in;
	mso-header-margin:.27in;
	mso-footer-margin:.17in;}
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
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl25
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	font-style:italic;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	font-style:italic;
	mso-pattern:auto none;}
.xl28
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;}
.xl29
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl30
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl34
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl35
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	color:#3366FF;
	font-size:16.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl37
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl38
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-style:italic;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl40
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt hairline windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl42
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl43
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>86</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
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
  <x:WindowHeight>7935</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>75</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$3:$4</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl35>

<table x:str border=0 cellpadding=0 cellspacing=0 width=879 style='border-collapse:
 collapse;table-layout:fixed;width:660pt'>
 <col class=xl35 width=59 style='mso-width-source:userset;mso-width-alt:2157;
 width:44pt'>
 <col class=xl35 width=166 style='mso-width-source:userset;mso-width-alt:6070;
 width:125pt'>
 <col class=xl35 width=261 style='mso-width-source:userset;mso-width-alt:9545;
 width:196pt'>
 <col class=xl35 width=108 style='mso-width-source:userset;mso-width-alt:3949;
 width:81pt'>
 <col class=xl35 width=85 style='mso-width-source:userset;mso-width-alt:3108;
 width:64pt'>
 <col class=xl35 width=136 style='mso-width-source:userset;mso-width-alt:4973;
 width:102pt'>
 <col class=xl35 width=64 style='width:48pt'>
 <tr height=27 style='height:20.25pt'>
  <td colspan=6 height=27 class=xl36 width=815 style='height:20.25pt;
  width:612pt'>ITEMS RESULT - <%=p_month.ToString().Substring(4,2) + "/" + p_month.ToString().Substring(0,4) %></td>
  <td class=xl35 width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='height:12.75pt'>
  <td height=17 colspan=7 class=xl35 style='height:12.75pt;mso-ignore:colspan'></td>
 </tr>
 <tr class=xl26 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl24 style='height:19.5pt'>No</td>
  <td class=xl25>Group</td>
  <td class=xl25>Working Description</td>
  <td class=xl25>Unit Price</td>
  <td class=xl25>Quantity</td>
  <td class=xl25>Amount</td>
  <td class=xl26></td>
 </tr>
 <tr class=xl26 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl27 style='height:19.5pt'>STT</td>
  <td class=xl28>Nhóm</td>
  <td class=xl28>Tác nghiệp</td>
  <td class=xl28>Đơn giá</td>
  <td class=xl28>Số lượng</td>
  <td class=xl28>Thành tiền</td>
  <td class=xl26></td>
 </tr>
 <% 
    double dUnit_Price,dQuantity,dAmount,bCount; 
    Boolean bGroup;
    dUnit_Price=0;
    dQuantity=0;
    dAmount=0; 
    bGroup=false;
    bCount=0;
    for (int i = 0; i < irow; i++) 
    {
        dUnit_Price+=Double.Parse(dt_Emp.Rows[i][3].ToString());
        dQuantity+=Double.Parse(dt_Emp.Rows[i][4].ToString());
        dAmount+=Double.Parse(dt_Emp.Rows[i][5].ToString());
        bCount+=1;
    %> 
 <tr class=xl30 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td height=26 class=xl29 style='height:19.5pt;border-top:none' x:num><%=bCount %></td>
  <td class=xl40 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][1].ToString() %></td>
  <td class=xl31 style='border-top:none;border-left:none'><%= dt_Emp.Rows[i][2].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_Emp.Rows[i][3].ToString() %> </td>
  <td class=xl29 style='border-top:none;border-left:none' x:num><%= dt_Emp.Rows[i][4].ToString() %></td>
  <td class=xl42 style='border-top:none;border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%= dt_Emp.Rows[i][5].ToString() %> </td>
  <td class=xl30></td>
 </tr>
 <% 
        if (i<irow-1)
        {   
            if (dt_Emp.Rows[i][0].ToString()!=dt_Emp.Rows[i+1][0].ToString())
                bGroup=true;
        }
        else
                bGroup=true;
        if (bGroup==true)
        {
 %>
 
 <tr class=xl30 height=26 style='mso-height-source:userset;height:19.5pt'>
  <td colspan=3 height=26 class=xl37 style='border-right:.5pt solid black;
  height:19.5pt'>Total - <% =dt_Emp.Rows[i][1].ToString()%></td>
  <td class=xl43 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dUnit_Price %> </td>
  <td class=xl32 style='border-left:none' x:num><%=dQuantity %> </td>
  <td class=xl43 style='border-left:none' x:num><span
  style='mso-spacerun:yes'> </span><%=dAmount%></td>
  <td class=xl34></td>
 </tr>
 <% 
            bCount=0;
            bGroup=false;
            dUnit_Price=0;
            dQuantity=0;
            dAmount=0; 
            bGroup=false;
        }
    }
 %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=59 style='width:44pt'></td>
  <td width=166 style='width:125pt'></td>
  <td width=261 style='width:196pt'></td>
  <td width=108 style='width:81pt'></td>
  <td width=85 style='width:64pt'></td>
  <td width=136 style='width:102pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
