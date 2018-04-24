<!-- #include file="../../../system/lib/form.inc"  -->
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="ftb" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Tournament Register</title>
    <style type="text/css">
        .fzbutton{
	        font-family:Arial;
	        font-weight:bold;
	        padding-right: 1px;
	        padding-left: 1px;
	        font-size: 11px;
	        padding-bottom: 0px;
	        padding-top: 0px;
	        color:  #33CCFF;
	        height:18px;
	        width:100px;
	        border: 1px solid #33CCFF;
	        background-color: #FFFFFF;
        }
        .fzbutton_act{
	        font-family:Arial;
	        font-weight:bold;
	        padding-right: 1px;
	        padding-left: 1px;
	        font-size: 11px;
	        padding-bottom: 0px;
	        padding-top: 0px;
	        color: red;
	        border: 1px solid red;
	        height:18px;
	        width:100px;
	        background-color: #FFFFFF;
        }
    </style>
</head>
<%  ESysLib.SetUser("crm")%>
<script language="javascript">
function BodyInit()
{   
    dso_jabk0040.StatusInsert();
	//alert(chkSplitManLady.value);
	OnInitForm();
}
//======================================================================
function OnInitForm(){
	txtDay.SetEnable(false);
	OnClick("dtReport");
}
//======================================================================
function OnInitData(){
    txtMasterPK.SetDataText(grdSearch.GetGridData(grdSearch.row,0));
    dso_jabk0040_select.Call('SELECT');
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
    var btn;
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
        case "Lang01": 
            OnGetFTB();
            btn = document.getElementById("btn01"); btn.className = "fzbutton_act";
            btn = document.getElementById("btn02"); btn.className = "fzbutton";
            btn = document.getElementById("btn03"); btn.className = "fzbutton";
            OnSetFTB();
        break;
        case "Lang02": 
            OnGetFTB();
            btn = document.getElementById("btn01"); btn.className = "fzbutton";
            btn = document.getElementById("btn02"); btn.className = "fzbutton_act";
            btn = document.getElementById("btn03"); btn.className = "fzbutton";
            OnSetFTB();
        break;
        case "Lang03": 
            OnGetFTB();
            btn = document.getElementById("btn01"); btn.className = "fzbutton";
            btn = document.getElementById("btn02"); btn.className = "fzbutton";
            btn = document.getElementById("btn03"); btn.className = "fzbutton_act";
            OnSetFTB();
        break;
        case "ibtnUpdate":
            if(Number(txtMaxHDCPA.text)<0){alert("Please input Max Handicap A");return false;}
            if(Number(txtMaxHDCPB.text)<0){alert("Please input Max Handicap B");return false;}
            if(Number(txtMinHDCPC.text)<0){alert("Please input Min Handicap C");return false;}
            OnClick("dtReport");
            OnGetFTB();
            dso_jabk0040.Call();
        break;
        case "ibtnDelete":
            if(txtMasterPK.GetData() != ''){
                if(confirm("Are you sure to delete!")){
                    dso_jabk0040.StatusDelete();
                    dso_jabk0040.Call();
                }
            } else alert("No data for delete");
            
        break;
        case "ibtnInsert":
            dso_jabk0040.StatusInsert();
            OnSetFTB();
        break;
        case "ibtnReport":
            if(txtMasterPK.GetData() == '' || txtMasterPK.GetData() == '0'){
                alert("No data for report!");
                return false;
            }
            var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/bk/jabk0040.rpt&procedure=crm.sp_sel_jabk0040_rpt&parameter=" + txtMasterPK.GetData()+","+ OnGetAct();
            System.OpenTargetPage(url); 
            window.close();
        break;
    }
}
//======================================================================
function OnSearch(){
    dso_jabk0040_search.Call('SELECT');
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
        case "dso_jabk0040":
            OnSearch();
        break;
        case "dso_jabk0040_select":
            OnSetFTB();
            dso_jabk0040.StatusUpdate();
        break;
    }
}
//======================================================================
function OnSetFTB(){
    switch(OnGetAct()){
        case "EN":
            txtContent0.SetDataText("");txtContent0.SetDataText(txtHDHTML0EN.GetData());
            txtContent1.SetDataText("");txtContent1.SetDataText(txtHDHTML1EN.GetData());
            txtContent2.SetDataText("");txtContent2.SetDataText(txtHDHTML2EN.GetData());
            txtContent3.SetDataText("");txtContent3.SetDataText(txtHDHTML3EN.GetData());
            txtContent4.SetDataText("");txtContent4.SetDataText(txtHDHTML4EN.GetData());
            txtContent5.SetDataText("");txtContent5.SetDataText(txtHDHTML5EN.GetData());
            txtContent6.SetDataText("");txtContent6.SetDataText(txtHDHTML6EN.GetData());
        break;
        case "VN":
            txtContent0.SetDataText("");txtContent0.SetDataText(txtHDHTML0VN.GetData());
            txtContent1.SetDataText("");txtContent1.SetDataText(txtHDHTML1VN.GetData());
            txtContent2.SetDataText("");txtContent2.SetDataText(txtHDHTML2VN.GetData());
            txtContent3.SetDataText("");txtContent3.SetDataText(txtHDHTML3VN.GetData());
            txtContent4.SetDataText("");txtContent4.SetDataText(txtHDHTML4VN.GetData());
            txtContent5.SetDataText("");txtContent5.SetDataText(txtHDHTML5VN.GetData());
            txtContent6.SetDataText("");txtContent6.SetDataText(txtHDHTML6VN.GetData());
        break;
        case "FR":
            txtContent0.SetDataText("");txtContent0.SetDataText(txtHDHTML0FR.GetData());
            txtContent1.SetDataText("");txtContent1.SetDataText(txtHDHTML1FR.GetData());
            txtContent2.SetDataText("");txtContent2.SetDataText(txtHDHTML2FR.GetData());
            txtContent3.SetDataText("");txtContent3.SetDataText(txtHDHTML3FR.GetData());
            txtContent4.SetDataText("");txtContent4.SetDataText(txtHDHTML4FR.GetData());
            txtContent5.SetDataText("");txtContent5.SetDataText(txtHDHTML5FR.GetData());
            txtContent6.SetDataText("");txtContent6.SetDataText(txtHDHTML6FR.GetData());
        break;
    }
}
//======================================================================
function OnGetFTB(){
    switch(OnGetAct()){
        case "EN":
            txtHDHTML0EN.SetDataText(txtContent0.GetData());
            txtHDHTML1EN.SetDataText(txtContent1.GetData());
            txtHDHTML2EN.SetDataText(txtContent2.GetData());
            txtHDHTML3EN.SetDataText(txtContent3.GetData());
            txtHDHTML4EN.SetDataText(txtContent4.GetData());
            txtHDHTML5EN.SetDataText(txtContent5.GetData());
            txtHDHTML6EN.SetDataText(txtContent6.GetData());
        break;
        case "VN":
            txtHDHTML0VN.SetDataText(txtContent0.GetData());
            txtHDHTML1VN.SetDataText(txtContent1.GetData());
            txtHDHTML2VN.SetDataText(txtContent2.GetData());
            txtHDHTML3VN.SetDataText(txtContent3.GetData());
            txtHDHTML4VN.SetDataText(txtContent4.GetData());
            txtHDHTML5VN.SetDataText(txtContent5.GetData());
            txtHDHTML6VN.SetDataText(txtContent6.GetData());
        break;
        case "FR":
            txtHDHTML0FR.SetDataText(txtContent0.GetData());
            txtHDHTML1FR.SetDataText(txtContent1.GetData());
            txtHDHTML2FR.SetDataText(txtContent2.GetData());
            txtHDHTML3FR.SetDataText(txtContent3.GetData());
            txtHDHTML4FR.SetDataText(txtContent4.GetData());
            txtHDHTML5FR.SetDataText(txtContent5.GetData());
            txtHDHTML6FR.SetDataText(txtContent6.GetData());
        break;
    }
}
function OnGetAct(){
    if(document.getElementById("btn01").className == "fzbutton_act")
        return "EN";
    else if (document.getElementById("btn02").className == "fzbutton_act")
        return "VN";
    else if (document.getElementById("btn03").className == "fzbutton_act")
        return "FR";
}
</script>
<body>
<!--------------------------------------------------------------------------------------->
<gw:data id="dso_jabk0040" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41" function="CRM.sp_sel_jabk0040" procedure="CRM.sp_upd_jabk0040">
        <inout> 
            <inout bind="txtMasterPK"/>
            <inout bind="dtReport"/>            
			<inout bind="txtHDHTML0EN"/>
			<inout bind="txtHDHTML1EN"/>
			<inout bind="txtHDHTML2EN"/>
			<inout bind="txtHDHTML3EN"/>
			<inout bind="txtHDHTML4EN"/>
			<inout bind="txtHDHTML5EN"/>
			<inout bind="txtHDHTML6EN"/>
			<inout bind="txtHDHTML0VN"/>
			<inout bind="txtHDHTML1VN"/>
			<inout bind="txtHDHTML2VN"/>
			<inout bind="txtHDHTML3VN"/>
			<inout bind="txtHDHTML4VN"/>
			<inout bind="txtHDHTML5VN"/>
			<inout bind="txtHDHTML6VN"/>
			<inout bind="txtHDHTML0FR"/>
			<inout bind="txtHDHTML1FR"/>
			<inout bind="txtHDHTML2FR"/>
			<inout bind="txtHDHTML3FR"/>
			<inout bind="txtHDHTML4FR"/>
			<inout bind="txtHDHTML5FR"/>
			<inout bind="txtHDHTML6FR"/>
			<inout bind="txtMaxHDCPA"/>
			<inout bind="txtMaxHDCPB"/>
			<inout bind="txtMinHDCPC"/>
			<inout bind="txtHole1"/>
			<inout bind="txtHole2"/>
			<inout bind="txtHole3"/>
			<inout bind="txtHole4"/>
			<inout bind="txtHole5"/>
			<inout bind="txtHole6"/>
			<inout bind="txtHole7"/>
			<inout bind="txtHole8"/>
			<inout bind="txtHole9"/>
			<inout bind="txtHole10"/>
			<inout bind="txtHole11"/>
			<inout bind="txtHole12"/>
			<inout bind="txtCutOffA"/>
			<inout bind="txtCutOffB"/>
			<inout bind="txtCutOffC"/>
			<inout bind="chkSplitManLady"/>
		</inout>
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
<gw:data id="dso_jabk0040_search"> 
    <xml>                                                               
        <dso id="1" type="grid" user="prod" function="CRM.sp_sel_jabk0040_search"> 
            <input> 
                <input bind="dtFromDate" /> 
                <input bind="dtToDate" />
            </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
