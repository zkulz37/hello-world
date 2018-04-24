<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Reports </title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<script>

    //=======================================================================
    var callerWindowObj = dialogArguments;
    function BodyInit() 
    {
        System.Translate(document);
    }
    //=======================================================================
    function OnReport() {
        callerWindowObj.OnReport(radType.value)
        this.close();
    }
    //=======================================================================
</script>
<body>
    <table border="0" style="height: 20%; width: 100%">
        <tr>
            <td colspan="3" style="font-size: large; color: Blue" align="center">
				Daily Stock Checking
            </td>
        </tr>
        <tr>
            <td align="center" colspan="3">
                <br />
                <gw:icon id="idBtnReport" img="2" text="Print Report" styles='width:40%' onclick="OnReport()" />
            </td>
        </tr>
        <tr style="height: 70%">
            <td colspan="2" style="width: 60%">
                <gw:radio id="radType" value="DR01" styles="width:100%"> 
                    <br/><br/>
                    <span value="DR01">DR : Daily Report</span><br/><br/>
					
                    <span value="SG01">SG : Daily Report</span><br/><br/>
					
					<span value="ST01">Type 1</span><br/><br/>
					
					<span value="ST02">Type 2</span><br/><br/>

					<span value="ST03">Type 3</span><br/><br/>
                </gw:radio>
            </td>
            <td>
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------->
</html>
