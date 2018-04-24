<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>Printing_Popup</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script>

var company_pk;    
//======================================================================

function BodyInit()
{
    var data = ""; 
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.F_LOGISTIC_CODE2('LGMF0010') FROM DUAL" )%>";    
    lstMachineNo.SetDataText(data);
    dtFromDate.SetDataText(System.AddDate(dtToDate.GetData(),-7));
}

//======================================================================

function OnSearch()
{
    data_shab00110.Call('SELECT');
}

//======================================================================
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
//======================================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shab00110" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" function="prod.sp_sel_shpr00050_popup" >
                <input bind="grdLotNo" >
                    <input bind="lstMachineNo" />
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />
                    <input bind="txtLotNo" />
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
                        <td style="width:10%; white-space: nowrap" align=right>
                            Machine No
                        </td>
                        <td style="width:20%" >
                            <gw:list id="lstMachineNo" styles="width:100%" onchange="OnSearch('idGrid')" csstype="mandatory" />
                        </td>
                        <td style="white-space:nowrap">
                            Lot No.
                        </td>
                        <td style="width:20%">
                            <gw:textbox id="txtLotNo" styles="width:100%" />
                        </td>
                        <td style="width:10%; white-space: nowrap" align=right>
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
                    header='_PK|Lot No|Inst Date|Estimated Qty|Prod Rec. Qty|Mat No|Prod Name|_tco_buspartner_pk|Vend No|Vend Name|Size Code|Size Name|CAP Code|CAP Name|BODY Code|BODY Name|Dip Qty|_Hoki|_VG GU'
                    format='0|0|0|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    aligns='0|0|0|3|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1500|1200|1200|1200|2000|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    acceptnulldate="T"  oncelldblclick="OnSelect()"
					autosize='true'
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
