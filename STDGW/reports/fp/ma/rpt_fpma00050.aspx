<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %>
<%  ESysLib.SetUser("prod");
    Response.ContentType = "application/vnd.ms-excel";
    Response.Buffer = false;
%>
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
<% 
    string p_master_pk = Request.QueryString["txtMasterPK"];
    string para = string.Empty;
    DataTable dt, dt1, dt2, dt3;
    dt = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpma00050");
    dt1 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpma00050_1", "'" + p_master_pk + "'");
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 11">
    <link rel="File-List" href="rpt_fpma00050_files/filelist.xml">
    <link rel="Edit-Time-Data" href="rpt_fpma00050_files/editdata.mso">
    <link rel="OLE-Object-Data" href="rpt_fpma00050_files/oledata.mso">
    <!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Mr Lee</o:Author>
  <o:LastAuthor>Server_Test</o:LastAuthor>
  <o:LastPrinted>2011-06-22T05:57:11Z</o:LastPrinted>
  <o:Created>2011-06-16T06:41:53Z</o:Created>
  <o:LastSaved>2011-06-22T06:00:29Z</o:LastSaved>
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
            margin: .14in .25in .25in .25in;
            mso-header-margin: 0in;
            mso-footer-margin: .25in;
        }
        .font8
        {
            color: windowtext;
            font-size: 10.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
        }
        .font18
        {
            color: windowtext;
            font-size: 8.0pt;
            font-weight: 700;
            font-style: italic;
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
        .style22
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
            font-family: \B3CB\C6C0, monospace;
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
            font-size: 14.0pt;
            font-weight: 700;
            font-family: "Code39\(2\:3\)" , sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
        }
        .xl26
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl27
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl28
        {
            mso-style-parent: style22;
            color: black;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl29
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            white-space: normal;
        }
        .xl30
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
        }
        .xl31
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "\#\,\#\#0";
            text-align: right;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
        }
        .xl32
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: Standard;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
        }
        .xl33
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            white-space: normal;
        }
        .xl34
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl35
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl36
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border: .5pt solid windowtext;
            white-space: normal;
        }
        .xl37
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl38
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl39
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl40
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl41
        {
            mso-style-parent: style22;
            color: black;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl42
        {
            mso-style-parent: style22;
            color: green;
            font-size: 34.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
        }
        .xl43
        {
            mso-style-parent: style22;
            color: black;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl44
        {
            mso-style-parent: style0;
            font-size: 18.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl45
        {
            mso-style-parent: style22;
            color: black;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl46
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: right;
            vertical-align: middle;
        }
        .xl47
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
        }
        .xl48
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl49
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: Standard;
            text-align: right;
            vertical-align: middle;
        }
        .xl50
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
        }
        .xl51
        {
            mso-style-parent: style0;
            font-size: 12.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
        }
        .xl52
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            mso-number-format: "d\\-mmm";
            vertical-align: middle;
        }
        .xl53
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl54
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl55
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl56
        {
            mso-style-parent: style22;
            color: black;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl57
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
        }
        .xl58
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl59
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
        }
        .xl60
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl61
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl62
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
        }
        .xl63
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl64
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl65
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl66
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: right;
            vertical-align: middle;
        }
        .xl67
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: right;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl68
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
        }
        .xl69
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl70
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: right;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl71
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl72
        {
            mso-style-parent: style0;
            font-size: 14.0pt;
            font-weight: 700;
            font-family: "Code39\(2\:3\)" , sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl73
        {
            mso-style-parent: style0;
            font-size: 14.0pt;
            font-weight: 700;
            font-family: "Code39\(2\:3\)" , sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
        }
        .xl74
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: none;
            border-left: .5pt solid windowtext;
        }
        .xl75
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
        }
        .xl76
        {
            mso-style-parent: style0;
            font-weight: 700;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
        }
        .xl77
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: none;
            border-bottom: none;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl78
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: none;
            border-left: 1.0pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl79
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl80
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: 1.0pt solid windowtext;
            border-bottom: none;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl81
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: 1.0pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl82
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl83
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: 1.0pt solid windowtext;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl84
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: none;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl85
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: 1.0pt solid windowtext;
            border-bottom: none;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl86
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: none;
            border-bottom: none;
            border-left: 1.0pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl87
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: none;
            border-left: 1.0pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl88
        {
            mso-style-parent: style0;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: 1.0pt solid windowtext;
            border-bottom: none;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
        }
        .xl89
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
        }
        .xl90
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
        }
        .xl91
        {
            mso-style-parent: style0;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border: .5pt solid windowtext;
        }
        .xl92
        {
            mso-style-parent: style22;
            color: green;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
        }
        .xl93
        {
            mso-style-parent: style22;
            color: green;
            font-size: 20.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: none;
            border-right: none;
            border-bottom: 2.0pt double windowtext;
            border-left: none;
        }
        .xl94
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: .5pt solid windowtext;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl95
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: none;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl96
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
            border-top: .5pt solid windowtext;
            border-right: .5pt solid windowtext;
            border-bottom: .5pt solid windowtext;
            border-left: none;
            background: #CCFFFF;
            mso-pattern: auto none;
        }
        .xl97
        {
            mso-style-parent: style0;
            font-size: 18.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: center;
            vertical-align: middle;
        }
        .xl98
        {
            mso-style-parent: style22;
            color: black;
            font-size: 8.0pt;
            font-weight: 700;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: right;
            vertical-align: middle;
        }
        .xl99
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: 1.0pt solid windowtext;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl100
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: none;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
        }
        .xl101
        {
            mso-style-parent: style0;
            font-size: 8.0pt;
            font-style: italic;
            font-family: Tahoma, sans-serif;
            mso-font-charset: 0;
            text-align: left;
            vertical-align: middle;
            border-top: 1.0pt solid windowtext;
            border-right: 1.0pt solid windowtext;
            border-bottom: 1.0pt solid windowtext;
            border-left: none;
            background: #FFFF99;
            mso-pattern: auto none;
            white-space: normal;
        }
        --></style>
    <!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Req 1</x:Name>
    <x:WorksheetOptions>
     <x:Print>
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>90</x:Scale>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>600</x:VerticalResolution>
     </x:Print>
     <x:PageBreakZoom>60</x:PageBreakZoom>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>4</x:ActiveRow>
       <x:RangeSelection>$A$5:$F$5</x:RangeSelection>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>8955</x:WindowHeight>
  <x:WindowWidth>17835</x:WindowWidth>
  <x:WindowTopX>600</x:WindowTopX>
  <x:WindowTopY>345</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
    <!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="6145"/>
