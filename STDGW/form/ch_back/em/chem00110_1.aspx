<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html>

<script>
    var opt;
    var winParent=null;
    function BodyInit(){
        opt = "<%=Request.QueryString("opt") %>";
        yn  = "<%=Request.QueryString("yn") %>";
        
        var callerWindowObj = dialogArguments;//windown
        
        if (yn == 'Y')
            txtaContent.SetDataText(callerWindowObj.GetOpinionContent(opt));
        else
        {
            txtaContent.SetDataText(callerWindowObj.GetOpinionContent(opt));
            idBtnOK.SetEnable(false);
            idBtnCancel.SetEnable(false);
        }
        //call 2 func :GetOpinionContent() and SetOpinionContent()
        
    }
function OnCancel(){
    window.close();
}    

function OnOK(){
    window.returnValue = txtaContent.GetData();
    window.close();
}
</script>

<body>
    <table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
        <tr style="height: 98%">
            <td>
                <table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                    <tr>
                        <td width="100%">
                            <gw:textarea id="txtaContent" rows="30" styles="width:100%" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 2%">
            <td>
                <table cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                    <tr>
                        <td width="45%" align="right">
                            <gw:icon id="idBtnOK" text="OK" img="in" onclick="OnOK()" />
                        </td>
                        <td width="10%"></td>
                        <td width="45%" >
                            <gw:icon id="idBtnCancel" text="Cancel" img="in" onclick="OnCancel()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
