<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>POPUP GET GOLFER PROFILE</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script> 
    

//=======================================================================
function BodyInit()
{
    var data="";
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" )%>"; 
	grdMember.SetComboFormat(3,data);
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'" ) %> "; 
	grdMember.SetComboFormat(5,data); 
    OnSearch();	
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
function OnNew()
{
   var path = System.RootURL + "/form/ja/st/jast00070.aspx";
            var obj = System.OpenModal( path ,700 , 350,  'resizable:yes;status:yes'); 
}
//=======================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_jabk0034" onreceive="OnDataReceive(this)"> 
	    <xml> 
		    <dso type="grid"  function="CRM.sp_sel_jast00070"  > 
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
            <td style="width: 15%">
                Player Name
            </td>
            <td style="width: 26%">
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
            <td style="width: 1%" align="right">
                <gw:imgbtn id="idBtnNewM" img="new" text="Add" alt="New" styles='width:100%' onclick="OnNew()" />
            </td>
        </tr>
        <tr style="height: 99%">
            <td colspan="7">
                <gw:grid id='grdMember' header="_PK|No|Golfer Name| Gender|Birthday|Nationality| Mobile Phone| Telephone| Home  Address| Company Name|Company Address| Company Phone|Hobby| Description| Tax Code"
				format="0|0|0|0|4|0|0|0|0|0|0|0|0|0|0"
				aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
				check="||0|0||0|||||||||"
				defaults="||||||||||||||" 
				editcol="0|0|1|1|1|1|1|1|1|1|1|1|1" 
				widths="0|1000|1500|2000|1200|30000|1500|2000|1200|3000|100|1000"
				sorting='T'
				acceptNullDate="T"
				autosize='T'
				styles="width:100%; height:100%" />
            </td>
        </tr>
    </table>
</body>
<!---------------------------------------------------------------------->
<gw:textbox id="txtSTItemPK" text="" styles="display:none" />
<!---------------------------------------------------------------------->
</html>
