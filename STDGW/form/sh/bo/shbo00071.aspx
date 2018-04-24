<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get One Item</title>
</head>
<%  ESysLib.SetUser("prod")
  
%>

<script>
//======================================================================
function BodyInit()
{
	//-------------------------
	dtTo.SetDataText(System.AddDate(dtFrom.GetData(),30));
    var data = ""; 
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code('LGMF0010') FROM DUAL" )%>";    
    lstMachineNo.SetDataText(data);  
    <%=ESysLib.SetGridColumnComboFormat("idGrid",4,"select   code, code_nm || ' - ' || code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0010' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
	OnFormatGrid();
	//---------------------------------------
}
//======================================================================
function OnFormatGrid()
{
    var trl;
    trl = idGrid.GetGridControl();	
    trl.ColFormat(6)           = "###,###,###,###,###.##"; 
    trl.ColFormat(7)           = "###,###,###,###,###.##";
}
//======================================================================
function OnSearch(obj)
{ 
    switch(obj)
    {
        case 'idGrid':
	            data_fpab00110_1.Call("SELECT");
        break;
    }
   
}
//======================================================================
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

//======================================================================
function OnReceiveData(obj)
{
    switch(obj.id)
    {
        case 'data_fpab00110_1':
            lblRecord.text = idGrid.rows-1 + " record(s)";
        break;
    }
}
//---------------------------------------------------------------------------
</script>

<body>
    <gw:data id="data_fpab00110_1" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="PROD.sp_sel_shbo00070_batlot_m" > 
                  <input bind="idGrid" > 
                    <input bind="lstMachineNo" />
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
					<input bind="txtLotNo" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 1%">
            <td style="width: 15%" align="right">
                Machine No
            </td>
            <td style="width: 25%">
                <gw:list id="lstMachineNo" styles="width:100%" onchange="OnSearch('idGrid')" csstype="mandatory" />
            </td>
            <td style="width: 4%" align="right">
                <b>Date</b>
            </td>
            <td style="width: 7%" align="left">
                <gw:datebox id="dtFrom" onchange="OnSearch()" lang="<%=Session("Lang")%>" />
            </td>
            <td style="width: 2%">
                ~</td>
            <td style="width: 7%">
                <gw:datebox id="dtTo" onchange="OnSearch()" lang="<%=Session("Lang")%>" />
            </td>
            <td style="width: 14%" align="right">
                Lot No
            </td>
            <td style="width: 24%">
                <gw:textbox id="txtLotNo" styles="width:100%" onenterkey="OnSearch('idGrid')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch('idGrid')" />
            </td>
            <td style="width: 1%" align="right">
                <gw:imgbtn id="btnSelect" img="select" alt="Select" onclick="OnSelect(idGrid)" />
            </td>
        </tr>
        <tr style="height: 1%">
            <td colspan="10">
                <table width="100%" style="height: 100%">
                    <tr align="right">
                        <td style="width: 5%;" align="right">
                        </td>
                        <td style="width: 95%;" align="left">
                            <gw:label id="lblRecord" styles="color: blue">record(s)</gw:label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 47%">
            <td colspan="10">
                <gw:grid id="idGrid" header="_PK|Lot No|Item Code|Item Name|Hoki|Porder Date|Porder Qty|Target Qty|Size Code|Size Name|Cap Color Code|Cap Color Name|Body Color Code|Body Color Name|Blend No|Partner ID|Partner Name|_Item_pk"
                    format="0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|0|3|3|1|1|1|0|1|0|0|0|0|0"
                    defaults="|||||||||||||||||" editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" widths="1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"
                    styles="width:100%; height:100%" sorting="T" oncelldblclick="OnSelect(idGrid)"
                    autosize='T' />
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------->
</body>
</html>
