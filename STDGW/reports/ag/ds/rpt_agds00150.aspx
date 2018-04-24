<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;    
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_site = Request.QueryString["p_site"];
    string p_job = Request.QueryString["p_job"];
    string p_task = Request.QueryString["p_task"];
    string p_emp = Request.QueryString["p_emp"];
    string p_from_date = Request.QueryString["p_from_date"];
    string p_to_date = Request.QueryString["p_to_date"];

    string para = " '" + p_site + "','" + p_job + "','" + p_task + "','" + p_emp + "','" + p_from_date + "','" + p_to_date + "'";
    DataTable dt, dt1;
    string str_sql = @"SELECT partner_name, addr1, phone_no, fax_no, tax_code, tco_bpphoto_pk
                       FROM tco_company
                       WHERE del_if = 0 AND pk = (SELECT MAX (pk)
                                                  FROM tco_company
                                                  WHERE del_if = 0 AND active_yn = 'Y')";
    dt = ESysLib.TableReadOpen(str_sql);
    dt1 = ESysLib.TableReadOpenCursor("lg_rpt_agds00150", para); 
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="po_files/filelist.xml">
    <link rel="Edit-Time-Data" href="po_files/editdata.mso">
    <link rel="OLE-Object-Data" href="po_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Lee</o:Author>
  <o:LastAuthor>Mr Khanh</o:LastAuthor>
  <o:LastPrinted>2011-12-15T09:32:03Z</o:LastPrinted>
  <o:Created>2011-06-10T03:14:58Z</o:Created>
  <o:LastSaved>2011-12-15T09:37:09Z</o:LastSaved>
  <o:Company>Prive</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
    <style>
        <!--table
        {
            mso-displayed-decimal-separator: "\.";
            mso-displayed-thousand-separator: "\,";
        }
        @page
        {
            mso-footer-data: "Page &P of &N";
            margin: 0in .05in .37in .05in;
            mso-header-margin: 0in;
            mso-footer-margin: .16in;
            mso-page-orientation: landscape;
        }
        .font5
        {
            color: windowtext;
            font-size: 10.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
        }
        .font11
        {
            color: windowtext;
            font-size: 12.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
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
        .style21
        {
            mso-number-format: General;
            text-align: general;
            vertical-align: bottom;
            white-space: nowrap;
            mso-rotate: 0;
            mso-background-source: auto;
            mso-pattern: auto;
            color: windowtext;
            font-size: 11.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: 돋움, monospace;
            mso-font-charset: 129;
            border: none;
            mso-protection: locked visible;
            mso-style-name: Normal_Sheet1;
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
        .xl25
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
        }
        .xl26
        {
            mso-style-parent: style21;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl27
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
        }
        .xl28
        {
            mso-style-parent: style21;
            color: black;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
        }
        .xl29
        {
            mso-style-parent: style21;
            color: black;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl30
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl31
        {
            mso-style-parent: style0;
            color: red;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl32
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl33
        {
            mso-style-parent: style0;
            color: red;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl34
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl35
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl36
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
        }
        .xl37
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: right;
        }
        .xl38
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            border-top: none;
            border-right: none;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
        }
        .xl39
        {
            mso-style-parent: style0;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            border-top: 2.0pt double windowtext;
            border-right: none;
            border-bottom: none;
            border-left: none;
        }
        .xl40
        {
            mso-style-parent: style0;
            font-size: 12.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl41
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            white-space: normal;
        }
        .xl42
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            white-space: normal;
        }
        --></style>
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
      <x:Scale>74</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>15</x:ActiveRow>
       <x:ActiveCol>5</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>5745</x:WindowHeight>
  <x:WindowWidth>11880</x:WindowWidth>
  <x:WindowTopX>0</x:WindowTopX>
  <x:WindowTopY>1365</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
 <x:ExcelName>
  <x:Name>Print_Titles</x:Name>
  <x:SheetIndex>1</x:SheetIndex>
  <x:Formula>=Sheet1!$1:$5</x:Formula>
 </x:ExcelName>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="1025"/>
