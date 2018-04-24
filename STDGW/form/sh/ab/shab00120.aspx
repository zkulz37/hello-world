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
    BindingDataList();
    dtFrom.SetDataText(System.AddDate(dtTo.GetData(),-7));
    OnSearch();
}
//===============================================================
function BindingDataList()
 {    
        var data="";
        data = "<%=ESysLib.SetListDataSQL("SELECT pk,PARTNER_NAME from  comm.TCO_COMPANY where del_if=0 order by PARTNER_NAME ")%>";
        lstCompany.SetDataText(data);
        data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code2('LGMF0010') FROM DUAL" )%>|ALL|Select All";    
        lstMachineNo.SetDataText(data);
 }
//===============================================================

function OnSearch()
{
    data_shab00040.Call('SELECT');
}

//===============================================================
function OnDataReceive(obj)
{
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
    <gw:data id="data_shab00040" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" function="prod.sp_sel_shab00120_1" >
                <input bind="grdLotNo" >
                    <input bind="lstCompany" />
                    <input bind="lstMachineNo" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtLOTNo" />
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
                     <tr style="height: 2%">
                        <td style="width: 15%" align="right" >
                            <b>Company</b>
                        </td>
                        <td style="width: 25%" align="right">
                            <gw:list id="lstCompany" styles='width:100%'  />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Period Date</b>
                        </td>
                        <td style="width: 30%;white-space:nowrap" >
                            <gw:datebox id="dtFrom" onchange="OnSearch()" lang="1" />
                           ~
                           <gw:datebox id="dtTo" onchange="OnSearch()" lang="1"/>
                        </td>
                        <td style="width: 10%" align="right">
                            <gw:label id="lblPinType" styles="width: 100%; color: red" />
                        </td>
                        <td style="width: 24%" align="right">
                        </td>
                        <td style="width: 3%" align="right">
                            <gw:imgbtn img="search" alt="New" id="btnSearch" onclick="OnSearch()" />
                        </td>
                        <td style="width: 3%">
                            <gw:imgbtn img="SELECT" alt="Search" onclick="OnSelect()" />
                        </td>
                        <td style="width: 3%">
                        </td>
                        <td style="width: 3%">
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 15%" align="right">
                            <b>Machine No</b>
                        </td>
                        <td style="width: 25%" align="right">
                           <gw:list id="lstMachineNo"  styles='width:100%' onchange="OnSearch()" />
                        </td>
                        <td style="width: 15%" align="right">
                            LOT No
                        </td>
                        <td style="width: 40%" align="right">
                            <gw:textbox id="txtLOTNo" styles="width: 100%" />
                        </td>
                        <td style="width: 24%" align="right">
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
                    header='_pk|Lot No|Instructed Date|Product Code|Product Name|Customer Code|Customer Name|Cap Col|Body Col|Prod Qty|Prod Rec. Qty.'
                    format='0|0|4|0|0|0|0|0|0|0|0' aligns='0|0|1|0|0|0|0|1|1|3|3' defaults='||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0' widths='0|1600|1500|1400|2500|1500|2000|1000|1000|1000|1000'
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
