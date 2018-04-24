<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))
     Response.Charset = "utf-8"
 %> 
 
<html xmlns="http://www.w3.org/1999/xhtml" >

<head id="Head1" runat="server">    
    <title>Untitled Page</title>
</head>
<script>
var g_SelfScore = "<%=Request("SelfScore") %>";
var g_1stScore = "<%=Request("1stScore") %>";
var g_2ndScore = "<%=Request("2ndScore") %>";
var g_Eva_Level = "<%=Request("Level") %>";
function BodyInit()
{ 	
    var callerWindowObj = dialogArguments;//windown        
    txtaMBO.SetDataText(callerWindowObj.GetMBO());
    txtaMBO_R.SetDataText(callerWindowObj.GetMBOResult_2());        
    txtaMBO.SetReadOnly(true);
    txtaMBO_R.SetReadOnly(true);
	txt1stScore.GetControl().focus();
	txt1stScore.text = g_1stScore;
	txt2ndScore.text = g_2ndScore;
	lblSelfScore.text = g_SelfScore;
	if(g_Eva_Level == 1)
	{
		td2ndSco.style.display = "none";
		txt2ndScore.style.display = "none";
		txt2ndScore.SetReadOnly(true);
		txt1stScore.SetReadOnly(false);		
	}
	else if(g_Eva_Level == 2)
	{
		td2ndSco.style.display = "";
		txt2ndScore.style.display = "";
		txt2ndScore.SetReadOnly(false);
		txt1stScore.SetReadOnly(true);
	}
}
function OnSave()
{
    var l_arr = new Array();
	l_arr[l_arr.length] = txt1stScore.text;
	l_arr[l_arr.length] = txt2ndScore.text;
	window.returnValue = l_arr;
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
            <td style="width:50%;height:70%">
                <gw:textarea id="txtaMBO" rows=25 styles='width:100%;'>
                </gw:textarea>
            </td>
            <td style="width:50%;height:70%">
                <gw:textarea id="txtaMBO_R" rows=25 styles='width:100%;'>
                </gw:textarea>
            </td>
        </tr>
		<tr>
			<td style="height:10%" colspan=2>
				<table border=0 cellpadding=0 cellspacing=0 style="width:100%">
					<tr>
						<td style="width:10%" align=right>Self Score&nbsp;</td>
						<td style="width:20%" align=left><gw:label id="lblSelfScore" text="" styles="width:100%; border:1px solid #6B9EB8;color: #000000; " /></td>
						<td style="width:15%" align=right>1st Score&nbsp;</td>
						<td style="width:20%" align=left><gw:textbox id="txt1stScore" text="" styles='width:100%;' /></td>
						<td id="td2ndSco" style="width:15%" align=right>2nd Score&nbsp;</td>
						<td style="width:20%" align=left><gw:textbox id="txt2ndScore" text="" styles='width:100%;' /></td>						
					</tr>
				</table>
			</td>		
		</tr>
        <tr>		
        <td style="height:10%" colspan=2>
            <table border=0 cellpadding=0 cellspacing=0 style="width:100%">
                <tr>
                    <td style="width:50%" align=right>
                        <gw:icon id="ibtnOK"  text="Save"  img="in"  styles="width:20%" onclick="OnSave()"/>
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
