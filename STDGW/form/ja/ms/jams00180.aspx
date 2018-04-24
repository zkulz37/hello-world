<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Non Member Handicap Entry</title>
</head>
<%EsysLib.SetUser("crm") %>
<script>
var G1_pk=0, 
G1_golfer_id=1, 
G1_golfer_name=2, 
G1_gender=4, 
G1_birthday=5, 
G1_mobile_phone=6, 
G1_telephone=7, 
G1_nationality=8, 
G1_taxcode=9, 
G1_home_adress=10, 
G1_company_name=11, 
G1_company_addr=12, 
G1_company_phone=13, 
G1_hobby=14, 
G1_description=15,
G1_rpt_gender=16;
function BodyInit()
{       
	var data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" ) %> "; 
	grdMember.SetComboFormat(G1_gender,data);//gender
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'" ) %> "; 
	grdMember.SetComboFormat(G1_nationality,data);//nation
		OnSearch();
}
function OnCellClickMember()
{
    txtMasterPK.text = grdMember.GetGridData(grdMember.row,G1_pk);
    dso_grdMemberEvent.Call('SELECT');
}

function OnSave(obj)
{
    if(obj=='Master')
	{
		if(CheckvalidateMaster())
		{
			dso_grdMember.Call();
		}
	}
	if(obj=='Detail')
	{
		if(checkvalidate())
		{
			dso_grdMemberEvent.Call();
		}
	}
}

function OnSearch()
{
   dso_grdMember.Call('SELECT');
}

