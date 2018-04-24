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
    data = "<%=ESysLib.SetGridColumnDataSQL(" select a.code, a.code || ' - ' || a.CODE_NM from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGHC0010' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.code " ) %>";       
    grdLotNo.SetComboFormat(7,data); 
    OnSearch();
    
}

//===============================================================

function OnSearch()
{
    data_shex00021.Call('SELECT');
}

//===============================================================
function OnDataReceive(obj)
{
    
}
//======================================================================
function OnSelect()
{
    if(chkCheckYN.value=='N')
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
    else
    {
        alert("Cannot select Release No already Registered");
    }
    
}
//===============================================================
</script>

<body>
    <!--------------------------------------------------------------------------------------->
    <gw:data id="data_shex00021" onreceive="OnDataReceive(this)">
        <xml>
            <dso id="3" type="grid" function="sale.sp_sel_shex00021" >
                <input bind="grdLotNo" >
                    <input bind="txtSlipNo" /> 
                    <input bind="chkCheckYN" />
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
                        <td style="width: 30%; white-space: nowrap" align="right">
                            Slip No
                        </td>
                        <td style="width: 40%">
                            <gw:textbox id="txtSlipNo" styles="width:100%" />
                        </td>
                        <td style="width: 5%; white-space: nowrap" align="left">
                            Check
                        </td>
                        <td style="width: 20%" align="left">
                            <gw:checkbox id="chkCheckYN" defaultvalue="Y|N" value="N" onchange="OnSearch()"/>
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn img="SELECT" alt="Seelct" onclick="OnSelect()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 97%">
            <td>
                <gw:grid id='grdLotNo' header='_PK|Release|Release Date|_tco_buspartner_pk|Customer|Check|Shipping Date|VATYN|_Customer_id|_Nation'
                    format='0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0' check='|||||||||' editcol='1|1|1|1|1|1|1|1|1|1'
                    widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' styles='width:100%; height:100%' oncelldblclick="OnSelect()" />
            </td>
        </tr>
    </table>
</body>
<gw:datebox id="dtnow" style="display: none" lang="1" />
<gw:textbox id="txtStartDT" styles="display:none" />
<gw:textbox id="txtStartTime" styles="display:none" />
<gw:textbox id="txtEndDT" styles="display:none" />
<gw:textbox id="txtEndTime" styles="display:none" />
<gw:textbox id="txtRtnValue" styles="display:none" />
<!--------------------------------------------------------------------------------------->
</html>
