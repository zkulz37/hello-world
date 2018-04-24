<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%  ESysLib.SetUser("acnt");
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
	string p_from_dt = "";
	string p_to_dt = "";
	string p_com_pk = "";
	p_from_dt = Request["from_dt"];
	p_to_dt = Request["to_dt"];
	p_com_pk = Request["company_pk"];
    string SQL = "";
    SQL
        = "select t.stocktr_no, t.tac_hgtrh_pk, (select w.wh_name from inv.tin_warehouse w where w.pk = t.tin_warehouse_pk) wh_name, " +
            "    to_char(to_date(t.tr_date, 'YYYYMMDD'), 'DD/MM/YYYY') tr_date, i.item_code, i.item_name, t.item_uom, t.output_qty,   " +
            "    round(t.out_uprice, 5) uprice, i.WEIGHT, t.out_amt amt_book, t.out_amt amt_vnd,  " +
            "    ( select pl_nm from v_abplcenter where tac_abplcenter_pk  in ( select tac_abplcenter_pk from inv.tin_warehouse where pk = m.in_wh_pk) ) project_in,  " +
            "       ( select pl_nm from v_abplcenter where tac_abplcenter_pk  = t.tac_abplcenter_pk) project_out, (select ac_cd from tac_abacctcode where pk = i.tac_abacctcode_pk ) remark " +
            "from tac_stocktr t, comm.tco_item i, inv.st_transfer_d d, inv.st_transfer_m m " +
            "where t.tr_date between '" + p_from_dt + "' and '" + p_to_dt + "' " +
            "and t.tr_status in ('2', '0') " +
            "and t.del_if = 0 " +
            "and t.tco_company_pk like '" + p_com_pk + "' " +
            "and t.trout_type = '11' " +
            "and t.tco_item_pk = i.pk " +
            "and i.del_if = 0 " +
            "and t.tr_table_nm = 'ST_TRANSFER_D' " +
            "and t.tr_table_pk = d.pk " +            
            "and d.st_transfer_m_pk = m.pk " +            
            "order by 3, 1, 4 asc ";
    DataTable dt = new DataTable();
	dt = ESysLib.TableReadOpen(SQL);	
	string ls_from_to_dt = p_from_dt.Substring(6, 2) + "/" + p_from_dt.Substring(4, 2) + "/" + p_from_dt.Substring(0, 4);
	ls_from_to_dt += " - " + p_to_dt.Substring(6, 2) + "/" + p_to_dt.Substring(4, 2) + "/" + p_to_dt.Substring(0, 4);
	int i;	
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="fmgf00220_Transfer_files/filelist.xml">
<style id="Book3_23646_Styles"><!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl2223646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:16.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2323646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2423646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2523646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:bottom;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2623646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2723646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2823646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl2923646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3023646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3123646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3223646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3323646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:VNI-Times;
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3423646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3523646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3623646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3723646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:none;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl3823646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:normal;}
.xl3923646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4023646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\.00)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4123646
	{padding-top:1px;
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
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4223646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4323646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4423646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4523646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4623646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4723646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4823646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl4923646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:General;
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5023646
	{padding-top:1px;
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
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5123646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5223646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:Standard;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5323646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5423646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\\\(\#\,\#\#0\\\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5523646
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:red;
	font-size:8.0pt;
	font-weight:700;
	font-style:italic;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl5523647
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0\.00";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl5523648
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman";
	mso-generic-font-family:auto;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0\.00_\)\;_\(* \\\(\#\,\#\#0\.00\\\)\;_\(* \0022-\0022??_\)\;_\(\@_\)";
	text-align:general;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt hairline windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
	
--></style>
</head>

<body>
<!--[if !excel]>&nbsp;&nbsp;<![endif]-->
<!--The following information was generated by Microsoft Office Excel's Publish
as Web Page wizard.-->
<!--If the same item is republished from Excel, all information between the DIV
tags will be replaced.-->
<!----------------------------->
<!--START OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD -->
<!----------------------------->

<div id="Book3_23646" align=center x:publishsource="Excel">

<table x:str border=0 cellpadding=0 cellspacing=0 width=1666 class=xl4123646
 style='border-collapse:collapse;table-layout:fixed;width:1252pt'>
 <col class=xl4123646 width=78 span=2 style='mso-width-source:userset;
 mso-width-alt:2852;width:59pt'>
 <col class=xl4123646 width=92 style='mso-width-source:userset;mso-width-alt:
 3364;width:69pt'>
 <col class=xl4123646 width=73 style='mso-width-source:userset;mso-width-alt:
 2669;width:55pt'>
 <col class=xl4123646 width=78 style='mso-width-source:userset;mso-width-alt:
 2852;width:59pt'>
 <col class=xl4123646 width=181 style='mso-width-source:userset;mso-width-alt:
 6619;width:136pt'>
 <col class=xl4123646 width=42 style='mso-width-source:userset;mso-width-alt:
 1536;width:32pt'>
 <col class=xl4123646 width=43 style='mso-width-source:userset;mso-width-alt:
 1572;width:32pt'>
 <col class=xl4123646 width=60 style='mso-width-source:userset;mso-width-alt:
 2194;width:45pt'>
 <col class=xl4123646 width=65 style='mso-width-source:userset;mso-width-alt:
 2377;width:49pt'>
 <col class=xl4123646 width=88 style='mso-width-source:userset;mso-width-alt:
 3218;width:66pt'>
 <col class=xl4123646 width=84 style='mso-width-source:userset;mso-width-alt:
 3072;width:63pt'>
 <col class=xl5023646 width=88 style='mso-width-source:userset;mso-width-alt:
 3218;width:66pt'>
 <col class=xl4123646 width=84 span=2 style='mso-width-source:userset;
 mso-width-alt:3072;width:63pt'>
 <col class=xl4123646 width=64 span=7 style='width:48pt'>
 <tr class=xl2323646 height=27 style='height:20.25pt'>
  <td height=27 class=xl2223646 colspan=6 align=left width=580
  style='height:20.25pt;width:437pt'>LIST OF MATERIAL TRANSFER PROJECT</td>
  <td class=xl2223646 width=42 style='width:32pt'></td>
  <td class=xl2223646 width=43 style='width:32pt'></td>
  <td class=xl2223646 width=60 style='width:45pt'></td>
  <td class=xl2223646 width=65 style='width:49pt'></td>
  <td class=xl2223646 width=88 style='width:66pt'></td>
  <td class=xl2223646 width=84 style='width:63pt'></td>
  <td class=xl2423646 width=88 style='width:66pt'></td>
  <td class=xl2323646 width=84 style='width:63pt'></td>
  <td class=xl2323646 width=84 style='width:63pt'></td>
  <td class=xl2323646 width=64 style='width:48pt'></td>
  <td class=xl2323646 width=64 style='width:48pt'></td>
  <td class=xl2323646 width=64 style='width:48pt'></td>
  <td class=xl2323646 width=64 style='width:48pt'></td>
  <td class=xl2323646 width=64 style='width:48pt'></td>
  <td class=xl2323646 width=64 style='width:48pt'></td>
  <td class=xl2323646 width=64 style='width:48pt'></td>
 </tr>
 <tr class=xl2323646 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl2523646 align=left style='height:20.1pt'>PERIOD:</td>
  <td class=xl2323646><%=ls_from_to_dt%></td>
  <td class=xl2323646></td>
  <td class=xl2623646></td>
  <td class=xl2323646></td>
  <td class=xl2323646></td>
  <td class=xl2623646></td>
  <td class=xl2323646></td>
  <td class=xl2623646></td>
  <td class=xl2723646></td>
  <td class=xl2423646></td>
  <td class=xl2723646></td>
  <td class=xl2423646></td>
  <td class=xl2723646></td>
  <td class=xl2723646></td>
  <td class=xl2323646></td>
  <td class=xl2323646></td>
  <td class=xl2323646></td>
  <td class=xl2323646></td>
  <td class=xl2323646></td>
  <td class=xl2323646></td>
  <td class=xl2323646></td>
 </tr>
 <tr class=xl3323646 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl2823646 style='height:20.1pt'>Voucher No.</td>
  <td class=xl2823646 style='border-left:none'>Seq</td>
  <td class=xl2823646 style='border-left:none'>Warehouse No.</td>
  <td class=xl2923646>Date</td>
  <td class=xl3023646>Code</td>
  <td class=xl2923646>Name of material</td>
  <td class=xl2923646>Unit</td>
  <td class=xl2923646 x:str="Q'ty ">Q'ty<span style='mso-spacerun:yes'> </span></td>
  <td class=xl2923646>Unit price</td>
  <td class=xl3123646 x:str="Weight "><span
  style='mso-spacerun:yes'> </span>Weight<span
  style='mso-spacerun:yes'>  </span></td>
  <td class=xl3223646 x:str="Amount _ book"><span
  style='mso-spacerun:yes'> </span>Amount _ book<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl3123646 x:str="Amount _ vnd"><span
  style='mso-spacerun:yes'> </span>Amount _ vnd<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl3223646 x:str="Project In"><span
  style='mso-spacerun:yes'> </span>Project In<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl3123646 x:str="Project out"><span
  style='mso-spacerun:yes'> </span>Project out<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl3123646 x:str="Remark"><span
  style='mso-spacerun:yes'> </span>Remark<span
  style='mso-spacerun:yes'> </span></td>
  <td class=xl3323646></td>
  <td class=xl3323646></td>
  <td class=xl3323646></td>
  <td class=xl3323646></td>
  <td class=xl3323646></td>
  <td class=xl3323646></td>
  <td class=xl3323646></td>
 </tr>
 <%
	decimal l_qty = 0, l_tramt = 0, l_bkamt = 0;
	for( i = 0; i < dt.Rows.Count; i++)
	{
		if(dt.Rows[i][7].ToString().Trim() != "")
			l_qty += decimal.Parse(dt.Rows[i][7].ToString());
		if(dt.Rows[i][10].ToString().Trim() != "")
			l_tramt += decimal.Parse(dt.Rows[i][10].ToString());
		if(dt.Rows[i][11].ToString().Trim() != "")
			l_bkamt += decimal.Parse(dt.Rows[i][11].ToString());
			
 %>
 <tr class=xl4223646 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl3423646 style='height:20.1pt'><%=dt.Rows[i][0]%></td>
  <td class=xl3523646><%=dt.Rows[i][1]%></td>
  <td class=xl3523646><%=dt.Rows[i][2]%></td>
  <td class=xl3623646><%=dt.Rows[i][3]%></td>
  <td class=xl3723646 style="border-right:.5pt hairline windowtext;" ><%=dt.Rows[i][4]%></td>
  <td class=xl3823646 width=181 style='width:136pt'><%=dt.Rows[i][5]%></td>
  <td class=xl3623646><%=dt.Rows[i][6]%></td>
  <td class=xl5123646 x:num><%=dt.Rows[i][7]%></td>
  <td class=xl5223646 x:num><%=dt.Rows[i][8]%></td>
  <td class=xl3923646 x:num><%=dt.Rows[i][9]%></td>
  <td class=xl5323646 x:num><%=dt.Rows[i][10]%></td>
  <td class=xl3923646 x:num><%=dt.Rows[i][11]%></td>
  <td class=xl4023646 x:str><%=dt.Rows[i][12]%></td>
  <td class=xl3523646>&nbsp;<%=dt.Rows[i][13]%></td>
  <td class=xl3523646>&nbsp;<%=dt.Rows[i][14]%></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
 </tr>
 <%
	}
 %>
 <tr class=xl4223646 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl3423646 style='height:20.1pt'>&nbsp;</td>
  <td class=xl3523646>&nbsp;</td>
  <td class=xl3523646>&nbsp;</td>
  <td class=xl3623646>&nbsp;</td>
  <td class=xl3723646>&nbsp;</td>
  <td class=xl3823646 width=181 style='width:136pt'>&nbsp;</td>
  <td class=xl3623646>&nbsp;</td>
  <td class=xl5523647 x:num><%=l_qty%></td>
  <td class=xl3623646>&nbsp;</td>
  <td class=xl3923646>&nbsp;</td>
  <td class=xl5523648 x:num><%=l_tramt%></td>
  <td class=xl5523648 x:num><%=l_bkamt%></td>
  <td class=xl4023646>&nbsp;</td>
  <td class=xl3523646>&nbsp;</td>
  <td class=xl3523646>&nbsp;</td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
  <td class=xl4123646></td>
 </tr>
 <tr class=xl4923646 height=26 style='mso-height-source:userset;height:20.1pt'>
  <td height=26 class=xl4323646 style='height:20.1pt'>&nbsp;</td>
  <td class=xl4423646>&nbsp;</td>
  <td class=xl4523646>&nbsp;</td>
  <td class=xl4623646>&nbsp;</td>
  <td class=xl4323646 align=left>Grand Total</td>
  <td class=xl4523646>&nbsp;</td>
  <td class=xl4423646>&nbsp;</td>
  <td class=xl5423646>&nbsp;</td>
  <td class=xl4423646>&nbsp;</td>
  <td class=xl4723646>&nbsp;</td>
  <td class=xl5523646>&nbsp;</td>
  <td class=xl4723646>&nbsp;</td>
  <td class=xl4823646>&nbsp;</td>
  <td class=xl4723646>&nbsp;</td>
  <td class=xl4723646>&nbsp;</td>
  <td class=xl4923646></td>
  <td class=xl4923646></td>
  <td class=xl4923646></td>
  <td class=xl4923646></td>
  <td class=xl4923646></td>
  <td class=xl4923646></td>
  <td class=xl4923646></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=78 style='width:59pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=92 style='width:69pt'></td>
  <td width=73 style='width:55pt'></td>
  <td width=78 style='width:59pt'></td>
  <td width=181 style='width:136pt'></td>
  <td width=42 style='width:32pt'></td>
  <td width=43 style='width:32pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=88 style='width:66pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=84 style='width:63pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--END OF OUTPUT FROM EXCEL PUBLISH AS WEB PAGE WIZARD-->
<!----------------------------->
</body>

</html>