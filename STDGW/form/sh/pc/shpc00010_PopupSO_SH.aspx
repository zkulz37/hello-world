<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>POP UP GET ARRAY SO/PO NO</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script> 
    
var G_SO_PK         = 0,
    G_SO_No         = 1,
    G_Ord_DT        = 2,
    G_PO_No         = 3,
    G_BILL_TO_PK    = 4,
    G_Customer      = 5,
    G_Description   = 6;

//=======================================================================
function BodyInit()
{
    //---------------------------                  
    data_shpc00010_Popup.Call("SELECT");
}
//=======================================================================

 function OnSearch()
 {
    data_shpc00010_Popup.Call('SELECT')
 }
   
//=======================================================================
function OnSelect(oGrid)
{
    var code_data = new Array();
    
    var t_link = "" ;
    var array_so_pk = "" ;
    var array_so_po = "" ;
    
    for ( var i = 0; i < oGrid.rows; i++ )
    {
        if ( oGrid.GetGridControl().isSelected(i) == true )
        {
            array_so_pk = array_so_pk + t_link + oGrid.GetGridData(i , G_SO_PK );
            array_so_po = array_so_po + t_link + oGrid.GetGridData(i , G_PO_No );
            
            t_link = ',' ;
        }                
    }
    
    code_data[0] = array_so_pk ;
    code_data[1] = array_so_po ;    
    //----------------------------
    window.returnValue = code_data; 
    this.close(); 	
}
//=======================================================================
function OnCancel(oGrid)
{
    var code_data=new Array()
    
    code_data[0] = '' ;
    code_data[1] = '' ;
	    
    window.returnValue = code_data; 
    this.close(); 	
}
//=======================================================================

function OnDataReceive(obj)
{
    switch ( obj.id )
    {
        case 'data_shpc00010_Popup' :
            if ( grdDetail.rows > 1 )
            {
                grdDetail.SetCellBgColor( 1, G_PO_No, grdDetail.rows - 1, G_PO_No, 0xCCFFFF );
            }
        break;
    }    
}
//=======================================================================

</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_shpc00010_Popup" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid"  function="PROD.sp_sel_shpc00010_SH"  > 
			    <input bind="grdDetail" >
			        <input bind="txtSONo" />	
			        <input bind="dtFromDate" />	
			        <input bind="dtToDate" />		
			    </input> 
			    <output bind="grdDetail" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td align="right" style="width: 10%; white-space: nowrap">
                SO/PO NO</td>
            <td style="width: 40%">
                <gw:textbox id="txtSONo" styles='width:100%' csstype="mandatory" onenterkey="OnSearch(1)" />
            </td>
            <td align='right' style="width: 10%; white-space: nowrap">
                Ord Date</td>
            <td style="width: 20%; white-space: nowrap">
                <gw:datebox id="dtFromDate" lang="1" />
                ~
                <gw:datebox id="dtToDate" lang="1" />
            </td>
            <td style="width: 17%">
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch(1)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel(grdDetail)" />
            </td>
            <td align="right" style="width: 1%">
                <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdDetail)" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="8">
                <gw:grid id='grdDetail' header='_PK|S/O No|Ord DT|P/O No|_BILL_TO_PK|Customer|Description'
                    format='0|0|4|0|0|0|0' aligns='0|0|1|0|0|0|0' defaults='||||||' editcol='0|0|0|0|0|0|0'
                    widths='0|1500|1200|1500|0|2000|1000' sorting='T' styles='width:100%; height:100%'
                    />
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------->
</html>