function OnDelete(obj)
{
    if(obj=='Master')
	{
		grdMember.DeleteRow();
		if(confirm("Do you want to delete this item?"))
			{
				dso_grdMember.Call();
			}
	}
	if(obj=='Detail')
	{
		grdMemberEvent.DeleteRow();
		if(confirm("Do you want to delete this item?"))
			{
				dso_grdMemberEvent.Call();
			}
	}
}
function OnNew(obj)
{
   if(obj=='Master')
   {
	   grdMember.AddRow();
   }
   if(obj=='Detail')
   {
	   var setPK = "";
	   if(txtMasterPK.GetData()!= "")
	   {   
			grdMemberEvent.AddRow();
			grdMemberEvent.SetGridText(grdMemberEvent.rows-1, 1, txtMasterPK.GetData());			
		}
		else
		{
			alert("Please select item of the member");
			return false;
		}
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
			for(var i=6;i<=24;i++){
					if(grdMemberEvent.GetGridData(row,i) == "" && x<3 && i!=15){
					   grdMemberEvent.SetGridText(row,i,score.substr(x,1)); 
					   x++;
					}
			}
		}
		else{
				for(var i=6;i<=24;i++){
						if(grdMemberEvent.GetGridData(row,i) == "" && x<6 && i!=15){
						   grdMemberEvent.SetGridText(row,i,score.substr(x,2)); 
						   x+=2;
						}
				}
			}
			//sum total out
			var total_out=0;
			for(var j=6;j<15;j++){
				if(grdMemberEvent.GetGridData(row,j) > 0){
					total_out += Number(grdMemberEvent.GetGridData(row,j));
				}
			}
			grdMemberEvent.SetGridText(row,15,total_out);
			//sum total in
			var total_in=0;
			for(j=16;j<=24;j++){
				if(grdMemberEvent.GetGridData(row,j) > 0){
					total_in += Number(grdMemberEvent.GetGridData(row,j));
				}
			}
			grdMemberEvent.SetGridText(row,25,total_in);
			var total_gross=0;
			total_gross = total_out + total_in;
			grdMemberEvent.SetGridText(row,5,total_gross);
			//save
			OnSave('Detail');
		}
    }
}
function OnEditCell(obj){
	if(checkvalidate())
		{
			OnSave();
		}
}
function CheckvalidateMaster()
{
	for (i = 1; i < grdMember.rows; i++)
	{
		if(grdMember.GetGridData(i,G1_golfer_name)=="")
		{
			grdMemberEvent.GetGridControl().row = i;
			alert("Please,input golfer name at row " +i);
			return false;
		}
	}
	return true;
}
function checkvalidate()
{
	for (i = 1; i < grdMemberEvent.rows; i++)
	{
		if(grdMemberEvent.GetGridData(i,2)=="")
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
	/*if(grdMember.row !='-1')
	{
		if(grdMemberEvent.rows > 1)
		{
			var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ja/ms/jams00120_hdcp_detail.rpt&procedure=CRM.sp_rpt_jams00120&parameter="+grdMember.GetGridData(grdMember.row,G1_pk)+","+url_encode(grdMember.GetGridData(grdMember.row,G1_golfer_id))+","+url_encode(grdMember.GetGridData(grdMember.row,G1_golfer_name))+","+url_encode(grdMember.GetGridData(grdMember.row,G1_rpt_gender));  
				 System.OpenTargetPage(url);
		}	 
    }
	else
	{
		alert("Please,choose member name to print.");
	}*/
	if(grdMember.row !='-1')
	{
		if(grdMemberEvent.rows > 1)
		{
			var url = '/reports/ja/ms/rpt_jams00120_none_hdcp_detail.aspx?p_master_pk='+ txtMasterPK.GetData()+'&p_id='+url_encode(grdMember.GetGridData(grdMember.row,G1_golfer_id))+'&p_name='+url_encode(grdMember.GetGridData(grdMember.row,G1_golfer_name))+'&p_gender='+url_encode(grdMember.GetGridData(grdMember.row,G1_rpt_gender));
			System.OpenTargetPage( System.RootURL+url , "newform" );
		}	 
    }
	else
	{
		alert("Please,choose member name to print.");
	}
}
function OnReportM()
{
		  var url = '/reports/ja/ms/rpt_jams00120_none_hdcp.aspx?p_name='+ txtName.GetData();
	    System.OpenTargetPage( System.RootURL+url , "newform" );
		
}
</script>

<body>

<gw:data id="dso_grdMember" >
    <xml>
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="crm.sp_sel_jams00120_master" procedure="CRM.sp_upd_jams00120_master">
            <input bind="grdMember" >
				<input bind="txtName" />
            </input>
            <output bind="grdMember" />
        </dso>
    </xml>
</gw:data>
<gw:data id="dso_grdMemberEvent" onreceive="receive()">
    <xml>
        <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="crm.sp_sel_jams00120_1" procedure="CRM.sp_upd_jams00120_1">
            <input bind="grdMemberEvent" >
                <input bind="txtMasterPK" />
            </input>
            <output bind="grdMemberEvent" />
        </dso>
    </xml>
</gw:data>

<table width="100%" height="100%" cellpadding="0" cellspacing="1" border="0" style="background: #BDE9FF" >
	<tr>
		<td width="100%" style="background: white">
            <table  width="100%" height="100%" border="0" >			    
			    <tr>
				    <td  width="5%">Name</td>
				    <td align = "left" width="20%">
					    <gw:textbox id="txtName" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearch()"  />
				    </td>
					 <td  width="60%"></td>
				    <td width="3%">
                        <gw:imgbtn id="ibtnSearch" img="search" alt="Search" onclick="OnSearch()" />
                   </td>
				   <td width="3%">
						<gw:imgbtn id="ibtnNew" img="new" alt="New" onclick="OnNew('Master')" styles="width:100%;display:none" />
				   </td>
					<td width="3%" ><gw:imgBtn img="delete" alt="Delete"   onclick ="OnDelete('Master')" styles="width:100%;display:none" /></td>
					<td width="3%" ><gw:imgBtn img="save"   alt="Save"     onclick ="OnSave('Master')" styles="width:100%;display:none" /></td>
					<td width="3%" align="right">
						<gw:imgbtn id="ibtnReport2" img="printer" alt="Print Detail" onclick="OnReportM()" />
					</td>
			    </tr>
				<tr width="100%" height="100%" >
					<td colspan="8" >
						<gw:grid   
						id="grdMember"  
						header="_pk|Golfer ID|Golfer Name|HDCP|Gender|Birthday|Mobile Phone|Telephone|Nationality| Taxcode|Home Adress|Company Name|Company Address|Company Phone|Hobby|Description|_rpt_gender"
						format ="0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0"
						aligns ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
						styles="width:100%; height:100%"   
						sorting="T"   
						acceptNullDate="T"
						autosize='T' 
						oncellclick="OnCellClickMember()"  />
					</td>
				</tr>
			</table>
        </td>
	</tr>
    <tr>
        
        <!------------------------------------------------------------------->
        <td width="100%" style="background: white">
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
									<td width="36%"></td>
                                <td width="3%">
                                    <gw:imgbtn id="ibtnNew" img="new" alt="New" onclick="OnNew('Detail')" styles="width:100%;display:none" />
                                 </td>
                                <td width="3%" ><gw:imgBtn img="delete" alt="Delete"   onclick ="OnDelete('Detail')" styles="width:100%;display:none" /></td>
                                <td width="3%" ><gw:imgBtn img="save"   alt="Save"     onclick ="OnSave('Detail')" styles="width:100%;display:none" /></td>
								 <td width="3%" align="right">
									<gw:imgbtn id="ibtnReport2" img="printer" alt="Print Detail" onclick="OnReportDetail('Detail')" />
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
                        header="_PK|_MEMBER_PK|Date|Caddy#|HDCP|Gross|1|2|3|4|5|6|7|8|9|OUT|10|11|12|13|14|15|16|17|18|IN"
                        format="0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||||||||||||||||||"
                        editcol="1|1|1|1|0|0|1|1|1|1|1|1|1|1|1|0|1|1|1|1|1|1|1|1|1|0"
                        widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
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