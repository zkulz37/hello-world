<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>POP UP GET SPEC</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script> 
    

//=======================================================================
function BodyInit()
{
    var data;
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'") %> "; 
	grdMember.SetComboFormat(6,data); 
}
//=======================================================================

 function OnSearch()
 {
    data_jabk0034.Call('SELECT')
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
    
}
//=======================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_jabk0034" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid"  function="crm.sp_sel_jabk0034"  > 
			    <input bind="grdMember" >	
			        <input bind="txtMember" />		
			    </input> 
			    <output bind="grdMember" /> 
		    </dso> 
	    </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 5%">
                Member
            </td>
            <td style="width: 37%">
                <gw:textbox id="txtMember" styles='width:100%' onenterkey="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
            </td>
            <td style="width: 1%">
                <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(grdMember)" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnCancel" img="cancel" alt="Cancel" onclick="OnCancel(grdMember)" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="7">
                <gw:grid id='grdMember' header='Member ID|_MEMBER_TYPE_PK|Member Name|Phone|_TCO_BUSPARTNER_PK|ID/Passport|Gender |Age|_PK'
                    format='0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0' check='||||||||' editcol='1|1|1|1|1|1|1|1|1'
                    widths='1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T'
                    styles='width:100%; height:100%' oncelldblclick='OnSelect(grdMember)' />
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------->
<gw:textbox id="txtSTItemPK" text="" styles="display:none" />
<!---------------------------------------------------------------------->
</html>
