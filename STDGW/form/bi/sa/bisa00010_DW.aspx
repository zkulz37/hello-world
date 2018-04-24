<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>STOCK OPENING</title>
</head>
<%ESysLib.SetUser("inv");%>

<script language="javascript" type="text/javascript">
//-----------------------------------------------------

var flag;

var G_PK    = 0 ;
//---------------------------------------------------------
var G1_DETAIL_PK    = 0, 
    G1_MASTER_PK    = 1,
    G1_SEQ          = 2,
    G1_ITEM_PK      = 3,
    G1_ITEM_CODE    = 4
    G1_ITEM_NAME    = 5,
    G1_UOM          = 6,
    G1_LOT_NO       = 7,
    G1_STOCK_QTY    = 8,
    G1_STOCK_AMOUNT = 9,
    G1_OPEN_QTY     = 10,
    G1_OPEN_AMOUNT  = 11,
    G1_ADJUST_QTY   = 12,
    G1_ADJUST_AMOUNT= 13,
    G1_REMARK       = 14;   

//===================================================================================
function OnToggle()
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 

    if(imgArrow.status == "expand"){
    left.style.display="none";
    imgArrow.status = "collapse";
    right.style.width="100%";
    imgArrow.src = "../../../system/images/button/next.gif";
    }
    else{
    left.style.display="";
    imgArrow.status = "expand";
    right.style.width="75%";
    imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

//===================================================================================

function BodyInit()
{  
    System.Translate(document);  // Translate to language session    
    txtUser_PK.text = "<%=Session["USER_PK"]%>";
    //----------  
    txtChargerName.SetEnable(false);
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //----------------------------
    
    BindingDataList();    
    dso_wh_list.Call();
    //----------------------------
    
    OnAddNew('Master');
 }
 
 //======================================================================================
 
 function BindingDataList()
 {  
     var data ;
     
       
     //-----------------------  
     
     var ctrl = grdDetail.GetGridControl(); 
    
     ctrl.ColFormat(G1_STOCK_QTY)     = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_STOCK_AMOUNT)  = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_OPEN_QTY)      = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_OPEN_AMOUNT)   = "#,###,###,###,###,###.##";
     ctrl.ColFormat(G1_ADJUST_QTY)    = "#,###,###,###,###,###.##";        
     ctrl.ColFormat(G1_ADJUST_AMOUNT) = "#,###,###,###,###,###.##";                  
 }
 
 //======================================================================================
  
function OnAddNew(pos)
{
    switch (pos)
    {   
        case 'Master' :         
            data_bisa00010_1.StatusInsert();
            
            //-------------------------------------------
            txtChargerName.text = "<%=Session["USER_NAME"]%>";
            txtChargerPK.text   = "<%=Session["EMPLOYEE_PK"]%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            
            flag = "view"; 
        break;
            
        case 'FreeItem':
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1 ); //master_pk	  
                             
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_PK, arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE,   arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME,   arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UOM,         arrTemp[5]);//item_uom                                                       
                    }		            
             }        
        break;                                
    }         
}  

//=====================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdVouchers':
            data_bisa00010.Call("SELECT");
        break;
    
        case 'Master':
        
            if ( data_bisa00010_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdVouchers.row > 0 )
                    {
                        txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G_PK );
                    }
                    flag = 'view' ;
                    data_bisa00010_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdVouchers.row > 0 )
                {
                    txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G_PK );
                }
                flag = 'view' ;
                data_bisa00010_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_bisa00010_2.Call("SELECT");
        break;
    }
}

