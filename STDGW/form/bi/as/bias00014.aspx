<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>POP </title>
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
    //-------------------------
}  
//=======================================================================
function OnReport()
{
    callerWindowObj.OnReport(radType.value)      
    this.close(); 	
}
//=======================================================================
</script>

<body>
    <!---------------------------------------------------------------->
    <table style="width:100%;height:100%" >
        <tr style="height: 20%">
            <td style="font-size: large; color: Blue;width:100%" align="center">
                Stock Stranfer</td>
        </tr>
        <tr style="height: 10%">
            <td align="center" style="width: 100%">
                <gw:icon id="idBtnOk" img="2" text="Print Report" styles='width:50%' onclick="OnReport()" />
            </td>
        </tr>
        <tr style="height: 70%">
            <td style="width: 100%" align="center">
                <gw:radio id="radType" value="SG01" styles="width:100%"> 
					<span value="SG01">SONG GIA</span> <br/>
					
                    <span value="0">Stock Stranfer (Type 1)</span> <br/>
                    <span value="1">Stock Stranfer (Type 2)</span> <br/>
                    <span value="2">Stock Stranfer (Type 3)</span> <br/>
                    <span value="3">Stock Stranfer (Type 4)</span> <br/>                                              
                    <span value="4">Stock Stranfer (Type 5)</span> <br/>
                    <span value="ST01">Stock Stranfer (ST01)</span> <br/>
					
					<span value="PB01">Stock Stranfer (PB01)</span> <br/>
					<span value="PB02">Stock Stranfer (PB02)</span> <br/>
                </gw:radio>
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------->
</html>
