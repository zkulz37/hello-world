<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Starter</title>
</head>

<script>
function BodyInit()
{
   dsoStartTime.Call("SELECT"); 
}
function HourMin()
{
    var HHMM;
    var currentTime = new Date();
    var hours = currentTime.getHours();
    var minutes = currentTime.getMinutes();
    hours = ( hours < 10 ? "0" : "" ) + hours;
    minutes = ( minutes < 10 ? "0" : "" ) + minutes

    HHMM = hours + ":" + minutes;
    dsoStartTime.Call("SELECT"); 
    
}
function Settime()
{
  setInterval('HourMin()', 120000 ); 
  
}
function OnDataReceive(obj)
{
    if(obj.id=='dsoStartTime')
    {
        Settime();
    }
}
</script>

<body bgcolor='#F5F8FF'>
    <gw:data id="dsoStartTime" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid" function="CRM.sp_sel_jast00050">  
                <input >  
                </input>
                <output bind="grdStartTime" /> 
            </dso> 
        </xml> 
    </gw:data>
    <table style="width: 100%; height: 100%">
        <tr>
            <td>
                <table style="width: 100%; height: 100%">
                    <tr style="height: 98%">
                        <td colspan="9">
                            <gw:grid id='grdStartTime' header='No|Tee Time|Course|Member No|Player Name|Gender|Card No|Caddies No|Caddies Name'
                                format='0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0' defaults='||||||||'
                                editcol='0|0|0|0|0|0|0|0|0' widths='1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%'
                                autosize='T' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
