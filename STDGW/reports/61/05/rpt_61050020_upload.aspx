<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<%  ESysLib.SetUser(Session["APP_DBUSER"].ToString());
	Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<% string p_Project_Pk = Request["Project_pk"];
   string p_tecps_orderingconttype_pk = Request["tecps_orderingconttype_pk"]; %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="kpcs312_upload_files/filelist.xml">
<link rel=Edit-Time-Data href="kpcs312_upload_files/editdata.mso">
<link rel=OLE-Object-Data href="kpcs312_upload_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>KENZIE</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-07-11T02:41:44Z</o:LastPrinted>
  <o:Created>2011-07-11T02:08:00Z</o:Created>
  <o:LastSaved>2011-07-12T08:45:07Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.52in .5in .49in 0in;
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
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	white-space:normal;}
.xl25
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl27
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl28
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl29
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl30
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl31
	{mso-style-parent:style0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;}
.xl33
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	white-space:normal;}
.xl34
	{mso-style-parent:style0;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl35
	{mso-style-parent:style0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;}
.xl36
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl37
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid black;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl38
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl39
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl40
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#99CCFF;
	mso-pattern:auto none;
	white-space:normal;}
.xl41
	{mso-style-parent:style0;
	font-weight:700;
	font-family:Arial, sans-serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:none;
	border-left:.5pt solid windowtext;
	background:#99CCFF;
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
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:Scale>44</x:Scale>
      <x:HorizontalResolution>200</x:HorizontalResolution>
      <x:VerticalResolution>200</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:FreezePanes/>
     <x:FrozenNoSplit/>
     <x:SplitHorizontal>2</x:SplitHorizontal>
     <x:TopRowBottomPane>2</x:TopRowBottomPane>
     <x:SplitVertical>7</x:SplitVertical>
     <x:LeftColumnRightPane>55</x:LeftColumnRightPane>
     <x:ActivePane>0</x:ActivePane>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>1</x:Number>
       <x:ActiveCol>7</x:ActiveCol>
      </x:Pane>
      <x:Pane>
       <x:Number>2</x:Number>
      </x:Pane>
      <x:Pane>
       <x:Number>0</x:Number>
       <x:ActiveRow>11</x:ActiveRow>
       <x:ActiveCol>57</x:ActiveCol>
      </x:Pane>
     </x:Panes>
     <x:ProtectContents>False</x:ProtectContents>
     <x:ProtectObjects>False</x:ProtectObjects>
     <x:ProtectScenarios>False</x:ProtectScenarios>
    </x:WorksheetOptions>
   </x:ExcelWorksheet>
  </x:ExcelWorksheets>
  <x:WindowHeight>9780</x:WindowHeight>
  <x:WindowWidth>18195</x:WindowWidth>
  <x:WindowTopX>480</x:WindowTopX>
  <x:WindowTopY>30</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=2336 style='border-collapse:
 collapse;table-layout:fixed;width:1751pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=122 style='mso-width-source:userset;mso-width-alt:4461;width:92pt'>
 <col width=0 style='display:none;mso-width-source:userset;mso-width-alt:4461'>
 <col width=215 style='mso-width-source:userset;mso-width-alt:7862;width:161pt'>
 <col width=90 style='mso-width-source:userset;mso-width-alt:3291;width:68pt'>
 <col width=64 style='width:48pt'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=0 span=9 style='display:none;mso-width-source:userset;mso-width-alt:
 4022'>
 <col width=110 style='mso-width-source:userset;mso-width-alt:4022;width:83pt'>
 <col width=131 span=8 style='mso-width-source:userset;mso-width-alt:4790;
 width:98pt'>
 <col width=0 span=27 style='display:none;mso-width-source:userset;mso-width-alt:
 4790'>
 <col width=61 style='mso-width-source:userset;mso-width-alt:2230;width:46pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=0 span=2 style='display:none;mso-width-source:userset;mso-width-alt:
 4790'>
 <col width=83 style='mso-width-source:userset;mso-width-alt:3035;width:62pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <col width=131 style='mso-width-source:userset;mso-width-alt:4790;width:98pt'>
 <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl36 width=40 style='border-bottom:.5pt solid black;  height:30.0pt;width:30pt'>No</td>
  <td rowspan=2 class=xl36 width=122 style='border-bottom:.5pt solid black;  width:92pt'>Detail Level Code</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td rowspan=2 class=xl36 width=215 style='border-bottom:.5pt solid black;  width:161pt'>Name</td>
  <td rowspan=2 class=xl36 width=90 style='border-bottom:.5pt solid black;  width:68pt'>Specification</td>
  <td rowspan=2 class=xl36 width=64 style='border-bottom:.5pt solid black;  width:48pt'>Weight</td>
  <td rowspan=2 class=xl36 width=110 style='border-bottom:.5pt solid black;  width:83pt'>Unit</td>
  <td class=xl26 width=0>&nbsp;</td>
  <td class=xl27 width=0>&nbsp;</td>
  <td class=xl27 width=0>&nbsp;</td>
  <td class=xl27 width=0>&nbsp;</td>
  <td class=xl27 width=0>&nbsp;</td>
  <td class=xl27 width=0>&nbsp;</td>
  <td class=xl27 width=0>&nbsp;</td>
  <td class=xl27 width=0>&nbsp;</td>
  <td class=xl27 width=0>&nbsp;</td>
  <td colspan=9 class=xl38 width=1158 style='border-right:.5pt solid black;
  width:867pt'>Working</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td rowspan=2 class=xl36 width=61 style='border-bottom:.5pt solid black;width:46pt'>VAT Rate</td>
  <td rowspan=2 class=xl36 width=131 style='border-bottom:.5pt solid black;width:98pt'>VAT Amount</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td class=xl25 width=0>&nbsp;</td>
  <td rowspan=2 class=xl36 width=83 style='width:62pt'>Withholding Tax</td>
  <td rowspan=2 class=xl36 width=131 style='width:98pt'>Withholding Amount</td>
  <td rowspan=2 class=xl36 width=131 style='border-bottom:.5pt solid black;  width:98pt'>Total</td>
 </tr>
 <tr class=xl24 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl28 width=0 style='height:15.0pt'>&nbsp;</td>
  <td class=xl29 width=0 x:num>7</td>
  <td class=xl29 width=0 x:num>8</td>
  <td class=xl29 width=0 x:num>9</td>
  <td class=xl29 width=0 x:num>10</td>
  <td class=xl29 width=0 x:num>11</td>
  <td class=xl29 width=0 x:num>12</td>
  <td class=xl29 width=0 x:num>13</td>
  <td class=xl29 width=0 x:num>14</td>
  <td class=xl29 width=0 x:num>15</td>
  <td class=xl30 width=110 style='width:83pt'>Q'ty</td>
  <td class=xl30 width=131 style='width:98pt'>Raw Mtrl Cost U/P</td>
  <td class=xl30 width=131 style='width:98pt'>Raw Mtrl Cost Amt</td>
  <td class=xl30 width=131 style='width:98pt'>Labor Cost U/P</td>
  <td class=xl30 width=131 style='width:98pt'>Labor Cost Amt</td>
  <td class=xl30 width=131 style='width:98pt'>Exp U/P</td>
  <td class=xl30 width=131 style='width:98pt'>Exp Amt</td>
  <td class=xl30 width=131 style='width:98pt'>Unit Price</td>
  <td class=xl30 width=131 style='width:98pt'>Amount</td>
  <td class=xl29 width=0 x:num>25</td>
  <td class=xl29 width=0 x:num>26</td>
  <td class=xl29 width=0 x:num>27</td>
  <td class=xl29 width=0 x:num>28</td>
  <td class=xl29 width=0 x:num>29</td>
  <td class=xl29 width=0 x:num>30</td>
  <td class=xl29 width=0 x:num>31</td>
  <td class=xl29 width=0 x:num>32</td>
  <td class=xl29 width=0 x:num>33</td>
  <td class=xl29 width=0 x:num>34</td>
  <td class=xl29 width=0 x:num>35</td>
  <td class=xl29 width=0 x:num>36</td>
  <td class=xl29 width=0 x:num>37</td>
  <td class=xl29 width=0 x:num>38</td>
  <td class=xl29 width=0 x:num>39</td>
  <td class=xl29 width=0 x:num>40</td>
  <td class=xl29 width=0 x:num>41</td>
  <td class=xl29 width=0 x:num>42</td>
  <td class=xl29 width=0 x:num>43</td>
  <td class=xl29 width=0 x:num>44</td>
  <td class=xl29 width=0 x:num>45</td>
  <td class=xl29 width=0 x:num>46</td>
  <td class=xl29 width=0 x:num>47</td>
  <td class=xl29 width=0 x:num>48</td>
  <td class=xl29 width=0 x:num>49</td>
  <td class=xl29 width=0 x:num>50</td>
  <td class=xl29 width=0 x:num>51</td>
  <td class=xl29 width=0 x:num>54</td>
  <td class=xl29 width=0 x:num>55</td>
 </tr>
 <%
   
	string l_parameter = "'" +p_Project_Pk +"','" + p_tecps_orderingconttype_pk + "' " ;

   
    string p_Pk = Request["Pk"];
    string SQL_Detail = "SELECT f.itemcode , f.itemname , " + 
        "       NVL (e.changeqty, 0) Qty " +
        "  FROM tecps_performrmrk e,  " +
        "       tecps_orderingconttype c,  " +
        "       tecps_st_budget d,  " +
        "       tecps_undertakelevelcode b , " +
        "       tecps_item f " +
        " WHERE     e.del_if = 0  " +
        "        and f.del_if = 0 " +
        "       AND e.tecps_orderingconttype_pk = c.pk(+)  " +
        "       AND e.tecps_stbudget_pk = d.pk(+)  AND e.level_num = 2  " +
        "       AND e.tecps_undertakelevelcode_pk = b.pk(+)  " +
        "       and E.TECPS_ITEM_PK = f.pk " +
        "       AND e.tecps_projectsumm_pk = '"+p_Project_Pk+"' " +
        "       AND e.tecps_orderingconttype_pk = '" + p_tecps_orderingconttype_pk + "' ";


    // Response.Write(SQL_Detail);
   //  Response.End();

   //  DataTable dt_detail = ESysLib.TableReadOpen(SQL_Detail);

    DataTable dt_detail = ESysLib.TableReadOpenCursor("sp_kpcs312_upload",l_parameter);
     int i ;
     int k = 0;
     
     for (i = 0; i < dt_detail.Rows.Count; i++)
     {
%>
 <tr class=xl31 height=22 style='mso-height-source:auto;height:17.1pt'>
  <td height=22 class=xl32 style='height:17.1pt' ><%=k+1 %></td>
  <td class=xl33 width=122 style='width:92pt'><%=dt_detail.Rows[i][0]%></td>
  <td class=xl33 width=0></td>
  <td class=xl33 width=215 style='width:161pt'><%=dt_detail.Rows[i][1]%></td>
  <td class=xl34></td>
  <td class=xl34></td>
  <td class=xl35></td>
  <td class=xl35></td>
  <td class=xl35></td>
  <td class=xl35></td>
  <td class=xl35></td>
  <td class=xl35></td>
  <td class=xl35></td>
  <td class=xl35></td>
  <td class=xl35></td>
  <td class=xl35></td>
  <td class=xl34 x:num><%=dt_detail.Rows[i][2]%></td>
  <td class=xl34 x:num></td>
  <td class=xl34 x:num></td>
  <td class=xl34 x:num></td>
  <td class=xl34 x:num></td>
  <td class=xl34 x:num></td>
  <td class=xl34 x:num></td>
  <td class=xl34 x:num></td>
  <td class=xl34 x:num></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 x:num></td>
  <td class=xl34 x:num></td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
  <td class=xl34 x:num></td>
  <td class=xl34 x:num></td>
  <td class=xl34 x:num></td>
 </tr>
 <%k+=1;} %>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=40 style='width:30pt'></td>
  <td width=122 style='width:92pt'></td>
  <td width=0></td>
  <td width=215 style='width:161pt'></td>
  <td width=90 style='width:68pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=110 style='width:83pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=110 style='width:83pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=0></td>
  <td width=61 style='width:46pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=0></td>
  <td width=0></td>
  <td width=83 style='width:62pt'></td>
  <td width=131 style='width:98pt'></td>
  <td width=131 style='width:98pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
