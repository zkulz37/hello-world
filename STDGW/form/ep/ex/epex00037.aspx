<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>POP </title>
</head>
<%  ESysLib.SetUser("sale")%>

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
                Export Invoice</td>
        </tr>
        <tr style="height: 10%">
            <td align="center" style="width: 100%">
                <gw:icon id="idBtnOk" img="2" text="Print Report" styles='width:50%' onclick="OnReport()" />
            </td>
        </tr>
        <tr style="height: 70%">
            <td style="width: 100%" align="left">
                <gw:radio id="radType" value="DORCO_6" styles="width:100%"> 
				
					<span value="DORCO_6"> DORCO : Export Document </span> <br/>
					
					<span value="DORCO_1"> DORCO : Sale Contract </span> <br/> 					
                    <span value="DORCO_2"> DORCO : Invoice </span> <br/>
                    <span value="DORCO_3"> DORCO : Packing List </span> <br/>
					
                    <span value="DORCO_4"> DORCO : Ship Booking 1 </span> <br/> 
					<span value="DORCO_5"> DORCO : Ship Booking 2 </span> <br/> 
                </gw:radio>
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------->
</html>
