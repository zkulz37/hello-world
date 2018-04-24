<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("comm")%>
<head>
    <title>ST ITEM ENTRY</title>
</head>

<script>
var G1_PK               = 0,
    G1_Member_ID        = 1,
    G1_Card_ID          = 2,
    G1_Customer_Name    = 3,
    G1_Passport         = 4,
    G1_Phone            = 5;
    
var G2_PK               = 0, 
    G2_TCM_MEMBERFEE_PK = 1,
    G2_Location         = 2,
    G2_TCO_ITEM_PK      = 3,
    G2_Item_Code        = 4,
    G2_Item_Name        = 5,
    G2_Quantity         = 6,
    G2_Price            = 7,
    G2_Amount           = 8,
    G2_VAT              = 9,
    G2_VAT_Amt          = 10,
    G2_Discount         = 11,
    G2_Discount_Amt     = 12,
    G2_AMT              = 13;
//==============================================================
function BodyInit()
{
	 var data = "Data|1|Mini Bar|2|Pro Shop|3|Kiosk|4|Fand B|5|Rental";
     lstLocation.SetDataText(data);	
     
     data ="#1;Mini Bar|#2;Pro Shop|#3;Kiosk|#4;Fand B|#5;Rental";
     grdDetail.SetComboFormat(G2_Location,data);      		
     
     trl = grdDetail.GetGridControl();
      	
     trl.ColFormat(6 ) = "###,###,###,###,###.##";
     trl.ColFormat(7)  = "###,###,###,###,###.##";
     trl.ColFormat(8)  = "###,###,###,###,###.##"; 
     trl.ColFormat(9)  = "###,###,###,###,###.##";     
     trl.ColFormat(10) = "###,###,###,###,###.##"; 
     trl.ColFormat(11) = "###,###,###,###,###.##"; 
     trl.ColFormat(12) = "###,###,###,###,###.##"; 
     trl.ColFormat(13) = "###,###,###,###,###.##";     									
}

//==============================================================

function OnSearch()
{
    data_jaso0010.Call("SELECT");
}
//========================================================
function  OnDataReceive(obj)
{
    switch( obj.id )
    {
        case 'data_jaso0010_2' :
            var t = 0 ;
            
            if ( txtItemPK.text != '' && txtMasterPK.text != '' )
            {
                for ( var i=1; i<grdDetail.rows-1; i++ )
                {
                    if ( grdDetail.GetGridData( i, G2_TCO_ITEM_PK) == txtItemPK.text )
                    {
                        grdDetail.SetGridText ( i, G2_Quantity , Number(grdDetail.GetGridData( i, G2_Quantity)) + 1 ); 
                        t = t + 1 ;
                        
                        var row = i ; 
                        
                        var d_amount = Number(grdDetail.GetGridData( row, G2_Quantity) ) * Number( grdDetail.GetGridData(row, G2_Price) );
                        grdDetail.SetGridText( row, G2_Amount, parseFloat(d_amount+"").toFixed(2));
                        
                        var d_vat_amount = d_amount * Number(grdDetail.GetGridData( row, G2_VAT) )/100 ;
                        grdDetail.SetGridText( row, G2_VAT_Amt, parseFloat(d_vat_amount+"").toFixed(2));
                        
                        var d_dis_amount = d_amount * Number(grdDetail.GetGridData( row, G2_Discount) )/100 ;
                        grdDetail.SetGridText( row, G2_Discount_Amt, parseFloat(d_dis_amount+"").toFixed(2));
                        
                        var d_pay_amount = d_amount + d_vat_amount - d_dis_amount ;
                        grdDetail.SetGridText( row, G2_AMT, parseFloat(d_pay_amount+"").toFixed(2));                        
                    }
                }
                
                if ( t==0 )
                {
                    grdDetail.AddRow();
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_TCM_MEMBERFEE_PK, txtMasterPK.text );
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_Location,         lstLocation.value ) ;
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_TCO_ITEM_PK,      txtItemPK.text ) ;
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_Item_Code,        txtItemCode.text ); 
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_Item_Name,        txtItemName.text );
                    grdDetail.SetGridText ( grdDetail.rows-1 , G2_Quantity, 1 ); 
                    
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_Price,            txtPrice.text );
                    
                    var row = grdDetail.rows-1 ; 
                    
                    var d_amount = Number(grdDetail.GetGridData( row, G2_Quantity) ) * Number( grdDetail.GetGridData(row, G2_Price) );
                    grdDetail.SetGridText( row, G2_Amount, parseFloat(d_amount+"").toFixed(2));
                    
                    var d_vat_amount = d_amount * Number(grdDetail.GetGridData( row, G2_VAT) )/100 ;
                    grdDetail.SetGridText( row, G2_VAT_Amt, parseFloat(d_vat_amount+"").toFixed(2));
                    
                    var d_dis_amount = d_amount * Number(grdDetail.GetGridData( row, G2_Discount) )/100 ;
                    grdDetail.SetGridText( row, G2_Discount_Amt, parseFloat(d_dis_amount+"").toFixed(2));
                    
                    var d_pay_amount = d_amount + d_vat_amount - d_dis_amount ;
                    grdDetail.SetGridText( row, G2_AMT, parseFloat(d_pay_amount+"").toFixed(2));                        
                    

                }
                txtItemCode.text = '' ;
            }
        break;
    }    
}

