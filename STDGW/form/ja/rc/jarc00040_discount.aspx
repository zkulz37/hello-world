<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Guest Check out</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
var PK                      = 0,
    NO                      = 1,
    ITEM                    = 2,
    DISCOUNT                = 3,
    REASON                  = 4,
    PK_VISITERFEE_GOLFER    = 5;

var ITEMEXIST = false;
function  BodyInit()
{   
  InitForm();
  
  var caller = dialogArguments;
  var arrDisInfo = caller.GetDiscountInfo('<%=Request.QueryString("idx") %>');
  InitData(arrDisInfo);
}
function InitForm(){
    txtLocker.SetReadOnly(true);
    txtPlayer.SetReadOnly(true);
    txtBagtag.SetReadOnly(true);
    txtGreenFee.SetReadOnly(true);
    txtCaddyFee.SetReadOnly(true);
    txtCartFee.SetReadOnly(true);
    txtGolfbagFee.SetReadOnly(true);
    txtF_B_Fee.SetReadOnly(true);
}
function InitData(arr){
    var tmp = new Array();
    tmp = arr;
    
    txtPK.text          = tmp[0];
    txtLocker.text      = tmp[1];
    txtPlayer.text      = tmp[2];
    txtBagtag.text      = tmp[3];
    txtGreenFee.text    = tmp[4];
    txtCaddyFee.text    = tmp[5];
    txtCartFee.text     = tmp[6];
    txtGolfbagFee.text  = tmp[7];
    txtF_B_Fee.text     = tmp[8];
    
    grdDiscount.SetComboFormat(ITEM, "#10;GREEN FEE|#20;CADDY FEE|#30;CART FEE|#40;F&B FEE|#50;GOLFBAG FEE");
    
    data_jarc00040_discount.Call("SELECT");
}
function OnNew(){
    if(ITEMEXIST){alert('Item discount already exist!'); return false;}
    grdDiscount.AddRow();
    grdDiscount.SetGridText(grdDiscount.rows - 1, NO                    , grdDiscount.rows - 1);
    grdDiscount.SetGridText(grdDiscount.rows - 1, PK_VISITERFEE_GOLFER  , txtPK.text);
    grdDiscount.SetGridText(grdDiscount.rows - 1, DISCOUNT              , 0);
}
function OnSave(){
    for(var idx = 1; idx < grdDiscount.rows; idx ++)
       if(grdDiscount.GetGridData(idx, ITEM) == ""){alert("Please choose discount item for row => " + idx + "!"); return false;}
    
    if(ITEMEXIST){alert('Item discount already exist!'); return false;}
    
    for(var idx = 1; idx < grdDiscount.rows; idx ++){
        if(isNaN(Number(grdDiscount.GetGridData(idx, DISCOUNT))) || Number(grdDiscount.GetGridData(idx, DISCOUNT)) == 0)
        {alert("Column discount amount unvalid for row => "+idx+"!");return false;}
        
        switch(grdDiscount.GetGridData(idx, ITEM)){
            case "10":
                if(Number(grdDiscount.GetGridData(idx, DISCOUNT)) > Number(txtGreenFee.text))
                    {alert("Discount amount more than green fee!");return false;}
            break;
            case "20":
                if(Number(grdDiscount.GetGridData(idx, DISCOUNT)) > Number(txtCaddyFee.text))
                    {alert("Discount amount more than caddy fee!");return false;}
            break;
            case "30":
                if(Number(grdDiscount.GetGridData(idx, DISCOUNT)) > Number(txtCartFee.text))
                    {alert("Discount amount more than cart fee!");return false;}
            break;
            case "40":
                if(Number(grdDiscount.GetGridData(idx, DISCOUNT)) > Number(txtF_B_Fee.text))
                    {alert("Discount amount more than f&b fee!");return false;}
            break;
            case "50":
                if(Number(grdDiscount.GetGridData(idx, DISCOUNT)) > Number(txtGolfbagFee.text))
                    {alert("Discount amount more than golf bag fee!");return false;}
            break;
        }
    }
    data_jarc00040_discount.Call();
}
function OnDelete(obj){
    var ctrl = grdDiscount.GetGridControl();
	var row  = ctrl.row;
	if (row > 0 )
		if (confirm("Do you want item this row to delete?")){ 
			grdDiscount.DeleteRow();
			data_jarc00040_discount.Call();}
 }
