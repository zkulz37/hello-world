<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%@ Import Namespace = "System"%>
<%@ Import Namespace = "System.Text.RegularExpressions"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
    
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
            ESysLib.SetUser("acnt");
            
            string l_status = Request["p_status"];
            string l_tco_company_pk = Request["p_tco_company_pk"];
            string l_date_fr = Request["p_date_fr"];
            string l_date_to = Request["p_date_to"];
            string l_kind = Request["p_kind"];
            string l_date_type = Request["p_date_type"];
            string l_scale = Request["p_scale"];
    
   // + rbstatus.GetData() +'&p_company_pk=' + lstCompany.GetData() + '&p_date_f=' + dtfrdate.GetData() + '&p_date_t=' + dttodate.GetData() + 
   //     '&p_kind=' + txtFinancialType.GetData() + '&p_date_type=' + txtDateType.GetData() + '&p_scale=' + txtScale.GetData()+ '&p_crt_by=' + emp_id;
    
            string l_parameter = "'" + l_kind + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_scale + "'";
            DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfka00210_3", l_parameter);  
            if (dt.Rows.Count == 0)
            {
                Response.Write("There is no data");
                Response.End();
            }
            
            //l_date_to = l_date_to.Substring(4, 2) + "/" + l_date_to.Substring(0, 4);// +"." + l_dtto.Substring(6, 2);//2009.08.25  
            string SQL1 = " select (TO_CHAR(ADD_MONTHS(TO_DATE('" + l_date_fr + "', 'yyyymmdd'), -1) , 'yyyymmdd')) dtfrom,(TO_CHAR(ADD_MONTHS(TO_DATE('" + l_date_fr + "', 'yyyymmdd'), -12) , 'yyyymmdd')) dtTo,(TO_CHAR(TO_DATE('" + l_date_fr + "', 'yyyymmdd') , 'yyyymmdd')) dtTo1 from dual ";
            string l_lastMonth = "", l_lastYear = "", l_firtMonthlastYear = "", l_curMonthlastYear = "";
            DataTable dt1 = ESysLib.TableReadOpen(SQL1);
            if (dt1.Rows.Count > 0)
            {
                l_lastMonth = dt1.Rows[0][0].ToString();
                l_lastYear = dt1.Rows[0][1].ToString();
                l_firtMonthlastYear = dt1.Rows[0][1].ToString();
                l_curMonthlastYear = dt1.Rows[0][2].ToString();
            }

            l_lastMonth = l_lastMonth.Substring(4, 2) + "/" + l_lastMonth.Substring(0, 4);
            l_lastYear = l_lastYear.Substring(4, 2) + "/" + l_lastYear.Substring(0, 4);
            l_firtMonthlastYear = "01" + "/" + l_firtMonthlastYear.Substring(0, 4);
            l_curMonthlastYear = "01" + "/" + l_curMonthlastYear.Substring(0, 4);
            string l_date_day = "", l_date_Years = "", l_date_Month = "";
             //l_date_day = l_date_to.Substring(6, 2);
             //l_date_Years = l_date_to.Substring(0, 4);
             //l_date_Month = l_date_to.Substring(4, 2);
            string l_company = "", l_address = "";
            string SQLAddress = " SELECT  PARTNER_NAME,addr1 FROM TCO_COMPANY WHERE DEL_IF=0 and pk ='" + l_tco_company_pk + "'";
            DataTable dt_f = ESysLib.TableReadOpen(SQLAddress);
            if (dt_f.Rows.Count > 0)
            {
                l_company = dt_f.Rows[0][0].ToString();
                l_address = dt_f.Rows[0][1].ToString();
            }
            string date_day_curr = "";
            string SQLdate = "select TO_CHAR(TO_DATE(' " + l_date_to + " ', 'yyyymmdd') , 'dd.Mon.yyyy') dtcurr  from dual";

            DataTable dtCurrdade = ESysLib.TableReadOpen(SQLdate);
            if (dtCurrdade.Rows.Count > 0)
            {
                date_day_curr = dtCurrdade.Rows[0][0].ToString();
            }
            string l_Unit = "";
            if (l_scale == "1")
            {
                l_Unit = "";
            }
            else
            {
                l_Unit = l_scale + "";
            }
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="gfka00120_bs_fiscalyeartodate123_files/filelist.xml">
<link rel=Edit-Time-Data
href="gfka00120_bs_fiscalyeartodate123_files/editdata.mso">
<link rel=OLE-Object-Data
href="gfka00120_bs_fiscalyeartodate123_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>shvtn04</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-10-19T02:08:37Z</o:LastPrinted>
  <o:Created>2009-08-03T07:27:09Z</o:Created>
  <o:LastSaved>2009-12-23T06:09:31Z</o:LastSaved>
  <o:Company>admin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:1.0in .25in .5in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.5in;}
