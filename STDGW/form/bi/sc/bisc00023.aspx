<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>W/H Stock Checking 3</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>


<script>

var G_WH           = 0,  
    G_TRANS_TYPE   = 1,   
    G_TR_DATE      = 2,
    G_SLIP_NO      = 3,
	G_ITEM_CODE	   = 4,
	G_ITEM_NAME    = 5,  
    G_LOT_NO       = 6,
    G_IN_QTY       = 7,  
    G_OUT_QTY      = 8;
    
//===========================================================================
function BodyInit()
{
    System.Translate(document); 
    
     var callerWindowObj = dialogArguments;
    
	dtFrom.value    = callerWindowObj.dtDTFrom.value;
	dtTo.value      = callerWindowObj.dtDTTo.value;
	lstWHType.value = callerWindowObj.lstWHType01.value;
	lstWH.value     = callerWindowObj.lstWH01.value;
	
	
	txtItem.text    = callerWindowObj.vITEM_ID;
	   
    //----------------
    SetGridFormat();
    //-----------------  
    data_bisc00023.Call('SELECT');
}
//===========================================================================
function SetGridFormat()
{ 
    var ctrl = grdStockTrans.GetGridControl();   
    
    ctrl.MergeCells = 2;
    ctrl.MergeCol(0) = true;
    ctrl.MergeCol(1) = true;
    ctrl.MergeCol(2) = true;
    ctrl.MergeCol(3) = true;
    ctrl.MergeCol(4) = true;
    ctrl.MergeCol(5) = true;
    ctrl.MergeCol(6) = true;
	
    ctrl.ColFormat(G_IN_QTY)  = "###,###,###.##" ;  
	ctrl.ColFormat(G_OUT_QTY) = "###,###,###.##" ; 
	
	var  data = "<%=ESysLib.SetListDataFUNC("SELECT LG_F_LOGISTIC_CODE('LGIN0210') FROM DUAL" )%>||Select ALL";
    lstWHType.SetDataText(data);
    lstWHType.value = '';
	
	data = "<%=ESysLib.SetListDataSQL("select pk, wh_id || ' * ' || wh_name from tlg_in_warehouse where del_if = 0 and use_yn='Y' order by wh_id")%>";
	lstWH.SetDataText( data + "||");
    lstWH.value = ''; 
	
    data = "<%=ESysLib.SetListDataSQL("SELECT TRANS_CODE ,TRANS_CODE || ' - ' || trans_name  FROM tlg_in_trans_code  WHERE del_if = 0 and ( trans_type = 'I' or trans_type = 'O' )ORDER BY trans_code" )%>||";    
    lstTransType.SetDataText(data);	
	lstTransType.value = "" ;
}
//===========================================================================
 
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'data_bisc00023':            
            grdStockTrans.Subtotal( 0, 2, 0, '7!8','###,###,###.##');
        break;                
    }
}
//===========================================================================

function OnSearch(pos)
{
	switch(pos)
	{
		case 'BALANCE':
			data_bisc00023.Call("SELECT");
		break;
	}
}
//===========================================================================
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bisc00020" onreceive="OnDataReceive(this)">
        <xml>
            <dso  type="list" procedure="<%=l_user%>lg_pro_bisc00020" >
                <input>
                    <input bind="lstWHType" />
                </input>
                <output>
                    <output bind="lstWH" />
                </output>
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="data_bisc00023" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" function="<%=l_user%>lg_sel_bisc00023" > 
                <input> 
					<input bind="lstTransType" />
					<input bind="lstWH" />                    		
                    <input bind="dtFrom" />
                    <input bind="dtTo" />                
                    <input bind="txtItem" />
                </input> 
                <output bind="grdStockTrans" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="height: 100%; width: 100%">
		<tr>
			<td style="width: 5%; white-space: nowrap" align="right">
                Type
            </td>
            <td style="width: 25%" align="right">
                <gw:list id="lstTransType" styles="width:100%" onchange="OnSearch('BALANCE')" />
            </td>
			
			<td style="width: 5%; white-space: nowrap" align="right">
                Date
            </td>
            <td style="width: 25%; white-space: nowrap">
                <gw:datebox id="dtFrom" lang="1"   />
                ~
                <gw:datebox id="dtTo" lang="1"   />
            </td>									 			          
			<td style="width: 5%; white-space: nowrap" align="right">
                Item
            </td>
            <td style="width: 25%">
                <gw:textbox id="txtItem" maxlen="100" styles='width:100%' onenterkey="OnSearch('BALANCE')" />
            </td>
			<td style="width: 5%">                 
            </td>
            <td style="width: 5%" align="right">
				<gw:imgbtn img="search" alt="Search" id="btnSearch2" onclick="OnSearch('BALANCE')" />
			</td>
		</tr>
		<tr>			 
			<td style="width: 5%; white-space: nowrap" align="right">
                W/H
            </td>
            <td style="width: 25%" align="right">
                <gw:list id="lstWHType" styles="width:100%" onchange="pro_bisc00020.Call('SELECT')" />
            </td>
			<td  colspan=2 style="width: 20%; white-space: nowrap">
				<gw:list id="lstWH" styles="width: 100%" onchange="OnSearch('BALANCE')" />
			</td>
			
            <td style="width: 5%; white-space: nowrap" align="right">                
            </td>
            <td style="width: 25%">                
            </td>
			<td style="width: 5%">                 
            </td>
            <td style="width: 5%" align="right">				 
			</td>
		</tr>
        <tr style="height: 100%">
            <td colspan=10>
                <gw:grid id='grdStockTrans' header='W/H|Type|Date|Slip No|Item Code|Item Name|Lot No|In Qty|Out Qty'
                    format='0|0|4|0|0|0|0|0|0' 
					aligns='0|0|1|0|0|0|1|3|3' 
					defaults='||||||||' 
					editcol='0|0|0|0|0|0|0|0|0'
                    widths='1500|1200|1200|1200|1200|2500|1200|1200|1200' sorting='T' styles="width:100%; height:100%" />
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------->
 
</html>
