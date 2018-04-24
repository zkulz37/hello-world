<!-- #include file="../../../system/lib/form.inc"  -->
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
	OnInitForm();
}
//======================================================================
function OnInitForm(){
	OnToggle();
}
//======================================================================
function OnInitData(){
    
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
        case "imgArrow":
            OnToggle();
        break;
        case "ibtnSearch":
            alert("Search");
        break;
        case "ibtnUpdate":
            alert("Update");
        break;
        case "ibtnDelete":
            //if(txtMasterPK.GetData() != ''){
                if(confirm("Are you sure to delete!")){
                    alert("Delete");
                }
            //} else alert("No data for delete");
        break;
        case "ibtnInsert":
            alert("Insert");
        break;
        case "ibtnReport":
            var fpath = System.RootURL+ '/reports/ja/ma/rpt_jama00140.aspx?dtfrom=' + dtFromDate2.GetData() + '&dtto=' + dtToDate2.GetData();
            window.open(fpath);
        break;
    }
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
//    switch(obj.id)
//    {
//        case "dso_cmab00010_search":
//            alert("Search Complete");
//        break;
//    }
}
</script>
<body>
<!--------------------------------------------------------------------------------------->
<!--gw:data id="dso_cmab00010_search"> 
    <xml>                                                               
        <dso id="1" type="grid" user="prod" function="CRM.sp_sel_cmab00010_search"> 
            <input> 
                <input bind="dtFromDate" /> 
                <input bind="dtToDate" />
            </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data-->
<!--------------------------------------------------------------------------------------->
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand; position: absolute; left: 3; top: 7;" onclick="OnClick('imgArrow')" />
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
                                            <td><gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnClick('ibtnSearch');" /></td>
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
                        	 header		="_pk|Date|Content"
                             format		="0|0|0"
                             aligns		="0|0|0"
                             defaults	="||"
                             editcol	="0|0|0"
                             widths		="0|1200|2900"/>
                    </td>
                </tr>
			</table>
        </td>
        <td style="width:80%" style="background:#f7f8fc;padding:5px" id="right" valign="top" align="center"> 
            <table style="width:100%">
                <tr>
                    <td style="width:100%"></td>
                    <td><gw:imgbtn id="ibtnInsert" img="new"    alt="new"       onclick="OnClick('ibtnInsert')" style="display:none" /></td>
                    <td><gw:imgbtn id="ibtnDelete" img="delete" alt="delete"    onclick="OnClick('ibtnDelete')" style="display:none" /></td>
                    <td><gw:imgbtn id="ibtnUpdate" img="save"   alt="save"      onclick="OnClick('ibtnUpdate')" style="display:none" /></td>
                    <td><gw:imgbtn id="ibtnReport" img="excel"  alt="report"    onclick="OnClick('ibtnReport')" /></td>
                </tr>
            </table>
            <table style="width:80%">
                <tr width="100%">
                    <td>Date&nbsp;<gw:datebox id="dtFromDate2" type="date" lang="1" /></td>
                    <td align="center">~</td>
                    <td><gw:datebox id="dtToDate2" type="date"  lang="1" /></td>
                    <td style="width:100%"></td>
                </tr>
                <tr><td colspan="4" style="height:20px"></td></tr>
            </table>
        </td>
    </tr>
</table>
<gw:textbox id="txtMasterPK" style="display:none" />
</body>
</html>