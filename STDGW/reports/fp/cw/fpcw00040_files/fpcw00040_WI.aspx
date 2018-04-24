<%@ Page Language="C#"%>
<%@ Import Namespace = "System.Data"%>

<html xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">

<%
    string SQL, tpr_workins_pk ;
    string wi_no = "", bc_wi_no = "", line_name = "", wi_date = "", shift = "", charger_nm = "", description = "";
    
    tpr_workins_pk = Request.QueryString["tpr_workins_pk"];
    
    SQL ="SELECT a.pk, a.wi_no, '*' || a.wi_no || '*' bc_wi_no, b.line_name, " +
        " TO_CHAR (TO_DATE (a.wi_date, 'yyyymmdd'), 'YYYY-MON-DD') wi_date, " +
        " c.start_time || '~' || c.end_time shift, " +
        " hr.sf_get_emp_id_name (charger_emp_pk, '1') charger_nm, a.description " +
        " FROM prod.tpr_workins a, prod.tpr_line b, hr.thr_work_shift c " +
        " WHERE a.del_if = 0 " +
        " AND b.del_if = 0 " +
        " AND c.del_if = 0 " +
        " AND a.close_yn = 'N' " +
        " AND a.tpr_line_pk = b.pk " +
        " AND a.thr_work_shift_pk = c.pk " +
        " AND a.pk = '" +  tpr_workins_pk + "'";
     DataTable dt = ESysLib.TableReadOpen(SQL);

     if (dt.Rows.Count > 0)
     {
         wi_no      = (string) dt.Rows[0]["wi_no"].ToString();
         bc_wi_no   = (string)dt.Rows[0]["bc_wi_no"].ToString();
         line_name  = (string)dt.Rows[0]["line_name"].ToString();
         wi_date    = (string)dt.Rows[0]["wi_date"].ToString();
         shift = (string)dt.Rows[0]["shift"].ToString();
         charger_nm = (string)dt.Rows[0]["charger_nm"].ToString();
         description = (string)dt.Rows[0]["description"].ToString();
     }

     SQL = "SELECT   a.pk, a.tpr_workins_pk, a.wid_seq, c.item_code stitem_code, " +
          " c.item_name stitem_name, prod.sf_get_fpbp00132 (a.tco_item_pk) spec, " +
          " a.item_uom, a.ins_qty, a.description " +
          " FROM prod.tpr_workinsd a, comm.tco_item b, comm.tco_stitem c " +
          "  WHERE a.del_if = 0 " +
          "    AND b.del_if(+) = 0 " +
          "    AND c.del_if(+) = 0 " +
          "    AND a.close_yn = 'N' " +
          "    AND a.tco_item_pk = b.pk(+) " +
          "    AND b.tco_stitem_pk = c.pk(+) " +
          "    AND a.tpr_workins_pk = '" + tpr_workins_pk + "'" +
          " ORDER BY a.wid_seq, c.item_code ";
     dt = ESysLib.TableReadOpen(SQL);
%>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link id=Main-File rel=Main-File href="../fpcw00040.htm">
<link rel=File-List href=filelist.xml>
<link rel=Edit-Time-Data href=editdata.mso>
<link rel=Stylesheet href=stylesheet.css>
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.5in .26in .5in .25in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;}
-->
</style>
<![if !supportTabStrip]><script language="JavaScript">
<!--
function fnUpdateTabs()
 {
  if (parent.window.g_iIEVer>=4) {
   if (parent.document.readyState=="complete"
    && parent.frames['frTabs'].document.readyState=="complete")
   parent.fnSetActiveSheet(0);
  else
   window.setTimeout("fnUpdateTabs();",150);
 }
}

if (window.name!="frSheet")
 window.location.replace("../fpcw00040.htm");
else
 fnUpdateTabs();
