<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>POP UP GET SPEC</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script> 
    
var G_PK            = 0,
    G_Caddy_ID      = 1,
    G_Full_Name     = 2,
    G_Gender        = 3;

//=======================================================================
function BodyInit()
{
       
}
//=======================================================================

 function OnSearch()
 {
    data_jabk0033.Call('SELECT')
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
            alert("You have not selected a caddy."); 	    
			return;
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
    
}
//=======================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_jabk0033" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid"  function="crm.sp_sel_jabk0033"  > 
			    <input bind="grdCaddy" >	
			        <input bind="txtSpec" />		
			    </input> 
			    <output bind="grdCaddy" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%">
                Caddy
            </td>
            <td style="width: 37%">
                <gw:textbox id="txtSpec" styles='width:100%' onenterkey="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdCaddy)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel(grdCaddy)" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="7">
                <gw:grid id='grdCaddy' header='_PK|Caddy ID|Full Name|Gender' format='0|0|0|0'
                    aligns='0|0|0|0' check='||||' editcol='1|1|1|1' widths='1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%'oncelldblclick='OnSelect(grdCaddy)'  />
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------->
<gw:textbox id="txtSTItemPK" text="" styles="display:none" />
<!---------------------------------------------------------------------->
</html>
