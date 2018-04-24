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
    var  matno = "<%=request.QueryString("matno")%>" ;
    var matname = "<%=request.QueryString("matname")%>" ;
    txtMatCode.text = matno;
    txtMatName.text = matname;
    OnSearch('TESTNO');
}
//===============================================================

function BindingDataList()
{ 
    txtMatCode.SetEnable(false);
    txtMatName.SetEnable(false);
}
//===============================================================
function OnSearch(p)
{
     if (p == 'TESTNO')
    {
        data_shab00050.Call('SELECT');            
    }      
}
//===============================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case 'data_shab00050_1':
            grdTestNo.ClearData();
        break;
    }    
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
    <gw:data id="data_shab00050" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" parameter="0,1,2,3,4,5" function="prod.sp_sel_shab00050" >
                <input bind="grdTestNo" >
                    <input bind="txtMatCode" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
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
                            <gw:textbox id="txtMatCode" styles="width: 30%" />
                            <gw:textbox id="txtMatName" styles="width: 70%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="right">
                            Enter Date</td>
                        <td style="width: 20%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch('TESTNO')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="select" alt="Select" onclick="OnSelect()" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="11">
                            <gw:grid id="grdTestNo" header="_PK|_tco_item_pk|Test No|Enter Date|Valid Y/N|Change Date"
                                format="0|0|0|4|3|4" aligns="0|0|0|1|0|1" defaults="||||1|" editcol="0|0|1|1|1|1"
                                widths="0|0|2000|1500|1500|1500" styles="width:100%;height:100%" oncelldblclick="OnSelect()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!--------------------------------------------------------------------------------------->
</html>
