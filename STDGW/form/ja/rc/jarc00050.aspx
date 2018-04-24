<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Correct Bill</title>
</head>
<%  ESysLib.SetUser("crm")%>
<script>
function BodyInit()
{
    var data="";
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='POINT' and description = 'GOLF' ") %> ";	
	lstLocation.SetDataText(data);
	//lstLocation.value = "3";
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='POINT'")%>"; 
	grdInvoice.SetComboFormat(11,data);
}
var G_PK=0,
G_tgm_invoice_pk=1,
G_item_pk=2,
G_No=3,
G_ItemCode=4,
G_ItemName=5,
G_Unit=6,
G_Quantity=7,
G_Price=8,
G_Amount=9;
var f_lag='select';
function OnSearch()
{
    data_jarc00050_invoiceM.Call("SELECT");
}
function OnShowInvoiceD()
{
    if (grdInvoice.row > 0 )
        {
            txtMasterPK.text = grdInvoice.GetGridData(grdInvoice.row,0);
            data_jarc00050_invoiceD.Call("SELECT");
        }
}
function OnpopupName()
{
    if(event.col == 6)//Golfer name
    {
         var path = System.RootURL + "/form/ja/rc/jarc00050_popup.aspx";
	         var object = System.OpenModal( path ,500 , 300 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            var arrTemp;
	            arrTemp = object[0];
	            grdInvoice.SetGridText(grdInvoice.row,1,arrTemp[0])//visitor_golfer_pk
	            grdInvoice.SetGridText(grdInvoice.row,6,arrTemp[4])//golfer name
	            grdInvoice.SetGridText(grdInvoice.row,4,arrTemp[2])//locker no
	            grdInvoice.SetGridText(grdInvoice.row,5,arrTemp[3])//bagtag no
	         }
    }      
}
function OnSave()
{
    
     f_lag='save';
    data_jarc00050_invoiceM.Call();
     //data_jarc00050_invoiceD.Call();
}
function OnNew()
{
    if(txtMasterPK.GetData()!="")
    {
                 var path = System.RootURL + '/form/ja/rc/jarc00050_popup_item.aspx?loc=' + lstLocation.value;//purchase_yn=Y
                 var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                 
                 if ( object != null )
                 {                    
                        var arrTemp;
                        for( var i=0; i < object.length; i++)	  
                        {	
                                arrTemp = object[i];
                                    
                               grdInvoiceD.AddRow();  
                                
                                grdInvoiceD.SetGridText( grdInvoiceD.rows-1, G_tgm_invoice_pk, txtMasterPK.GetData());//Master_pk
                                grdInvoiceD.SetGridText( grdInvoiceD.rows-1, G_item_pk,   arrTemp[0]);//item_pk	    
                                grdInvoiceD.SetGridText( grdInvoiceD.rows-1, G_ItemCode, arrTemp[1]);//item_code	    
                                grdInvoiceD.SetGridText( grdInvoiceD.rows-1, G_ItemName, arrTemp[2]);//item_name	    
                                grdInvoiceD.SetGridText( grdInvoiceD.rows-1, G_Unit,    arrTemp[4]);//item_uom
                                grdInvoiceD.SetGridText( grdInvoiceD.rows-1, G_Quantity,   '1');//quantity
                                grdInvoiceD.SetGridText( grdInvoiceD.rows-1, G_Price,   arrTemp[5]);//Price 
                                grdInvoiceD.SetGridText( grdInvoiceD.rows-1, G_Amount,   arrTemp[5]);//Price         
                        }		            
                 } 
                 
      } 
      else
      {
        alert("Please select item master before add new detail item");
      }    
}
function OnDelete(pos)
 {
     switch(pos)
     {
        case 1:
            if(grdInvoice.row > 0){
                var remarklenght=0;
                    remarklenght=grdInvoice.GetGridData(grdInvoice.row,12);
                if(remarklenght.length > 10)
                {
                    if ( confirm( "Do you want to delete bill "+ grdInvoice.GetGridData(grdInvoice.row,3)+" ?" ) )
                    {
                        f_lag='delete';
				        grdInvoice.DeleteRowAt(grdInvoice.row);
				        data_jarc00050_invoiceM.Call();  
                    } 
                }
                else
                {
                   alert('Please, input remark greater than 10 characters!') ; 
                }
            }
            break;
        case 2: //search master
             if ( confirm( "Do you want item this row to delete?" ) ) 
			{
				grdInvoiceD.DeleteRow();
				data_jarc00050_invoiceD.Call();
			}
        break;
     }
 }
