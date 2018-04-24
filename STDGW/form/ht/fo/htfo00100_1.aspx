<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("crm")%>
<head>
    <title>Get Detail</title>
</head>

<script type="text/javascript" language="javascript">
//-------------------------------------------------
    function BodyInit()
    {
        TABLE_PK.text = '<%= Request.QueryString("pk") %>';
        dsoShowDetailInvoice.Call("SELECT");
    }
    function OnDataReceive()
    {
        if (idGrid.rows > 1)	
		{
				idGrid.Subtotal( 1, 2, -1, '5!6');
		}
    }
</script>
<body>
    <!----------------------------------------------------->
    <gw:data id="dsoShowDetailInvoice" onreceive="OnDataReceive(this)">
	    <xml> 
		    <dso type="grid" parameter="" function="CRM.sp_sel_htfo00100_2">
			    <input bind="idGrid">
				    <input bind="TABLE_PK" />
			    </input> 
			    <output bind="idGrid" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------>
    <table style="height: 100%; width: 100%">
        <tr>
            <td style="height:5%" align="center">
                Slip No: <%= Request.QueryString("sn") %> - Room: <%=Request.QueryString("room")%> - Date: <%=Request.QueryString("date")%> 
            </td>
        </tr>
        <tr style="height: 95%">
            <td colspan="7">
                <gw:grid id="idGrid" 
                    header="_PK|No.|Item Name|Unit|Price|Quantity|Amount"
                    format="0|0|0|0|1|-0|-0" 
                    aligns="0|1|0|1|3|1|3" 
                    defaults="||||||" 
                    editcol="0|0|0|0|0|0|0"
                    styles="width:100%; height:100%" 
                    sorting="T" 
                    autosize="T"
                    param="0,1,2,3,4" />
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="TABLE_PK" styles="width: 100%; display:none" />
</html>
