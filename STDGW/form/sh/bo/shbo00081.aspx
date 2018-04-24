<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>WI</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script>

var company_pk;    
//===============================================================

function BodyInit()
{
    var data = ""; 
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>";    
    lstMachineNo.SetDataText(data);
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
    //OnSearch();
}

//===============================================================

function OnSearch()
{
    data_shab00110.Call('SELECT');
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
    <gw:data id="data_shab00110" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" function="prod.sp_sel_shab00081" >
                <input bind="grdLotNo" >
                    <input bind="lstMachineNo" />
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />
                </input>
                <output bind="grdLotNo" />
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------------------->
    <table style="height: 100%; width: 100%" border="1">
        <tr style="height: 1%">          
            <td style="width: 100%">
                <table style="height: 100%; width: 100%" >
                     <tr style="height: 1%" >
                        <td style="width:10%; white-space: nowrap" align="right">
                            Machine No
                        </td>
                        <td style="width:30%" >
                            <gw:list id="lstMachineNo" styles="width:100%" onchange="OnSearch('idGrid')" csstype="mandatory" />
                        </td>
                        <td style="width:10%; white-space: nowrap" align="right">
                            Instructed DT
                        </td>
                        <td style="width:30%" >
                            <gw:datebox id="dtFromDate" lang="1" styles="width:100%" />
                            ~<gw:datebox id="dtToDate" lang="1" styles="width:100%" />
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
            <td >
                <gw:grid id="grdLotNo" 
                    header='Lot No|Inst Date|Mat Name|Vendor Name|Prod Qty|Prod Rec. Qty|Iss No'
                    format='0|4|0|0|0|0|0'
                    aligns='0|0|0|0|0|0|0'
                    defaults='||||||'
                    editcol='0|0|0|0|0|0|0'
                    widths='1500|1200|2000|2000|1200|1200|2000'
                    acceptnulldate="T"  oncelldblclick="OnSelect()"
                    sorting='T' styles="width:100%;height:100%" />
            </td>
        </tr>
    </table>
</body>
<gw:datebox id="dtnow" style="display:none" lang="1" />
<gw:textbox id="txtStartDT" styles="display:none" />
<gw:textbox id="txtStartTime" styles="display:none" />
<gw:textbox id="txtEndDT" styles="display:none" />
<gw:textbox id="txtEndTime" styles="display:none" />
<gw:textbox id="txtRtnValue" styles="display:none" />
<!--------------------------------------------------------------------------------------->
</html> 
