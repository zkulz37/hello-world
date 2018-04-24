<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))
     Response.Charset = "utf-8"
 %> 
 
<html xmlns="http://www.w3.org/1999/xhtml" >

<head id="Head1" runat="server">    
    <title>Untitled Page</title>
</head>
<script>
var edit_yn;
function BodyInit()
{ 
    lblText.text="<%=Request("p_data") %>";
    
    edit_yn = "<%=Request("write_yn") %>";
    var callerWindowObj = dialogArguments;//window

    var l_content=callerWindowObj.GetContent();
    
    
    txtaMBO.SetDataText(l_content);   
   
    if(edit_yn=="N")
    {
        txtaMBO.SetReadOnly(true);

    }

}


function OnSave()
{
    
    if(edit_yn=="N")
    {
        window.close(); 
    }
    else
    {
    
        var code_data=new Array();
        code_data[0] = txtaMBO.GetData();	
	    window.returnValue = code_data; 
        window.close(); 
    }
}
</script>
<body>

    <form id="form1" runat="server">
    <div>
    <table border=0 style="width:100%;height:100%">
        <tr>
            <td style="width:100%;height:10%"><b><gw:label id="lblText"  text=""/></b></td>
        </tr>
        <tr>
            <td style="width:100%;height:80%">
                <gw:textarea id="txtaMBO" rows=25 styles='width:100%;' tabindex="2">
                </gw:textarea>
            </td>
        </tr>
        <tr>
        <td style="height:10%">
            <table border=0 cellpadding=0 cellspacing=0 style="width:100%">
                <tr>
                    <td style="width:50%" align=right>
                        <gw:icon id="ibtnOK"  text="OK"  img="in"  styles="width:20%" onclick="OnSave()" tabindex="0"/>
                    </td>
                    <td style="width:50%" align=left>&nbsp;</td>
                </tr>
            </table>
           </td>
        </tr>
    </table>    
    </div>
    </form>
</body>
<gw:textbox id="txt_mbo_pk" style="display:none" />
<gw:textbox id="txtType"  style="display:none"/>
</html>
