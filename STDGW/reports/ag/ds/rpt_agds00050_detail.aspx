<%@ Page Language="C#"%>
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
    
     string strGName,strGroup;    
    strGName=Request.QueryString["codegrp_nm"];
    strGroup=Request.QueryString["code_grp"];

   string SQL
	= "select PK,  " + 
        "        ROWNUM,  " +
        "        group_ID,  " +
        "        group_NaMe,  " +
        "        (CASE WHEN USE_IF='Y' THEN 'Y' ELSE 'N' END),  " +
        "        REMARK,  " +
        "        Rem_num1,  " +
        "        Rem_num2,  " +
        "        Rem_num3,         " +
        "        Rem_cha1,  " +
        "        Rem_cha2,  " +
        "        Rem_cha3,        " +
        "        (CASE WHEN NVL(SYS_YN,'N')='Y' THEN 'Y' ELSE 'N' END)  " +
        "    FROM sale.LG_CODE_GROUP a " +
        "    WHERE DEL_IF=0 AND A.PARENT_PK <>1 " +
        "    and (upper(group_NaMe) like '%' || '" + strGName + "' ||'%'  or " +
        "       upper(group_ID) like  '%' ||'" +  strGName + "'||'%') " +
        "    and  a.pk in  " +
        "    ( " +
        "        select pk from sale.lg_code_group B " +
        "        WHERE B.DEL_IF =0  " +
        "        CONNECT BY PRIOR  B.PK = B.PARENT_PK " +
        "        START WITH B.PK = '" + strGroup + "'       " +
        "    )  " ;
        
   // Response.Write(SQL);
    //Response.End();
    
    DataTable dt_master = ESysLib.TableReadOpen(SQL);
    if (dt_master.Rows.Count == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    int cnt_master = dt_master.Rows.Count;        
 %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Book3_files/filelist.xml">
<link rel=Edit-Time-Data href="Book3_files/editdata.mso">
<link rel=OLE-Object-Data href="Book3_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Hee</o:Author>
  <o:LastAuthor>Hee</o:LastAuthor>
  <o:Created>2008-10-17T04:19:51Z</o:Created>
  <o:LastSaved>2008-10-17T06:23:37Z</o:LastSaved>
  <o:Company>Hee Nguyen</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .75in 1.0in .75in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
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
	white-space:wrap;
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
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-size:22.0pt;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl29
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl31
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;}
.xl32
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	white-space:normal;}
.xl35
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#FFCC99;
	mso-pattern:auto none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Tahoma, sans-serif;
	mso-font-charset:0;
	text-align:left;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}	
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
      <x:Scale>54</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>3</x:SplitHorizontal>
     <x:TopRowBottomPane>3</x:TopRowBottomPane>
     <x:SplitVertical>5</x:SplitVertical>
     <x:LeftColumnRightPane>5</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
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
  <x:WindowHeight>8700</x:WindowHeight>
  <x:WindowWidth>11355</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>120</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$3</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1606 style='border-collapse:
 collapse;table-layout:fixed;width:1209pt'>
 <col class=xl24 width=30 style='mso-width-source:userset;mso-width-alt:1097;
 width:23pt'>
 <col class=xl24 width=90 style='mso-width-source:userset;mso-width-alt:3291;
 width:45pt'>
 <col class=xl24 width=100 style='mso-width-source:userset;mso-width-alt:3657;
 width:70pt'>
 <col class=xl24 width=50 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col class=xl24 width=168 style='mso-width-source:userset;mso-width-alt:6144;
 width:126pt'>
 <col class=xl24 width=98 style='mso-width-source:userset;mso-width-alt:3584;
 width:74pt'>
 <col class=xl24 width=89 span=11 style='mso-width-source:userset;mso-width-alt:
 3254;width:67pt'>
 <col class=xl24 width=64 span=2 style='width:48pt'>
 <tr height=36 style='height:27.0pt'>
  <td height=36 class=xl24 width=30 style='height:27.0pt;width:23pt'></td>
  <td class=xl24 width=60 style='width:45pt'></td>
  <td class=xl24 width=93 style='width:70pt'></td>
  <td class=xl24 width=50 style='width:38pt'></td>
  <td class=xl24 width=168 style='width:126pt'></td>
  <td class=xl25 colspan=4 width=365 style='mso-ignore:colspan;width:275pt'>LOGISTIC
  DETAIL CODE REPORT</td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=89 style='width:67pt'></td>
  <td class=xl24 width=64 style='width:48pt'></td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 colspan=5 class=xl24 style='height:12.75pt;mso-ignore:colspan'></td>
  <td class=xl25></td>
  <td colspan=13 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <tr height=39 style='mso-height-source:userset;height:29.25pt'>
  <td height=39 class=xl26 width=30 style='height:29.25pt;width:23pt'>No.</td>
  <td class=xl27 width=60 style='width:45pt'>Master ID</td>
  <td class=xl27 width=93 style='width:70pt'>Master Name</td>
  <td colspan=4 class=xl36 width=405 style='border-right:.5pt solid black;
  border-left:none;width:305pt'>LG Code Detail</td>
  <td class=xl27 width=89 style='width:67pt'>Num1 Name</td>
  <td class=xl27 width=89 style='width:67pt'>Num2 Name</td>
  <td class=xl27 width=89 style='width:67pt'>Num3 Name</td>
  <td class=xl27 width=89 style='width:67pt'>Char1 Name</td>
  <td class=xl27 width=89 style='width:67pt'>Char2 Name</td>
  <td class=xl27 width=89 style='width:67pt'>Char3 Name</td>
  <td class=xl27 width=64 style='width:48pt'>Use Y/N</td>
  <td class=xl27 width=64 style='width:48pt'>Remark</td>
 </tr>
 <%
    for(int i=0;i<cnt_master;i++)
    {
     string  SQL_detail;
	 SQL_detail = "select b.group_ID,b.group_NaMe,             " + 
        "            a.CODE,  " +
        "            a.CODE_NM,  " +
        "            a.CODE_LNM,  " +
        "            a.CODE_FNM,  " +
        "            a.NUM_VALUE1,  " +
        "            a.NUM_VALUE2,  " +
        "            a.NUM_VALUE3,          " +
        "            a.CHA_VALUE1,  " +
        "            a.CHA_VALUE2,  " +
        "            a.CHA_VALUE3,              " +
        "            (CASE WHEN NVL(b.SYS_YN,'N')='Y' THEN 'Y' ELSE 'N' END) , " +
        "            b.REMARK  " +
        "    FROM   sale.lg_code a, sale.LG_CODE_GROUP b " +
        "    WHERE b.DEL_IF=0 AND b.pk = a.LG_CODE_GROUP_PK " +
        "        and a.DEL_IF = 0  " +
        "        and ( upper(b.GROUP_ID) like  '%' || '" + strGName +"' || '%'  " +
        "               or upper(b.GROUP_NAME) like '%' ||'"+ strGName +"'|| '%' ) " +
        "         and  b.pk in  " +
        "            ( " +
        "                select pk from sale.lg_code_group B " +
        "                WHERE B.DEL_IF =0  " +
        "                CONNECT BY PRIOR  B.PK = B.PARENT_PK " +
        "                START WITH B.PK =  " + int.Parse(dt_master.Rows[i][0].ToString()) +"  " +
        "            )  " +
        "    order by a.ORD  " ;

        //Response.Write(SQL_detail);
        //Response.End();
    
        DataTable dt_detail = ESysLib.TableReadOpen(SQL_detail);
        int cnt_detail = dt_detail.Rows.Count;
  %>
 <tr height=22 style='userset;height:16.5pt'>
  <td rowspan=<%=cnt_detail+1 %> height=39 class=xl31 style='border-bottom:.5pt solid black;
  height:29.25pt;border-top:none' x:num><b><%=i+1 %></b></td>
  <td rowspan=<%=cnt_detail+1 %> class=xl33 width=60 style='border-bottom:.5pt solid black;
  border-top:none;width:45pt'><b><%=dt_master.Rows[i][2].ToString() %></b></td>
  <td rowspan=<%=cnt_detail+1 %> class=xl33 width=93 style='border-bottom:.5pt solid black;
  border-top:none;width:70pt'><b><%=dt_master.Rows[i][3].ToString() %></b></td>
  <td class=xl35 width=50 style='border-top:none;width:38pt'>Code</td>
  <td class=xl35 width=168 style='border-top:none;width:126pt'>Name</td>
  <td class=xl35 width=98 style='border-top:none;width:74pt'>Kname</td>
  <td class=xl35 width=89 style='border-top:none;width:67pt'>Fname</td>
  <% //num 1
      if (dt_master.Rows[i][6].ToString()=="")
      {
   %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'>-</td>
  <%
      }
      else
      {
  %>
  <td class=xl35 width=89 style='border-top:none;width:67pt' ><%=dt_master.Rows[i][6].ToString()%></td>
  <%    
      } 
  //num 2
      if (dt_master.Rows[i][7].ToString()=="")
      {
   %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'>-</td>
  <%
      }
      else
      {
  %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'><%=dt_master.Rows[i][7].ToString()%></td>
  <%    
      } 
  //num 3
      if (dt_master.Rows[i][8].ToString()=="")
      {
   %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'>-</td>
  <%
      }
      else
      {
  %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'><%=dt_master.Rows[i][8].ToString()%></td>
  <%    
      } 
  //num 4
      if (dt_master.Rows[i][9].ToString()=="")
      {
   %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'>-</td>
  <%
      }
      else
      {
  %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'><%=dt_master.Rows[i][9].ToString()%></td>
  <%    
      } 
      //num 5
      if (dt_master.Rows[i][10].ToString()=="")
      {
   %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'>-</td>
  <%
      }
      else
      {
  %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'><%=dt_master.Rows[i][10].ToString()%></td>
  <%    
      } 
  //cha 1       
      if (dt_master.Rows[i][11].ToString()=="")
      {
   %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'>-</td>
  <%
      }
      else
      {
  %>
  <td class=xl35 width=89 style='border-top:none;width:67pt'><%=dt_master.Rows[i][11].ToString()%></td>
  <%    
      } 
  %>
  
  <td class=xl35 width=64 style='border-top:none;width:48pt'>Use Y/N</td>
  <td class=xl35 width=64 style='border-top:none;width:48pt'>Remark</td>
 </tr>
 <%
     for (int j = 0; j < cnt_detail; j++)
     {
  %>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl28 style='height:12.75pt' x:num><%=dt_detail.Rows[j][2].ToString() %></td>
  <td class=xl29 width=168 style='width:126pt'><%=dt_detail.Rows[j][3].ToString() %></td>
  <td class=xl29 width=98 style='width:74pt'><%=dt_detail.Rows[j][4].ToString() %></td>
  <td class=xl29 width=89 style='width:67pt'><%=dt_detail.Rows[j][5].ToString() %></td>
  <td class=xl29 width=89 style='text-align:center;width:67pt' x:num><%=dt_detail.Rows[j][6].ToString() %></td>
  <td class=xl29 width=89 style='text-align:center;width:67pt' x:num><%=dt_detail.Rows[j][7].ToString() %></td>
  <td class=xl29 width=89 style='text-align:center;width:67pt' x:num><%=dt_detail.Rows[j][8].ToString() %></td>
  <td class=xl29 width=89 style='text-align:center;width:67pt' x:num><%=dt_detail.Rows[j][9].ToString() %></td>
  <td class=xl29 width=89 style='text-align:center;width:67pt' x:num><%=dt_detail.Rows[j][10].ToString() %></td>
  <td class=xl29 width=89 style='text-align:center;width:67pt' x:num><%=dt_detail.Rows[j][11].ToString() %></td>
  <td class=xl28><%=dt_detail.Rows[j][12].ToString() %></td>
  <td class=xl30><%=dt_detail.Rows[j][13].ToString() %></td>
 </tr>
 <%     }//end for detail
    }//end for master
  %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
 
 </tr>
 <![endif]>
</table>

</body>

</html>
