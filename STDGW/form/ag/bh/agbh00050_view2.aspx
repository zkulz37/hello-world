<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{   
   
    if (v_language!="ENG")
        System.Translate(document);	
    txtgroup_pk.text="<%=request.QueryString("group_pk")%>";
	txtwork_dt.text="<%=request.QueryString("dt")%>";    
    datWorkSchedule_view.Call("SELECT");
}
function OnDataReceive(obj)
{
	var i,max_dt=0;
	if(obj.id=="datWorkSchedule_view")
	{
		idRecord.text=grdView.rows-1 +" Records";
	}
	
}
</script>

<body>

<gw:data id="datWorkSchedule_view" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="" function="HR_sel_80020004_gw_popup3" > 
                <input bind="grdView" >
                <input bind="txtwork_dt" />
                <input bind="txtgroup_pk" />
                </input>
                <output  bind="grdView" />
            </dso> 
        </xml> 
</gw:data>


<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
    <table id="Table1" style="width:100%;height:6%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr>
				<td align=Center width=100% <b style="color=#FF00CC"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></b></td>
  	    </tr>
	</table>
	<table id="tbl" style="width:100%;height:94%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				<gw:grid   
				id="grdView"  
				header="Work Group|Full Name|Emp ID|Join Date|Work Date|Work Shift"   
				format="0|0|0|4|4|0"  
				aligns="0|0|0|0|0|0"  
				defaults="|||||"  
				editcol="0|0|0|0|0|0"  
				widths="2000|2500|1000|1200|1200|3000"  
				styles="width:100%; height:100%"   
				sorting="T"   
				oncellclick     = "" />
			</td>
		</tr>	
	</table>
</table>
<gw:textbox id="txtwork_dt" styles="display:none"/>
	<gw:textbox id="txtgroup_pk" styles="display:none"/>
</body>
</html>

