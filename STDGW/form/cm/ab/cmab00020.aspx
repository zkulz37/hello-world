<!-- #include file="../../../system/lib/form.inc"  -->
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="ftb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Vina Genuwin</title>
    <style type="text/css">
		.bodyscrollbar{
		scrollbar-face-color: #ffffff;
		scrollbar-shadow-color: #A8A8A8;
		scrollbar-base-color : #ffffff;
		scrollbar-highlight-color: #A8A8A8;
		scrollbar-3dlight-color: #ffffff;
		scrollbar-darkshadow-color: #ffffff;
		scrollbar-track-color: #f8f8f8;
		scrollbar-arrow-color: #3366CC}
	</style>
</head>
<%  ESysLib.SetUser("crm")%>
<script language="javascript">
function BodyInit()
{   
    dso_cmab00020.StatusInsert();
	OnInitForm();
}
//======================================================================
function OnInitForm(){
	txtDay.SetEnable(false);
}
//======================================================================
function OnInitData(){
    txtMasterPK.SetDataText(grdSearch.GetGridData(grdSearch.row,0));
    dso_cmab00020_select.Call('SELECT');
}
//======================================================================
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    	left.style.display="none";
    	imgArrow.status = "collapse";
		left.style.width="0%";
    	right.style.width="100%";
    	imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else{
    	left.style.display="";
    	imgArrow.status = "expand";
		left.style.width="20%";
   		right.style.width="80%";
    	imgArrow.src = "../../../system/images/prev_orange.gif";
    }
}
//======================================================================
function OnClick(obj){
    switch(obj)
    {
        case "dtReport":
            var dt;
            var d,m,y, str;
            str = dtReport.GetData().toString();

            y = parseFloat(str.substring(0,4));
            d = parseFloat(str.substring(6,8));
            m = parseFloat(str.substring(4,6))-1;
            dt = new Date();
            dt.setFullYear(y,m,d);
            var weekday=new Array(7);
            weekday[0]="Sunday";
            weekday[1]="Monday";
            weekday[2]="Tuesday";
            weekday[3]="Wednesday";
            weekday[4]="Thursday";
            weekday[5]="Friday";
            weekday[6]="Saturday";
            txtDay.SetDataText(weekday[dt.getDay()]);
        break;
        case "ibtnUpdate":
            OnClick("dtReport");
            OnGetFTB();
            dso_cmab00020.Call();
        break;
        case "ibtnDelete":
            if(txtMasterPK.GetData() != ''){
                if(confirm("Are you sure to delete!")){
                    dso_cmab00020.StatusDelete();
                    dso_cmab00020.Call();
                }
            } else alert("No data for delete");
            
        break;
        case "ibtnInsert":
            dso_cmab00020.StatusInsert();
            OnSetFTB();
        break;
        case "ibtnReport":
            if(txtMasterPK.GetData() == '' || txtMasterPK.GetData() == '0'){
                alert("No data for report!");
                return false;
            }
			var fpath = System.RootURL+ '/form/cm/ab/cmab00020_popup.aspx?p_master=' + txtMasterPK.GetData();
            var object = System.OpenModal( fpath , 1024 , 768 , 'resizable:yes;status:yes');
        break;
    }
}
//======================================================================
function OnSearch(){
    dso_cmab00020_search.Call('SELECT');
}
//======================================================================
function CheckNum()
{
if (isNaN(String.fromCharCode(event.keyCode)))
        event.keyCode = "";
}
//======================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "dso_cmab00020":
            OnSearch();
        break;
        case "dso_cmab00020_select":
            OnSetFTB();
            dso_cmab00020.StatusUpdate();
        break;
    }
}
//======================================================================
function OnSetFTB(){
    FTB_API['ftbContent0'].SetHtml("");FTB_API['ftbContent0'].SetHtml(txtHDHTML0.GetData());
    FTB_API['ftbContent1'].SetHtml("");FTB_API['ftbContent1'].SetHtml(txtHDHTML1.GetData());
    FTB_API['ftbContent2'].SetHtml("");FTB_API['ftbContent2'].SetHtml(txtHDHTML2.GetData());
    FTB_API['ftbContent3'].SetHtml("");FTB_API['ftbContent3'].SetHtml(txtHDHTML3.GetData());
    FTB_API['ftbContent4'].SetHtml("");FTB_API['ftbContent4'].SetHtml(txtHDHTML4.GetData());
    FTB_API['ftbContent5'].SetHtml("");FTB_API['ftbContent5'].SetHtml(txtHDHTML5.GetData());
    FTB_API['ftbContent6'].SetHtml("");FTB_API['ftbContent6'].SetHtml(txtHDHTML6.GetData());
}
//======================================================================
function OnGetFTB(){
    txtHDHTML0.SetDataText(FTB_API['ftbContent0'].GetHtml());
    txtHDHTML1.SetDataText(FTB_API['ftbContent1'].GetHtml());
    txtHDHTML2.SetDataText(FTB_API['ftbContent2'].GetHtml());
    txtHDHTML3.SetDataText(FTB_API['ftbContent3'].GetHtml());
    txtHDHTML4.SetDataText(FTB_API['ftbContent4'].GetHtml());
    txtHDHTML5.SetDataText(FTB_API['ftbContent5'].GetHtml());
    txtHDHTML6.SetDataText(FTB_API['ftbContent6'].GetHtml());
}
</script>
<body>
<!--------------------------------------------------------------------------------------->
<gw:data id="dso_cmab00020" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17" function="CRM.sp_sel_cmab00020" procedure="CRM.sp_upd_cmab00020">
        <inout> 
            <inout bind="txtMasterPK"/>
            <inout bind="dtReport"/>
            <inout bind="txtDay"/>
			<inout bind="txtWeather"/>
			<inout bind="txtRainfall"/>
			<inout bind="txtHGreens"/>
			<inout bind="txtHTee_Box"/>
			<inout bind="txtHCollar"/>
			<inout bind="txtHFairway"/>
			<inout bind="txtHApron"/>
			<inout bind="txtHRough"/>
			<inout bind="txtHDHTML0"/>
			<inout bind="txtHDHTML1"/>
			<inout bind="txtHDHTML2"/>
			<inout bind="txtHDHTML3"/>
			<inout bind="txtHDHTML4"/>
			<inout bind="txtHDHTML5"/>
			<inout bind="txtHDHTML6"/>
		</inout>
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
<gw:data id="dso_cmab00020_search"> 
    <xml>                                                               
        <dso id="1" type="grid" user="prod" function="CRM.sp_sel_cmab00020_search"> 
            <input> 
                <input bind="dtFromDate" /> 
                <input bind="dtToDate" />
            </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