</xml><![endif]-->
</head>
<body link="blue" vlink="purple" class="xl34">
    <table x:str border="0" cellpadding="0" cellspacing="0" width="1126" style='border-collapse: collapse;
        table-layout: fixed; width: 845pt'>
        <col class="xl34" width="69" style='mso-width-source: userset; mso-width-alt: 2523;
            width: 52pt'>
        <col class="xl34" width="101" style='mso-width-source: userset; mso-width-alt: 3693;
            width: 76pt'>
        <col class="xl34" width="240" style='mso-width-source: userset; mso-width-alt: 8777;
            width: 180pt'>
        <col class="xl34" width="105" style='mso-width-source: userset; mso-width-alt: 3840;
            width: 79pt'>
        <col class="xl34" width="136" style='mso-width-source: userset; mso-width-alt: 4973;
            width: 102pt'>
        <col class="xl34" width="135" style='mso-width-source: userset; mso-width-alt: 4937;
            width: 101pt'>
        <col class="xl34" width="84" style='mso-width-source: userset; mso-width-alt: 3072;
            width: 63pt'>
        <col class="xl34" width="64" span="4" style='width: 48pt'>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td colspan="2" rowspan="3" height="72" class="xl92" width="170" style='border-bottom: 2.0pt double black;
                height: 54.0pt; width: 128pt'>
                <v:shape id="_x0000_s2051" type="#_x0000_t75" style='position: absolute; margin-left: 13.5pt;
                    margin-top: 5.25pt; width: 104.25pt; height: 42pt; z-index: 1'>
                    <v:imagedata src="..\..\..\system\binary\ViewFile.aspx?img_pk=<%=dt.Rows[0]["tco_bpphoto_pk"]%>&table_name=tco_bpphoto"
                        o:title="image001" />
                    <x:clientdata objecttype="Pict">
                        <x:sizewithcells />
                        <x:cf>Bitmap</x:cf>
                    </x:clientdata>
                </v:shape>
            </td>
            <td class="xl39" width="240" style='width: 180pt'>
                <%= dt.Rows[0]["partner_name"]%>
            </td>
            <td class="xl40" width="105" style='width: 79pt'>
            </td>
            <td class="xl40" width="136" style='width: 102pt'>
            </td>
            <td class="xl39" width="135" style='width: 101pt'>
                Tel:
                <%= dt.Rows[0]["phone_no"]%>
            </td>
            <td class="xl34" width="84" style='width: 63pt'>
            </td>
            <td class="xl41" width="64" style='width: 48pt'>
            </td>
            <td class="xl41" width="64" style='width: 48pt'>
            </td>
            <td class="xl41" width="64" style='width: 48pt'>
            </td>
            <td class="xl41" width="64" style='width: 48pt'>
            </td>
        </tr>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl39" colspan="2" style='height: 18.0pt; mso-ignore: colspan'>
                <%= dt.Rows[0]["addr1"]%>
            </td>
            <td class="xl40">
            </td>
            <td class="xl39">
                Fax:
                <%= dt.Rows[0]["fax_no"]%>
            </td>
            <td class="xl34">
            </td>
            <td colspan="4" class="xl41" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" class="xl89" style='height: 18.0pt'>
                MST:
                <%= dt.Rows[0]["tax_code"]%>
            </td>
            <td class="xl90">
                &nbsp;
            </td>
            <td class="xl90">
                &nbsp;
            </td>
            <td class="xl90">
                &nbsp;
            </td>
            <td class="xl40">
            </td>
            <td colspan="4" class="xl41" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="16" style='mso-height-source: userset; height: 12.0pt'>
            <td height="16" colspan="2" class="xl42" style='height: 12.0pt; mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
            <td class="xl43">
            </td>
            <td colspan="4" class="xl41" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="40" style='mso-height-source: userset; height: 30.0pt'>
            <td colspan="6" height="40" class="xl97" style='height: 30.0pt' x:str="MAINTENANCE REQUEST ">
                MAINTENANCE REQUEST<span style='mso-spacerun: yes'> </span>
            </td>
            <td class="xl44">
            </td>
            <td colspan="4" class="xl41" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl34" style='height: 12.75pt'>
            </td>
            <td colspan="3" class="xl35" style='mso-ignore: colspan'>
            </td>
            <td colspan="2" class="xl98">
                Print date:
                <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm") %>
            </td>
            <td class="xl35">
            </td>
            <td colspan="4" class="xl45" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl76" colspan="2" style='height: 18.75pt; mso-ignore: colspan'>
                Request Info
            </td>
            <td colspan="3" class="xl35" style='mso-ignore: colspan'>
            </td>
            <td class="xl43">
            </td>
            <td class="xl35">
            </td>
            <td colspan="4" class="xl45" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl62" style='height: 18.75pt; mso-ignore: colspan'>
                Req No <font class="font18">:<span style='mso-spacerun: yes'> </span></font>
            </td>
            <td class="xl63" style='border-left: none'>
                <%= dt1.Rows[0]["req_no"]%>
            </td>
            <td class="xl62" style='border-left: none'>
                Requestor:
                <%= dt1.Rows[0]["req_emp_name"]%>
            </td>
            <td class="xl69">
                &nbsp;
            </td>
            <td class="xl69">
                &nbsp;
            </td>
            <td class="xl71">
                &nbsp;
            </td>
            <td class="xl35">
            </td>
            <td colspan="4" class="xl41" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="33" style='mso-height-source: userset; height: 24.75pt'>
            <td height="33" class="xl62" style='height: 24.75pt; border-top: none'>
                Req Date:
            </td>
            <td class="xl63" style='border-top: none'>
                <span style='mso-spacerun: yes'></span>
                <%= dt1.Rows[0]["req_date"]%>
            </td>
            <td class="xl62" style='border-top: none; border-left: none'>
                Req Type:
                <%= dt1.Rows[0]["req_type"]%>
            </td>
            <td class="xl72" style='border-top: none'>
            </td>
            <td class="xl72" style='border-top: none'>
                &nbsp;
            </td>
            <td class="xl73" style='border-top: none'>
                &nbsp;
            </td>
            <td class="xl25">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl34" style='height: 18.75pt'>
            </td>
            <td colspan="6" class="xl35" style='mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="26" style='mso-height-source: userset; height: 19.5pt'>
            <td height="26" class="xl37" style='height: 19.5pt'>
                Process
            </td>
            <td class="xl68">
                <%= dt1.Rows[0]["process_name"]%>
            </td>
            <td class="xl69">
                &nbsp;
            </td>
            <td class="xl70">
                &nbsp;
            </td>
            <td class="xl69">
                &nbsp;
            </td>
            <td class="xl71">
                &nbsp;
            </td>
            <td class="xl35">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="16" style='mso-height-source: userset; height: 12.0pt'>
            <td height="16" class="xl37" style='height: 12.0pt'>
            </td>
            <td colspan="2" class="xl35" style='mso-ignore: colspan'>
            </td>
            <td class="xl46">
            </td>
            <td colspan="3" class="xl35" style='mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl37" style='height: 18.75pt'>
                Charger
            </td>
            <td class="xl38">
                <%= dt1.Rows[0]["charger_name"]%>
            </td>
            <td class="xl66">
                M/P
            </td>
            <td class="xl67">
                <%= dt1.Rows[0]["mp"]%>
            </td>
            <td class="xl66">
                Estimate Cost
            </td>
            <td class="xl38">
                <%= dt1.Rows[0]["estimate_cost"]%>
            </td>
            <td class="xl35">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" colspan="2" class="xl37" style='height: 18.75pt; mso-ignore: colspan'>
            </td>
            <td class="xl66">
            </td>
            <td class="xl46">
            </td>
            <td colspan="2" class="xl37" style='mso-ignore: colspan'>
            </td>
            <td class="xl35">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl65" style='height: 18.75pt'>
                No.
            </td>
            <td class="xl65" style='border-left: none'>
                Asset Code
            </td>
            <td class="xl65" style='border-left: none'>
                Asset Name
            </td>
            <td class="xl65" style='border-left: none'>
                Asset Group
            </td>
            <td class="xl65" style='border-left: none'>
                Brand
            </td>
            <td class="xl65" style='border-left: none'>
                Manufacture Year
            </td>
            <td class="xl47">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%
            for (int i = 0; i < dt1.Rows.Count; i++)
            {
        %>
        <tr height="27" style='mso-height-source: userset; height: 20.25pt'>
            <td height="27" class="xl91" style='height: 20.25pt; border-top: none' x:num>
                <%= i+1 %>
            </td>
            <td class="xl53" style='border-top: none; border-left: none'>
                <%= dt1.Rows[i]["asset_code"]%>
            </td>
            <td class="xl54" style='border-top: none; border-left: none'>
                <%= dt1.Rows[i]["asset_name"]%>
            </td>
            <td class="xl54" style='border-top: none; border-left: none'>
                <%= dt1.Rows[i]["asset_group"]%>
            </td>
            <td class="xl54" style='border-top: none; border-left: none'>
                <%= dt1.Rows[i]["brand"]%>
            </td>
            <td class="xl64" style='border-top: none; border-left: none' x:num>
                <%= dt1.Rows[i]["manufacture_year"]%>
            </td>
            <td class="xl35">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <% } %>
        <tr height="16" style='mso-height-source: userset; height: 12.0pt'>
            <td height="16" class="xl34" style='height: 12.0pt'>
            </td>
            <td class="xl48">
            </td>
            <td colspan="5" class="xl35" style='mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="77" style='mso-height-source: userset; height: 57.75pt'>
            <td height="77" class="xl37" style='height: 57.75pt'>
                Description
            </td>
            <td colspan="5" class="xl99" width="717" style='border-right: 1.0pt solid black;
                width: 538pt'>
                <%= dt1.Rows[0]["req_desc"]%>
            </td>
            <td class="xl35">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl26" style='height: 18.75pt'>
                Task List
            </td>
            <td colspan="5" class="xl26" style='mso-ignore: colspan'>
            </td>
            <td class="xl48">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl65" style='height: 18.75pt'>
                Task Type
            </td>
            <td colspan="4" class="xl94" style='border-right: .5pt solid black; border-left: none'>
                Task Name
            </td>
            <td class="xl65" style='border-left: none'>
                Remark
            </td>
            <td class="xl26">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <% 
            string p_ma_process_pk = dt1.Rows[0]["ma_process_pk"].ToString();
            string p_ma_req_m_pk = dt1.Rows[0]["req_pk"].ToString();
            para = "'" + p_ma_process_pk + "','" + p_ma_req_m_pk + "'";
            dt2 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpma00050_2", para);
            dt3 = ESysLib.TableReadOpenCursor("PROD.sp_rpt_fpma00050_3", para);
            for (int j = 0; j < dt2.Rows.Count; j++)
            {
        %>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl55" style='height: 18.75pt; border-top: none'>
                <%= dt2.Rows[j]["ma_task_type_name"]%>
            </td>
            <td class="xl59" style='border-top: none; border-left: none'>
                <%= dt2.Rows[j]["ma_task_name"]%>
            </td>
            <td class="xl60" style='border-top: none'>
            </td>
            <td class="xl60" style='border-top: none'>
            </td>
            <td class="xl61" style='border-top: none'>
            </td>
            <td class="xl55" style='border-top: none; border-left: none'>
                <%= dt2.Rows[j]["description"]%>
            </td>
            <td class="xl26">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%} %>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl26" style='height: 18.75pt'>
                Maintenance Tools</span>
            </td>
            <td class="xl27">
                &nbsp;
            </td>
            <td class="xl27">
                &nbsp;
            </td>
            <td class="xl27">
                &nbsp;
            </td>
            <td class="xl27">
                &nbsp;
            </td>
            <td class="xl27">
                &nbsp;
            </td>
            <td class="xl57">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr class="xl29" height="31" style='mso-height-source: userset; height: 23.25pt'>
            <td height="31" class="xl28" width="69" style='height: 23.25pt; width: 52pt'>
                No
            </td>
            <td class="xl56" width="101" style='border-top: none; border-left: none; width: 76pt'>
                Item Code
            </td>
            <td class="xl56" width="240" style='border-top: none; width: 180pt'>
                Item Name
            </td>
            <td class="xl28" width="105" style='border-top: none; width: 79pt'>
                UOM
            </td>
            <td class="xl28" width="136" style='border-top: none; border-left: none; width: 102pt'>
                Qty
            </td>
            <td class="xl28" width="135" style='border-top: none; border-left: none; width: 101pt'>
                Remark
            </td>
            <td colspan="5" class="xl29" style='mso-ignore: colspan'>
            </td>
        </tr>
        <% 
            for (int z = 0; z < dt3.Rows.Count; z++)
            {
        %>
        <tr class="xl33" height="31" style='mso-height-source: userset; height: 23.25pt'>
            <td height="31" class="xl30" width="69" style='height: 23.25pt; border-top: none;
                width: 52pt' x:num>
                <%= dt3.Rows[z]["seq"]%>
            </td>
            <td class="xl36" width="101" style='border-top: none; border-left: none; width: 76pt'>
                <%= dt3.Rows[z]["item_code"]%>
            </td>
            <td class="xl36" width="240" style='border-top: none; border-left: none; width: 180pt'>
                <%= dt3.Rows[z]["item_name"]%>
            </td>
            <td class="xl30" width="105" style='border-top: none; border-left: none; width: 79pt'>
                <%= dt3.Rows[z]["uom"]%>
            </td>
            <td class="xl31" width="136" style='border-top: none; border-left: none; width: 102pt'
                x:num>
                <%= dt3.Rows[z]["qty"]%>
            </td>
            <td class="xl32" width="135" style='border-top: none; border-left: none; width: 101pt'>
                <%= dt3.Rows[z]["description"]%>
            </td>
            <td colspan="5" class="xl33" style='mso-ignore: colspan'>
            </td>
        </tr>
        <%} %>
        <tr class="xl40" height="24" style='mso-height-source: userset; height: 18.0pt'>
            <td height="24" colspan="3" class="xl35" style='height: 18.0pt; mso-ignore: colspan'>
            </td>
            <td colspan="2" class="xl34" style='mso-ignore: colspan'>
            </td>
            <td class="xl35">
            </td>
            <td class="xl49">
            </td>
            <td colspan="4" class="xl40" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="18" style='height: 13.5pt'>
            <td height="18" class="xl34" style='height: 13.5pt'>
                Response
            </td>
            <td colspan="3" class="xl34" style='mso-ignore: colspan'>
            </td>
            <td class="xl34" colspan="2" style='mso-ignore: colspan'>
                Authorized and Approved by:
            </td>
            <td class="xl35">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl86" style='height: 12.75pt'>
                Ma Date:
            </td>
            <td class="xl77">
                <%= dt1.Rows[0]["ma_date"]%>
            </td>
            <td class="xl88">
                Amount:
                <%= dt1.Rows[0]["ma_amount"]%>
            </td>
            <td colspan="2" class="xl34" style='mso-ignore: colspan'>
            </td>
            <td colspan="2" class="xl35" style='mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" class="xl87" colspan="2" style='height: 12.75pt; mso-ignore: colspan'>
                Description:
                <%= dt1.Rows[0]["response"]%>
            </td>
            <td class="xl85">
                &nbsp;
            </td>
            <td class="xl34">
            </td>
            <td class="xl64">
                Request by
            </td>
            <td class="xl64" style='border-left: none'>
                Approve by
            </td>
            <td colspan="5" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl78" style='height: 18.75pt'>
                &nbsp;
            </td>
            <td class="xl79">
                &nbsp;
            </td>
            <td class="xl80">
                &nbsp;
            </td>
            <td class="xl34">
            </td>
            <td class="xl74">
                &nbsp;
            </td>
            <td class="xl74" style='border-left: none'>
                &nbsp;
            </td>
            <td colspan="5" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl78" style='height: 18.75pt'>
                &nbsp;
            </td>
            <td class="xl79">
                &nbsp;
            </td>
            <td class="xl80">
                &nbsp;
            </td>
            <td class="xl34">
            </td>
            <td class="xl74">
                &nbsp;
            </td>
            <td class="xl74" style='border-left: none'>
                &nbsp;
            </td>
            <td colspan="5" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl78" style='height: 18.75pt'>
                &nbsp;
            </td>
            <td class="xl79">
                &nbsp;
            </td>
            <td class="xl80">
                &nbsp;
            </td>
            <td class="xl34">
            </td>
            <td class="xl74">
                &nbsp;
            </td>
            <td class="xl74" style='border-left: none'>
                &nbsp;
            </td>
            <td colspan="5" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
            <td height="25" class="xl81" style='height: 18.75pt'>
                &nbsp;
            </td>
            <td class="xl82">
                &nbsp;
            </td>
            <td class="xl83">
                &nbsp;
            </td>
            <td class="xl34">
            </td>
            <td class="xl75">
                &nbsp;
            </td>
            <td class="xl75" style='border-left: none'>
                &nbsp;
            </td>
            <td colspan="5" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="7" class="xl50" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="20" style='height: 15.0pt'>
            <td height="20" colspan="4" class="xl51" style='height: 15.0pt; mso-ignore: colspan'>
            </td>
            <td colspan="2" class="xl35" style='mso-ignore: colspan'>
            </td>
            <td class="xl50">
            </td>
            <td colspan="4" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="11" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
        </tr>
        <tr height="17" style='height: 12.75pt'>
            <td height="17" colspan="3" class="xl34" style='height: 12.75pt; mso-ignore: colspan'>
            </td>
            <td class="xl52">
            </td>
            <td colspan="7" class="xl34" style='mso-ignore: colspan'>
            </td>
        </tr>
        <![if supportMisalignedColumns]>
        <tr height="0" style='display: none'>
            <td width="69" style='width: 52pt'>
            </td>
            <td width="101" style='width: 76pt'>
            </td>
            <td width="240" style='width: 180pt'>
            </td>
            <td width="105" style='width: 79pt'>
            </td>
            <td width="136" style='width: 102pt'>
            </td>
            <td width="135" style='width: 101pt'>
            </td>
            <td width="84" style='width: 63pt'>
            </td>
            <td width="64" style='width: 48pt'>
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