//===============================================================================

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_bisa00010_1": 
            //-------------------        
            if ( flag == "save" )
            {
               for (var i = 1; i<grdDetail.rows; i++)   
               {
                    grdDetail.SetGridText(i, G1_MASTER_PK,  txtMasterPK.GetData());  
               }                                     
               //---------------------   
               OnSave('data_bisa00010_2');                
            }
            else
            {                
                OnSearch('grdDetail');                  
            } 
                
        break;

        case "data_bisa00010_2":
            if ( flag != 'view' ) 
            {
                OnSearch('grdVouchers');
            }             
            //----------------------
            
            if ( grdDetail.rows - 1 > 0 )
            {
                grdDetail.GetGridControl().Cell( 7, 1, G1_ADJUST_QTY, grdDetail.rows - 1, G1_ADJUST_AMOUNT ) = 0x3300cc;
            
                grdDetail.SetCellBold( 1, G1_STOCK_QTY,  grdDetail.rows - 1, G1_STOCK_QTY,  true);	
                grdDetail.SetCellBold( 1, G1_OPEN_QTY,   grdDetail.rows - 1, G1_OPEN_QTY,   true);
                grdDetail.SetCellBold( 1, G1_ADJUST_QTY, grdDetail.rows - 1, G1_ADJUST_QTY, true);
                
                grdDetail.SetCellBgColor( 1, G1_OPEN_QTY , grdDetail.rows - 1, G1_OPEN_AMOUNT , 0xCCFFFF );                
                
                grdDetail.SetCellBold( 1, G1_ITEM_CODE, grdDetail.rows - 1, G1_ITEM_CODE, true);			
            }   
            //----------------------------------
            var total1=0;
            for (var i=1;i<grdDetail.rows;i++)
            {
                
                total1=total1+Number(grdDetail.GetGridData(i,G1_OPEN_QTY));
            }
            
            lblTotalQty1.text=total1; 
            //----------------------                
        break;
        
        case 'pro_bisa00010':
			alert(txtReturnValue.text);		
					
			OnSearch('grdDetail');
		break;
		
        case 'pro_bisa00050_1':
            alert(txtReturnValue.text);
            
			OnSearch('Master');
		break;	
		
		 case 'dso_wh_list':
            lstWarehouse.SetDataText(txtWHStr.text);
            lstWHSearch.SetDataText(txtWHStr.text +"||");
            lstWHSearch.value =''
         break;
		
			
   }            
}

//===============================================================================
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtChargerName.text = obj[2];
                txtChargerPK.text   = obj[0];
            }
        break;         
    }	       
}

//===============================================================================

function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            data_bisa00010_1.Call();
            flag='save';        
        break;
        
        case 'data_bisa00010_2':
            data_bisa00010_2.Call();
        break;
    }
}

//===================================================================================

function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                var event_col = event.col ;
                var event_row = event.row ;
                
                if ( event_col == G1_UOM )
                {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[1]);
	                   }	
                }                
            break;             
      }         
}   
//===================================================================================

 function OnDelete(index)
 {        
    switch (index)
    {
        case 'Voucher':// delete master       
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_bisa00010_1.StatusDelete();
                data_bisa00010_1.Call();
            }           
        break;

        case 'GridItem':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdDetail.GetGridData( grdDetail.row, G1_DETAIL_PK ) == '' )
                {
                    grdDetail.RemoveRow();
                }
                else
                {   
                    grdDetail.DeleteRow();
                }    
            }            
        break;            

    }     
}
//===================================================================================
 
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}

//===================================================================================

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G1_OPEN_QTY || col == G1_ADJUST_QTY || col == G1_OPEN_AMOUNT || col == G1_ADJUST_AMOUNT )
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText( row, col, parseFloat(dQuantiy+"").toFixed(2));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText( row, col, "");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"") ;
        }     
    }
    //----------------------Calculate Adjust Qty-----
    if ( col == G1_OPEN_QTY )
    {
        var dStockQty  = Number(grdDetail.GetGridData( row, G1_STOCK_QTY)) ;
        var dCheckQty  = Number(grdDetail.GetGridData( row, G1_OPEN_QTY)) ;
           
        var dAdjust = Number(dCheckQty) - Number(dStockQty);
        
        grdDetail.SetGridText( row, G1_ADJUST_QTY, parseFloat(dAdjust+"").toFixed(2));           
    }   
    else if ( col == G1_OPEN_AMOUNT )
    {
        var dStockAmount  = Number(grdDetail.GetGridData( row, G1_STOCK_AMOUNT)) ;
        var dCheckAMount  = Number(grdDetail.GetGridData( row, G1_OPEN_AMOUNT)) ;
           
        var dAdjust = Number(dCheckAMount) - Number(dStockAmount);
        
        grdDetail.SetGridText( row, G1_ADJUST_AMOUNT, parseFloat(dAdjust+"").toFixed(2));           
    
    } 
    //----------------------
}
 
//===================================================================================

function OnProcess(pos)
{
    switch(pos)
    {
        case 'LoadStock':
            if ( txtMasterPK.text != '' )
            {
                pro_bisa00010.Call();
            }
            else
            {
                alert("Pls save slip first.");
            }
        break;
        
        case 'Submit':
            if ( txtMasterPK.text != '' )
            {
                if ( confirm("Do you want to submit this slip?") )
                {
                    pro_bisa00010_1.Call();
                }    
            }
            else
            {
                alert("Pls select one slip first.");
            }
        break;
    }
}

