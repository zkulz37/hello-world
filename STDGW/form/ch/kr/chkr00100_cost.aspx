<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head>
    <title>Get Detail</title>
</head>

<script type="text/javascript" language="javascript">
//-------------------------------------------------
    function BodyInit(){
        txt_pk.text = '<%= Request.QueryString("pk") %>';
        dso_chkr00100_cost.Call("SELECT");
    }
	
    function OnDataReceive(obj){
        switch(obj.id){
			case 'dso_chkr00100_cost':			
				if (idGrid.rows > 1)
					idGrid.Subtotal( 1, 2, -1, '2');
			break;
		}
    }
</script>
<body>
    <!----------------------------------------------------->
    <gw:data id="dso_chkr00100_cost" onreceive="OnDataReceive(this)">
	    <xml> 
		    <dso type="grid" parameter="" function="hr.sp_sel_chkr00100_cost">
			    <input bind="idGrid">
				    <input bind="txt_pk" />
			    </input> 
			    <output bind="idGrid" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr>
            <td style="height:5%" align="center">
                Course ID: <%= Request.QueryString("id") %> - Course Name: <%=Request.QueryString("name")%> 
            </td>
        </tr>
        <tr style="height: 95%">
            <td colspan="7">
                <gw:grid id		="idGrid" 
						header  ="No.|Name|Cost|Remark"
						format  ="0|0|-0|0" 
						aligns  ="1|0|0|0" 
						defaults="|||" 
						editcol ="0|0|0|0"
						widths  ="500|1500|1500|4000"  
						styles  ="width:100%; height:100%" 
						sorting ="T" 
				/>
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txt_pk" styles="width: 100%; display:none" />
</html>
