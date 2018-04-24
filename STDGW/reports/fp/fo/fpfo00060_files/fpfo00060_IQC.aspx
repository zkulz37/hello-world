<%@ Page Language="C#" %>

<%@ Import Namespace="System.Data" %><html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:x="urn:schemas-microsoft-com:office:excel"
xmlns="http://www.w3.org/TR/REC-html40">
<%
    string sSQL, tpr_reqiqc_pk;

    tpr_reqiqc_pk = Request.QueryString["tpr_reqiqc_pk"];
  
    sSQL = "SELECT to_char(to_date(a.req_date,'YYYYMMDD'),'DD/MM') req_date, c.partner_name, " +
           " sale.sf_get_dsbs00010_4 ('80', b.tco_item_pk) spec1, g.item_name, " +
           " sale.sf_get_dsbs00010_4 ('10', b.tco_item_pk) spec2, e.lot_no,b.ref_no,  " +
           " nvl(f.lot_qty,1) roll_num, NULL width, total_lot_qty req_qty, total_weight weight_qty, " +
           " NULL actual_length, NULL actual_weight, NULL defect, NULL t_remark, " +
           " f.unit_lot_qty sticker_length, f.unit_weight_qty sticker_weight " +
           " FROM prod.tpr_reqiqc a, prod.tpr_reqiqcd b, comm.tco_buspartner c, " +
           " comm.tco_item d, prod.tpr_lotno e , TPR_REQIQC_LOT f , comm.tco_stitem g " +
           " WHERE a.del_if = 0 and f.del_if=0 " +
           " and d.TCO_STITEM_PK = g.pk(+) and g.del_if(+) =0 " +
           " AND b.del_if(+) = 0 AND c.del_if(+) = 0 AND d.del_if(+) = 0 AND e.del_if(+) = 0 " +
           " AND a.pk = b.tpr_reqiqc_pk(+) AND b.vendor_pk = c.pk(+) " +
           " AND b.tco_item_pk = d.pk(+) AND f.tpr_lotno_pk = e.pk(+)  " +
           " and b.pk= f.tpr_reqiqcd_pk " +
           " AND a.pk = '" + tpr_reqiqc_pk + "'" +  
           " ORDER BY b.ref_no, d.item_name ";
    
    DataTable dt = ESysLib.TableReadOpen(sSQL);       
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=ProgId content=Excel.Sheet>
<meta name=Generator content="Microsoft Excel 11">
<link id=Main-File rel=Main-File href="../fpfo00060.htm">
<link rel=File-List href=filelist.xml>
<link rel=Edit-Time-Data href=editdata.mso>
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<link rel=Stylesheet href=stylesheet.css>
<style>
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
@page
	{margin:.23in .17in .18in .15in;
	mso-header-margin:.23in;
	mso-footer-margin:.22in;
	mso-page-orientation:landscape;}
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
 window.location.replace("../fpfo00060.htm");
else
 fnUpdateTabs();
//-->
</script>
<![endif]><!--[if gte mso 9]><xml>
 <x:WorksheetOptions>
  <x:FitToPage/>
  <x:FitToPage/>
  <x:Print>
   <x:FitHeight>0</x:FitHeight>
   <x:ValidPrinterInfo/>
   <x:Scale>87</x:Scale>
   <x:HorizontalResolution>300</x:HorizontalResolution>
   <x:VerticalResolution>300</x:VerticalResolution>
  </x:Print>
  <x:Selected/>
  <x:Panes>
   <x:Pane>
    <x:Number>3</x:Number>
    <x:ActiveRow>4</x:ActiveRow>
   </x:Pane>
  </x:Panes>
  <x:ProtectContents>False</x:ProtectContents>
  <x:ProtectObjects>False</x:ProtectObjects>
  <x:ProtectScenarios>False</x:ProtectScenarios>
 </x:WorksheetOptions>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext="edit">
  <o:idmap v:ext="edit" data="2"/>
 </o:shapelayout></xml><![endif]-->
</head>

<body link=blue vlink=purple>