<gw:data id="dso_cmab00020_select" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" function="CRM.sp_sel_cmab00020">
        <inout> 
            <inout bind="txtMasterPK"/>
            <inout bind="dtReport"/>
            <inout bind="txtDay"/>
			<inout bind="txtWeather"/>
			<inout bind="txtRainfall"/>
			<inout bind="txtHGreens"/>
			<inout bind="txtHTee_Box"/>
			<inout bind="txtHCollar"/>
			<inout bind="txtHFairway"/>
			<inout bind="txtHApron"/>
			<inout bind="txtHRough"/>
			<inout bind="txtHDHTML0"/>
			<inout bind="txtHDHTML1"/>
			<inout bind="txtHDHTML2"/>
			<inout bind="txtHDHTML3"/>
			<inout bind="txtHDHTML4"/>
			<inout bind="txtHDHTML5"/>
			<inout bind="txtHDHTML6"/>
		</inout>
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
<form id="Form1" runat="server">
<table border="0" style="width: 100%; height: 100%; background-color:#CCCCCC" cellpadding="3" cellspacing="1">
	<tr>
    	<td style="width:20%" style="background:#f7f8fc;padding:2px" id="left">
        	<table border="0" style="width: 100%; height: 100%" cellpadding="0" cellspacing="0">
	            <tr style="height: 5%">
    	            <td width="100%" style="background-color:#f7f8fc" valign="top">
                    	<table border="0" width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="35%" align="right" style="padding-left:20px">Date</td>
                                <td width="65%" >
                                    <table style="width: 100%">
                                        <tr width="100%">
                                            <td><gw:datebox id="dtFromDate" type="date" lang="1" /></td>
                                            <td align="center">~</td>
                                            <td><gw:datebox id="dtToDate" type="date"  lang="1" /></td>
                                            <td><gw:imgbtn id="ibtnDelete17" img="search" alt="Search" onclick="OnSearch();" /></td>
                                        </tr>
                                    </table>	
                                </td>
                            </tr>
						</table>
                    </td>
        		</tr>
                <tr style="height:95%">
                	<td style="padding-top:4px">
                    	<gw:grid id="grdSearch" styles="width:100%; height:100%" sorting="F" oncellclick="OnInitData();"
                        	 header		="_pk|Day|Date|Weather"
                             format		="0|0|0|0"
                             aligns		="0|0|0|0"
                             defaults	="|||"
                             editcol	="0|0|0|0"
                             widths		="0|1200|1200|1700"/>
                    </td>
                </tr>
			</table>
        </td>
        <td style="width:80%" style="background:#f7f8fc;padding:5px" id="right" valign="top" align="center"> 
            <table style="width:100%">
                <tr>
                    <td style="width:100%"></td>
                    <td><gw:imgbtn id="ibtnInsert" img="new"    alt="new"       onclick="OnClick('ibtnInsert')" /></td>
                    <td><gw:imgbtn id="ibtnDelete" img="delete" alt="delete"    onclick="OnClick('ibtnDelete')" /></td>
                    <td><gw:imgbtn id="ibtnUpdate" img="save"   alt="save"      onclick="OnClick('ibtnUpdate')" /></td>
                    <td><gw:imgbtn id="ibtnReport" img="printer" alt="Print Acct" onclick="OnClick('ibtnReport')" styles='width:100%'/></td>
                </tr>
            </table>
            <script>function Cursor(){}</script>
            <table style="width:80%">
                <tr>
                    <td style="width:15%">Date</td>
                    <td style="width:35%"><gw:datebox id="dtReport" type="date" lang="1" style="width:70%" onchange="OnClick('dtReport');" /></td>
                    <td style="width:15%">Weather</td>
                    <td style="width:35%"><gw:textbox id="txtWeather" styles='width:70%' /></td>
                </tr>
                <tr>
                    <td>Day</td>
                    <td><gw:textbox id="txtDay" styles='width:70%' /></td>
                    <td>Rainfall</td>
                    <td><gw:textbox id="txtRainfall" styles='width:70%' /></td>
                </tr>
                <tr><td colspan="4" style="padding:5px 0px 5px 0px;"><u>Height of cut</u></td></tr>
                <tr>
                    <td>Greens</td>
                    <td><gw:textbox id="txtHGreens" styles='width:70%' /></td>
                    <td>Tee Box</td>
                    <td><gw:textbox id="txtHTee_Box" styles='width:70%' /></td>
                </tr>
                <tr>
                    <td>Collar</td>
                    <td><gw:textbox id="txtHCollar" styles='width:70%' /></td>
                    <td>Fairway</td>
                    <td><gw:textbox id="txtHFairway" styles='width:70%' /></td>
                </tr>
                <tr>
                    <td>Apron</td>
                    <td><gw:textbox id="txtHApron" styles='width:70%' /></td>
                    <td>Rough</td>
                    <td><gw:textbox id="txtHRough" styles='width:70%' /></td>
                </tr>
                <tr><td colspan="4" style="height:20px"></td></tr>
            </table>
            <gw:tab id="idTab" onpageactivate="return OnClick('idTab');" style="width: 100%; height: 300px; border:1px;">
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="GREENS/COLLAR" id="Tab0" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;"><ftb:freetextbox id="ftbContent0" runat="server" height="300px"  imagegallerypath="~/form/cm/ab/cmab00020/" supportfolder="~/FreeTextBox/"  width="100%" BreakMode="LineBreak" ToolbarLayout="ParagraphMenu,FontFacesMenu, FontSizesMenu, FontForeColorsMenu,FontForeColorPicker, FontBackColorsMenu, FontBackColorPicker|Preview,Cut, Copy, Paste, Delete, Undo, Redo, Print | JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, NumberedList, Indent, Outdent , InsertDate, InsertTime ,RemoveFormat| Bold, Italic, Underline, Strikethrough, Superscript, Subscript ,InsertRule, CreateLink, Unlink, InsertImage,InsertImageFromGallery,InsertTable, InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter,DeleteTableColumn,SymbolsMenu,WordClean"></ftb:freetextbox></td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="APRON" id="Tab1" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;"><ftb:freetextbox id="ftbContent1" runat="server" height="300px"  imagegallerypath="~/form/cm/ab/cmab00020/" supportfolder="~/FreeTextBox/"  width="100%" BreakMode="LineBreak" ToolbarLayout="ParagraphMenu,FontFacesMenu, FontSizesMenu, FontForeColorsMenu,FontForeColorPicker, FontBackColorsMenu, FontBackColorPicker|Preview,Cut, Copy, Paste, Delete, Undo, Redo, Print | JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, NumberedList, Indent, Outdent , InsertDate, InsertTime ,RemoveFormat| Bold, Italic, Underline, Strikethrough, Superscript, Subscript ,InsertRule, CreateLink, Unlink, InsertImage,InsertImageFromGallery,InsertTable, InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter,DeleteTableColumn,SymbolsMenu,WordClean"></ftb:freetextbox></td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="TEE BOX" id="Tab2" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;"><ftb:freetextbox id="ftbContent2" runat="server" height="300px"  imagegallerypath="~/form/cm/ab/cmab00020/" supportfolder="~/FreeTextBox/"  width="100%" BreakMode="LineBreak" ToolbarLayout="ParagraphMenu,FontFacesMenu, FontSizesMenu, FontForeColorsMenu,FontForeColorPicker, FontBackColorsMenu, FontBackColorPicker|Preview,Cut, Copy, Paste, Delete, Undo, Redo, Print | JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, NumberedList, Indent, Outdent , InsertDate, InsertTime ,RemoveFormat| Bold, Italic, Underline, Strikethrough, Superscript, Subscript ,InsertRule, CreateLink, Unlink, InsertImage,InsertImageFromGallery,InsertTable, InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter,DeleteTableColumn,SymbolsMenu,WordClean"></ftb:freetextbox></td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="FAIRWAY" id="Tab3" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;"><ftb:freetextbox id="ftbContent3" runat="server" height="300px"  imagegallerypath="~/form/cm/ab/cmab00020/" supportfolder="~/FreeTextBox/"  width="100%" BreakMode="LineBreak" ToolbarLayout="ParagraphMenu,FontFacesMenu, FontSizesMenu, FontForeColorsMenu,FontForeColorPicker, FontBackColorsMenu, FontBackColorPicker|Preview,Cut, Copy, Paste, Delete, Undo, Redo, Print | JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, NumberedList, Indent, Outdent , InsertDate, InsertTime ,RemoveFormat| Bold, Italic, Underline, Strikethrough, Superscript, Subscript ,InsertRule, CreateLink, Unlink, InsertImage,InsertImageFromGallery,InsertTable, InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter,DeleteTableColumn,SymbolsMenu,WordClean"></ftb:freetextbox></td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="ROUGH/SEMI ROUGH" id="Tab4" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;"><ftb:freetextbox id="ftbContent4" runat="server" height="300px"  imagegallerypath="~/form/cm/ab/cmab00020/" supportfolder="~/FreeTextBox/"  width="100%" BreakMode="LineBreak" ToolbarLayout="ParagraphMenu,FontFacesMenu, FontSizesMenu, FontForeColorsMenu,FontForeColorPicker, FontBackColorsMenu, FontBackColorPicker|Preview,Cut, Copy, Paste, Delete, Undo, Redo, Print | JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, NumberedList, Indent, Outdent , InsertDate, InsertTime ,RemoveFormat| Bold, Italic, Underline, Strikethrough, Superscript, Subscript ,InsertRule, CreateLink, Unlink, InsertImage,InsertImageFromGallery,InsertTable, InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter,DeleteTableColumn,SymbolsMenu,WordClean"></ftb:freetextbox></td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="BUNKER" id="Tab5" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;"><ftb:freetextbox id="ftbContent5" runat="server" height="300px"  imagegallerypath="~/form/cm/ab/cmab00020/" supportfolder="~/FreeTextBox/"  width="100%" BreakMode="LineBreak" ToolbarLayout="ParagraphMenu,FontFacesMenu, FontSizesMenu, FontForeColorsMenu,FontForeColorPicker, FontBackColorsMenu, FontBackColorPicker|Preview,Cut, Copy, Paste, Delete, Undo, Redo, Print | JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, NumberedList, Indent, Outdent , InsertDate, InsertTime ,RemoveFormat| Bold, Italic, Underline, Strikethrough, Superscript, Subscript ,InsertRule, CreateLink, Unlink, InsertImage,InsertImageFromGallery,InsertTable, InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter,DeleteTableColumn,SymbolsMenu,WordClean"></ftb:freetextbox></td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="GENERAL" id="Tab6" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;"><ftb:freetextbox id="ftbContent6" runat="server" height="300px"  imagegallerypath="~/form/cm/ab/cmab00020/" supportfolder="~/FreeTextBox/"  width="100%" BreakMode="LineBreak" ToolbarLayout="ParagraphMenu,FontFacesMenu, FontSizesMenu, FontForeColorsMenu,FontForeColorPicker, FontBackColorsMenu, FontBackColorPicker|Preview,Cut, Copy, Paste, Delete, Undo, Redo, Print | JustifyLeft, JustifyRight, JustifyCenter, JustifyFull, BulletedList, NumberedList, Indent, Outdent , InsertDate, InsertTime ,RemoveFormat| Bold, Italic, Underline, Strikethrough, Superscript, Subscript ,InsertRule, CreateLink, Unlink, InsertImage,InsertImageFromGallery,InsertTable, InsertTableRowAfter, DeleteTableRow, InsertTableColumnBefore, InsertTableColumnAfter,DeleteTableColumn,SymbolsMenu,WordClean"></ftb:freetextbox></td>
                    </tr>
                </table>
            </gw:tab>
        </td>
    </tr>
</table>
</form>
<gw:textbox id="txtMasterPK" style="display:none" />
<gw:textbox id="txtHDHTML0" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML1" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML2" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML3" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML4" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML5" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML6" maxlen="100" styles='width:100%;display:none' />
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand; position: absolute; left: 3; top: 7;" onClick="OnToggle()" />
</body>
</html>