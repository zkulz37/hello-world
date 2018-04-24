<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Uniform Application List</title>
</head>
<script>

var p_can      = "<%=Request("p_cancel")%>";
var v_language = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{   
    if (v_language!="ENG")
        System.Translate(document); 
        
    txtReason.SetDataText(p_can);
}

function OnSelect()
{
    window.returnValue = txtReason.GetData(); 
	window.close()
}
</script>

<body>
<table width="100%" cellpadding="0" cellspacing="1" border="0">
    <tr>
        <td width="97%"></td>
        <td width="3%"><gw:imgBtn img="select"    alt="Select"    onclick ="OnSelect()"/></td>
    </tr>
    <tr>
        <td width="100%" colspan="2">
            <fieldset style="padding: 5">
                <legend><font color="black" ><b>Reason of Cancellation</b></font></legend>
                <table width="100%" cellpadding="0" cellspacing="1" border="0">                    
                    <tr>
                        <td width="100%"><gw:textarea id="txtReason" rows="5" styles="width:100%" /></td>
                    </tr>
                </table>
            </fieldset>
        </td>
    </tr>
</table>
</body>