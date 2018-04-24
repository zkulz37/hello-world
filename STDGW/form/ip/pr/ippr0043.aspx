<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Line Info Display</title>    
</head>
<%  ESysLib.SetUser("stm")%>

<script> 
var p_date = "<%=request.QueryString("p_date") %>" ; 
var p_line = "<%=request.QueryString("line_id") %>" ; 
//------------------------------------------------------------------------------ 
    
function BodyInit()
{
    txtLine.text = p_line;
    txtDate.text = p_date;
    dat_ippr0043.Call("SELECT");
}

function OnDataReceive()
{       
    var count = 0;
    for( var i=1; i < grdView.rows;i++ )
    {
        for( var j=2;j<=7;j++)
        {
           if(Trim(grdView.GetGridData(i,j)) != ""){
                count += Number(grdView.GetGridData(i,j));
            }
        }
        
        grdView.SetGridText(i,8, count);
    }
    
    grdView.Subtotal(0,2, -1,'2!3!4!5!6!7');
}
//----------------------------------------------------------------------------- 

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="dat_ippr0043" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" user="stm" function="STM.sp_sel_ippr0043"  > 
                <input> 
                    <input bind="txtLine" />
                    <input bind="txtDate" />
                </input> 
                <output bind="grdView" /> 
            </dso> 
        </xml> 
    </gw:data>    
    <!------------------------------------------------------------------->
    <table style="width: 100%; height: 100%;"border="1" >
        <tr  style="height: 98%">
            <td  style="width: 100%">
                <gw:grid id='grdView'
                    header='Time|Style-PO#-Color|XS|S|M|L|XL|XXL|Total'
                    format='0|0|0|1|1|1|1|1|1'
                    aligns='0|2|3|3|3|3|3|3|3'
                    defaults='||||||||'
                    editcol='0|0|0|0|0|0|0|0|0'
                    widths='1500|5000|800|800|800|800|800|800|800'
                    sorting='T'
                    onafteredit=""
                    styles='width:100%; height:100%; font:6pt'
                />
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtDate" styles='width:100%;display:none' />
<gw:textbox id="txtLine" styles='width:100%;display:none' />
<!------------------------------------------------------->
</html>
