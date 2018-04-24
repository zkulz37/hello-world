<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<head id="Head1" runat="server">
    <title>P/O No</title>
</head>

<script>
    
//===========================================================

 function BodyInit()
 {
    System.Translate(document);
    //----------------------
    txtWIMasterPK.text = "<%=Request.querystring("WI_PK")%>";
	//----------------
    pro_dsep00077.Call();
	//----------------
 } 
//==============================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="pro_dsep00077" onreceive=""> 
        <xml> 
            <dso  type="process" procedure="<%=l_user%>lg_pro_dsep00077" > 
                <input>
                    <input bind="txtWIMasterPK" />
                </input> 
                <output>
                    <output bind="txtPONo" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%;">
        <tr>
            <td>
                <gw:textarea id="txtPONo" styles="width: 100%;height: 99%" />
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------>
    <gw:textbox id="txtWIMasterPK" styles='width:100%;display:none' />
    <!------------------------------------------------------------------>
</body>
</html>