//========================================================================
function OnSelect()
{
    if ( idGrid.row > 0 )
    {
        txtMasterPK.text = idGrid.GetGridData( idGrid.row, G1_PK );
    } 
    else
    {
        txtMasterPK.text = '' ;
    }
    
    data_jaso0010_detail.Call("SELECT");
         
}
//========================================================================
function OnSearchItem()
{
    if ( txtMasterPK.text != '' )
    {
        data_jaso0010_2.Call("SELECT");
    }
    else
    {
        alert('Pls select master in the left.');
    }
        
}
//========================================================================
function OnSave()
{
    data_jaso0010_detail.Call();
}

//========================================================================
function OnSearchItemList()
{
    if ( txtMasterPK.text == '' )
    {
        return;
    }
    
        var path = System.RootURL + "/form/fp/ab/fpab00070.aspx?group_type=|Y||||";
        var object = System.OpenModal( path ,700 , 550 ,  'resizable:yes;status:yes', this);
        
         if ( object != null )
         {
                for ( var i=0; i< object.length; i++)
                {
                    data = object[i];
                    
                    grdDetail.AddRow();

                    grdDetail.SetCellBgColor( grdDetail.rows-1, 1 , grdDetail.rows-1, 6, 0xCCFFFF );  
                    
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_TCM_MEMBERFEE_PK, txtMasterPK.text );
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_Location,         lstLocation.value ) ;
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_TCO_ITEM_PK,      data[0] ) ;
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_Item_Code,        data[1] ) ;
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_Item_Name,        data[2] )  ;
                    grdDetail.SetGridText( grdDetail.rows-1 , G2_Price,            data[7] ) ;                                                                                          
                }                 
         }                           

}
//========================================================================
function OnCheckInput()
{
    var  row, col 
        
    row = event.row ;
    col = event.col ; 
    
    var d_amount = Number(grdDetail.GetGridData( row, G2_Quantity) ) * Number( grdDetail.GetGridData(row, G2_Price) );
    grdDetail.SetGridText( row, G2_Amount, parseFloat(d_amount+"").toFixed(2));
    
    var d_vat_amount = d_amount * Number(grdDetail.GetGridData( row, G2_VAT) )/100 ;
    grdDetail.SetGridText( row, G2_VAT_Amt, parseFloat(d_vat_amount+"").toFixed(2));
    
    var d_dis_amount = d_amount * Number(grdDetail.GetGridData( row, G2_Discount) )/100 ;
    grdDetail.SetGridText( row, G2_Discount_Amt, parseFloat(d_dis_amount+"").toFixed(2));
    
    var d_pay_amount = d_amount + d_vat_amount - d_dis_amount ;
    grdDetail.SetGridText( row, G2_AMT, parseFloat(d_pay_amount+"").toFixed(2));
}
//========================================================================
function OnDelete()
{
    grdDetail.DeleteRow();
    
}
//========================================================================
function OnUnDelete()
{
    grdDetail.UnDelete();
    
}
</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="data_jaso0010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" user="crm"  function="crm.sp_sel_jaso0010" > 
                <input> 
                    <input bind="idCard" /> 
                </input> 
                    <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="data_jaso0010_detail" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid" user="crm" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="crm.sp_sel_jaso0010_1" procedure="crm.sp_upd_jaso0010_1" > 
                <input> 
                    <input bind="txtMasterPK" /> 
                </input> 
                    <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_jaso0010_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2" function="crm.sp_sel_jaso0010_2" >
                <inout>
                    <inout bind="txtItemCode" /> 
                    <inout bind="txtItemPK" />     
                    <inout bind="txtItemName" /> 
                    <inout bind="txtPrice" />                 
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td width="30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td nowrap width="30%">
                            Card/Member ID</td>
                        <td width="60%">
                            <gw:textbox id="idCard" csstype="filter" onenterkey="OnSearch()" />
                        </td>
                        <td width="10%">
                            <gw:imgbtn id="idSearch" alt="Search" img="search" onclick="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="3">
                            <gw:grid id="idGrid" header="_PK|Member ID|Card ID|Customer Name|Passport|Phone"
                                format="0|0|0|0|0|0" aligns="0|0|0|0|0|0" defaults="|||||" editcol="1|1|1|1|1|1"
                                widths="0|2000|1500|2000|1500|1500" styles="width:100%; height:100%" sorting="T"
                                param="0,1,2,3,4,5" oncellclick="OnSelect()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td width="70%" valign="top">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Location</td>
                        <td style="width: 30%">
                            <gw:list id="lstLocation" styles="color:blue;width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            Item
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtItemCode" onenterkey="OnSearchItem()" />
                        </td>
                        <td></td>
                        <td align="right" style="width: 1%">
                            <gw:imgbtn id="idSearch02" alt="search" img="search" onclick="OnSearchItemList()" />
                        </td>
                        <td align="right" style="width: 1%">
                            <gw:imgbtn id="idDelete" alt="delete" img="delete" onclick="OnDelete()" />
                        </td>
                        <td align="right" style="width: 1%">
                            <gw:imgbtn id="idUnDelete" alt="udelete" img="udelete" onclick="OnUnDelete()" />
                        </td>
                        <td align="right" style="width: 1%">
                            <gw:imgbtn id="idSave" alt="Save" img="save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr style="height: 99%">
                        <td colspan="9">
                            <gw:grid id='grdDetail' header='_PK|_TCM_MEMBERFEE_PK|Location|_TCO_ITEM_PK|Item Code|Item Name|Quantity|Price|Amount|VAT|VAT Amt|Discount|Discount Amt|AMT'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|3|3|3|3|3|3|3|3' defaults='|||||||||||||'
                                editcol='0|0|0|0|0|0|1|1|1|1|1|1|1|1' widths='1000|1000|1500|1000|1500|2000|1500|1500|1500|1500|1500|1500|1500|1500'
                                sorting='T' styles='width:100%; height:100%' onafteredit="OnCheckInput()"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" style="display: none" />
    <gw:textbox id="txtItemPK" style="display: none" />
    <gw:textbox id="txtItemName" style="display: none" />
    <gw:textbox id="txtPrice" style="display: none" />
    <!------------------------------------------------------------------->
</body>
</html>