.font7
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:0;}
.font8
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
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
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:Normal;
	mso-style-id:0;}
.style27
	{mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	mso-style-name:"\C27C\D45C \[0\]_Income_Statement_2009-2nd-\C131\D6C8";}
.style33
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"\D45C\C900_Cost manufacturing Statement_\C11C\D765\BCA0\D2B8\B0A8 \ACC4\C815\ACFC\BAA9\D45C";}
.style34
	{mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	white-space:nowrap;
	mso-rotate:0;
	mso-background-source:auto;
	mso-pattern:auto;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	border:none;
	mso-protection:locked visible;
	mso-style-name:"\D45C\C900_Cost manufacturing Statement_\C11C\D765\BCA0\D2B8\B0A8 \ACC4\C815\ACFC\BAA9\D45C_Sheet1";}
.style35
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border:none;
	mso-protection:locked visible;
	mso-style-name:\D45C\C900_Income_Statement_2009-2nd-\C131\D6C8;}
td
	{mso-style-parent:style0;
	padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:11.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border:none;
	mso-background-source:auto;
	mso-pattern:auto;
	mso-protection:locked visible;
	white-space:nowrap;
	mso-rotate:0;}
.xl40
	{mso-style-parent:style34;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl41
	{mso-style-parent:style34;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl42
	{mso-style-parent:style35;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl43
	{mso-style-parent:style35;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\\\(\#\#\\\)";
	text-align:center;}
.xl44
	{mso-style-parent:style35;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl45
	{mso-style-parent:style35;
	font-weight:700;
	font-family:\B3CB\C6C0, monospace;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style35;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl47
	{mso-style-parent:style35;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border-top:1.0pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:silver;
	mso-pattern:auto none;}
.xl48
	{mso-style-parent:style35;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:1.0pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl49
	{mso-style-parent:style35;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl50
	{mso-style-parent:style35;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	border-top:.5pt solid windowtext;
	border-right:1.0pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-number-format:"\#\,\#\#0\.00\;\[Red\]\#\,\#\#0\.00";}
.xl51
	{mso-style-parent:style35;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";}
.xl52
	{mso-style-parent:style33;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl53
	{mso-style-parent:style27;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;}
.xl54
	{mso-style-parent:style33;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl55
	{mso-style-parent:style33;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl56
	{mso-style-parent:style35;
	font-size:20.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl57
	{mso-style-parent:style35;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Balance Sheet</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>342</x:DefaultRowHeight>
     <x:Unsynced/>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>95</x:Scale>
      <x:HorizontalResolution>180</x:HorizontalResolution>
      <x:VerticalResolution>180</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>7</x:SplitHorizontal>
     <x:TopRowBottomPane>7</x:TopRowBottomPane>
     <x:ActivePane>2</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:ActiveCol>3</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8190</x:WindowHeight>
  <x:WindowWidth>14235</x:WindowWidth>
  <x:WindowTopX>240</x:WindowTopX>
  <x:WindowTopY>105</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl42>

<table x:str border=0 cellpadding=0 cellspacing=0 width=750 style='border-collapse:
 collapse;table-layout:fixed;width:562pt'>
 <col class=xl42 width=232 style='mso-width-source:userset;mso-width-alt:6599;
 width:174pt'>
 <col class=xl43 width=367 style='mso-width-source:userset;mso-width-alt:10439;
 width:275pt'>
 <col class=xl42 width=151 style='mso-width-source:userset;mso-width-alt:4295;
 width:113pt'>
 <col class=xl42 width=64 span=253 style='mso-width-source:userset;mso-width-alt:
 1820;width:48pt'>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl40 width=232 style='height:17.1pt;width:174pt'><%=l_company %></td>
  <td class=xl41 width=367 style='width:275pt'></td>
  <td class=xl40 width=151 style='width:113pt'></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl40 style='height:17.1pt'><%=l_address %></td>
  <td class=xl41></td>
  <td class=xl40></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl40 style='height:17.1pt'>Tax code:</td>
  <td class=xl41></td>
  <td class=xl40></td>
 </tr>
 <tr height=33 style='mso-height-source:userset;height:24.75pt'>
  <td colspan=3 height=33 class=xl56 style='height:24.75pt'>BALANCE SHEET</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td colspan=3 height=22 class=xl57 style='height:17.1pt'>As
  Of&nbsp;&nbsp;&nbsp;<%=date_day_curr %></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl42 style='height:17.1pt'></td>
  <td class=xl43></td>
  <td class=xl44>Unit:  <%=l_Unit%>  VND</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl45 style='height:17.1pt'>&#44284;<font class="font8">&nbsp;&nbsp;&nbsp;&nbsp;</font><font
  class="font7">&#47785;</font></td>
  <td class=xl46 style='border-left:none'>Classfication</td>
  <td class=xl47 style='border-left:none'>Amount</td>
 </tr>
 <%
     string  l_prn_no = "", xx="";
     int color = 0;
     string strBegin = "";
     string strEnd = "";
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         color = int.Parse(dt.Rows[i][11].ToString());
         strBegin = "";
         strEnd = "";
         if (dt.Rows[i][5].ToString() == "B")
         {
             strBegin = "<b>";
             strEnd = "</b>";
         }
         //l_prn_no = color.Substring(0, 1);
      %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
 <%
     if (color == 1 || color == 2 || color == 4 || color == 5)
     {   
         %>
  <td height=22 class=xl48 style='height:17.1pt;border-top:none'><%=strBegin %><%= dt.Rows[i][2].ToString()%><%=strEnd%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%=strBegin %><%= dt.Rows[i][0].ToString()%><%=strEnd%></td>
  <td class=xl50 align=right style='border-top:none;border-left:none' x:num><%=strBegin %><%= dt.Rows[i][8].ToString()%><%=strEnd%></td>
  <%  
     }
     else
     {         
  %>
  <td height=22 class=xl48 style='height:17.1pt;border-top:none'><%=strBegin %><%= dt.Rows[i][2].ToString()%><%=strEnd%></td>
  <td class=xl49 style='border-top:none;border-left:none'><%=strBegin %><%= dt.Rows[i][0].ToString()%><%=strEnd%></td>
  <td class=xl50 align=right style='border-top:none;border-left:none' x:num><%=strBegin %><%= dt.Rows[i][8].ToString()%><%=strEnd%></td>
  <%
     }
     %>  
 </tr>
 <%
     }
     %>  
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=2 class=xl42 style='height:17.1pt;mso-ignore:colspan'></td>
  <td class=xl51></td>
 </tr>
 <tr class=xl55 height=20 style='height:15.0pt'>
  <td height=20 class=xl52 style='height:15.0pt' x:str="Prepared by ">Prepared
  by<span style='mso-spacerun:yes'> </span></td>
  <td class=xl52></td>
  <td class=xl53 x:str=" Approved by"><span style='mso-spacerun:yes'> 
  </span>Approved by<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl55 height=20 style='height:15.0pt'>
  <td height=20 class=xl52 style='height:15.0pt'
  x:str="Chief Accountant           ">Chief Accountant<span
  style='mso-spacerun:yes'>           </span></td>
  <td class=xl55></td>
  <td class=xl54>General Director</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=232 style='width:174pt'></td>
  <td width=367 style='width:275pt'></td>
  <td width=151 style='width:113pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