//-->
</script>
<![endif]><!--[if gte mso 9]><xml>
 <x:WorksheetOptions>
  <x:DefaultRowHeight>225</x:DefaultRowHeight>
  <x:FitToPage/>
  <x:FitToPage/>
  <x:Print>
   <x:FitHeight>0</x:FitHeight>
   <x:ValidPrinterInfo/>
   <x:HorizontalResolution>600</x:HorizontalResolution>
   <x:VerticalResolution>600</x:VerticalResolution>
  </x:Print>
  <x:Selected/>
  <x:Panes>
   <x:Pane>
    <x:Number>3</x:Number>
    <x:ActiveRow>12</x:ActiveRow>
    <x:ActiveCol>1</x:ActiveCol>
   </x:Pane>
  </x:Panes>
  <x:ProtectContents>False</x:ProtectContents>
  <x:ProtectObjects>False</x:ProtectObjects>
  <x:ProtectScenarios>False</x:ProtectScenarios>
 </x:WorksheetOptions>
</xml><![endif]-->
</head>

<body link=blue vlink=purple class=xl24>

<table x:str border=0 cellpadding=0 cellspacing=0 width=720 style='border-collapse:
 collapse;table-layout:fixed;width:537pt'>
 <col class=xl24 width=27 style='mso-width-source:userset;mso-width-alt:987;
 width:20pt'>
 <col class=xl24 width=63 span=11 style='mso-width-source:userset;mso-width-alt:
 2304;width:47pt'>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=44  width=27 style='height:33.0pt;width:20pt; border-bottom:none; ' align=left
  valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75" coordsize="21600,21600"
   o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe" filled="f"
   stroked="f">
   <v:stroke joinstyle="miter"/>
   <v:formulas>
    <v:f eqn="if lineDrawn pixelLineWidth 0"/>
    <v:f eqn="sum @0 1 0"/>
    <v:f eqn="sum 0 0 @1"/>
    <v:f eqn="prod @2 1 2"/>
    <v:f eqn="prod @3 21600 pixelWidth"/>
    <v:f eqn="prod @3 21600 pixelHeight"/>
    <v:f eqn="sum @0 0 1"/>
    <v:f eqn="prod @6 1 2"/>
    <v:f eqn="prod @7 21600 pixelWidth"/>
    <v:f eqn="sum @8 21600 0"/>
    <v:f eqn="prod @7 21600 pixelHeight"/>
    <v:f eqn="sum @10 21600 0"/>
   </v:formulas>
   <v:path o:extrusionok="f" gradientshapeok="t" o:connecttype="rect"/>
   <o:lock v:ext="edit" aspectratio="t"/>
  </v:shapetype><v:shape id="_x0000_s1025" type="#_x0000_t75" style='position:absolute;
   margin-left:18.75pt;margin-top:0;width:211.5pt;height:33pt;z-index:1;
   mso-position-horizontal-relative:char;mso-position-vertical-relative:line'>
   <v:imagedata src="image001.png" o:title=""/>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:25px;margin-top:0px;width:282px;
  height:44px'><img width=282 height=44 src=image002.jpg v:shapes="_x0000_s1025"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td height=44 class=xl51 width=27 style='height:33.0pt;width:20pt'><br>
        </td>
   </tr>
  </table>
  </span></td>
  <td class=xl36 width=63 style='width:47pt;border-right:none;border-top:none;border-bottom:none; border-left:none' colspan="5">&nbsp;</td>
  <td colspan=3 rowspan=2 class=xl30 width=189 style='width:141pt'>Work
  Instruction</td>
  <td colspan=3 class=xl31 width=189 style='border-left:.5pt;width:141pt'><%=wi_no%></td>
 </tr>
 <tr height=45 style='mso-height-source:userset;height:33.75pt'>
  <td colspan=6 height=32 class=xl51 width=342 style='border-right:.5pt solid black;
  height:20.0pt;width:255pt; font-size:8.0pt; font-family:Arial; white-space:normal; border-top:none'>
       C&#212;NG TY C&#7892; PH&#7846;N NH&#7920;A YOUL CHON VINA<br>
    L&#212; K-3-CN, KCN M&#7928; PH&#431;&#7898;C 2, HUY&#7878;N B&#7870;N C&#193;T, B&#204;NH D&#431;&#416;NG
  </td>
  <td colspan=3 height=45 class=xl28 style='height:33.75pt;border-left:none'><%=bc_wi_no%></td>
 </tr>
 <tr class=xl47 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl45 style='height:15.75pt'>Line</td>
  <td colspan=4 class=xl45 style='border-left:none'><%=line_name %></td>
  <td class=xl45 style='border-top:none;border-left:none'>Date</td>
  <td colspan=2 class=xl45 style='border-left:none'><%=wi_date %></td>
  <td class=xl46 style='border-top:none;border-left:none'>Shift</td>
  <td colspan=2 class=xl45 style='border-left:none'><%=shift%></td>
 </tr>
 <tr class=xl47 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=2 height=21 class=xl45 style='height:15.75pt'>Charger</td>
  <td colspan=4 class=xl45 style='border-left:none'><%=charger_nm %></td>
  <td class=xl46 style='border-top:none;border-left:none' x:str="Remark ">Remark<span
  style='mso-spacerun:yes'> </span></td>
  <td colspan=5 class=xl48 style='border-right:.5pt solid black;border-left:
  none' x:str="$Remark "><%=description %><span style='mso-spacerun:yes'> </span></td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td colspan=12 height=21 class=xl34 style='height:15.75pt'>&nbsp;</td>
 </tr>
 <tr height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl25 style='height:15.75pt;border-top:none'>No</td>
  <td colspan=2 class=xl25 style='border-left:none'>Item Code</td>
  <td colspan=3 class=xl25 style='border-left:none'>Item Name</td>
  <td colspan=2 class=xl25 style='border-left:none'>Spec</td>
  <td class=xl25 style='border-top:none;border-left:none'>UOM</td>
  <td class=xl25 style='border-top:none;border-left:none'>Qty</td>
  <td colspan=2 class=xl25 style='border-left:none'>Description</td>
 </tr>
 <%
     double tot_qty = 0;
     for (int i = 0; i < dt.Rows.Count; i++)
     {
         tot_qty = tot_qty + Convert.ToDouble(dt.Rows[i]["ins_qty"]);
  %>
 <tr class=xl44 height=21 style='mso-height-source:userset;height:15.75pt'>
  <td height=21 class=xl41 style='height:15.75pt;border-top:none' x:num><%=i+1 %></td>
  <td colspan=2 class=xl42 style='border-left:none'><%=dt.Rows[i]["stitem_code"]%></td>
  <td colspan=3 class=xl42 style='border-left:none'><%=dt.Rows[i]["stitem_name"]%></td>
  <td colspan=2 class=xl42 style='border-left:none'><%=dt.Rows[i]["spec"]%></td>
  <td class=xl41 style='border-top:none;border-left:none'><%=dt.Rows[i]["item_uom"] %></td>
  <td class=xl43 style='border-top:none;border-left:none'><%=dt.Rows[i]["ins_qty"] %></td>
  <td colspan=2 class=xl42 style='border-left:none'><%=dt.Rows[i]["description"] %></td>
 </tr>
 <%
     }      
  %>
 <tr height=15 style='height:11.25pt'>
  <td colspan=12 height=15 class=xl35 style='border-right:.5pt solid black;
  height:11.25pt'>&nbsp;</td>
 </tr>
 <tr height=17 style='mso-height-source:userset;height:12.75pt'>
  <td height=17 class=xl24 style='height:12.75pt'></td>
  <td colspan=2 class=xl32>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>Total :</td>
  <td class=xl27 style='border-top:none'><%=tot_qty %></td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
  <td class=xl26 style='border-top:none'>&nbsp;</td>
 </tr>
 <tr height=15 style='height:11.25pt'>
  <td height=15 class=xl24 style='height:11.25pt'></td>
  <td colspan=2 class=xl33>Manager Approve</td>
  <td colspan=9 class=xl24 style='mso-ignore:colspan'></td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=27 style='width:20pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
  <td width=63 style='width:47pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
