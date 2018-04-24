﻿<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Printing Popup</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script>

var p_box_gu = "<%=Request.querystring("box_gu")%>";  
//===============================================================

function BodyInit()
{
    var data = ""; 
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.F_LOGISTIC_CODE('LGMF0010') FROM DUAL" )%>";
    lstMachineNo.SetDataText(data);
    OnSearch();
}

//===============================================================

function OnSearch()
{
    data_shab00210.Call('SELECT');
}

//===============================================================
function OnDataReceive(obj)
{
    switch (obj.id)
    {
       
    }    
}
//======================================================================
function OnSelect()
{
    var code_data = new Array();       
    
    if ( grdLotNo.row > 0 )
    {
        for( j=0 ; j<grdLotNo.cols ; j++ )
        {
            code_data[j] = grdLotNo.GetGridData(grdLotNo.row , j );
        } 
    }
    else
    {
        for( j=0 ; j<grdLotNo.cols ; j++ )
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
    <gw:data id="data_shab00210" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" function="PROD.sp_sel_shbo00210_popup" >
                <input bind="grdLotNo" >
                    <input bind="lstMachineNo" />
                    <input bind="txtLotno" />
                </input>
                <output bind="grdLotNo" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr style="height: 1%">
            <td style="width: 100%">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Machine No
                        </td>
                        <td style="width: 30%">
                            <gw:list id="lstMachineNo" styles="width:100%" onchange="OnSearch()" csstype="mandatory" />
                        </td>
                        <td style="width: 10%; white-space: nowrap" align="right">
                            Lot No.
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtLotno" styles="width:100%" />
                        </td>
                        <td style="width: 14%" align="right">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="SELECT" alt="Seelct" onclick="OnSelect()" />
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
            <td>
                <gw:grid id='grdLotNo' header='_PK|Lot No|Hoki|Instructed Date|Product Qty|Issue No.' format='0|0|0|0|0|0' aligns='0|0|0|0|0|0'
                    check='|||||' editcol='1|1|1|1|1|1' widths='1000|1000|1000|1000|1000|1000'
                    sorting='T' autosize='T' styles='width:100%; height:100%'oncelldblclick="OnSelect()" />
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtBoxGu" styles="display:none" />
<!--------------------------------------------------------------------------------------->
</html>
