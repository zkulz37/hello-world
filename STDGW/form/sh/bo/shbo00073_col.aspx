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
    
    txtMain_m_pk.text = "<%=Request.querystring("p_main_m_pk")%>";
    dso_shbo00070_col.Call("SELECT");
	//-------------------------
	/*dtTo.SetDataText(System.AddDate(dtFrom.GetData(),30));
    var data = ""; 
    data = "<%=ESysLib.SetListDataFUNC("SELECT COMM.f_logistic_code2('LGMF0010') FROM DUAL" )%>";    
    lstMachineNo.SetDataText(data);  
    <%=ESysLib.SetGridColumnComboFormat("idGrid",4,"select   code, code_nm || ' - ' || code_nm from sale.lg_code a, sale.lg_code_group b where a.lg_code_group_pk = b.pk and b.group_id = 'LGMF0010' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>;  
    */
	OnFormatGrid();
	//---------------------------------------
}
//======================================================================
function OnFormatGrid()
{
    var trl;
    trl = idGrid.GetGridControl();	
    trl.ColFormat(5)           = "###,###,###,###,###.###"; 
    trl.ColFormat(7)           = "###,###,###,###,###.###";
}
//======================================================================
/*function OnSearch(obj)
{ 
    switch(obj)
    {
        case 'idGrid':
	            dso_shbo00070_add.Call("SELECT");
        break;
    }
   
}*/
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
        case 'dso_shbo00070_col':
            lblRecord.text = idGrid.rows-1 + " record(s)";
            if(idGrid.rows-1 > 0)
            {
                txtLotNo.text = idGrid.GetGridData(idGrid.rows-1,0);
            }
        break;
    }
}
//---------------------------------------------------------------------------
</script>

<body>
    <gw:data id="dso_shbo00070_col" onreceive="OnReceiveData(this)"> 
    <xml> 
           <dso id="1" type="grid" function="PROD.sp_sel_shbo00070_col" > 
                  <input bind="idGrid" > 
					<input bind="txtMain_m_pk" />
                  </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td style="width: 5%" align="right">
                
            </td>
            <td style="width: 5%">
            </td>
            
            <td style="width: 1%" align="right">
                <b></b>
            </td>
            <td style="width: 1%" align="left">
            </td>
            
            <td style="width: 4%"></td>
            <td style="width: 1%" align="right">
                
            </td>
            <td style="width: 19%; background-color:Red; font:20" align="center">
             Colorant   
            </td>
            <td style="width: 11%" align="right">
              Lot No 
            </td>
            <td style="width: 35%" align="right">
             <gw:textbox id="txtLotNo" styles="width:100%" readonly="true" />
            </td>
            <td style="width: 13%" align="right"><gw:label id="lblRecord" styles="color: blue">record(s)</gw:label></td> 
        </tr>
        <tr style="height: 98%">
            <td colspan="10">
                <gw:grid id="idGrid" header="_Lot No|Cap Gu|Item Code|Item Name|_Uom|Inst Qty|_Test No|_Use Ratio"
                    format="0|0|0|0|0|0|0|0" aligns="0|0|0|0|0|3|0|3" defaults="|||||||"
                    editcol="0|0|0|0|0|0|0|0" widths="1000|1000|1000|1000|1000|1000|1000|1000"
                    styles="width:100%; height:100%" sorting="T" oncelldblclick="OnSelect(idGrid)" autosize='T' />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMain_m_pk" style="display: none" />
    <!---------------------------------------------------------------->
</body>
</html>
