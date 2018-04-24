<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser(Session["hr"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8";
    Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    //ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    string p_user,  p_org, p_wg, p_search, p_temp, p_from_dt, p_to_dt;
    p_user      = Request.QueryString["p_user"].ToString();
    p_org       = Request.QueryString["p_org"].ToString();
    p_wg        = Request.QueryString["p_wg"].ToString();
    p_search    = Request.QueryString["p_search"].ToString();
    p_temp      = Request.QueryString["p_temp"].ToString();
    p_from_dt   = Request.QueryString["p_from_dt"].ToString();
    p_to_dt     = Request.QueryString["p_to_dt"].ToString();

    string SQL = "SELECT R.PK, " +
        "             O.ORG_NM, " +
        "             E.EMP_ID, " +
        "             TO_CHAR(TO_DATE(E.JOIN_DT, 'yyyymmdd'), 'dd/mm/yyyy') JOIN_DT, " +
        "             E.FULL_NAME, " +
        "             TO_CHAR(TO_DATE(R.FROM_DT, 'yyyymmdd'), 'dd/mm/yyyy') FROM_DT, " +
        "             TO_CHAR(TO_DATE(R.TO_DT, 'yyyymmdd'), 'dd/mm/yyyy') TO_DT, " +
        "             R.MAIN_TASK, " +
        "             R.TASK_DETAIL, " +
        "             R.RATION, " +
        "             R.REMARK, " +
        "             E.PK AS EMP_PK " +
        "        FROM THR_WEEKLY_REPORT R, TCO_ORG O, THR_EMPLOYEE E " +
        "       WHERE     R.THR_EMP_PK = E.PK " +
        "             AND E.TCO_ORG_PK = O.PK " +
        "             AND R.DEL_IF = 0 " +
        "             AND E.DEL_IF = 0 " +
        "             AND DECODE ('" + p_wg + "', 'ALL', '" + p_wg + "', E.THR_WG_PK) = '" + p_wg + "' " +
        "             AND (   E.TCO_ORG_PK IN " +
        "                        (    SELECT G.pk " +
        "                               FROM TCO_ORG G " +
        "                              WHERE G.del_if = 0 " +
        "                         START WITH G.pk = " +
        "                                       DECODE ('" + p_org + "', 'ALL', 0, '" + p_org + "') " +
        "                         CONNECT BY PRIOR G.pk = G.p_pk) " +
        "                  OR '" + p_org + "' = 'ALL') " +
        "             AND (DECODE('" + p_search + "','2',UPPER(E.EMP_ID),'3',E.ID_NUM,'1',UPPER(E.FULL_NAME)) LIKE '%'||UPPER('" + p_temp + "')||'%' " +
        "                        OR '" + p_temp + "' IS NULL) " +
        "             AND (R.FROM_DT = '" + p_from_dt + "' OR '" + p_from_dt + "' IS NULL OR R.FROM_DT IS NULL) " +
        "             AND (R.TO_DT = '" + p_to_dt + "' OR '" + p_to_dt + "' IS NULL OR R.TO_DT IS NULL)";
    DataTable dt_weekly = ESysLib.TableReadOpen(SQL);
    int irow;
    irow = dt_weekly.Rows.Count;
    if (irow == 0)
    {
        Response.Write("There is no data to show");
        Response.End();
    }
    
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_weekly_report_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_weekly_report_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_weekly_report_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>FOREVER</o:Author>
  <o:LastAuthor>FOREVER</o:LastAuthor>
  <o:Created>2013-06-18T05:34:53Z</o:Created>
  <o:LastSaved>2013-06-18T06:01:22Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
    <style>
        <!-- table
        {
            mso-displayed-decimal-separator: "\.";
            mso-displayed-thousand-separator: "\,";
        }

        @page
        {
            margin: 1.0in .75in 1.0in .75in;
            mso-header-margin: .5in;
            mso-footer-margin: .5in;
        }

        tr
        {
            mso-height-source: auto;
        }

        col
        {
            mso-width-source: auto;
        }

        br
        {
            mso-data-placement: same-cell;
        }

        .style0
        {
            mso-number-format: General;
            text-align: general;
            vertical-align: bottom;
            white-space: nowrap;
            mso-rotate: 0;
            mso-background-source: auto;
            mso-pattern: auto;
            color: windowtext;
            font-size: 10.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Arial;
            mso-generic-font-family: auto;
            mso-font-charset: 0;
            border: none;
            mso-protection: locked visible;
            mso-style-name: Normal;
            mso-style-id: 0;
        }

        td
        {
            mso-style-parent: style0;
            padding-top: 1px;
            padding-right: 1px;
            padding-left: 1px;
            mso-ignore: padding;
            color: windowtext;
            font-size: 10.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Arial;
            mso-generic-font-family: auto;
            mso-font-charset: 0;
            mso-number-format: General;
            text-align: general;
            vertical-align: bottom;
            border: none;
            mso-background-source: auto;
            mso-pattern: auto;
            mso-protection: locked visible;
            white-space: nowrap;
            mso-rotate: 0;
        }

        .xl24
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
        }

        .xl25
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            border-top: .5pt solid #00CCFF;
            border-right: none;
            border-bottom: none;
            border-left: none;
        }

        .xl26
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            border-top: none;
            border-right: none;
            border-bottom: none;
            border-left: .5pt solid #00CCFF;
        }

        .xl27
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid #00CCFF;
            border-left: none;
        }

        .xl28
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid #00CCFF;
        }

        .xl29
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid #00CCFF;
            border-right: .5pt solid #00CCFF;
            border-bottom: .5pt solid #00CCFF;
            border-left: .5pt solid windowtext;
        }

        .xl30
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid #00CCFF;
            border-right: none;
            border-bottom: .5pt solid #00CCFF;
            border-left: none;
        }

        .xl31
        {
            mso-style-parent: style0;
            color: #3366FF;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid #00CCFF;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid #00CCFF;
            border-left: .5pt solid windowtext;
            background: white;
            mso-pattern: auto none;
        }

        .xl32
        {
            mso-style-parent: style0;
            border-top: .5pt solid #00CCFF;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid #00CCFF;
            border-left: .5pt solid windowtext;
            background: white;
            mso-pattern: auto none;
        }

        .xl33
        {
            mso-style-parent: style0;
            border-top: .5pt solid #00CCFF;
            border-right: .5pt solid #00CCFF;
            border-bottom: .5pt solid #00CCFF;
            border-left: .5pt solid windowtext;
            background: white;
            mso-pattern: auto none;
        }

        .xl34
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid #00CCFF;
            border-right: .5pt solid #00CCFF;
            border-bottom: .5pt solid #00CCFF;
            border-left: none;
        }

        .xl35
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border: .5pt solid #00CCFF;
        }

        .xl36
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border: .5pt solid #00CCFF;
            white-space: normal;
        }

        .xl37
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            mso-number-format: 0%;
            text-align: right;
            vertical-align: middle;
            border: .5pt solid #00CCFF;
        }

        .xl38
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            mso-number-format: "Short Date";
            text-align: center;
            vertical-align: middle;
            border: .5pt solid #00CCFF;
        }

        .xl39
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            border-top: .5pt solid #00CCFF;
            border-right: none;
            border-bottom: .5pt solid #00CCFF;
            border-left: none;
        }

        .xl40
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            border: .5pt solid #00CCFF;
        }

        .xl41
        {
            mso-style-parent: style0;
            font-family: "Segoe UI", sans-serif;
            mso-font-charset: 0;
            mso-number-format: "Short Date";
            text-align: center;
            border: .5pt solid #00CCFF;
        }
        -->
    </style>
    <!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Weekly report</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>285</x:DefaultRowHeight>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:HorizontalResolution>300</x:HorizontalResolution>
      <x:VerticalResolution>300</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>7</x:ActiveRow>
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
  <x:WindowHeight>8760</x:WindowHeight>
  <x:WindowWidth>17235</x:WindowWidth>
  <x:WindowTopX>120</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link="blue" vlink="purple" class="xl24">

    <table x:str border="0" cellpadding="0" cellspacing="0" width="1409" style='border-collapse: collapse; table-layout: fixed; width: 1060pt'>
        <col class="xl24" width="37" style='mso-width-source: userset; mso-width-alt: 1353; width: 28pt'>
        <col class="xl24" width="154" style='mso-width-source: userset; mso-width-alt: 5632; width: 116pt'>
        <col class="xl24" width="80" style='mso-width-source: userset; mso-width-alt: 2925; width: 60pt'>
        <col class="xl24" width="174" style='mso-width-source: userset; mso-width-alt: 6363; width: 131pt'>
        <col class="xl24" width="82" style='mso-width-source: userset; mso-width-alt: 2998; width: 62pt'>
        <col class="xl24" width="207" style='mso-width-source: userset; mso-width-alt: 7570; width: 155pt'>
        <col class="xl24" width="240" style='mso-width-source: userset; mso-width-alt: 8777; width: 180pt'>
        <col class="xl24" width="82" span="2" style='mso-width-source: userset; mso-width-alt: 2998; width: 62pt'>
        <col class="xl24" width="54" style='mso-width-source: userset; mso-width-alt: 1974; width: 41pt'>
        <col class="xl24" width="153" style='mso-width-source: userset; mso-width-alt: 5595; width: 115pt'>
        <col class="xl24" width="64" style='width: 48pt'>
        <tr height="19" style='height: 14.25pt'>
            <td height="19" class="xl24" width="37" style='height: 14.25pt; width: 28pt'></td>
            <td class="xl24" width="154" style='width: 116pt'></td>
            <td class="xl24" width="80" style='width: 60pt'></td>
            <td class="xl24" width="174" style='width: 131pt'></td>
            <td class="xl24" width="82" style='width: 62pt'></td>
            <td class="xl24" width="207" style='width: 155pt'></td>
            <td class="xl24" width="240" style='width: 180pt'></td>
            <td class="xl24" width="82" style='width: 62pt'></td>
            <td class="xl24" width="82" style='width: 62pt'></td>
            <td class="xl24" width="54" style='width: 41pt'></td>
            <td class="xl24" width="153" style='width: 115pt'></td>
            <td class="xl24" width="64" style='width: 48pt'></td>
        </tr>
        <tr height="47" style='mso-height-source: userset; height: 35.25pt'>
            <td colspan="11" height="47" class="xl31" style='border-right: .5pt solid #00CCFF; height: 35.25pt'>WEEKLY REPORT</td>
            <td class="xl24"></td>
        </tr>
        <tr height="19" style='height: 14.25pt'>
            <td height="19" colspan="2" class="xl24" style='height: 14.25pt; mso-ignore: colspan'></td>
            <td class="xl39" style='border-top: none'>&nbsp;</td>
            <td colspan="2" class="xl24" style='mso-ignore: colspan'></td>
            <td class="xl39" style='border-top: none'>&nbsp;</td>
            <td colspan="6" class="xl24" style='mso-ignore: colspan'></td>
        </tr>
        <tr height="19" style='height: 14.25pt'>
            <td height="19" colspan="2" class="xl24" style='height: 14.25pt; mso-ignore: colspan'></td>
            <td class="xl40" style='border-top: none'>Date report</td>
            <td class="xl41" style='border-left: none' x:num><%=DateTime.Now.ToString("dd/MM/yyyy") %></td>
            <td class="xl40" style='border-left: none'>Manager</td>
            <td class="xl26" style='border-left: none'><%=p_user %></td>
            <td class="xl26">&nbsp;</td>
            <td colspan="5" class="xl24" style='mso-ignore: colspan'></td>
        </tr>
        <tr height="19" style='height: 14.25pt'>
            <td height="19" colspan="2" class="xl24" style='height: 14.25pt; mso-ignore: colspan'></td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25">&nbsp;</td>
            <td colspan="6" class="xl24" style='mso-ignore: colspan'></td>
        </tr>
        <tr height="19" style='height: 14.25pt'>
            <td height="19" colspan="10" class="xl24" style='height: 14.25pt; mso-ignore: colspan'></td>
            <td class="xl27">&nbsp;</td>
            <td class="xl24"></td>
        </tr>
        <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
            <td height="22" class="xl29" style='height: 16.5pt'>No.</td>
            <td class="xl28" style='border-left: none'>Organization</td>
            <td class="xl34">Employee ID</td>
            <td class="xl28" style='border-left: none'>Full Name</td>
            <td class="xl28" style='border-left: none'>Join Date</td>
            <td class="xl28" style='border-left: none'>Main Task</td>
            <td class="xl28" style='border-left: none'>Task Detail</td>
            <td class="xl28" style='border-left: none'>Start date</td>
            <td class="xl30">Finish Date</td>
            <td class="xl28">Ration</td>
            <td class="xl28" style='border-top: none; border-left: none'>Note</td>
            <td class="xl26" style='border-left: none'>&nbsp;</td>
        </tr>
        <!--Begin export data here-->
        <%
            for(int i=0; i< dt_weekly.Rows.Count; i++)
            {
                string taskdetail = dt_weekly.Rows[i][8].ToString();
                string[] td = taskdetail.Split('\n');
        %>
        <tr height="75" style='mso-height-source: userset; height: 56.25pt'>
            <td height="75" class="xl29" style='height: 56.25pt; border-top: none' x:num><%=i+1 %></td>
            <td class="xl35" style='border-top: none; border-left: none'><%=dt_weekly.Rows[i][1].ToString() %></td>
            <td class="xl28" style='border-top: none; border-left: none' x:num><%=dt_weekly.Rows[i][2].ToString() %></td>
            <td class="xl35" style='border-top: none; border-left: none'><%=dt_weekly.Rows[i][4].ToString() %></td>
            <td class="xl38" style='border-top: none; border-left: none' x:num><%=dt_weekly.Rows[i][3].ToString() %></td>
            <td class="xl35" style='border-top: none; border-left: none'><%=dt_weekly.Rows[i][7].ToString() %></td>
            <td class="xl36" width="240" style='border-top: none; border-left: none; width: 180pt;'>
                <% for (int j = 0; j < td.Length; j++ )
                   { 
                %>
                <%=td[j]%><br />
                <% } %>
            </td>
            <td class="xl38" style='border-top: none; border-left: none' x:num><%=dt_weekly.Rows[i][5].ToString() %></td>
            <td class="xl38" style='border-top: none; border-left: none' x:num><%=dt_weekly.Rows[i][6].ToString() %></td>
            <td class="xl37" style='border-top: none; border-left: none' x:num=""><%=dt_weekly.Rows[i][9].ToString() %></td>
            <td class="xl35" style='border-top: none; border-left: none'><%=dt_weekly.Rows[i][10].ToString() %></td>
            <td class="xl26" style='border-left: none'>&nbsp;</td>
        </tr>
        <% } %>
        <!--End export data-->
        <tr height="19" style='height: 14.25pt'>
            <td height="19" class="xl25" style='height: 14.25pt; border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td class="xl25" style='border-top: none'>&nbsp;</td>
            <td colspan="2" class="xl24" style='mso-ignore: colspan'></td>
        </tr>
        <![if supportMisalignedColumns]>
 <tr height="0" style='display: none'>
     <td width="37" style='width: 28pt'></td>
     <td width="154" style='width: 116pt'></td>
     <td width="80" style='width: 60pt'></td>
     <td width="174" style='width: 131pt'></td>
     <td width="82" style='width: 62pt'></td>
     <td width="207" style='width: 155pt'></td>
     <td width="240" style='width: 180pt'></td>
     <td width="82" style='width: 62pt'></td>
     <td width="82" style='width: 62pt'></td>
     <td width="54" style='width: 41pt'></td>
     <td width="153" style='width: 115pt'></td>
     <td width="64" style='width: 48pt'></td>
 </tr>
        <![endif]>
    </table>

</body>

</html>
