<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%@ Import Namespace = "System"%>
<%@ Import Namespace = "System.Text.RegularExpressions"%>
<% 	
	Response.ContentType = "application/vnd.ms-excel";
	Response.Charset = "utf-8";
	//Response.Buffer = false;
    
%>
<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
            ESysLib.SetUser("acnt");
            string l_kind = Request["p_kind"];
            string l_status = Request["p_status"];
            string l_tco_company_pk = Request["p_tco_company_pk"];
            string l_date_fr = Request["p_date_fr"];
            string l_date_to = Request["p_date_to"];
            string l_date_type = Request["p_date_type"];
            string l_scale = Request["p_scale"];
            string l_lastMonth = "", l_lastYear = "", l_firtMonthlastYear = "", l_curMonthlastYear = "";
            string l_parameter = "'" + l_kind + "','" + l_status + "','" + l_tco_company_pk + "','" + l_date_fr + "','" + l_date_to + "','" + l_date_type + "','" + l_scale + "'";
            DataTable dt = ESysLib.TableReadOpenCursor("ACNT.sp_sel_gfka00210_3_1", l_parameter);  
            if (dt.Rows.Count == 0)
            {
                Response.Write("There is no data");
                Response.End();
            }
            //l_date_fr = l_date_fr.Substring(4, 2)+ "/" + l_date_fr.Substring(0, 4);//2009.08.25
            //l_date_to = l_date_to.Substring(4, 2) + "/" + l_date_to.Substring(0, 4);// +"." + l_dtto.Substring(6, 2);//2009.08.25  
            string SQL1 = " select (TO_CHAR(ADD_MONTHS(TO_DATE('" + l_date_fr + "', 'yyyymmdd'), -1) , 'yyyymmdd')) dtfrom,(TO_CHAR(ADD_MONTHS(TO_DATE('" + l_date_fr + "', 'yyyymmdd'), -12) , 'yyyymmdd')) dtTo,(TO_CHAR(TO_DATE('" + l_date_fr + "', 'yyyymmdd') , 'yyyymmdd')) dtTo1 from dual ";

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
            string l_company = "", l_address = "";
            string SQLAddress = " SELECT  PARTNER_NAME,addr1 FROM TCO_COMPANY WHERE DEL_IF=0 and pk ='" + l_tco_company_pk + "'";
            DataTable dt_f = ESysLib.TableReadOpen(SQLAddress);
            if (dt_f.Rows.Count > 0)
            {
                l_company = dt_f.Rows[0][0].ToString();
                l_address = dt_f.Rows[0][1].ToString();
            }
            string date_dtfr = "", date_dtTo = "";
            string SQLdate = "select TO_CHAR(TO_DATE(' " + l_date_to + " ', 'yyyymmdd') , 'dd.Mon.yyyy') dtTo,TO_CHAR(TO_DATE(' " + l_date_fr + " ', 'yyyymmdd') , 'dd.Mon.yyyy') dtfr  from dual";

            DataTable dtCurrdade = ESysLib.TableReadOpen(SQLdate);
            if (dtCurrdade.Rows.Count > 0)
            {
                date_dtfr = dtCurrdade.Rows[0][1].ToString();
                date_dtTo = dtCurrdade.Rows[0][0].ToString();
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
<link rel=File-List href="gfka00120_mc_fiscalyeartodate6987_files/filelist.xml">
<link rel=Edit-Time-Data
href="gfka00120_mc_fiscalyeartodate6987_files/editdata.mso">
<link rel=OLE-Object-Data
href="gfka00120_mc_fiscalyeartodate6987_files/oledata.mso">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>shvtn04</o:Author>
  <o:LastAuthor>PCVINA002</o:LastAuthor>
  <o:LastPrinted>2009-12-24T03:44:28Z</o:LastPrinted>
  <o:Created>2009-08-03T07:27:09Z</o:Created>
  <o:LastSaved>2009-12-24T03:45:55Z</o:LastSaved>
  <o:Company>admin</o:Company>
  <o:Version>11.5606</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.75in .25in .25in .75in;
	mso-header-margin:.25in;
	mso-footer-margin:.25in;}
