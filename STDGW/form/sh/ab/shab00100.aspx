<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Get Blending No</title>
</head>
<%  ESysLib.SetUser("prod")%>

<script>

var G1_Mat_PK    = 0,
    G1_Group     = 1,
    G1_Mat_Code  = 2,
    G1_Mat_Name  = 3; 
    var typeCode = "<%=Request.querystring("typeCode")%>";
//===============================================================

function BodyInit()
{
    //------------------
	BindingDataList();
	OnSearch();	
	//lstBlending .SetEnable(false);	
}
//===============================================================

function BindingDataList()
{ 
    var datalstBlending  = "<%=ESysLib.SetListDataSQLPara("select   code, code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0030' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 and a.CHA_VALUE1 = {0} order by a.def_yn desc, ord",request.QueryString("type") )%>";  
    lstBlending.SetDataText(datalstBlending );
    lstBlending.value= typeCode;
    
}
//===============================================================
function OnSearch()
{
    data_shab00100.Call('SELECT');
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
   <gw:data id="data_shab00100" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="1" type ="grid" function="PROD.sp_sel_shab00100">
                <input bind="grdSearch" >
                    <input bind="lstBlending" />
                    <input bind="txtBlendingNo" />
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
                        <td colspan=2>
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
                        <td style="width: 10%; white-space: nowrap">
                            Blending </td>
                        <td style="width: 90%" align="right" colspan="2">
                            <gw:list id="lstBlending" styles="width: 100%" onchange="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            Blending  No</td>
                        <td style="width: 89%">
                            <gw:textbox id="txtBlendingNo" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|Type  No|Type  Name|Blending No" format="0|0|0|0" aligns="0|0|0|0"
                                defaults="|||" editcol="0|0|0|0" widths="0|2000|2000|1500" styles="width:100%;height:100%" autosize='T'
                                oncelldblclick="OnSelect()" param="0,1,2,3" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------------------->
</html>
