<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Basic Info for Uniform</title>
</head>
<%EsysLib.SetUser("crm") %>
<script>
function BodyInit()
{       
var dataMemberType    = "<%=ESysLib.SetListDataSQL("SELECT PK, NAME FROM crm.tcm_member_type WHERE DEL_IF=0 and Type =10 ")%>|ALL|Select All";
 lstMemberTypeS.SetDataText(dataMemberType);
 lstMemberTypeS.value='ALL';
		OnSearch();
}
function OnCellClickMember()
{
    txtMasterPK.text = grdMember.GetGridData(grdMember.row,0);
    dso_grdMemberEvent.Call('SELECT');
}

function OnSave()
{
    if(checkvalidate())
	{
		dso_grdMemberEvent.Call();
	}
}

function OnSearch()
{
   dso_grdMember.Call('SELECT');
}

function OnDelete()
{
    grdMemberEvent.DeleteRow();
    if(confirm("Do you want to delete this item?"))
    {
        dso_grdMemberEvent.Call();
    }
}
function OnNew()
{
   
   var setPK = "";
   if(txtMasterPK.GetData()!= "")
   {
        grdMemberEvent.AddRow();
        setPK = txtMasterPK.GetData();
        //alert(setPK);
            for (i = 1; i < grdMemberEvent.rows; i++)	
					if (grdMemberEvent.GetGridData(i, 1)  == "")
					{
						grdMemberEvent.SetGridText( i , 1, setPK);	

					}

	}
	else
	{
	    alert("Please select item of the member");
        return false;
	}
}

function OnEnterKeyScore(obj){
if(checkvalidate())
{
    if(obj.text.length != 3 && obj.text.length != 6){
        alert("You must input 3 digits or 6 digits in score field.");
        obj.text="";
        obj.GetControl().focus();
    }
    else{
        if(grdMemberEvent.row < 1){
            alert("Please select row in the grid to input score.");
            return;
        }
        var row = grdMemberEvent.row;
        var score = obj.text;
        obj.text="";
        if(isNaN(score)){
            alert("Score must be a number.");
            return;
        }
        var x=0;
		if(score.length == 3)
		{
			for(var i=7;i<=25;i++){
					if(grdMemberEvent.GetGridData(row,i) == "" && x<3 && i!=16){
					   grdMemberEvent.SetGridText(row,i,score.substr(x,1)); 
					   x++;
					}
			}
		}
		else{
				for(var i=7;i<=25;i++){
						if(grdMemberEvent.GetGridData(row,i) == "" && x<6 && i!=16){
						   grdMemberEvent.SetGridText(row,i,score.substr(x,2)); 
						   x+=2;
						}
				}
			}
			//sum total out
			var total_out=0;
			for(var j=7;j<16;j++){
				if(grdMemberEvent.GetGridData(row,j) > 0){
					total_out += Number(grdMemberEvent.GetGridData(row,j));
				}
			}
			grdMemberEvent.SetGridText(row,16,total_out);
			//sum total in
			var total_in=0;
			for(j=17;j<=25;j++){
				if(grdMemberEvent.GetGridData(row,j) > 0){
					total_in += Number(grdMemberEvent.GetGridData(row,j));
				}
			}
			grdMemberEvent.SetGridText(row,26,total_in);
			var total_gross=0;
			total_gross = total_out + total_in;
			grdMemberEvent.SetGridText(row,6,total_gross);
			//save
			OnSave();
		}
    }
}
function OnEditCell(obj){
	if(checkvalidate())
		{
			OnSave();
		}
}
function checkvalidate()
{
	for (i = 1; i < grdMemberEvent.rows; i++)
	{
		if(grdMemberEvent.GetGridData(i,3)=="")
		{
			grdMemberEvent.GetGridControl().row = i;
			alert("Please,choose date to input handicap.");
			return false;
		}
	}
	return true;
}
function receive()
{
	if(grdMemberEvent.rows >1 )
	{
		grdMemberEvent.GetGridControl().row = 1;
	}
}
function url_encode(s) {
		string = s.replace(/\r\n/g,"\n");
		var utftext = "";
 
		for (var n = 0; n < string.length; n++) {
 
			var c = string.charCodeAt(n);
 
			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
 
		}
 
		return escape(utftext);
}
function OnReportDetail()
{
	if(grdMember.row !='-1')
	{
		//var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/ms/jams00100_hdcp_detail.rpt&procedure=CRM.sp_sel_jams00100_hdcp_detail&parameter="+grdMember.GetGridData(grdMember.row,0);  
			 //System.OpenTargetPage(url);
			 if(grdMemberEvent.rows > 1)
			 {
					 var url = '/reports/ja/ms/rpt_jams100_detail.aspx?p_member_pk='+url_encode(grdMember.GetGridData(grdMember.row,0))+'&p_member_id='+url_encode(grdMember.GetGridData(grdMember.row,1))+'&p_member_name='+url_encode(grdMember.GetGridData(grdMember.row,2))+'&p_member_type='+url_encode(grdMember.GetGridData(grdMember.row,6))+'&p_gender='+url_encode(grdMember.GetGridData(grdMember.row,5));
				System.OpenTargetPage( System.RootURL+url , "newform" );
			}
    }
	else
	{
		alert("Please,choose member name to print.");
	}
}
function OnReport()
{
		// var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/ms/jams00100.rpt&procedure=CRM.sp_sel_jams00100_rpt&parameter="+txtName.text;  
	     //System.OpenTargetPage(url);
		  var url = '/reports/ja/ms/rpt_jams00100.aspx?p_name='+ txtName.GetData() + '&p_member_type=' + lstMemberTypeS.value;
	      System.OpenTargetPage( System.RootURL+url , "newform" );
}
function OnUpdateCoursePopup()
{
	var path = System.RootURL + "/form/ja/ms/jams00100_setup_course_popup.aspx?";
	var object = System.OpenModal( path ,750 , 500 , 'resizable:yes;status:yes');
}
</script>