function OnDataReceive(obj)
{
   switch (obj.id) 
    {
         case "data_jarc00050_invoiceM" :
            MandatoryColor();
            if(f_lag=='save' || f_lag=='delete')
            {
                    data_jarc00050_invoiceD.Call();
            }
            else
            {
               f_lag='break';
               data_jarc00050_invoiceD.Call("SELECT");
            }
         break;
    }   
}
function OnReditQuantity()
{
    if(grdInvoiceD.col== 7)
    {
        var price_Qty;
        price_Qty=(grdInvoiceD.GetGridData(grdInvoiceD.row, 7)*(grdInvoiceD.GetGridData(grdInvoiceD.row, 8)));
        grdInvoiceD.SetGridText(grdInvoiceD.row, 9,price_Qty)
    }
}
function MandatoryColor()
{
    if (grdInvoice.rows >1)
    {
		grdInvoice.SetCellBgColor( 1, 6 , grdInvoice.rows - 1, 6 , 0xCCFFFF );
    }
}
function OnDiscount(obj)
{
	if(obj.col==9)
	{
		var discount_amt=0;
		discount_amt=(grdInvoice.GetGridData(grdInvoice.row, 8))-(grdInvoice.GetGridData(grdInvoice.row, 8)*(grdInvoice.GetGridData(grdInvoice.row, 9)))/100;
		grdInvoice.SetGridText(grdInvoice.row, 10,discount_amt)
	}
}
</script>
<body>
<!------------------------------------------------------->
<gw:data id="data_jarc00050_invoiceM" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,9,10,12" function="crm.sp_sel_jarc00050_invoice_m" procedure="crm.sp_upd_jarc00050_invoice_m">
                <input>
                    <input bind="dtfr" />
                    <input bind="lstLocation" />
                    <input bind="txtName" />
                </input>
                <output bind="grdInvoice" />
            </dso>
        </xml>
    </gw:data>
 <!------------------------------------------------------->
 <gw:data id="data_jarc00050_invoiceD" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5,6,7,8,9" function="crm.sp_sel_jarc00050_invoice_D" procedure="crm.sp_upd_jarc00050_invoice_D">
                <input>
                    <input bind="txtMasterPK" />
                </input>
                <output bind="grdInvoiceD" />
            </dso>
        </xml>
    </gw:data>
 <!------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 100%">
            <td style="width: 100%;">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 2%">
                        <td >
                        <fieldset>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 100%">
                                    <td style="width: 4%;">
                                        Date
                                    </td>
                                    <td style="width: 6%;">
                                        <gw:datebox id="dtfr" lang="1" onchange="OnSearch()" />
                                    </td>
                                    <td style="width: 7%;">
                                        Location
                                    </td>
                                    <td style="width: 20%;">
                                        <gw:list id="lstLocation" styles="color:blue;width:100%" onchange="OnSearch()" />
                                    </td>
                                    <td style="width: 7%;" align="right">
                                        Invoice#
                                    </td>
                                    <td style="width: 20%;">
                                        <gw:textbox id="txtName" onenterkey="OnSearch()" />
                                    </td>
                                    <td style="width: 30%;">
                                    </td>
                                    <td align="right" style="width: 3%">
                                        <gw:imgbtn id="idSearch" alt="search" img="search" onclick="OnSearch()" />
                                    </td>
                                    <td style="width: 3%">
                                        <gw:imgbtn id="btnSaveMaster" img="save" alt="Save" onclick="OnSave()" />
                                    </td>
                                    <td style="width:2%;">
                                    </td>
                                    <td align="right" style="width: 3%">
                                         <gw:imgbtn id="idDeleteM" alt="delete" img="delete" onclick="OnDelete(1)" />
                                    </td>
                                </tr>
                            </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 58%">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 100%">
                                    <td>
                                        <gw:grid id="grdInvoice" header="_PK|_TGM_VISITORFEE_GOLFER_PK|Date|Invoice#|Locker#|Bagtag#|Golfer Name#|Group#|Amount|Discount(%)|Amount|Location|Remark"
                                            format="0|0|4|0|-0|-0|0|-0|-0|0|-0|0|0" aligns="0|0|0|0|3|3|0|3|3|3|3|0|0" editcol="0|0|0|0|0|0|0|0|0|1|0|0|1"
                                            widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000' sorting='T' autosize='T' 
                                            styles="width:100%; height:100%" onafteredit="OnDiscount(this)" oncellclick="OnShowInvoiceD()" oncelldblclick="OnpopupName()"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td>
                        <fieldset>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 100%">
                                    <td style="width: 94%;">
                                    </td>
                                    <td align="right" style="width: 3%">
                                        <gw:imgbtn id="idBtnNewM" img="new" text="Add" alt="New" styles='width:100%' onclick="OnNew()" />
                                    </td>
                                    <td align="right" style="width: 3%">
                                         <gw:imgbtn id="idDelete" alt="delete" img="delete" onclick="OnDelete(2)" />
                                    </td>
                                </tr>
                            </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 38%">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr style="height: 100%">
                                    <td>
                                        <gw:grid id="grdInvoiceD" header="_PK|_tgm_invoice_pk|_item_pk|No|Item Code|Item Name|Unit|Quantity|Price|Amount"
                                            format="0|0|0|0|0|0|0|-0|-0|-0" aligns="0|0|0|0|0|0|0|3|3|3" editcol="0|0|0|0|0|0|0|1|0|0" sorting='T'
                                            widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000' autosize='T' 
                                            styles="width:100%; height:100%" onafteredit="OnReditQuantity()"
                                             />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" styles="width:100%; display:none" />
    <gw:textbox id="txtInvoiceM_PK" styles="width:100%; display:none" />
    <!------------------------------------------------------------------------>
</body>
</html>