<table x:str border=0 cellpadding=0 cellspacing=0 width=1098 style='border-collapse:
 collapse;table-layout:fixed;width:825pt'>
 <col width=28 style='mso-width-source:userset;mso-width-alt:1024;width:21pt'>
 <col width=45 style='mso-width-source:userset;mso-width-alt:1645;width:34pt'>
 <col width=65 style='mso-width-source:userset;mso-width-alt:2377;width:49pt'>
 <col width=184 style='mso-width-source:userset;mso-width-alt:6729;width:138pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=60 style='mso-width-source:userset;mso-width-alt:2194;width:45pt'>
 <col width=64 style='width:48pt'>
 <col width=67 style='mso-width-source:userset;mso-width-alt:2450;width:50pt'>
 <col width=45 style='mso-width-source:userset;mso-width-alt:1645;width:34pt'>
 <col width=50 span=2 style='mso-width-source:userset;mso-width-alt:1828;
 width:38pt'>
 <col width=79 style='mso-width-source:userset;mso-width-alt:2889;width:59pt'>
 <col width=50 style='mso-width-source:userset;mso-width-alt:1828;width:38pt'>
 <col width=40 style='mso-width-source:userset;mso-width-alt:1462;width:30pt'>
 <col width=64 span=3 style='width:48pt'>
 <tr height=32 style='mso-height-source:userset;height:24.0pt'>
  <td colspan=15 height=32 width=970 style='height:24.0pt;width:729pt'
  align=left valign=top><!--[if gte vml 1]><v:shapetype id="_x0000_t75"
   coordsize="21600,21600" o:spt="75" o:preferrelative="t" path="m@4@5l@4@11@9@11@9@5xe"
   filled="f" stroked="f">
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
  </v:shapetype><v:shape id="_x0000_s2049" type="#_x0000_t75" style='position:absolute;
   margin-left:240pt;margin-top:1.5pt;width:18.75pt;height:19.5pt;z-index:1'>
   <v:imagedata src="image001.png" o:title="New Image"/>
   <x:ClientData ObjectType="Pict">
    <x:SizeWithCells/>
    <x:CF>Bitmap</x:CF>
   </x:ClientData>
  </v:shape><![endif]--><![if !vml]><span style='mso-ignore:vglayout;
  position:absolute;z-index:1;margin-left:320px;margin-top:2px;width:25px;
  height:26px'><img width=25 height=26 src=image002.gif v:shapes="_x0000_s2049"></span><![endif]><span
  style='mso-ignore:vglayout2'>
  <table cellpadding=0 cellspacing=0>
   <tr>
    <td colspan=15 height=32 class=xl67 width=970 style='height:24.0pt;
    width:729pt'>FABRIC INPUT &amp; INSPECTION</td>
   </tr>
  </table>
  </span></td>
  <td class=xl24 width=64 style='width:48pt'>&nbsp;</td>
  <td class=xl24 width=64 style='width:48pt'>&nbsp;</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td rowspan=2 height=40 class=xl68 style='border-bottom:1.0pt solid black;
  height:30.0pt;border-top:none'>No</td>
  <td rowspan=2 class=xl61 style='border-bottom:1.0pt solid black;border-top:
  none'>Date</td>
  <td rowspan=2 class=xl61 style='border-bottom:1.0pt solid black;border-top:
  none'>Buyer</td>
  <td rowspan=2 class=xl61 style='border-bottom:1.0pt solid black;border-top:
  none'>Contents</td>
  <td rowspan=2 class=xl61 style='border-bottom:1.0pt solid black;border-top:
  none'>Width</td>
  <td rowspan=2 class=xl61 style='border-bottom:1.0pt solid black;border-top:
  none'>Color</td>
  <td rowspan=2 class=xl61 style='border-bottom:1.0pt solid black;border-top:
  none'>Lot No</td>
  <td rowspan=2 class=xl61 style='border-bottom:1.0pt solid black;border-top:
  none'>PO No</td>
  <td rowspan=2 class=xl61 style='border-bottom:1.0pt solid black;border-top:
  none'>Roll No</td>
  <td colspan=3 class=xl63 style='border-right:.5pt solid black;border-left:
  none'>Stiker Qty</td>
  <td colspan=3 class=xl66 style='border-right:.5pt solid black;border-left:
  none'>Actual Qty</td>
  <td class=xl25>Defect</td>
  <td class=xl26>Remark</td>
 </tr>
 <tr height=20 style='mso-height-source:userset;height:15.0pt'>
  <td height=20 class=xl56 style='height:15.0pt;border-left:none'>width</td>
  <td class=xl27>Length</td>
  <td class=xl27>Weight</td>
  <td class=xl58 style='border-top:none;border-left:none'>Width</td>
  <td class=xl27>Length</td>
  <td class=xl27>Weight</td>
  <td class=xl27>&nbsp;</td>
  <td class=xl28>&nbsp;</td>
 </tr><%
    for (int i = 0; i < dt.Rows.Count; i++)
    {
        Int32 t = Convert.ToInt32(dt.Rows[i]["roll_num"]);

        if (t == 0)
        {
            t = 1;
        }
        Int32 count = 0;
        while (t > 0)
        {

            if (t == Convert.ToInt32(dt.Rows[i]["roll_num"]))
            {
%>
 <tr height=31 style='mso-height-source:userset;height:23.45pt'>
  <td height=31 class=xl29 style='height:23.45pt' x:num><%=i+1 %></td>
  <td class=xl30><%=dt.Rows[i]["req_date"]%></td>
  <td class=xl57><%=dt.Rows[i]["partner_name"]%></td>
  <td class=xl57 width=184 style='width:138pt' x:str><%=dt.Rows[i]["item_name"]%></td>
  <td class=xl31><%=dt.Rows[i]["spec1"]%></td>
  <td class=xl59 style='border-top:none;border-left:none'><%=dt.Rows[i]["spec2"]%></td>
  <td class=xl30><%=dt.Rows[i]["lot_no"]%></td>
  <td class=xl31><%=dt.Rows[i]["ref_no"]%></td>
  <td class=xl30 x:num><%=count +1 %></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl32 x:num><%=dt.Rows[i]["sticker_length"]%></td>
  <td class=xl78 x:num><%=dt.Rows[i]["sticker_weight"]%></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34><%=dt.Rows[i]["t_remark"]%></td>
 </tr>
 <% 
    }
    else
    {
%>
 <tr height=31 style='mso-height-source:userset;height:23.45pt'>
  <td height=31 class=xl29 style='height:23.45pt' x:num></td>
  <td class=xl30></td>
  <td class=xl31></td>
  <td class=xl57 width=184 style='width:138pt'x:str></td>
  <td class=xl32 x:str></td>
  <td class=xl31></td>
  <td class=xl30></td>
  <td class=xl31></td>
  <td class=xl30 x:num><%=count +1 %></td>
  <td class=xl30>&nbsp;</td>
  <td class=xl32 x:num><%=dt.Rows[i]["sticker_length"]%></td>
  <td class=xl78 x:num><%=dt.Rows[i]["sticker_weight"]%></td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34><%=dt.Rows[i]["t_remark"]%></td>
 </tr>
 <%
    }
    count = count + 1;
    t = t - 1;

    if (count == Convert.ToInt32(dt.Rows[i]["roll_num"]))
    {
        
%>
 <tr height=31 style='mso-height-source:userset;height:23.45pt'>
  <td height=31 class=xl29 style='height:23.45pt'>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl35>Total</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl31>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl30>&nbsp;</td>
  <td class=xl35 x:num><%=dt.Rows[i]["req_qty"]%></td>
  <td class=xl35 x:num><%=dt.Rows[i]["weight_qty"]%></td>
  <td class=xl35>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl32>&nbsp;</td>
  <td class=xl33>&nbsp;</td>
  <td class=xl34>&nbsp;</td>
 </tr>
  <%
        }
    }
} %>
 <tr height=25 style='mso-height-source:userset;height:18.75pt'>
  <td height=25 class=xl36 style='height:18.75pt'>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl38>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl37>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl39>&nbsp;</td>
  <td class=xl40>&nbsp;</td>
  <td class=xl41>&nbsp;</td>
 </tr>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=28 style='width:21pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=65 style='width:49pt'></td>
  <td width=184 style='width:138pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=60 style='width:45pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=67 style='width:50pt'></td>
  <td width=45 style='width:34pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=79 style='width:59pt'></td>
  <td width=50 style='width:38pt'></td>
  <td width=40 style='width:30pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
  <td width=64 style='width:48pt'></td>
 </tr>
 <![endif]>
</table>

</body>

</html>