<body>

<gw:data id="dso_grdMember" >
    <xml>
        <dso id="1" type="grid" function="CRM.sp_sel_jams00100">
            <input bind="grdMember" >
				<input bind="txtName" />
				<input bind="lstMemberTypeS" />
            </input>
            <output bind="grdMember" />
        </dso>
    </xml>
</gw:data>
<gw:data id="dso_grdMemberEvent" onreceive="receive()">
    <xml>
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26" function="crm.sp_sel_jams00100_1" procedure="CRM.sp_upd_jams00100_1">
            <input bind="grdMemberEvent" >
                <input bind="txtMasterPK" />
            </input>
            <output bind="grdMemberEvent" />
        </dso>
    </xml>
</gw:data>

<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="0" style="background: #BDE9FF" >
    <tr>
        <td width="30%" style="background: white">
            <table  width="100%" height="100%" border="0" >			    
			    <tr>
				    <td  width="23%">Name</td>
				    <td align = "left" width="50%">
					    <gw:textbox id="txtName" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearch()"  />
				    </td>
				    <td width="3%">
                        <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
                   </td>
				   <td width="3%" align="right">
                            <gw:imgbtn id="ibtnReport" img="printer" alt="Print" onclick="OnReport()" />
                    </td>
			    </tr>
				<tr>
				    <td >Member Type</td>
					<td colspan="3">
                          <gw:list id="lstMemberTypeS" styles='width:100%' onchange="OnSearch()" />
                    </td>
			    </tr>
				<tr width="100%" height="100%" >
					<td colspan="4" >
						<gw:grid   
						id="grdMember"  
						header="_PK|Member ID|Member Name|_Card Number|HDCP|Gender|Member Type"
						format ="0|0|0|0|0|0|0"
						aligns ="0|0|0|0|0|0|0"
						default="0|0|0|0|0|0|0"
						editcol="0|0|0|0|0|0|0"
						widths ="0|1500|2500|1000|1500|1200|1200"
						styles="width:100%; height:100%"   
						sorting="T"   
						acceptNullDate="T"
						autosize='T' 
						oncellclick="OnCellClickMember()"  />
					</td>
				</tr>
			</table>
        </td>
        <!------------------------------------------------------------------->
        <td width="67%" style="background: white">
            <table width="100%" width="100%" height="100%">
                <tr valign="top" style="background: #BDE9FF" height="5%" >        
                    <td style="background: white">
                    <fieldset>
                        <table width="100%" border="0">
                            <tr width="100%">
							<td width="15%">
								Score#(3 digits)</td>
									<td width="7%">
                                       <gw:textbox id="txtScore" maxlen="6" onenterkey="OnEnterKeyScore(this)" />
                                    </td>
									<td width="36%"><gw:icon id="idBtnUpdateCourse" img="in" text="Setup Course Information" styles='width:100%' onclick="OnUpdateCoursePopup()" /></td>
                                <td width="3%">
                                    <gw:imgbtn id="ibtnNew" img="new" alt="New" onclick="OnNew()" />
                                 </td>
                                <td width="3%" ><gw:imgBtn img="delete" alt="Delete"   onclick ="OnDelete()"/></td>
                                <td width="3%" ><gw:imgBtn img="save"   alt="Save"     onclick ="OnSave()"/></td>
								 <td width="3%" align="right">
									<gw:imgbtn id="ibtnReport2" img="printer" alt="Print Detail" onclick="OnReportDetail()" />
								</td>
                            </tr>
                        </table>
                        </fieldset>
                    </td>           
                </tr>
                <tr valign="top" height="90%">
                    <td colspan="4" width="100%" >
                        <gw:grid   
                        id="grdMemberEvent"  
                        header="_PK|_MEMBER_PK|No|Date|Caddy#|HDCP|Gross|1|2|3|4|5|6|7|8|9|OUT|10|11|12|13|14|15|16|17|18|IN"
                        format="0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="||||||||||||||||||||||||||"
                        editcol="1|1|0|1|1|0|0|1|1|1|1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|0"
                        widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        styles="width:100%; height:100%"  
                        autosize='T' acceptnulldate="T"
                        sorting="T" onafteredit="OnEditCell(this)"
                        />
                    </td>
                </tr>
            </table>
        </td>
    </tr>    
</table>
<gw:textbox id="txtMasterPK" styles="width:100%;display:none" /> 
</body>