</xml><![endif]-->
</head>
<body link="blue" vlink="purple" class="xl25">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1588" style='border-collapse: collapse;
        table-layout: fixed; width: 1194pt'>
        <col class="xl25" width="134" style='mso-width-source: userset; mso-width-alt: 4900;
            width: 101pt'>
        <col class="xl25" width="74" style='mso-width-source: userset; mso-width-alt: 2706;
            width: 56pt'>
        <col class="xl25" width="168" style='mso-width-source: userset; mso-width-alt: 6144;
            width: 126pt'>
        <col class="xl25" width="74" style='mso-width-source: userset; mso-width-alt: 2706;
            width: 56pt'>
        <col class="xl25" width="50" style='mso-width-source: userset; mso-width-alt: 1828;
            width: 38pt'>
        <col class="xl25" width="64" style='width: 48pt'>
        <col class="xl25" width="44" style='mso-width-source: userset; mso-width-alt: 1609;
            width: 33pt'>
        <col class="xl25" width="74" style='mso-width-source: userset; mso-width-alt: 2706;
            width: 56pt'>
        <col class="xl25" width="297" style='mso-width-source: userset; mso-width-alt: 10861;
            width: 223pt'>
        <col class="xl25" width="417" style='mso-width-source: userset; mso-width-alt: 15250;
            width: 313pt'>
        <col class="xl25" width="64" span="3" style='width: 48pt'>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl26" width="134" style='height: 18.0pt; width: 101pt'>
            </td>
            <td colspan="3" class="xl36" width="316" style='width: 238pt'>
                <%= dt.Rows[0]["partner_name"] %>
            </td>
            <td class="xl27" width="50" style='width: 38pt'>
            </td>
            <td class="xl27" width="64" style='width: 48pt'>
            </td>
            <td class="xl27" width="44" style='width: 33pt'>
            </td>
            <td colspan="3" class="xl37" width="788" style='width: 592pt'>
                Tel:
                <%= dt.Rows[0]["phone_no"] %>
            </td>
            <td class="xl28" width="64" style='width: 48pt'>
            </td>
            <td class="xl28" width="64" style='width: 48pt'>
            </td>
            <td class="xl28" width="64" style='width: 48pt'>
            </td>
        </tr>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl26" style='height: 18.0pt'>
            </td>
            <td colspan="3" class="xl36">
                <%= dt.Rows[0]["addr1"] %>
            </td>
            <td colspan="3" class="xl27" style='mso-ignore: colspan'>
            </td>
            <td colspan="3" class="xl37">
                Fax:
                <%= dt.Rows[0]["fax_no"] %>
            </td>
            <td colspan="3" class="xl28" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl26" style='height: 18.0pt'>
            </td>
            <td colspan="3" class="xl38">
                MST:
                <%= dt.Rows[0]["tax_code"] %>
            </td>
            <td colspan="5" class="xl27" style='mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl28" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="40" style='mso-height-source: userset; height: 30.0pt'>
            <td colspan="10" height="40" class="xl39" style='height: 30.0pt'>
                WORKING TASKS CHECKING
            </td>
            <td class="xl25">
            </td>
            <td class="xl29">
            </td>
            <td class="xl28">
            </td>
        </tr>
        <tr height="28" style='mso-height-source: userset; height: 21.0pt'>
            <td colspan="10" height="28" class="xl40" style='height: 21.0pt'>
                <span style='mso-spacerun: yes'></span><font class="font5">Date: </font><font class="font11">
                    <%=System.DateTime.ParseExact(p_from_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%>
                    -
                    <%=System.DateTime.ParseExact(p_to_date, "yyyyMMdd", System.Globalization.CultureInfo.InvariantCulture).ToString("dd/MM/yyyy")%></font>
            </td>
            <td colspan="3" class="xl28" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="28" style='mso-height-source: userset; height: 21.0pt'>
            <td height="28" class="xl30" style='height: 21.0pt'>
                Site
            </td>
            <td class="xl31">
                Status
            </td>
            <td class="xl32">
                Job
            </td>
            <td class="xl31">
                Status
            </td>
            <td class="xl32">
                Staff
            </td>
            <td class="xl32">
                Date
            </td>
            <td class="xl32">
                Seq
            </td>
            <td class="xl31">
                Status
            </td>
            <td class="xl32">
                Plan Task
            </td>
            <td class="xl32">
                Staff Note
            </td>
            <td colspan="3" class="xl25" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%
            string strSite = string.Empty;
            string str_status_site = string.Empty;
            string str_job_desc = string.Empty;
            string str_status_site_job = string.Empty;
            string str_staff = string.Empty;
            string str_work_dt = string.Empty;
            string str_status_site_task = string.Empty;

            string[] ColumnName = new string[] { "site_name", "status_site", "job_desc", "status_site_job", "staff", "work_dt", "status_site_task" };
            int[,] arrSite_count = new int[ColumnName.Length, dt1.Rows.Count];
            int a = 0, b = 0, c = 0, d = 0, e = 0, f = 0, g = 0;
            int c_temp = 0;
            int strSite_count = 1;

            for (int i = 0; i < ColumnName.Length; i++)
            {
                if (c_temp < ColumnName.Length-1)
                {
                    c_temp++;
                }
                for (int y = 0; y < dt1.Rows.Count; y++)
                {
                    if (string.IsNullOrEmpty(strSite))
                    {
                        strSite = dt1.Rows[y][ColumnName[i].ToString()].ToString();
                        strSite_count = 1;
                    }
                    else
                    {
                        if (dt1.Rows[y][ColumnName[i].ToString()].ToString().Trim() != strSite.Trim())
                        {
                            arrSite_count[i, a] = strSite_count;
                            strSite_count = 1;
                            a++;
                            strSite = dt1.Rows[y][ColumnName[i].ToString()].ToString();
                        }
                        else
                        {
                            strSite_count++;
                        }
                    }
                }
                arrSite_count[i, a] = strSite_count;
                a = 0;
                strSite = string.Empty;
            }
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
        %>
        <tr class="xl27" height="36" style='mso-height-source: userset; height: 27.0pt'>
            <%
                if (strSite != dt1.Rows[i]["site_name"].ToString())
                {
            %>
            <td rowspan="<%=arrSite_count[0,a]%>" height="36" class="xl42" width="134" style='height: 27.0pt;
                width: 101pt'>
                <%= dt1.Rows[i]["site_name"]%>
            </td>
            <% 
                strSite = dt1.Rows[i]["site_name"].ToString();
                a++;
                }
            %>
            <%
                if (str_status_site != dt1.Rows[i]["status_site"].ToString())
                {
            %>
            <td rowspan="<%=arrSite_count[1,b]%>" class="xl33">
                <%= dt1.Rows[i]["status_site"]%>
            </td>
            <% 
                str_status_site = dt1.Rows[i]["status_site"].ToString();
                b++;
                }
            %>
            <td class="xl41" width="168" style='width: 126pt'>
                <%= dt1.Rows[i]["job_desc"]%>
            </td>
            <td class="xl33">
                <%= dt1.Rows[i]["status_site_job"]%>
            </td>
            <td class="xl34">
                <%= dt1.Rows[i]["staff"]%>
            </td>
            <td class="xl34">
                <%= dt1.Rows[i]["work_dt"]%>
            </td>
            <td class="xl34" x:num>
                <%= dt1.Rows[i]["seq"]%>
            </td>
            <td class="xl33">
                <%= dt1.Rows[i]["status_site_task"]%>
            </td>
            <td class="xl35" width="297" style='width: 223pt'>
                <%= dt1.Rows[i]["plan_task"]%>
            </td>
            <td class="xl35" width="417" style='width: 313pt'>
                <%= dt1.Rows[i]["staff_note"]%>
            </td>
            <td colspan="3" class="xl27" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%} %>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="134" style='width: 101pt'>
            </td>
            <td width="74" style='width: 56pt'>
            </td>
            <td width="168" style='width: 126pt'>
            </td>
            <td width="74" style='width: 56pt'>
            </td>
            <td width="50" style='width: 38pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="44" style='width: 33pt'>
            </td>
            <td width="74" style='width: 56pt'>
            </td>
            <td width="297" style='width: 223pt'>
            </td>
            <td width="417" style='width: 313pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
            <td width="64" style='width: 48pt'>
            </td>
        </tr>
        <![endif]>
    </table>
</body>
</html>