<gw:data id="dso_jabk0040_select" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" function="CRM.sp_sel_jabk0040">
        <inout> 
            <inout bind="txtMasterPK"/>
            <inout bind="dtReport"/>
			<inout bind="txtHDHTML0EN"/>
			<inout bind="txtHDHTML1EN"/>
			<inout bind="txtHDHTML2EN"/>
			<inout bind="txtHDHTML3EN"/>
			<inout bind="txtHDHTML4EN"/>
			<inout bind="txtHDHTML5EN"/>
			<inout bind="txtHDHTML6EN"/>
			<inout bind="txtHDHTML0VN"/>
			<inout bind="txtHDHTML1VN"/>
			<inout bind="txtHDHTML2VN"/>
			<inout bind="txtHDHTML3VN"/>
			<inout bind="txtHDHTML4VN"/>
			<inout bind="txtHDHTML5VN"/>
			<inout bind="txtHDHTML6VN"/>
			<inout bind="txtHDHTML0FR"/>
			<inout bind="txtHDHTML1FR"/>
			<inout bind="txtHDHTML2FR"/>
			<inout bind="txtHDHTML3FR"/>
			<inout bind="txtHDHTML4FR"/>
			<inout bind="txtHDHTML5FR"/>
			<inout bind="txtHDHTML6FR"/>
			<inout bind="txtMaxHDCPA"/>
			<inout bind="txtMaxHDCPB"/>
			<inout bind="txtMinHDCPC"/>
			<inout bind="txtHole1"/>
			<inout bind="txtHole2"/>
			<inout bind="txtHole3"/>
			<inout bind="txtHole4"/>
			<inout bind="txtHole5"/>
			<inout bind="txtHole6"/>
			<inout bind="txtHole7"/>
			<inout bind="txtHole8"/>
			<inout bind="txtHole9"/>
			<inout bind="txtHole10"/>
			<inout bind="txtHole11"/>
			<inout bind="txtHole12"/>
			<inout bind="txtCutOffA"/>
			<inout bind="txtCutOffB"/>
			<inout bind="txtCutOffC"/>
			<inout bind="chkSplitManLady"/>
		</inout>
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
<form id="Form1" runat="server">
<table border="0" style="width: 100%; height: 90%; background-color:#CCCCCC;" cellpadding="3" cellspacing="1">
	<tr>
    	<td style="width:0%" style="display:none;background:#f7f8fc;padding:2px" id="left">
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
                        	 header		="_pk|Day|Event Name"
                             format		="0|0|0"
                             aligns		="0|0|0"
                             defaults	="||"
                             editcol	="0|0|0"
                             widths		="0|2000|2000"/>
                    </td>
                </tr>
			</table>
        </td>
        <td style="width:100%" style="background:#f7f8fc;padding:5px" id="right" valign="top" align="center"> 
            <table style="width:100%">
				<tr>
					<td style="width:5%"></td>
					<td style="width:14%"></td>
					<td style="width:6%"></td>
					<td style="width:6%"></td>
					<td style="width:6%"></td>
					<td style="width:6%"></td>
					<td style="width:6%"></td>
					<td style="width:6%"></td>
					<td style="width:6%"></td>
					<td style="width:6%"></td>
					<td style="width:6%"></td>
					<td style="width:6%"></td>
					<td style="width:6%"></td>
					<td style="width:15%"></td>
				</tr>
				<tr>
					<td  colspan="10"></td>
					<td ><gw:imgbtn id="ibtnInsert" img="new"        alt="new"       onclick="OnClick('ibtnInsert')" /></td>
					<td ><gw:imgbtn id="ibtnDelete" img="delete"     alt="delete"    onclick="OnClick('ibtnDelete')" /></td>
					<td ><gw:imgbtn id="ibtnUpdate" img="save"       alt="save"      onclick="OnClick('ibtnUpdate')" /></td>
					<td ><gw:imgbtn id="ibtnReport" img="printer"    alt="Print"     onclick="OnClick('ibtnReport')" styles='width:100%'/></td>
				</tr>
                <tr>
					<td colspan="1" align="right"></td>
					<td colspan="3" align="center">Date<gw:datebox id="dtReport" type="date" lang="1" style="width:80%" onchange="OnClick('dtReport');" /></td>
					<td colspan="2" align="right">Day</td>
					<td colspan="2" align="right"><gw:textbox id="txtDay" styles='width:100%' /></td>
					<td colspan="2" align="center"><input id="btn01" type="button" onclick="OnClick('Lang01');" class="fzbutton_act" value="English" onmouseover="javascript:this.style.cursor='hand';" /></td>
					<td colspan="2" align="center"><input id="btn02" type="button" onclick="OnClick('Lang02');" class="fzbutton" value="Vietnamese" onmouseover="javascript:this.style.cursor='hand';" /></td>
					<td colspan="2" align="center"><input id="btn03" type="button" onclick="OnClick('Lang03');" class="fzbutton" value="Foreign" onmouseover="javascript:this.style.cursor='hand';" /></td>
				</tr>
				<tr>
					<td colspan="2" align="right">Max handicap A</td>
					<td colspan="2" ><gw:textbox id="txtMaxHDCPA" styles="width:100%" type="number" format="###,###,###,###"  /></td>
					<td colspan="2" align="right">Max handicap B</td>
					<td colspan="2"><gw:textbox id="txtMaxHDCPB" styles="width:100%;" type="number" format="###,###,###,###"  /></td>
					<td colspan="2" align="right">Min handicap C</td>
					<td colspan="2"><gw:textbox id="txtMinHDCPC" styles="width:100%;" type="number" format="###,###,###,###"  /></td>
					<td colspan="2"><gw:checkbox id="chkSplitManLady" defaultvalue="Y|N" value="N" styles="width:30%" />Split Man & Lady</td>
				</tr>
				<tr>
					<td colspan="2" align="right">Cut off A</td>
					<td colspan="2" ><gw:textbox id="txtCutOffA" styles="width:100%" type="number" format="###,###,###,###"  /></td>
					<td colspan="2" align="right">Cut off B</td>
					<td colspan="2"><gw:textbox id="txtCutOffB" styles="width:100%;" type="number" format="###,###,###,###"  /></td>
					<td colspan="2" align="right">Cut off C</td>
					<td colspan="2"><gw:textbox id="txtCutOffC" styles="width:100%;" type="number" format="###,###,###,###"  /></td>
					<td colspan="2"></td>
				</tr>
            </table>
            <table style="width: 100%">
                <tr><td colspan="13" style="height:5px"></td></tr>
                <tr>
                    <td></td>
                    <td align="center">1</td>
                    <td align="center">2</td>
                    <td align="center">3</td>
                    <td align="center">4</td>
                    <td align="center">5</td>
                    <td align="center">6</td>
                    <td align="center">7</td>
                    <td align="center">8</td>
                    <td align="center">9</td>
                    <td align="center">10</td>
                    <td align="center">11</td>
                    <td align="center">12</td>
                </tr>
                <tr>
                    <td align="left" style="width:5%;white-space:nowrap;">Peoria</td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole1" styles="width:100%;"  onenterkey="txtHole2.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole2" styles="width:100%;"  onenterkey="txtHole3.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole3" styles="width:100%;"  onenterkey="txtHole4.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole4" styles="width:100%;"  onenterkey="txtHole5.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole5" styles="width:100%;"  onenterkey="txtHole6.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole6" styles="width:100%;"  onenterkey="txtHole7.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole7" styles="width:100%;"  onenterkey="txtHole8.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole8" styles="width:100%;"  onenterkey="txtHole9.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole9" styles="width:100%;"  onenterkey="txtHole10.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole10" styles="width:100%;" onenterkey="txtHole11.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole11" styles="width:100%;" onenterkey="txtHole12.GetControl().focus();" /></td>
                    <td align="center" style="width:3%;white-space:nowrap;"><gw:textbox id="txtHole12" styles="width:100%;" /></td>
                </tr>
                <tr><td colspan="13" style="height:5px"></td></tr>
            </table> 
            <gw:tab id="idTab" onpageactivate="return OnClick('idTab');" style="width: 100%; height: 200px; border:1px;">
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="EVENT NAME" id="Tab0" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;">
							<gw:textarea id="txtContent0" styles='width:100%;height:200px' />
						</td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="SCHEDULE" id="Tab1" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;">
							<gw:textarea id="txtContent1" styles='width:100%;height:200px' />
						</td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="FORMAT" id="Tab2" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;">
							<gw:textarea id="txtContent2" styles='width:100%;height:200px' />
						</td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="TEES" id="Tab3" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;">
							<gw:textarea id="txtContent3" styles='width:100%;height:200px' />
						</td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="PRIZES" id="Tab4" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;">
							<gw:textarea id="txtContent4" styles='width:100%;height:200px' />
						</td>
                    </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="FEE" id="Tab5" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;">
							<gw:textarea id="txtContent5" styles='width:100%;height:200px' />
						</td>
                    </tr>
                </table>
                 <table width="100%" border="0" cellpadding="0" cellspacing="0"  name="NOTE" id="Tab6" style="overflow:scroll;background-color:#CCCCCC;height:auto">
                    <tr>
                        <td style="background:#ffffff;">
							<gw:textarea id="txtContent6" styles='width:100%;height:200px' />
						</td>
                    </tr>
                </table>
            </gw:tab>
        </td>
    </tr>
</table>
</form>
<gw:textbox id="txtMasterPK" style="display:none" />
<gw:textbox id="txtHDHTML0EN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML1EN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML2EN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML3EN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML4EN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML5EN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML6EN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML0VN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML1VN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML2VN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML3VN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML4VN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML5VN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML6VN" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML0FR" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML1FR" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML2FR" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML3FR" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML4FR" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML5FR" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtHDHTML6FR" maxlen="100" styles='width:100%;display:none' />
<img status="" id="imgArrow" src="../../../system/images/next_orange.gif" style="cursor: hand; position: absolute; left: 3; top: 7;" onclick="OnToggle()" />
</body>
</html>