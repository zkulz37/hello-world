<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head id="Head1" runat="server">
    <title>WI</title>
</head>
<%  ESysLib.SetUser("comm")%>

<script>

var company_pk;    
//===============================================================
var l_inst_qty = 5,
    l_target_qty = 6;
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
        data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>|ALL|Select All";    
        lstMachineNo.SetDataText(data);
       var trl ;
      trl = grdLotNo.GetGridControl();
      trl.ColFormat(l_inst_qty )         = "###,###,###,###";
       trl.ColFormat(l_target_qty )         = "###,###,###,###";
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
            <dso id="3" type="grid" function="prod.sp_sel_shab00040_1" >
                <input bind="grdLotNo" >
                    <input bind="lstCompany" />
                    <input bind="lstMachineNo" />
                    <input bind="txtCapPinNo" />
                    <input bind="txtBodyPinNo" />
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
                            <gw:list id="lstCompany" styles='width:100%' />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Cap Pin No</b>
                        </td>
                        <td style="width: 30%" align="right">
                            <gw:textbox id="txtCapPinNo" styles="width: 100%" />
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
                           <gw:list id="lstMachineNo"  styles='width:100%' />
                        </td>
                        <td style="width: 15%" align="right">
                            <b>Body Pin No</b>
                        </td>
                        <td style="width: 40%" align="right">
                            <gw:textbox id="txtBodyPinNo" styles="width: 100%" />
                        </td>
                        <td style="width: 24%" align="right">
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 15%" align="right">
                            <b>Period Date</b>
                        </td>
                        <td style="width: 40%" align="left">
                           <gw:datebox id="dtFrom" onchange="OnSearch()" lang="1" />
                           ~
                           <gw:datebox id="dtTo" onchange="OnSearch()" lang="1"/>
                        </td>
                        <td style="width: 15%" align="right">
                            LOT No
                        </td>
                        <td style="width: 40%" align="left">
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
                    header='_PK|_Item_pk|Product Code|Product Name|Lot No|Intructed Qty|Target Qty|Intructed Date|Require Day|Issue No|Type Code|Type Text|Size|Cap Color|Body Color|Printing|Customer Code|Customer Name|Color Match|_Company_PK|_HOKI|_CapPinNo|_BodyPinNo|_TCO_BUSPARTNER_PK|_PrintType_YN'
                    format='0|0|0|0|0|1|1|4|0|0|0|0|0|0|0|0|0|0|3|0|0|0|0|0|0' aligns='0|0|0|0|0|3|3|0|3|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0' defaults='||||||||||||||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' widths='1000|1200|1200|1500|1500|1500|1500|1500|1500|1700|1500|1500|1500|1500|1500|1700|1500|1500|1500|1000|1000|1000|1000|1000|1000'
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