//===================================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="dso_wh_list" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="INV.sp_sel_bisa00010_3" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="txtWHStr" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_bisa00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1" function="inv.sp_sel_bisa00010" > 
                <input>                      
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="lstWHSearch" />
                    <input bind="txtItem01" />
                </input> 
                <output bind="grdVouchers" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_bisa00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6" function="inv.sp_sel_bisa00010_1"  procedure="inv.sp_upd_bisa00010_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="dtStockDate" />                         
                     <inout  bind="txtChargerPK" />
                     <inout  bind="txtChargerName" />
                     <inout  bind="lbStatus" />
                     <inout  bind="lstWarehouse" />
                     <inout  bind="txtRemark" />                    
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_bisa00010_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="inv.sp_sel_bisa00010_2_DW"   procedure="inv.sp_upd_bisa00010_2_DW"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                    <input bind="txtItem" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_bisa00010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="inv.sp_pro_bisa00010_DW" > 
                <input>
					 <input bind="txtMasterPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_bisa00010_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="inv.sp_pro_bisa00010_1" > 
                <input>
					 <input bind="txtMasterPK" />
                </input> 
                <output> 
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Date
                        </td>
                        <td style="width: 89%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~<gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdVouchers')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            W/H
                        </td>
                        <td colspan="2">
                            <gw:list id="lstWHSearch" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            Item
                        </td>
                        <td colspan="2">
                            <gw:textbox id="txtItem01" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id="grdVouchers" header="_PK|Date|Status|W/H" format="0|4|0|0" aligns="0|0|1|0"
                                defaults="|||" editcol="0|0|0|0" widths="0|1200|1000|0" styles="width:100%; height:100%"
                                sorting="T" param="0,1,2,3" oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td align="right" style="width: 5%">
                            W/H
                        </td>
                        <td style="width: 30%">
                            <gw:list id="lstWarehouse" styles='width:100%' csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Stock Date
                        </td>
                        <td style="width: 15%">
                            <gw:datebox id="dtStockDate" lang="1" />
                        </td>
                        <td align="right" style="width: 5%">
                            <a title="Employee" onclick="OnPopUp('Charger')" href="#tips">Charger</a>
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtChargerName" styles="width:100%" />
                            <gw:textbox id="txtChargerPK" styles="display:none" />
                        </td>
                        <td style="width: 6%">
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="OnProcess('Submit')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Voucher')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 10%" align="right">
                            Remark
                        </td>
                        <td colspan="8">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                        <td style="width: 20%; white-space: nowrap" align="center" colspan="5">
                            <gw:label id="lbStatus" styles='width:100%;color:cc0000;font:9pt;align:center' text='-' />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 5%" align="left">
                            <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                style="cursor: hand" onclick="OnToggle()" />
                        </td>
                        <td style="width: 1%" align="right">
                            Item
                        </td>
                        <td style="white-space: nowrap" colspan="2">
                            <gw:textbox id="txtItem" styles="width:100%" onenterkey="OnSearch('grdDetail')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch_1" img="search" alt="Search" text="Search" onclick="OnSearch('grdDetail')" />
                        </td>
                        <td style="white-space: nowrap" colspan="2">
                            Open Qty :
                            <gw:label id="lblTotalQty1" styles='width:100%;color:cc0000;font:9pt' text='' type="number"
                                format="###,###.##" />
                        </td>
                        <td align="right">
                            <gw:icon id="idBtnLoadStock" img="2" text="Load Stock" styles='width:100%' onclick="OnProcess('LoadStock')" />
                        </td>
                        <td align="right">
                            <gw:imgbtn id="btnGetFreeItem" img="popup" alt="Get free Item" text="Get free Item"
                                onclick="OnAddNew('FreeItem')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('GridItem')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 94%">
                        <td colspan="11">
                            <gw:grid id='grdDetail' header='_PK|_OPEN_M_PK|Seq|SO Item No|_ITEM_PK|Item Code|Item Name|UOM|Lot No|Stock Qty|Stock Amount|Open Qty|Open Amount|Adjust Qty|Adjust Amount|Description'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|0|0|0|0|1|1|3|3|3|3|3|3|0'
                                check='|||||||||||||||' editcol='0|0|1|1|0|0|0|0|1|0|0|1|1|1|1|1' widths='0|0|800|1500|0|2000|3000|1000|1200|1500|1500|1500|1500|1500|1500|1000'
                                sorting='T' onafteredit='CheckInput()' styles='width:100%; height:100%' oncelldblclick="OnGridCellDoubleClick(this)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtReturnValue" styles="width:100%; display:none" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />
<gw:textbox id="txtWHStr" styles="width: 100%;display: none" />
</html>
