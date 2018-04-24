<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pop Up Get Many Item</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script>

var c_ITEM_CODE=0,
c_ITEM_NAME=1,
c_UOM=2,c_ITEM_CODE_CONS=3,c_ITEM_NAME_CONS=4,
c_UOM_CONS=5,
c_CONS_QTY=6,
c_UNIT_PRICE=7,
c_ADJUST_PRICE=8,
c_REMARK = 9,
c_SO_STATUS = 10,
c_PK=11,
c_TLG_SA_SALEORDER_M_PK=12,
c_TLG_SA_SALEORDER_D_PK=13,
c_TLG_IT_ITEM_PK=14,
c_TLG_ITEM_CONS_PK=15;

var l_so_status;
var l_check_update=0;

//------------------------------------------------------------------------------------------------
function BodyInit()
{
    System.Translate(document);

    txtSOMasterPK.text="<%=request.QueryString("p0")%>";
    txtSODetailPK.text="<%=request.QueryString("p1")%>";
    txtItemPK.text="<%=request.QueryString("p2")%>";
    txtMaskUnitPrice.text="<%=request.QueryString("p3")%>";
    idGrid.GetGridControl().ColFormat(c_UNIT_PRICE)  = txtMaskUnitPrice.text;
    idGrid.GetGridControl().ColFormat(c_ADJUST_PRICE)  = txtMaskUnitPrice.text;

    var ctrl = idGrid.GetGridControl();

    ctrl.MergeCells = 2;
    ctrl.MergeCol(c_ITEM_CODE) = true;
    ctrl.MergeCol(c_ITEM_NAME) = true;
    ctrl.MergeCol(c_UOM) = true;
    

    auto_resize_column(idGrid, 0, idGrid.cols - 1, 0);
    data_fpab00800.Call("SELECT");
	
}
//------------------------------------------------------------------------------------------------

function OnSearch(obj)
{ 
    

}

function auto_resize_column(obj, col1, col2, font_size) {
    if (font_size != 0)
        obj.GetGridControl().FontSize = font_size;
    obj.GetGridControl().AutoSize(col1, col2, false, 0);
}

function OnDataReceive(obj)
{
    if(obj.id=="data_fpab00800")
    {
        auto_resize_column(idGrid, 0, idGrid.cols - 1, 0);
        idGrid.Subtotal( 0, 2, -1, '7!8','###,###,###.##');
        l_so_status=idGrid.GetGridData(1,c_SO_STATUS);
        if(l_so_status=='1')
            idSO_Status.text="SAVED";
        else if(l_so_status=='2')
            idSO_Status.text="SUBMITTED";
        else if(l_so_status=='3')
            idSO_Status.text="APPROVED";
        else
            idSO_Status.text="CANCELED";

        if(l_so_status=='2' || l_so_status=='3')
             idBtnConfirm.SetEnable(0);
    
        if(l_check_update==1) //update to save order
        {
            l_check_update=0;
            data_fpab00800_2.Call();
        }

    }

    if(obj.id=="data_fpab00800_2")
    {
        alert("Finish!");
        window.returnValue =  1;
		window.close();
    }

}

function on_Confirm()
{
    if(confirm("Do you want to update?"))
    {
        l_check_update=1;
        idGrid.SetAllRowStatusModify();
        data_fpab00800.Call();
    }
}

//================================================================================================

</script>

<body>
    <!---------------------------------------------------------------->
     <!------------------------------------------------------------------>
    <gw:data id="data_fpab00800" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="<%=l_user%>lg_sel_fpab00800_1"  procedure="<%=l_user%>lg_upd_fpab00800_1" > 
                <input> 
                    <input bind="txtSOMasterPK" /> 
                    <input bind="txtSODetailPK" /> 
                    <input bind="txtItemPK" /> 
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>

    <gw:data id="data_fpab00800_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="lg_PRO_fpab00800_2" > 
                <input>
                    <input bind="txtSOMasterPK" /> 
                    <input bind="txtSODetailPK" /> 
                    <input bind="txtItemPK" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 5%">
		    <td style="width: 10%"></td><td style="width: 10%"></td><td style="width: 10%"></td><td style="width: 10%"></td><td style="width: 10%"></td>
            <td style="width: 10%"></td><td style="width: 10%"></td><td style="width: 10%"></td><td style="width: 10%"></td><td style="width: 10%"></td>
        </tr>
        <tr style="height: 5%">
		    <td colspan=4 style="width: 10%">&nbsp;</td>
            <td style="width: 10%"><gw:icon id="idBtnConfirm" img="in" text="Update S/O Price" onclick="on_Confirm()" /></td>
            <td colspan=3 style="width: 10%">&nbsp;</td>
            <td align=right colspan=1 style="width: 10%">SO Status: &nbsp;</td>
            <td align=left colspan=1 style="width: 10%"><gw:label id="idSO_Status" text="" styles="width:100%;color:red" ></gw:label></td>
        </tr>
        <tr style="height: 95%">
            <td colspan="10">
				 <gw:grid id="idGrid" 
				    header="ITEM CODE|ITEM NAME|UOM|ITEM CODE(CONS)|ITEM NAME(CONS)|UOM|CONS QTY|UNIT PRICE|ADJUST PRICE|REMARK|_SO STATUS|_PK|_TLG_SA_SALEORDER_M_PK|_TLG_SA_SALEORDER_D_PK|_TLG_IT_ITEM_PK|_TLG_ITEM_CONS_PK"
                    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
					aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                    editcol="0|0|0|0|0|0|0|0|1|1|0|0|0|0|0|0" 
					widths="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"                
                    styles="width:100%; height:100%" sorting="T" />
            </td>
        </tr>
        
    </table>
    <!---------------------------------------------------------------->
</body>
</html>
<gw:textbox id="txtSOMasterPK"    styles='width:100%;display:none' />
<gw:textbox id="txtSODetailPK"    styles='width:100%;display:none' />
<gw:textbox id="txtItemPK"    styles='width:100%;display:none' />
<gw:textbox id="txtMaskUnitPrice"    styles='width:100%;display:none' />
<gw:textbox id="txtResult"    styles='width:100%;display:none' />

