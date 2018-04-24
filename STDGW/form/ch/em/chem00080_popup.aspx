<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Details</title>
</head>

<script>
//---------------------------------------------------------------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ; 
 var g_contents = "";
 var g_view_level = "";
 var g_control = "";
//---------------------------------------------------------------------	        
function BodyInit()
{	
	g_view_level = "<%=Request.querystring("VIEW_LEVEL")%>" 
	g_control = "<%=Request.querystring("CTRL")%>" 
	var callerWindowObj = dialogArguments;//window		
	
	if(g_control == 'txtInfo3')
	{
		txtDetails.SetDataText(callerWindowObj.GetOpinionEva_1St());
	}
	else if(g_control == 'txtInfo5')
	{
		txtDetails.SetDataText(callerWindowObj.GetOpinionEva_2nd());
	}
	else if(g_control == 'txtInfo4')
	{
		txtDetails.SetDataText(callerWindowObj.GetOpinionPos_1St());
	}
	else if(g_control == 'txtInfo6')
	{
		txtDetails.SetDataText(callerWindowObj.GetOpinionPos_2nd());
	}	
	else if(g_control == 'txtInfo1')
	{
		txtDetails.SetDataText(callerWindowObj.GetMBOPlan());
	}	
	else if(g_control == 'txtInfo2')
	{
		txtDetails.SetDataText(callerWindowObj.GetMBOResult());
	}	
	idBtnOK.SetEnable(false);
	txtDetails.SetReadOnly(true);
	
	if((g_control == 'txtInfo3' || g_control == 'txtInfo4') && g_view_level == '1')
	{
		idBtnOK.SetEnable(true);
		txtDetails.SetReadOnly(false)
	}		
	else if((g_control == 'txtInfo5' || g_control == 'txtInfo6') && g_view_level == '2')		
	{
		idBtnOK.SetEnable(true);
		txtDetails.SetReadOnly(false);		
	}			
}
//---------------------------------------------------------------------
function OnUpdate()
{
	var i = 0;
    var code_data=new Array()
    code_data[i] = txtDetails.GetData();	
	i++;
	window.returnValue = code_data; 
    window.close(); 	    
}
//---------------------------------------------------------------------
</script>

<body>
      <table style="width:100%; height:100%; " >
          <tr style="height:90%">                                        
              <td style="width:100%" colspan="2" align="left"><gw:textarea id="txtDetails" rows="29" styles="width:100%; "  /></td>
          </tr>
	<tr style="height:10%">
		<td align="right" style="width:45%" ><gw:icon id="idBtnOK" img="in" text="OK" onclick="OnUpdate()" /></td>
		<td align="left" style="width:55%"><gw:icon id="idBtnCancel" img="in" text="Cancel" onclick="window.close()" /></td>
	</tr>
      </table>
</body>
</html>