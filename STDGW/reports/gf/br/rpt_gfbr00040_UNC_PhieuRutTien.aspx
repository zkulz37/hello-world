<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>
<%
    ESysLib.SetUser(Session["APP_DBUSER"].ToString());
    Response.ContentType = "application/vnd.ms-excel";
    Response.Charset = "utf-8"; 
	Response.Buffer = false;
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string p_Seq = Request["Seq"];
    string p_Date = "";
    string p_Month = "";
    string p_Year = "";
    string p_D_Acc_No = "";
    string p_D_Acc_Nm = "";
    string p_D_Add = "";
    string p_D_Bank = "";
    string p_C_Acc_No = "";
    string p_C_Acc_Nm = "";
    string p_C_Add = "";
    string p_C_Bank = "";
    string p_Remark = "";
    string p_So = "";
    
    DataTable dt = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030", p_Seq);
    if (dt.Rows.Count == 0)
    {
        Response.Write("There is not data !!");
        Response.End();
    }
    else
    {
        p_Date = dt.Rows[0][15].ToString();
        p_Month = dt.Rows[0][16].ToString();
        p_Year = dt.Rows[0][17].ToString();
        p_D_Acc_No = dt.Rows[0][24].ToString();
        //p_D_Acc_No = dt.Rows[0][8].ToString();
        p_D_Acc_Nm = dt.Rows[0][12].ToString();
        //p_D_Add = dt.Rows[0][25].ToString();
        p_D_Bank = dt.Rows[0][9].ToString();
        p_C_Acc_No = dt.Rows[0][0].ToString();
        p_C_Acc_Nm = dt.Rows[0][19].ToString();
        //p_C_Add = dt.Rows[0][26].ToString();
        p_C_Bank = dt.Rows[0][1].ToString();
        p_Remark = dt.Rows[0][14].ToString();//eng
        p_So = dt.Rows[0][11].ToString();
    }

    string _str = "";
    char[] _ch = p_C_Acc_No.ToCharArray();
    for (int _j = 0; _j < _ch.Length; _j++)
    {
        _str += _ch[_j] + "<font class=font18><span style='mso-spacerun:yes'>     </span></font>";
    }
    string _str_Dr = "";
    char[] _ch_Dr = p_D_Acc_No.ToCharArray();
    for (int _k = 0; _k < _ch_Dr.Length; _k++)
    {
        _str_Dr += _ch_Dr[_k] ;
    }
    //Response.Write(_str_Dr[0]);
    //Response.End();
    string p_Amt = "";
    string p_Ccy = "";
    string p_Amt1 = "";
    string Inword = "";
    string _str_Amt = "";
    DataTable dt_Amount = ESysLib.TableReadOpenCursor("rpt_sel_gfbr00030_1", p_Seq);
    if (dt_Amount.Rows.Count > 0)
    {
        p_Amt = dt_Amount.Rows[0][11].ToString();
        p_Ccy = dt_Amount.Rows[0][3].ToString();
        p_Amt1 = dt_Amount.Rows[0][11].ToString();

        string _ch_Amt = p_Amt.ToString();

        int p = _ch_Amt.Length % 3;
        
        if (p > 0)
        {
            _str_Amt = _ch_Amt.Substring(0, p) + "     ";
        }
        
        int z = _ch_Amt.Length / 3;
        int r;
        for (r = 0; r < z; r++)
        {
            _str_Amt = _str_Amt + _ch_Amt.Substring(p, 3) + " ";
            p = p + 3;
            
        }
        
        Inword = CommondLib.Num2EngText(dt_Amount.Rows[0][9].ToString(), p_Ccy);
        string SQL3 = " SELECT upper(substr(trim('" + Inword + "'),1,1)) || substr(lower(trim('" + Inword + "')),2, length(trim('" + Inword + "')))  from dual ";
        DataTable dt_t = ESysLib.TableReadOpen(SQL3);

        if (dt_t.Rows.Count > 0)
        {
            Inword = dt_t.Rows[0][0].ToString();
        }
        //Response.Write(p_Amt1);
        //Response.End();
        //p_Ccy = "VND";
        //p_Amt1 = "1600";
        //p_D_Acc_No = "123456789012";
	p_D_Acc_No = p_D_Acc_No.Replace(".","");
	p_D_Acc_No = p_D_Acc_No.Replace("-","");
    }
     %>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link rel=File-List href="Phieu%20rut%20tien_files/filelist.xml">
