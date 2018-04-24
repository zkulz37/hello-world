<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<% Response.ContentType = "application/vnd.ms-excel"; %>
<% Response.Charset = "utf-8"; %>
<% ESysLib.SetUser("prod");%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns="http://www.w3.org/TR/REC-html40">
<%
    string wi_from_dt = Request.QueryString["wi_from_dt"];
    string wi_to_dt   = Request.QueryString["wi_to_dt"];
    
    string SQL ="";
    
	SQL   = " SELECT a.pk, a.wi_no, prod.sf_get_fpcw00061 (1, null, a.tco_item_pk) classfication, " + 
            "  prod.sf_get_fpcw00061 (2, null,a.tco_item_pk) item_class, prod.sf_get_fpcw00061 (3, null,a.tco_item_pk) treament, " +
            "  prod.sf_get_fpcw00061 (4, null,a.tco_item_pk) thickness, a.att13 item_length, " +
            "  a.att11 sum_of_width, a.att03 block_no, a.description,   " +
            "  round((TO_NUMBER (a.att06) - TO_NUMBER (a.att11))/ TO_NUMBER (a.att06)* 100,2) loss_rate,to_number(a.att06)" +
            "  FROM   prod.tpr_workins a WHERE a.del_if = 0 AND a.wi_type = 2 " +
            "         AND a.wi_date BETWEEN '"+ wi_from_dt +"' AND '" + wi_to_dt +"'"+
            "       order by a.wi_no " ;

   
    DataTable dt = ESysLib.TableReadOpen(SQL);
 
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="fpcw00062_WI_Report_files/filelist.xml">
    <link rel="Edit-Time-Data" href="fpcw00062_WI_Report_files/editdata.mso">
    <link rel="OLE-Object-Data" href="fpcw00062_WI_Report_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>NgaLe</o:Author>
  <o:LastAuthor>NgaLe</o:LastAuthor>
  <o:LastPrinted>2009-03-08T08:19:58Z</o:LastPrinted>
  <o:Created>2009-03-08T08:03:18Z</o:Created>
  <o:LastSaved>2009-03-09T02:11:13Z</o:LastSaved>
  <o:Company>Vinagenuwin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
    <style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.33in .19in .35in .36in;
	mso-header-margin:.23in;
	mso-footer-margin:.17in;
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
	font-family:Arial, sans-serif;
	mso-font-charset:0;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#CCFFFF;
	mso-pattern:auto none;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl29
	{mso-style-parent:style0;
	border:.5pt solid windowtext;
	vertical-align:middle;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	mso-number-format:"0\.0%";
	border:.5pt solid windowtext;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl31
	{mso-style-parent:style0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl32
	{mso-style-parent:style0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	border:.5pt solid windowtext;
	vertical-align:middle;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl33
	{mso-style-parent:style0;
	font-size:18.0pt;
	text-align:center;}
-->
</style>
    <!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>WI</x:Name>
    <x:WorksheetOptions>
     <x:FitToPage/>
     <x:FitToPage/>
     <x:Print>
      <x:FitHeight>0</x:FitHeight>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>68</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>8</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
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
  <x:WindowHeight>9210</x:WindowHeight>
  <x:WindowWidth>15195</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>60</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>
<body link="blue" vlink="purple">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1488" style='border-collapse: collapse;
        table-layout: fixed; width: 1113pt'>
        <col width="39" style='mso-width-source: userset; mso-width-alt: 1426; width: 29pt'>
        <col width="107" style='mso-width-source: userset; mso-width-alt: 3913; width: 80pt'>
        <col width=147 style='mso-width-source:userset;mso-width-alt:5376;width:110pt'>
        <col width="111" style='mso-width-source: userset; mso-width-alt: 4059; width: 83pt'>
        <col width="98" style='mso-width-source: userset; mso-width-alt: 3584; width: 74pt'>
        <col width="95" style='mso-width-source: userset; mso-width-alt: 3474; width: 71pt'>
        <col width="64" style='width: 48pt'>
        <col width="51" span="10" style='mso-width-source: userset; mso-width-alt: 1865;
            width: 38pt'>
        <col width="74" style='mso-width-source: userset; mso-width-alt: 2706; width: 56pt'>
        <col width="64" style='width: 48pt'>
        <col width="59" style='mso-width-source: userset; mso-width-alt: 2157; width: 44pt'>
        <col width="124" style='mso-width-source: userset; mso-width-alt: 4534; width: 93pt'>
        <tr height="31" style='height: 23.25pt'>
            <td colspan="21" height="31" class="xl33" width="1488" style='height: 23.25pt; width: 1113pt'>
                MAIN S/L CUTTING PLAN</td>
        </tr>
        <tr height="12" style='mso-height-source: userset; height: 9.0pt'>
            <td height="12" colspan="21" style='height: 9.0pt; mso-ignore: colspan'>
            </td>
        </tr>
        <%
	        SQL   = " SELECT to_char(to_date("+ wi_from_dt +",'yyyymmdd'),'YYYY-MON-DD') || '~' || to_char(to_date("+ wi_to_dt +",'yyyymmdd'),'YYYY-MON-DD') from dual" ; 

            DataTable dt1 = ESysLib.TableReadOpen(SQL);

        %>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl24" colspan="2" style='height: 12.75pt; mso-ignore: colspan'>
                Date :
                <%=dt1.Rows[0][0].ToString()%>
            </td>
            <td colspan="19" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="12" style='mso-height-source: userset; height: 9.0pt'>
            <td height="12" colspan="21" style='height: 9.0pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr class="xl27" height="34" style='height: 25.5pt'>
            <td height="34" class="xl25" style='height: 25.5pt'>
                SEQ</td>
            <td class="xl25" style='border-left: none'>
                WI NO.</td>
            <td class="xl25" style='border-left: none'>
                CLASSIFICATION</td>
            <td class="xl25" style='border-left: none'>
                ITEM CLASS</td>
            <td class="xl25" style='border-left: none'>
                TREATMENT</td>
            <td class="xl25" style='border-left: none'>
                THICKNESS</td>
            <td class="xl25" style='border-left: none'>
                LENGTH</td>
            <td class="xl25" style='border-left: none'>
                No1</td>
            <td class="xl25" style='border-left: none'>
                No2</td>
            <td class="xl25" style='border-left: none'>
                No3</td>
            <td class="xl25" style='border-left: none'>
                No4</td>
            <td class="xl25" style='border-left: none'>
                No5</td>
            <td class="xl25" style='border-left: none'>
                No6</td>
            <td class="xl25" style='border-left: none'>
                No7</td>
            <td class="xl25" style='border-left: none'>
                No8</td>
            <td class="xl25" style='border-left: none'>
                No9</td>
            <td class="xl25" style='border-left: none'>
                No10</td>
             <td class="xl26" width="74" style='border-left: none; width: 56pt'>
                SUM OF
                <br>
                WIDTH</td>
            <td class="xl25" style='border-left: none'>
                Loss Rate</td>
             <td class="xl25" style='border-left: none'>
                BLOCK</td>
            <td class="xl25" style='border-left: none'>
                Remark</td>
        </tr>
        <%
        if ( dt.Rows.Count > 0 )
        {
            int index = 0;
            
            while ( index < dt.Rows.Count )
            {
        %>
        <tr class="xl31" height="20" style='mso-height-source: userset; height: 30.0pt;'>
            <td height="20" class="xl28" valign="middle" style='height: 15.0pt; border-top: none'>
                <%=index+1 %>
            </td>
            <td class="xl29" style='border-top: none; border-left: none' valign="middle">
                <%=dt.Rows[index][1].ToString()%>
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                <%=dt.Rows[index][2].ToString()%>
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                <%=dt.Rows[index][3].ToString()%>
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                <%=dt.Rows[index][4].ToString()%>
            </td>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'></span>
                <%=dt.Rows[index][5].ToString()%>
            </td>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'></span>
                <%=dt.Rows[index][6].ToString()%>
            </td>
           
            
            <%
               
                SQL
                    = "SELECT   NVL2 (b.att08, " +
                        "               '*' || sale.sf_get_dsbs00013_2 (5, a.tco_item_pk), " +
                        "               sale.sf_get_dsbs00013_2 (5, a.tco_item_pk) " +
                        "              ) width, " +
                        "         a.num_of_arm " +
                        "    FROM prod.tpr_workinsd a, prod.tpr_workinsd b " +
                        "   WHERE a.del_if = 0 AND a.tpr_workins_pk = " + dt.Rows[index][0].ToString() + " AND b.del_if(+) = 0 " +
                        "         AND a.pk = b.att08(+) " +
                        "ORDER BY a.wid_seq ";               
                
            DataTable dt2 = ESysLib.TableReadOpen(SQL);
            int sumroll = 0, arm_roll=0;
             
            if ( 0 < dt2.Rows.Count )
            {
                arm_roll = Int32.Parse(dt2.Rows[0][1].ToString());
                sumroll = sumroll + arm_roll;
                for (int i = 0; i < arm_roll; i++)
                {
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'>
                    <%=dt2.Rows[0][0].ToString()%>
                </span>
            </td>
            <%
                }
            }
                    
            if ( 1 < dt2.Rows.Count )
            { 
                arm_roll = Int32.Parse(dt2.Rows[1][1].ToString());
                sumroll = sumroll + arm_roll;
                for (int i = 0; i < arm_roll; i++)
                {
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'>
                    <%=dt2.Rows[1][0].ToString()%>
                </span>
            </td>
            <%
                }
            }
                   
            if ( 2 < dt2.Rows.Count )
            { 
                arm_roll = Int32.Parse(dt2.Rows[2][1].ToString());
                sumroll = sumroll + arm_roll;
                for (int i = 0; i < arm_roll; i++)
                {
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'>
                    <%=dt2.Rows[2][0].ToString()%>
                </span>
            </td>
            <%
                }
            }
           
            if (3 < dt2.Rows.Count)
            {
                arm_roll = Int32.Parse(dt2.Rows[3][1].ToString());
                sumroll = sumroll + arm_roll;
                for (int i = 0; i < arm_roll; i++)
                {
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'>
                    <%=dt2.Rows[3][0].ToString()%>
                </span>
            </td>
            <%
                }
            }
                        
            if ( 4 < dt2.Rows.Count )
            { 
                arm_roll = Int32.Parse(dt2.Rows[4][1].ToString());
                sumroll = sumroll + arm_roll;
                for (int i = 0; i < arm_roll; i++)
                {
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'>
                    <%=dt2.Rows[4][0].ToString()%>
                </span>
            </td>
            <%
                }
            }
                   
            if ( 5 < dt2.Rows.Count )
            { 
                arm_roll = Int32.Parse(dt2.Rows[5][1].ToString());
                sumroll = sumroll + arm_roll;
                for (int i = 0; i < arm_roll; i++)
                {
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'>
                    <%=dt2.Rows[5][0].ToString()%>
                </span>
            </td>
            <%
                }
            }
                      
            if ( 6 < dt2.Rows.Count )
            { 
                arm_roll = Int32.Parse(dt2.Rows[6][1].ToString());
                sumroll = sumroll + arm_roll;
                for (int i = 0; i < arm_roll; i++)
                {
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'>
                    <%=dt2.Rows[6][0].ToString()%>
                </span>
            </td>
            <%
                }
            }
                   
            if ( 7 < dt2.Rows.Count )
            { 
                arm_roll = Int32.Parse(dt2.Rows[7][1].ToString());
                sumroll = sumroll + arm_roll;
                for (int i = 0; i < arm_roll; i++)
                {
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'>
                    <%=dt2.Rows[7][0].ToString()%>
                </span>
            </td>
            <%
                }
            }
                    
            if ( 8 < dt2.Rows.Count )
            { 
                arm_roll = Int32.Parse(dt2.Rows[8][1].ToString());
                sumroll = sumroll + arm_roll;
                for (int i = 0; i < arm_roll; i++)
                {
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'>
                    <%=dt2.Rows[8][0].ToString()%>
                </span>
            </td>
            <%
                }
            }
                  
            if ( 9 < dt2.Rows.Count )
            { 
                arm_roll = Int32.Parse(dt2.Rows[9][1].ToString());
                sumroll = sumroll + arm_roll;
                for (int i = 0; i < arm_roll; i++)
                {
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'>
                    <%=dt2.Rows[9][0].ToString()%>
                </span>
            </td>
            <%
                }
            }
            
            for (int i = sumroll; i < 10; i++)
            {
                %>
                     <td class="xl32" style='border-top: none; border-left: none' x:num="">
                        <span style='mso-spacerun: yes'></span>
                    </td>
                <%
            }
            double loss = Convert.ToDouble(dt.Rows[index][10].ToString());
            double width = Convert.ToDouble(dt.Rows[index][11].ToString());
            string st = loss.ToString().Replace(",", ".");
            %>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'></span>
                <%=dt.Rows[index][7].ToString()%>
            </td>
            <td class="xl32" align="right" style='border-top: none; border-left: none' >
                <% =st %>%
            </td>
            <td class="xl32" style='border-top: none; border-left: none' x:num="">
                <span style='mso-spacerun: yes'></span>
                <%=dt.Rows[index][8].ToString()%>
            </td>
            <td class="xl29" style='border-top: none; border-left: none'>
                <%=dt.Rows[index][9].ToString()%>
            </td>
        </tr>
        <%
                index = index + 1;
            }
        }
        %>
        <tr class="xl31" height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td height="20" class="xl28" style='height: 15.0pt; border-top: none'>
                &nbsp;</td>
            <td class="xl29" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl29" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl29" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl29" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl32" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl29" style='border-top: none; border-left: none'>
                &nbsp;</td>
            <td class="xl29" style='border-top: none; border-left: none'>
                &nbsp;</td>
        </tr>
        <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
            <td height="20" colspan="21" style='height: 15.0pt; mso-ignore: colspan'>
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="39" style='width: 29pt'>
            </td>
            <td width="107" style='width: 80pt'>
            </td>
            <td width="147" style='width: 110pt'>
            </td>
            <td width="111" style='width: 83pt'>
            </td>
            <td width="98" style='width: 74pt'>
            </td>
            <td width="95" style='width: 71pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
           
            <td width="51" style='width: 38pt'>
            </td>
            <td width="51" style='width: 38pt'>
            </td>
            <td width="51" style='width: 38pt'>
            </td>
            <td width="51" style='width: 38pt'>
            </td>
            <td width="51" style='width: 38pt'>
            </td>
            <td width="51" style='width: 38pt'>
            </td>
            <td width="51" style='width: 38pt'>
            </td>
            <td width="51" style='width: 38pt'>
            </td>
            <td width="51" style='width: 38pt'>
            </td>
            <td width="51" style='width: 38pt'>
            </td>
             <td width="74" style='width: 56pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
             <td width="59" style='width: 44pt'>
            </td>
            <td width="124" style='width: 93pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
