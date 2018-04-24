<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>POP UP GET SO/PO NO</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script> 
    
var G_SO_PK         = 0,
    G_SO_No         = 1,
    G_Ord_DT        = 2,
    G_PO_No         = 3,
    G_Style         = 4,
    G_BILL_TO_PK    = 5,
    G_Customer      = 6,
    G_Description   = 7;

//=======================================================================
function BodyInit()
{
	System.Translate(document);
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFromDate.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFromDate.value=ldate ;   
    //---------------------------                  
    data_kblc00172.Call("SELECT");
}
//=======================================================================

 function OnSearch()
 {
    data_kblc00172.Call('SELECT')
 }
   
//=======================================================================
function OnSelect(oGrid)
{
        var code_data = new Array();       
	    
	    if ( oGrid.row > 0 )
	    {
            for( j=0 ; j<oGrid.cols ; j++ )
            {
                code_data[j] = oGrid.GetGridData(oGrid.row , j );
            } 
	    }
	    else
	    {
            for( j=0 ; j<oGrid.cols ; j++ )
            {
                code_data[j] = '';
            } 	    
	    }
	    //----------------------------
	    window.returnValue = code_data; 
	    this.close(); 	
}
//=======================================================================
function OnCancel(oGrid)
{
    var code_data=new Array()
    
    for( j=0 ; j < oGrid.cols ; j++ )
    {
        code_data[j] = '' ;
    } 
	    
    window.returnValue = code_data; 
    this.close(); 	
}
//=======================================================================

function OnDataReceive(obj)
{
    switch ( obj.id )
    {
        case 'data_kblc00172' :
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
    <gw:data id="data_kblc00172" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid"  function="<%=l_user%>lg_sel_kblc00172"  > 
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
                SO/PO/Style
            </td>
            <td style="width: 50%">
                <gw:textbox id="txtSONo" styles='width:100%' csstype="mandatory" onenterkey="OnSearch(1)" />
            </td>
            <td align='right' style="width: 10%; white-space: nowrap">
                Ord Date
            </td>
            <td style="width: 20%; white-space: nowrap">
                <gw:datebox id="dtFromDate" lang="1" />
                ~
                <gw:datebox id="dtToDate" lang="1" />
            </td>
            <td style="width: 7%">
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
                <gw:grid id='grdDetail' header='_PK|Slip No|Postage|Exchange Commission|Alternative Fee|Delay|Less|Other|Deduct Amount|_Order_PK|Order No|_LC_PK|L/C No'
                    format='0|0|1|1|1|1|1|1|1|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0' check='||||||||||||' editcol='1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'
                    widths='1400|1400|1400|1400|1400|1400|1200|1200|1400|1200|1200|1200|1200' sorting='T' styles='width:100%; height:100%'
                    oncelldblclick="OnSelect(grdDetail)" />
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------->
</html>