<link rel=Edit-Time-Data href="Phieu%20rut%20tien_files/editdata.mso">
<link rel=OLE-Object-Data href="Phieu%20rut%20tien_files/oledata.mso">
<!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>KENZIE</o:Author>
  <o:LastAuthor>KENZIE</o:LastAuthor>
  <o:LastPrinted>2011-12-29T03:00:59Z</o:LastPrinted>
  <o:Created>2011-12-16T09:49:06Z</o:Created>
  <o:LastSaved>2011-12-29T03:02:22Z</o:LastSaved>
  <o:Version>11.9999</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.51in .43in .51in .57in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
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
.font15
	{color:white;
	font-size:12.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}	
.xl24
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl25
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl26
	{mso-style-parent:style0;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;
	vertical-align:middle;}
.xl27
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl28
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl29
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl30
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl31
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:middle;}
.xl32
	{mso-style-parent:style0;
	font-size:8.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl33
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl34
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl35
	{mso-style-parent:style0;
	font-size:6.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl36
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:left;}
.xl37
	{mso-style-parent:style0;
	font-size:9.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl38
	{mso-style-parent:style0;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl39
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	text-align:center;}
.xl40
	{mso-style-parent:style0;
	font-size:11.0pt;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl41
	{mso-style-parent:style0;
	font-size:12.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;}
.xl42
	{mso-style-parent:style0;
	font-size:7.0pt;
	font-weight:700;
	font-family:"Times New Roman", serif;
	mso-font-charset:0;
	vertical-align:top;
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
     
      <x:ValidPrinterInfo/>
      <x:PaperSizeIndex>9</x:PaperSizeIndex>
      <x:HorizontalResolution>600</x:HorizontalResolution>
      <x:VerticalResolution>0</x:VerticalResolution>
     </x:Print>
     <x:Selected/>
     <x:Panes>
      <x:Pane>
       <x:Number>3</x:Number>
       <x:ActiveRow>2</x:ActiveRow>
       <x:ActiveCol>2</x:ActiveCol>
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
  <x:WindowHeight>9270</x:WindowHeight>
  <x:WindowWidth>15315</x:WindowWidth>
  <x:WindowTopX>615</x:WindowTopX>
  <x:WindowTopY>150</x:WindowTopY>
  <x:ProtectStructure>False</x:ProtectStructure>
  <x:ProtectWindows>False</x:ProtectWindows>
 </x:ExcelWorkbook>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl25>

<table x:str border=0 cellpadding=0 cellspacing=0 width=501 style='border-collapse:
 collapse;table-layout:fixed;width:376pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <col class=xl25 width=45 style='mso-width-source:userset;mso-width-alt:1645;
 width:34pt'>
 <col class=xl26 width=20 span=12 style='mso-width-source:userset;mso-width-alt:
 731;width:15pt'>
 <col class=xl26 width=19 style='mso-width-source:userset;mso-width-alt:694;
 width:14pt'>
 <col class=xl26 width=69 style='mso-width-source:userset;mso-width-alt:2523;
 width:52pt'>
 <col class=xl25 width=64 style='width:48pt'>
 <tr height=17 style='height:12.75pt'>
  <td height=17 class=xl25 width=64 style='height:12.75pt;width:48pt'></td>
  <td class=xl25 width=45 style='width:34pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=20 style='width:15pt'></td>
  <td class=xl26 width=19 style='width:14pt'></td>
  <td class=xl26 width=69 style='width:52pt'></td>
  <td class=xl25 width=64 style='width:48pt'></td>
 </tr>
 <tr height=30 style='mso-height-source:userset;height:23.1pt'>
  <td height=30 colspan=2 class=xl25 style='height:23.1pt;mso-ignore:colspan'></td>
  <td colspan=14 class=xl26 style='mso-ignore:colspan'></td>
  <td class=xl25></td>
 </tr>
 <tr class=xl38 height=31 style='mso-height-source:userset;height:23.25pt;vertical-align:top'>
  <td height=31 class=xl37 style='height:23.25pt'></td>
  <td class=xl38></td>
  <td class=xl36 colspan=13 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span><%if(p_D_Acc_No.Length >=12){%><%=p_D_Acc_No[p_D_Acc_No.Length - 12]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_D_Acc_No.Length >=11){%><%=p_D_Acc_No[p_D_Acc_No.Length - 11]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_D_Acc_No.Length >=10){%><%=p_D_Acc_No[p_D_Acc_No.Length - 10]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>   </span><%if(p_D_Acc_No.Length >=9){%><%=p_D_Acc_No[p_D_Acc_No.Length - 9]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_D_Acc_No.Length >=8){%><%=p_D_Acc_No[p_D_Acc_No.Length - 8]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_D_Acc_No.Length >=7){%><%=p_D_Acc_No[p_D_Acc_No.Length - 7]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>   </span><%if(p_D_Acc_No.Length >=6){%><%=p_D_Acc_No[p_D_Acc_No.Length - 6]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_D_Acc_No.Length >=5){%><%=p_D_Acc_No[p_D_Acc_No.Length - 5]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>    </span><%if(p_D_Acc_No.Length >=4){%><%=p_D_Acc_No[p_D_Acc_No.Length - 4]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>    </span><%if(p_D_Acc_No.Length >=3){%><%=p_D_Acc_No[p_D_Acc_No.Length - 3]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   
  </span><%if(p_D_Acc_No.Length >=2){%><%=p_D_Acc_No[p_D_Acc_No.Length - 2]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>    </span><%if(p_D_Acc_No.Length >=1){%><%=p_D_Acc_No[p_D_Acc_No.Length - 1]%><%}else{%><font class="font15">9</font><%}%></td>
  <td class=xl39></td>
  <td class=xl40></td>
 </tr>
 <%if(p_Ccy=="VND"){ %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=2 class=xl25 style='height:23.25pt;mso-ignore:colspan;color:White'></td>
 <td class=xl36 colspan=14 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span><%if(p_Amt1.Length >=12){%><%=p_Amt1[p_Amt1.Length - 12]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=11){%><%=p_Amt1[p_Amt1.Length - 11]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=10){%><%=p_Amt1[p_Amt1.Length - 10]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>    </span><%if(p_Amt1.Length >=9){%><%=p_Amt1[p_Amt1.Length - 9]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=8){%><%=p_Amt1[p_Amt1.Length - 8]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=7){%><%=p_Amt1[p_Amt1.Length - 7]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes;'>    </span><%if(p_Amt1.Length >=6){%><%=p_Amt1[p_Amt1.Length - 6]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=5){%><%=p_Amt1[p_Amt1.Length - 5]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=4){%><%=p_Amt1[p_Amt1.Length - 4]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>    </span><%if(p_Amt1.Length >=3){%><%=p_Amt1[p_Amt1.Length - 3]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=2){%><%=p_Amt1[p_Amt1.Length - 2]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=1){%><%=p_Amt1[p_Amt1.Length - 1]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>     </span>0<span style='mso-spacerun:yes'>  
  </span>0</td>

  <td class=xl24></td>
 </tr>
 <%  }else{ %>
 <tr height=31 style='mso-height-source:userset;height:23.25pt'>
  <td height=31 colspan=2 class=xl25 style='height:23.25pt;mso-ignore:colspan;color:White'></td>
 <td class=xl36 colspan=14 style='mso-ignore:colspan'><span
  style='mso-spacerun:yes'> </span><%if(p_Amt1.Length >=15){%><%=p_Amt1[p_Amt1.Length - 15]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=14){%><%=p_Amt1[p_Amt1.Length - 14]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=13){%><%=p_Amt1[p_Amt1.Length - 13]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>    </span><%if(p_Amt1.Length >=12){%><%=p_Amt1[p_Amt1.Length - 12]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=11){%><%=p_Amt1[p_Amt1.Length - 11]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=10){%><%=p_Amt1[p_Amt1.Length - 10]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes;'>    </span><%if(p_Amt1.Length >=9){%><%=p_Amt1[p_Amt1.Length - 9]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=8){%><%=p_Amt1[p_Amt1.Length - 8]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=7){%><%=p_Amt1[p_Amt1.Length - 7]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>    </span><%if(p_Amt1.Length >=6){%><%=p_Amt1[p_Amt1.Length - 6]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=5){%><%=p_Amt1[p_Amt1.Length - 5]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>   </span><%if(p_Amt1.Length >=4){%><%=p_Amt1[p_Amt1.Length - 4]%><%}else{%><font class="font15">9</font><%}%><span
  style='mso-spacerun:yes'>     </span><%if(p_Amt1.Length >=2){%><%=p_Amt1[p_Amt1.Length - 2]%><%}else{%><font class="font15">9</font><%}%><span style='mso-spacerun:yes'>  
  </span><%if(p_Amt1.Length >=1){%><%=p_Amt1[p_Amt1.Length - 1]%><%}else{%><font class="font15">9</font><%}%></td>

  <td class=xl24></td>
 </tr>
 <%} %>
 <tr class=xl27 height=24 style='mso-height-source:userset;height:18.0pt'>
  <td height=24 colspan=2 class=xl27 style='height:18.0pt;mso-ignore:colspan'></td>
  <td colspan=2 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl29 colspan=13 style='mso-ignore:colspan'><%=Inword %></td>
 </tr>
 <tr class=xl27 height=15 style='height:11.25pt'>
  <td height=15 colspan=2 class=xl27 style='height:11.25pt;mso-ignore:colspan'></td>
  <td colspan=14 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 colspan=2 class=xl27 style='height:15.0pt;mso-ignore:colspan'></td>
  <td colspan=14 class=xl28 style='mso-ignore:colspan'></td>
  <td class=xl27></td>
 </tr>
 <tr class=xl27 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl27 style='height:15.0pt'></td>
  <td class=xl30></td>
  <td colspan=5 class=xl36 style='mso-ignore:colspan'></td>
  <td colspan=9 class=xl36></td>
  <td class=xl30></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'></td>
  <td class=xl30></td>
  <td class=xl34 colspan=8 style='mso-ignore:colspan'><%=p_C_Bank %></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl27 height=15 style='height:11.25pt'>
  <td height=15 class=xl27 style='height:11.25pt'></td>
  <td class=xl30></td>
  <td colspan=14 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl27 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl27 style='height:15.75pt'></td>
  <td class=xl30></td>
  <td class=xl29 colspan=8 style='mso-ignore:colspan'><%=p_C_Acc_Nm %></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl27 height=6 style='mso-height-source:userset;height:4.5pt'>
  <td height=6 class=xl27 style='height:4.5pt'></td>
  <td class=xl30></td>
  <td colspan=14 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl27 height=15 style='height:11.25pt'>
  <td height=15 class=xl27 style='height:11.25pt'></td>
  <td class=xl30></td>
  <td class=xl29 colspan=8 style='mso-ignore:colspan'><%=p_C_Acc_No %></td>
  <td colspan=6 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl32 height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl32 style='height:15.0pt'></td>
  <td class=xl33></td>
  <td colspan=8 class=xl34 style='mso-ignore:colspan'></td>
  <td class=xl34 colspan=5 style='mso-ignore:colspan'><%=_str_Amt%> <%=p_Ccy %></td>
  <td class=xl34></td>
  <td class=xl35></td>
 </tr>
 <tr class=xl27 height=14 style='mso-height-source:userset;height:10.5pt'>
  <td height=14 class=xl27 style='height:10.5pt'></td>
  <td class=xl30></td>
  <td colspan=12 rowspan=2 class=xl42 width=240 style='width:180pt'><%=p_Remark %></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <tr class=xl27 height=13 style='mso-height-source:userset;height:9.75pt'>
  <td height=13 class=xl27 style='height:9.75pt'></td>
  <td class=xl30></td>
  <td colspan=2 class=xl29 style='mso-ignore:colspan'></td>
  <td class=xl31></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=64 style='width:48pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=20 style='width:15pt'></td>
  <td width=19 style='width:14pt'></td>
  <td width=69 style='width:52pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
