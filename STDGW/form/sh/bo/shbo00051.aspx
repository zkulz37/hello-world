<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Get Type No</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

var G1_Mat_PK    = 0,
    G1_Group     = 1,
    G1_Mat_Code  = 2,
    G1_Mat_Name  = 3; 
//===============================================================

function BodyInit()
{
    //------------------
	BindingDataList();
	OnSearch();	
}
//===============================================================

function BindingDataList()
{ 
//    var datalstType = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code3('LGMF0030') FROM DUAL" )%>";  
//    var datalstTrOP = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0040') FROM DUAL" )%>";
//    lstType.SetDataText(datalstType);
//    lstType.value = "<%=request.QueryString("type")%>" ;
//    lstTrOP.SetDataText(datalstTrOP);
}
//===============================================================
function OnSearch()
{
    data_shbo00051.Call('SELECT');
}
//===============================================================
function OnDataReceive(obj)
{
    
} 
//===============================================================
function OnSelect()
{
    
    var code_data = new Array();       
    
    if ( grdSearch.row > 0 )
    {
        for( j=0 ; j<grdSearch.cols ; j++ )
        {
            code_data[j] = grdSearch.GetGridData(grdSearch.row , j );
        } 
    }
    else
    {
        for( j=0 ; j<grdSearch.cols ; j++ )
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
    <gw:data id="data_shbo00051" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type="grid" function="PROD.sp_sel_shbo00051">
                <input bind="grdSearch" >
                    <input bind="txtColorNo" />
                </input>
                <output bind="grdSearch" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr>
            <td style="width: 100%" align="left" id="left">
                <table style="height: 100%; width: 100%">
                    <tr>
                        <td colspan="2">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 96%">
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="search" alt="Search" id="btnSearch" onclick="OnSearch()" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="select" alt="Save" id="btnSelect" onclick="OnSelect()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            Color</td>
                        <td style="width: 89%">
                            <gw:textbox id="txtColorNo" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|Color Code|Color Name|Galetin/1Pack|Pack Weight' format='0|0|0|0|0'
                                aligns='0|0|0|0|0' defaults='||||' editcol='1|1|1|1|1' widths='1000|1000|1000|1000|1000'
                                sorting='T' styles='width:100%; height:100%' oncelldblclick="OnSelect()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------------------->
</html>