function OnValid(){
    if(event.col == ITEM){
        ITEMEXIST = OnDataValid(event.row);
        if(ITEMEXIST){alert('Item discount already exist!'); return false;}
    }else{
        if(ITEMEXIST){alert('Item discount already exist!'); return false;}
        return true;
    }
    return true;
}
function OnDataValid(row){
    for(var idx = 1; idx < grdDiscount.rows; idx ++){
        if(idx == row){}
        else if(grdDiscount.GetGridData(idx, ITEM) == grdDiscount.GetGridData(row, ITEM))
                return true;
    }
    return false;
}
function OnDataReceive(obj){}
</script>
<body>
    <gw:data id="data_jarc00040_discount" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5" function="crm.sp_sel_jarc00040_discount" procedure="crm.sp_upd_jarc00040_discount">
                <input>
                    <input bind="txtPK" />
                </input>
                <output bind="grdDiscount" />
            </dso>
        </xml>
    </gw:data>
    <table style="width: 100%; height: 100%" border="0">
        <tr valign="top" style="height: 2%">
            <td align="center" colspan="4">
                <table style="height: 100%; width: 100%">
                    <tr style="height:20px;">
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;">Locker</td>
                        <td><gw:textbox id="txtLocker" styles="width:100%" /></td>
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;">Player</td>
                        <td><gw:textbox id="txtPlayer" styles="width:100%" /></td>
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;">Bagtag</td>
                        <td><gw:textbox id="txtBagtag" styles="width:100%" /></td>
                    </tr>
                    <tr style="height:20px;">
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;">Green Fee</td>
                        <td><gw:textbox id="txtGreenFee" styles="width:100%" /></td>
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;width:60px;">Caddy Fee</td>
                        <td><gw:textbox id="txtCaddyFee" styles="width:100%" /></td>
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;width:60px;">Cart Fee</td>
                        <td><gw:textbox id="txtCartFee" styles="width:100%" /></td>
                    </tr>
                    <tr>
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;width:70px;">Golfbag Fee</td>
                        <td><gw:textbox id="txtGolfbagFee" styles="width:100%" /></td>
                        <td valign="middle" align="right" style="padding-left:3px;padding-right:3px;">F&B Fee</td>
                        <td><gw:textbox id="txtF_B_Fee" styles="width:100%" /></td>
                        <td></td>
                        <td></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height:20px">
            <td style="width: 88%"></td>
            <td style="width: 3%"><gw:imgbtn id="idBtnNew" img="new" alt="New" text="New" styles='width:100%' onclick="OnNew();" /></td>
            <td style="width: 3%"><gw:imgbtn id="idBtnDel" img="delete" alt="Delete" text="Delete" styles='width:100%' onclick="OnDelete();" /></td>
            <td style="width: 3%"><gw:imgbtn id="idBtnSave" img="save" alt="Save" text="Save" styles='width:100%' onclick="OnSave();" /></td>
            <!--td style="width: 3%"><gw:imgbtn id="idBtnPrint" img="print" alt="Print" text="Print" styles='width:100%' onclick="OnSave();" /></td-->
        </tr>
        <tr>
            <td style="height:100%" colspan="4">
                <gw:grid id='grdDiscount' 
                    header  ='_pk|No#|Item Discount|Discount Amt|Reason|_Pk_Visiterfee_Golfer'
                    format  ='0|0|0|-2|0|0' 
                    aligns  ='0|1|0|0|0|0' 
                    editcol ='0|0|1|1|1|0'
                    check   ='|||0-|0|'
                    autosize='T' 
                    sorting ='T' 
                    styles  ='width:100%; height:100%'
                    onafteredit ="OnValid();"
                />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtPK" styles="width:100%; display:none" />
    <!------------------------------------------------------------------------>
</body>
</html>
