<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Packaging_Popup</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script>

var company_pk;    
//===============================================================

function BodyInit()
{
    OnSearch();
}

//===============================================================

function OnSearch()
{
    data_shbo00100_packing.Call('SELECT');
}

//===============================================================
function OnDataReceive(obj)
{
    lblRecord.text = grdPacking.rows - 1 + ' record(s)';
}
//======================================================================
function OnSelect()
{
    var code_data = new Array();       
    
    if ( grdPacking.row > 0 )
    {
        for( j=0 ; j<grdPacking.cols ; j++ )
        {
            code_data[j] = grdPacking.GetGridData(grdPacking.row , j );
        } 
    }
    else
    {
        for( j=0 ; j<grdPacking.cols ; j++ )
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
    <gw:data id="data_shbo00100_packing" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" function="prod.sp_sel_shbo00100_packing" >
                <input bind="grdPacking" >
                    <input bind="txtPackageCode" />
                </input>
                <output bind="grdPacking" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr style="height: 1%">          
            <td style="width: 100%">
                <table style="height: 100%; width: 100%" >
                     <tr style="height: 1%" >
                        <td style="width:10%; white-space: nowrap" align=right>
                            Packing Unit
                        </td>
                        <td style="width:30%" >
                            <gw:textbox id="txtPackageCode" styles="width:100%" onenterkey="OnSearch()"/>
                        </td>
						<td align="right">
							<gw:label id="lblRecord" style="width:100%; color: blue">record(s)</gw:label>
						</td>
                     </tr>
                 </table>  
            </td> 
        </tr>
        <tr style="height: 1%">
            <td style="width: 100%">
               
            </td>
        </tr>
        <tr style="height: 97%">
            <td >
                <gw:grid id="grdPacking" 
                    header='_PK|Packing Unit|Packaing Qty'
                    format='0|0|1'
                    aligns='0|0|3'
                    defaults='||'
                    editcol='0|0|0'
                    widths='0|1200|1000'
                    acceptnulldate="T"  
					oncelldblclick="OnSelect()"
                    sorting='T' styles="width:100%;height:100%" />
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------------------->
</html> 
