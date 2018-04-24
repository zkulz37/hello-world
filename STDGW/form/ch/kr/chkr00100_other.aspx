<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head>
    <title>Get Detail</title>
</head>

<script type="text/javascript" language="javascript">
//-------------------------------------------------
    function BodyInit(){
		var data;
		data = "<%=ESysLib.SetListDataSQL("select pk,org_id ||'-'|| org_nm from comm.tco_org a where  del_if=0 order by org_nm")%>||ALL"; 
		lstDept.SetDataText(data);
		lstDept.value = '';
		
        txt_pk.text 			= '<%= Request.QueryString("pk") %>';
		txt_isReject.text		= '<%= Request.QueryString("p1") %>';
		txt_isParticipate.text	= '<%= Request.QueryString("p2") %>';
		txt_isPass.text			= '<%= Request.QueryString("p3") %>';
        dso_chkr00100_other.Call("SELECT");
    }
	
    function OnDataReceive(obj){
        switch(obj.id){
			case 'dso_chkr00100_other':
				
			break;
		}
    }
</script>
<body>
    <!----------------------------------------------------->
    <gw:data id="dso_chkr00100_other" onreceive="OnDataReceive(this)">
	    <xml> 
		    <dso type="grid" parameter="" function="hr.sp_sel_chkr00100_other">
			    <input bind="idGrid">
				    <input bind="txt_pk" />
					<input bind="txt_isReject" />
					<input bind="txt_isParticipate" />
					<input bind="txt_isPass" />
					<input bind="lstDept" />
			    </input> 
			    <output bind="idGrid" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr>
            <td style="height:5%;white-space:nowrap;" align="left">
                Course ID: <%= Request.QueryString("id") %> - Course Name: <%=Request.QueryString("name")%> 
            </td>
			<td style="white-space:nowrap;padding-right:5px;" align="right">Department</td>
			<td align="left" style="width:250px;"><gw:list id="lstDept" styles="width:100%" /></td>
			<td width="1%"><gw:imgBtn id="btnSearch" img="search" alt="Search item" onclick='dso_chkr00100_other.Call("SELECT");' /></td>
        </tr>
        <tr style="height: 95%" colspan="4">
            <td colspan="7">
                <gw:grid id		="idGrid" 
						header  ="No.|Emp ID|Emp Name|Department|TeamSection|Description"
						format  ="0|0|0|0|0|0" 
						aligns  ="1|1|0|0|0|0" 
						defaults="|||||" 
						editcol ="0|0|0|0|0|0"
						widths  ="500|1000|2000|2700|3000|1500"  
						styles  ="width:100%; height:100%" 
						sorting ="T" 
				/>
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txt_pk" styles="width: 100%; display:none" />
<gw:textbox id="txt_isReject" styles="width: 100%; display:none" />
<gw:textbox id="txt_isParticipate" styles="width: 100%; display:none" />
<gw:textbox id="txt_isPass" styles="width: 100%; display:none" />
</html>
