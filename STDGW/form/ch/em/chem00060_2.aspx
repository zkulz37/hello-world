<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))
     Response.Charset = "utf-8"
 %> 
 
<html xmlns="http://www.w3.org/1999/xhtml" >

<head id="Head1" runat="server">    
    <title>Untitled Page</title>
</head>
<script>
function BodyInit()
{ 
    txtaMBO.SetEnable(false);
    
    var callerWindowObj = dialogArguments;//windown
    
     
    txtaMBO.SetDataText(callerWindowObj.GetMBO());
    txtaMBO_R.SetDataText(callerWindowObj.GetMBOResult());    
    
    var write_YN = "<%=Request("write_yn") %>";
    if(write_YN == "N"){
        ibtnOK.SetEnable(false);
        txtaMBO_R.SetReadOnly(true);
    }
    else{
        txtaMBO_R.GetControl().focus();
    }  
}
function OnSave()
{
    var code_data=new Array()
    code_data[0] = txtaMBO_R.GetData();	
	window.returnValue = code_data; 
    window.close(); 
}
</script>
<body>
<gw:data id="datchem00060_1" onreceive=""  > 
    <xml> 
        <dso  type="process" procedure="sp_pro_chem00060_1_popup" > 
            <input>
                <input bind="txt_mbo_pk" />                 
            </input> 
            <output>
                <output bind="txtaMBO" /> 
            </output>
        </dso> 
    </xml> 
</gw:data>
    <form id="form1" runat="server">
    <div>
    <table border=0 style="width:100%;height:100%">
        <tr>
            <td  style="width:50%;height:10%"><b>MBO Plan</b></td>
            <td  style="width:50%;height:10%">MBO Result</td>
        </tr>
        <tr>
            <td style="width:50%;height:80%">
                <gw:textarea id="txtaMBO" rows=25 styles='width:100%;'>
                </gw:textarea>
            </td>
            <td style="width:50%;height:80%">
                <gw:textarea id="txtaMBO_R" rows=25 styles='width:100%;'>
                </gw:textarea>
            </td>
        </tr>
        <tr>
        <td style="height:10%" colspan=2>
            <table border=0 cellpadding=0 cellspacing=0 style="width:100%">
                <tr>
                    <td style="width:50%" align=right>
                        <gw:icon id="ibtnOK"  text="OK"  img="in"  styles="width:20%" onclick="OnSave()"/>
                    </td>
                    <td style="width:50%" align=left>
                        <gw:icon id="ibtnCancel"  text="Cancel"  img="in"  styles="width:20%" onclick="window.close()"/>
                    </td>
                </tr>
            </table>
           </td>
        </tr>
    </table>    
    </div>
    </form>
</body>
<gw:textbox id="txt_mbo_pk" style="display:none" />
<gw:textbox id="txtType" style="display:none" />
</html>
