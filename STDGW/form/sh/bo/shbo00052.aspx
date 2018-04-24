<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Get Test No </title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>
    
var G2_PK           = 0,
    G2_tco_item_pk  = 1,
    G2_Test_No      = 2,
    G2_Enter_Date   = 3,
    G2_Valid        = 4,
    G2_Change_Date  = 5;
//===============================================================

function BodyInit()
{
    data_shbo00052.Call('SELECT');
}
//===============================================================

function BindingDataList()
{ 
    txtMatCode.SetEnable(false);
}
//===============================================================
function OnSearch()
{
    data_shbo00052.Call('SELECT');                
}
//===============================================================
function OnDataReceive(obj)
{
  
}
//------------------------------------------------------------------------------------	
function OnSelect()
{
    
    var code_data = new Array();       
    
    if ( grdTestNo.row > 0 )
    {
        for( j=0 ; j<grdTestNo.cols ; j++ )
        {
            code_data[j] = grdTestNo.GetGridData(grdTestNo.row , j );
        } 
    }
    else
    {
        for( j=0 ; j<grdTestNo.cols ; j++ )
        {
            code_data[j] = '';
        } 	    
    }
    //----------------------------
    window.returnValue = code_data; 
    this.close(); 	
}
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shbo00052" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid"  function="prod.sp_sel_shbo00052" >
                <input bind="grdTestNo" >
                    <input bind="txtMatCode" />
                </input>
                <output bind="grdTestNo" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr>
            <td style="width: 100%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Mat</td>
                        <td style="width: 65%; white-space: nowrap">
                            <gw:textbox id="txtMatCode" styles="width: 100%" />
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="select" alt="Select" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="9">
                            <gw:grid id='grdTestNo' header='_PK|Item Code|Item Name|Unit' format='0|0|0' aligns='0|0|0'
                                defaults='||' editcol='1|1|1' widths='1000|1000|1000' sorting='T' styles='width:100%; height:100%'
                                oncelldblclick="OnSelect()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------------------->
</html>