.font13
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.font14
	{color:windowtext;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:\BC14\D0D5\CCB4, serif;
	mso-font-charset:129;}
.font17
	{color:black;
	font-size:9.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:\AD74\B9BC, monospace;
	mso-font-charset:129;}
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
.style22
	{mso-number-format:0%;
	mso-style-name:Percent;
	mso-style-id:5;}
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
	padding:0px;
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
.xl39
	{mso-style-parent:style33;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl40
	{mso-style-parent:style33;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl41
	{mso-style-parent:style27;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:right;}
.xl42
	{mso-style-parent:style33;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:right;}
.xl43
	{mso-style-parent:style33;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl44
	{mso-style-parent:style34;
	font-size:12.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl45
	{mso-style-parent:style34;
	font-size:10.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	white-space:nowrap;
	mso-text-control:shrinktofit;}
.xl46
	{mso-style-parent:style22;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"0\.0%";
	text-align:right;}
.xl47
	{mso-style-parent:style27;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";}
.xl48
	{mso-style-parent:style33;
	font-weight:700;
	font-family:\BC14\D0D5\CCB4, serif;
	mso-font-charset:129;
	text-align:center;
	border:.5pt solid windowtext;}
.xl49
	{mso-style-parent:style33;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	border:.5pt solid windowtext;}
.xl50
	{mso-style-parent:style27;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"_\(* \#\,\#\#0_\)\;_\(* \\\(\#\,\#\#0\\\)\;_\(* \0022-\0022_\)\;_\(\@_\)";
	text-align:center;
	border:.5pt solid windowtext;}
.xl51
	{mso-style-parent:style33;
	color:black;
	font-family:\BC14\D0D5\CCB4, serif;
	mso-font-charset:129;
	text-align:left;
	border:.5pt solid windowtext;}
.xl52
	{mso-style-parent:style33;
	color:black;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;
	border:.5pt solid windowtext;}
.xl53
	{mso-style-parent:style27;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	mso-number-format:"\#\,\#\#0_\)\;\[Red\]\\\(\#\,\#\#0\\\)";
	border:.5pt solid windowtext;}
.xl54
	{mso-style-parent:style33;
	font-size:20.0pt;
	font-weight:700;
	text-decoration:underline;
	text-underline-style:single;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	white-space:normal;}
.xl55
	{mso-style-parent:style34;
	font-size:10.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
-->
</style>
<![if !supportAnnotations]><style id="dynCom" type="text/css"><!-- --></style>

<script language="JavaScript"><!--

function msoCommentShow(com_id,anchor_id) {
	if(msoBrowserCheck()) {
	   c = document.all(com_id);
	   a = document.all(anchor_id);
	   if (null != c) {
		var cw = c.offsetWidth;
		var ch = c.offsetHeight;
		var aw = a.offsetWidth;
		var ah = a.offsetHeight;
		var x = a.offsetLeft;
		var y = a.offsetTop;
		var el = a;
		while (el.tagName != "BODY") {
		   el = el.offsetParent;
		   x = x + el.offsetLeft;
		   y = y + el.offsetTop;
		   }		
		var bw = document.body.clientWidth;
		var bh = document.body.clientHeight;
		var bsl = document.body.scrollLeft;
		var bst = document.body.scrollTop;
		if (x + cw + ah/2 > bw + bsl && x + aw - ah/2 - cw >= bsl ) {
		   c.style.left = x + aw - ah / 2 - cw; 
		}
		else {
		   c.style.left = x + ah/2; 
		}
		if (y + ch + ah/2 > bh + bst && y + ah/2 - ch >= bst ) {
	 	   c.style.top = y + ah/2 - ch;
		} 
		else {
		   c.style.top = y + ah/2;
		}
		c.style.visibility = "visible";
	   }
	}
}

function msoCommentHide(com_id) {
	if(msoBrowserCheck()) {
	  c = document.all(com_id)
	  if (null != c) {
	    c.style.visibility = "hidden";
	    c.style.left = "-10000";
	    c.style.top = "-10000";
	  }
	}
}

function msoBrowserCheck() {
 ms=navigator.appVersion.indexOf("MSIE");
 vers = navigator.appVersion.substring(ms+5, ms+6);
 ie4 = (ms>0) && (parseInt(vers) >=4);
 return ie4
}

if (msoBrowserCheck()) {
document.styleSheets.dynCom.addRule(".msocomspan1","position:absolute");
document.styleSheets.dynCom.addRule(".msocomspan2","position:absolute");
document.styleSheets.dynCom.addRule(".msocomspan2","left:-1.5ex");
document.styleSheets.dynCom.addRule(".msocomspan2","width:2ex");
document.styleSheets.dynCom.addRule(".msocomspan2","height:0.5em");
document.styleSheets.dynCom.addRule(".msocomanch","font-size:0.5em");
document.styleSheets.dynCom.addRule(".msocomanch","color:red");
document.styleSheets.dynCom.addRule(".msocomhide","display: none");
document.styleSheets.dynCom.addRule(".msocomtxt","visibility: hidden");
document.styleSheets.dynCom.addRule(".msocomtxt","position: absolute");        
document.styleSheets.dynCom.addRule(".msocomtxt","top:-10000");         
document.styleSheets.dynCom.addRule(".msocomtxt","left:-10000");         
document.styleSheets.dynCom.addRule(".msocomtxt","width: 33%");                 
document.styleSheets.dynCom.addRule(".msocomtxt","background: infobackground");
document.styleSheets.dynCom.addRule(".msocomtxt","color: infotext");
document.styleSheets.dynCom.addRule(".msocomtxt","border-top: 1pt solid threedlightshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","border-right: 2pt solid threedshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","border-bottom: 2pt solid threedshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","border-left: 1pt solid threedlightshadow");
document.styleSheets.dynCom.addRule(".msocomtxt","padding: 3pt 3pt 3pt 3pt");
document.styleSheets.dynCom.addRule(".msocomtxt","z-index: 100");
}

// -->
</script>
<![endif]><!--[if gte mso 9]><xml>
 <x:ExcelWorkbook>
  <x:ExcelWorksheets>
   <x:ExcelWorksheet>
    <x:Name>Manufacturing Cost Statement</x:Name>
    <x:WorksheetOptions>
     <x:DefaultRowHeight>300</x:DefaultRowHeight>
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
       <x:ActiveRow>17</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext="edit" spidmax="4097"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="3"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=730 style='border-collapse:
 collapse;table-layout:fixed;width:548pt'>
 <col class=xl39 width=230 style='mso-width-source:userset;mso-width-alt:6542;
 width:173pt'>
 <col class=xl43 width=349 style='mso-width-source:userset;mso-width-alt:9927;
 width:262pt'>
 <col class=xl39 width=151 style='mso-width-source:userset;mso-width-alt:4295;
 width:113pt'>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 width=230 style='height:15.0pt;width:173pt'><%=l_company %></td>
  <td class=xl43 width=349 style='width:262pt'></td>
  <td class=xl39 width=151 style='width:113pt'></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'><%=l_address %></td>
  <td class=xl43></td>
  <td class=xl39></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'>Tax code:</td>
  <td class=xl43></td>
  <td class=xl39></td>
 </tr>
 <tr height=34 style='height:25.5pt'>
  <td colspan=3 height=34 class=xl54 width=730 style='height:25.5pt;width:548pt'>MANUFACTURING
  COST STATEMENT</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td colspan=3 height=22 class=xl55 style='height:17.1pt'>From <%=date_dtfr %><span
  style='mso-spacerun:yes'>  </span>To <%=date_dtTo%></td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl44 style='height:17.1pt'></td>
  <td class=xl45></td>
  <td class=xl46>Unit:  <%=l_Unit%>  VND</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl48 style='height:17.1pt'>&#44396;<font class="font13"><span
  style='mso-spacerun:yes'>   </span></font><font class="font14">&#48516;</font></td>
  <td class=xl49 style='border-left:none'>Classfication</td>
  <td class=xl50 style='border-left:none' x:str="Amount"><span
  style='mso-spacerun:yes'> </span>Amount<span
  style='mso-spacerun:yes'> </span></td>
 </tr>
 <%
     string strBegin = "";
     string strEnd = "";
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         strBegin = "";
         strEnd = "";
         if (dt.Rows[i][11].ToString() == "B")
         {
            
             strBegin = "<b>";
             strEnd = "</b>";
         }
  %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 class=xl51 style='height:17.1pt;border-top:none'><%=strBegin %><%= dt.Rows[i][2].ToString()%><%=strEnd%></td>
  <td class=xl52 style='border-top:none;border-left:none'><%=strBegin %><%= dt.Rows[i][1].ToString()%><%=strEnd%></td>
  <td class=xl53 align=right style='border-top:none;border-left:none' x:num><%=strBegin %><%= dt.Rows[i][9].ToString()%><%=strEnd%></td>
 </tr>
  <%
     } %>
 <tr height=22 style='mso-height-source:userset;height:17.1pt'>
  <td height=22 colspan=2 class=xl40 style='height:17.1pt;mso-ignore:colspan'></td>
  <td class=xl47></td>
 </tr>
 <tr class=xl43 height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt' x:str="Prepared by ">Prepared
  by<span style='mso-spacerun:yes'> </span></td>
  <td class=xl40></td>
  <td class=xl41 x:str=" Approved by"><span style='mso-spacerun:yes'> 
  </span>Approved by<span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr class=xl43 height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'
  x:str="Chief Accountant           ">Chief Accountant<span
  style='mso-spacerun:yes'>           </span></td>
  <td class=xl43></td>
  <td class=xl42>General Director</td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl40 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl40></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl39></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl39></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl39></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl39></td>
 </tr>
 <tr height=20 style='height:15.0pt'>
  <td height=20 class=xl39 style='height:15.0pt'></td>
  <td class=xl43></td>
  <td class=xl39></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=230 style='width:173pt'></td>
  <td width=349 style='width:262pt'></td>
  <td width=151 style='width:113pt'></td>
 </tr>
 <![endif]>
</table>

<div style='mso-element:comment-list'><![if !supportAnnotations]>

<hr class=msocomhide align=left size=1 width="33%">

<![endif]>

<div style='mso-element:comment'><![if !supportAnnotations]>

<div id="_com_1" class=msocomtxt
onmouseover="msoCommentShow('_com_1','_anchor_1')"
onmouseout="msoCommentHide('_com_1')" language=JavaScript><![endif]>

<div><![if !supportAnnotations]><a class=msocomhide href="#_msoanchor_1"
name="_msocom_1">[1]</a><![endif]><!--[if gte mso 9]><xml>
 <v:shapetype id="_x0000_t202" coordsize="21600,21600" o:spt="202" path="m,l,21600r21600,l21600,xe">
  <v:stroke joinstyle="miter"/>
  <v:path gradientshapeok="t" o:connecttype="rect"/>
 </v:shapetype><v:shape id="_x0000_s3073" type="#_x0000_t202" style='position:absolute;
  margin-left:183.75pt;margin-top:-641.25pt;width:96.75pt;height:64.5pt;
  z-index:1;visibility:hidden' fillcolor="infoBackground [80]" o:insetmode="auto">
  <v:fill color2="infoBackground [80]"/>
  <v:shadow on="t" color="black" obscured="t"/>
  <v:path o:connecttype="none"/>
  <v:textbox style='mso-direction-alt:auto'/>
  <x:ClientData ObjectType="Note">
   <x:MoveWithCells/>
   <x:SizeWithCells/>
   <x:AutoFill>False</x:AutoFill>
   <x:Row>7</x:Row>
   <x:Column>0</x:Column>
   <x:Author>user</x:Author>
  </x:ClientData>
 </v:shape></xml><![endif]--><![if !vml]><span style='mso-ignore:vglayout'><![endif]>

<div v:shape="_x0000_s3073" style='padding:.75pt 0pt 0pt .75pt;text-align:left'
class=shape><font class="font17">user:152100 + 152200 + 152300</font></div>

<![if !vml]></span><![endif]></div>

<![if !supportAnnotations]></div>

<![endif]></div>

</div>

</body>

</html>
