<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<%  ESysLib.SetUser("STM")%>
<head runat="server">
    <title>SaleOrder Entry</title>
</head>
<script>
var G1_PK =0,
G1_oder_dt=1;
var
G2_order =0,
G2_orderd_pk =1,
G2_orderm_pk =2,
G2_style_pk =3,
G2_style_id =4,
G2_style_nm =5,
G2_color_pk =6,
G2_color =7,
G2_size_pk =8,
G2_size =9,
G2_gender =10,
G2_ord_qty =11,
G2_price =12,
G2_amt =13,
G2_etd =14,
G2_eta = 15,
G2_status =16;
var initFlag = 1;
function BodyInit()
{
      BindingDataList();
      ipbo00010_1.StatusInsert();  
      txtOrderNo.text ='NEW SLIP NO';
      GridFormat();  
}
//---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="70%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
//-----------------------------------------------------
 function BindingDataList()
 {    
       var data="";      
        // Set order type to  combo      
        data = "<%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0016'")%>";    
        lstOrderType.SetDataText(data);   
        // Set currency to  combo
	    data = "<%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0006'")%>";    
        lstCurrency.SetDataText(data);
         // Set gender to  combo
	    data = "<%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0013'")%>";    
        lstGender.SetDataText(data); 
        
        // Set Gender to grid 
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0013'" )  %> " ; 
        grdDetail.SetComboFormat(G2_gender,data); 
         // Set Hist Type to grid 
        data = "<%=ESysLib.SetGridColumnDataSQL("SELECT V.CODE, V.CODE_NM FROM VST_POP_CODE V WHERE V.MASTER_CODE = 'POP0017'" )  %> " ; 
        grdDetail.SetComboFormat(G2_status,data);  
         
  } 
//----------------------------------------------------
function GridFormat()
{
    //Set Control status
      txtBuyerNo.SetEnable(false); 
      lstGender.SetEnable(false);
      txtOrderNo.SetEnable(false);
    //--------------
    var trl
      trl=grdDetail.GetGridControl();
      trl.FrozenCols = G2_color_pk;	
      trl.ColFormat(G2_ord_qty)      = "###,###,###,###,###"; 
      trl.ColFormat(G2_price)      = "###,###,###,###,###.###"; 
      trl.ColFormat(G2_amt)      = "###,###,###,###,###.###"; 
}
//----------------------------------------------------
function OnSearch(pos)
{
    switch(pos)
    {
        case 1:
            ipbo00010.Call('SELECT')
        break;
        case 2:
             if ( ipbo00010_1.GetStatus() == 20 && initFlag ==0 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave(1);
                }
                else
                {
                    txtMasterPK.text = grdSearch.GetGridData(grdSearch.row,G1_PK)
                    ipbo00010_1.Call('SELECT')
                }                
            } else
            {
                 txtMasterPK.text = grdSearch.GetGridData(grdSearch.row,G1_PK)
                 ipbo00010_1.Call('SELECT')
            }
        break;
    }
}
//----------------------------------------------------
function OnNew(id)
{   
    if(id==1)
    {
      //Add new master
       initFlag = 0;
       ipbo00010_1.StatusInsert();
       txtOrderNo.text ='NEW SLIP NO';
       grdDetail.ClearData();
    }else
    {
        if(txtStylePK.text!="")
        {
            var path = System.RootURL + '/form/ip/bo/ipbo0014.aspx?style_pk='+txtStylePK.text+'&style_no='+txtStyleNo.text;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if ( object != null )
            {
                for(var k =0 ; k< object.length; k++)
                {
                     grdDetail.AddRow();
                     //Set grid
                     grdDetail.SetGridText(grdDetail.rows -1,G2_order, IncrementSeq(grdDetail,G2_order));
                     grdDetail.SetGridText(grdDetail.rows -1,G2_color_pk, object[k][0]);
                     grdDetail.SetGridText(grdDetail.rows -1,G2_color, object[k][1]);
                     
                     grdDetail.SetGridText(grdDetail.rows -1,G2_size_pk, object[k][2]);
                     grdDetail.SetGridText(grdDetail.rows -1,G2_size, object[k][3]);
                     
                     grdDetail.SetGridText(grdDetail.rows -1,G2_style_pk, txtStylePK.text);
                     grdDetail.SetGridText(grdDetail.rows -1,G2_style_id, txtStyleNo.text);
                     grdDetail.SetGridText(grdDetail.rows -1,G2_style_nm, txtStyleNM.text);
                     grdDetail.SetGridText(grdDetail.rows -1,G2_price, txtUPrice.text); 
                     grdDetail.SetGridText(grdDetail.rows -1,G2_gender,lstGender.value); 
                     
                     grdDetail.SetGridText(grdDetail.rows -1,G2_ord_qty,object[k][4]); 
                     
                     grdDetail.SetGridText(grdDetail.rows -1,G2_etd, dtEtd.value); 
                     grdDetail.SetGridText(grdDetail.rows -1,G2_eta, dtEta.value); 
                    //Calculate amount
                    var qty, price 
                    qty = grdDetail.GetGridData(grdDetail.rows -1,G2_ord_qty)
                    price = grdDetail.GetGridData(grdDetail.rows -1,G2_price)
                    if (qty !="" && price !="")
                       {
                        grdDetail.SetGridText(grdDetail.rows -1,G2_amt,Number(qty)*Number(price))
                       }
                }
                //Sum amount
                 TotalAmount();
            }
        }else
        {
            alert("Please select Style first!!")
        }
         
    } 
}
//---------------------------------------------------------
 function OnDelete(id)
 {
    if(id==1)
    {
        //delete master
        if ( confirm ( "Do you want to delete this order?" ) )
          {
            ipbo00010_1.StatusDelete();       
            if (txtMasterPK.text!="")
             {
                 ipbo00010_1.Call()
             }
            else
                alert("Please,Select a SO !")
         }
     }else
     {
         //delete client
        var ctrl = grdDetail.GetGridControl();
	    var n    = ctrl.rows;
	    var row  = ctrl.row;
	        if ( n > 1 ) 
	        {		
		        if ( row < 0 ) 
		        {			
				        alert("Please select a Code to delete .");
		        }			
		        else 
		        {
			        if ( grdDetail.GetGridData( ctrl.row,G2_orderd_pk  ) == "" ) 
		            {						
					     grdDetail.RemoveRow();					
			        }			
			        else 
			        {
				        if ( confirm( "Do you want to mark this row to delete?" ) ) 
				        {
					        grdDetail.DeleteRow();
				        }
				        checkData();
			        }
		        }
            }
     }
 }
 
//---------------------------------------------------------
 function OnUnDelete() {
    	grdDetail.UnDeleteRow()
		checkData();
}
//-------------------------
     var p_update = 0 ;
//-------------------------
function OnSave(id)
{
   if(CheckSaveValid())
   {
        switch(id)
        {
            //Save master
            case 1:
                 p_update = 1 ;
                ipbo00010_1.Call(); 
            break;
            //Save detail
            case 2: 
               SetParentPKtoGrid();
               ipbo00010_2.Call(); 
            break;
           
        }
   }
}

//----------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'ipbo00010':
            
        break;
        case 'ipbo00010_1':
             if ( p_update == 1 )
            {
                p_update = 0 ;
                OnSave(2);
            }
            else
                { 
                  ipbo00010_2.Call('SELECT')
                }
        break;
        case 'ipbo00010_2':
            SetItemSequence();
        break;
    }    
}

//----------------------------------------------------
function OnPopUp(pos)
 {
    switch(pos)
    {
        //Select Style No for master
        case 1:
            var path = System.RootURL + '/form/ip/bo/ipbo0011.aspx';
	        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	        if ( object != null )
	        {
	            txtStylePK.text = object[0][0]
	            txtStyleNo.text = object[0][4]
	            txtStyleNM.text = object[0][5]
	            txtUPrice.text = object[0][10]
	            
	            txtBuyerPK.text = object[0][1]
	            txtBuyerNo.text = object[0][2]
	            lstGender.value = object[0][3]
	        }
        break;
    }
 }
 
 //-----------------------------------------
 function OnGridCellDblClick()
 {
    var col , row
    col = event.col
    row = event.row
    //Get style for detail
    if(col ==G2_style_id || col== G2_style_nm )
    {
         var path = System.RootURL + '/form/ip/bo/ipbo0011.aspx';
        var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
        if ( object != null )
        {
             grdDetail.SetGridText(grdDetail.rows -1,G2_style_pk, object[0][0]);
             grdDetail.SetGridText(grdDetail.rows -1,G2_style_id, object[0][4]);
             grdDetail.SetGridText(grdDetail.rows -1,G2_style_nm, object[0][5]);
        }
        return;
    }
 }
 
 //-----------------reset item sequence ------------------------------
 function SetItemSequence()
{
    var items = grdDetail.rows
    for(var i =1 ; i<items ; i ++)
    {
        grdDetail.SetGridText(i,G2_order,i)
    }
}
//-------------------------------------
function IncrementSeq(p_obj, p_col)
{    
    var data = 0;        
    for (row = 1; row < p_obj.rows; row++)    
    {       
         if (!isNaN(p_obj.GetGridData(row, p_col)))        
         {           
           if (data < Number(p_obj.GetGridData(row, p_col)))                
           data = Number(p_obj.GetGridData(row, p_col));        
         }    
     }        
      return data + 1;
}
//-------------------Set parent pk to gridDetail before save so detail---------------
 function SetParentPKtoGrid()
 {
        for ( i = 1; i < grdDetail.rows ; i++ )
        {
            if ( grdDetail.GetGridData(i,G2_orderd_pk) == "" )
                {
                    grdDetail.SetGridText( i ,G2_orderm_pk, txtMasterPK.text ) ;
                }
        }
 }
 //----------------------Calculate AMT---------------
    function CheckEdit()
    {
        var col, row
        col = event.col
        row = event.row 
        //Check input number        
        if ( col == G2_ord_qty || col == G2_price || col ==G2_amt)
        {
            var dQuantiy
            dQuantiy = grdDetail.GetGridData(row,col)
            if (Number(dQuantiy))
            {   
                if (dQuantiy >0)
                {
                    grdDetail.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(3));
                }
                else
                {
                    grdDetail.SetGridText(row,col,"")
                }
            }
            else
            {
                grdDetail.SetGridText(row,col,"")
            }
          } 
          //Calcualte amount
             if ( col == G2_ord_qty || col == G2_price)
             {
                var qty, price 
                qty = grdDetail.GetGridData(row,G2_ord_qty)
                price = grdDetail.GetGridData(row,G2_price)
                if (qty !="" && price !="")
                   {
                    grdDetail.SetGridText(row,G2_amt,Number(qty)*Number(price))
                   }
            }
         TotalAmount();
    }
//----------------------------------------------------------
function checkData() 
{
	var ctrl = grdDetail.GetGridControl();
	var n    = ctrl.rows;
	var row  = ctrl.row;	
	
	if ( n > 1 ) 
	{	
		if ( row > 0 ) 
		{			
			if ( grdDetail.GetRowStatus( ctrl.row ) >= 64 ) 
			{
				btnDelete.SetEnable(false);
				btnUnDelete.SetEnable(true);
			}
			else 
			{
				btnDelete.SetEnable(true);
				btnUnDelete.SetEnable(false);
			}
		}	
	}	
}
//----------------------------------------------
function CheckSaveValid()
{
    if(txtStylePK.text =="")
    {
        alert("Please select Style first!")
        return false;
    }
    for (var i =1; i< grdDetail.rows ; i++)
    {
        if(grdDetail.GetGridData(i,G2_style_pk)=="" || grdDetail.GetGridData(i,G2_color_pk)=="" || grdDetail.GetGridData(i,G2_size_pk)=="" ||grdDetail.GetGridData(i,G2_ord_qty)=="" )
        {
            alert("Please check all information in SO Detail!")
            return false;
        }
    }
    return true;
}
//---------------------------------------------
function TotalAmount()
 {
    var sumQty,sum 
    sum =0;
    sumQty =0;
    for(i=1; i<grdDetail.rows; i++ )
    {
        var dValueOder ,dValueTotal
        
       dValueTotal = grdDetail.GetGridData(i,G2_amt) ;
       dValueOder = grdDetail.GetGridData(i,G2_ord_qty) ;
       if ( Number(dValueTotal) )
       {
            sum = sum + parseFloat(dValueTotal);
            sumQty = sumQty + parseFloat(dValueOder);
       }
       
    }
    txtAmount.text = sum.toFixed(3)
    txtQty.text = sumQty.toFixed(3)
 }
 
</script>
<body>
    <!------------------------------------------------------------------>
    <gw:data id="ipbo00010" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso id="1" type="grid" function="stm.sp_sel_ipbo0010" > 
                    <input bind="grdSearch" > 
                         <input bind="txtPoNoSearch" /> 
                         <input bind="dtFromDate" /> 
                         <input bind="dtToDate" /> 
                    </input> 
                    <output bind="grdSearch" /> 
                </dso> 
            </xml> 
        </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="ipbo00010_1" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso  type="control" function="stm.sp_sel_ipbo0010_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" procedure="stm.sp_upd_ipbo0010_1" > 
                    <inout > 
                         <inout bind="txtMasterPK" /> 
                         <inout bind="txtOrderNo" /> 
                         <inout bind="dtOrderDate" />
                         <inout bind="txtPoNo"/> 
                         <inout bind="lstOrderType"/>
                         
                         <inout bind="txtStylePK"/>
                         <inout bind="txtStyleNo"/>
                         <inout bind="txtStyleNM"/>
                         <inout bind="txtExRate"/>
                         <inout bind="txtUPrice"/>
                         <inout bind="txtBuyerPK"/>
                         <inout bind="txtBuyerNo"/> 
                         <inout bind="lstGender" /> 
                         
                         <inout bind="dtEtd"/>
                         <inout bind="dtEta"/> 
                         <inout bind="lstCurrency"/>
                         <inout bind="txtDescription"/>
                         
                         <inout bind="txtAmount"/>
                         <inout bind="txtQty"/>
                    </inout> 
                 </dso> 
            </xml> 
        </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="ipbo00010_2" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso id="1" type="grid" function="stm.sp_sel_ipbo0010_2" parameter='1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17' procedure="stm.sp_upd_ipbo0010_2"> 
                    <input bind="grdDetail" > 
                         <input bind="txtMasterPK" /> 
                    </input> 
                    <output bind="grdDetail" /> 
                </dso> 
            </xml> 
        </gw:data>
        
    <table class="table" style="height: 100%; width: 100%" cellpadding="0" cellspacing="0"
        border="1">
        <tr style="height: 100%">
            <td id="left" style="width: 30%" valign="top">
                <table style="height: 100%; width: 100%" border="0" cellpadding="0" cellspacing="0">
                    <tr style="height: 5%">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td align="right" style="width: 30%">
                                        <b>PO Date</b>
                                    </td>
                                    <td style="width:30%" align="left">
                                        <gw:datebox id="dtFromDate" lang="1" />
                                    </td>
                                    <td style="width: 30%" align="left">
                                        ~<gw:datebox id="dtToDate" lang="1" />
                                    </td>
                                    <td style="width: 10%" align='right'>
                                        <gw:imgbtn id="btnSearch1" img="search" onclick='OnSearch(1)' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                     <tr style="height: 5%">
                        <td>
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td align="right" style="width: 20%">
                                        <b>SO/PO No</b>
                                    </td>
                                    <td style="width: 70%" align="left">
                                        <gw:textbox id="txtPoNoSearch" styles="width:100%" onenterkey="OnSearch()"/>
                                    </td>
                                    <td style="width: 10%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 90%">
                        <td>
                            <gw:grid id='grdSearch' header='_PK|Order Date|Order Id|Po No' format='0|0|0|0'
                                aligns='0|0|0|0' editcol='0|0|0|0' widths='0|1200|2000|2000' sorting='T' styles='width:100%; height:100%'
                                oncellclick='OnSearch(2)' />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 78%" valign="top">
                <table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
                    <tr style="height: 5%">
                        <td style="width: 1%" align="right">
                             <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
                                style="cursor: hand;" onclick="OnToggle()" />
                        </td>
                        <td style="width: 9%" align="right">
                            <b>Order No</b>
                        </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtOrderNo" csstype="mandatory" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            <b>Order Date</b>
                        </td>
                        <td style="width: 15%" align="left">
                            <gw:datebox id="dtOrderDate" lang="1" />
                        </td>
                        <td style="width: 8%" align="right">
                            PO No
                        </td>
                        <td style="width: 15%" align="left">
                            <gw:textbox id="txtPoNo"  styles="width:100%" />
                        </td>
                       <td style="width: 8%" ></td>
                       <td style="width: 4%" ></td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnNew" img="new" alt="New Plan" text="Add" onclick="OnNew(1)" />
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnDelete1" img="delete" alt="Delete" text="Delete" onclick="OnDelete(1)" />
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave(1)" />
                        </td>
                    </tr>
                    
                    <tr style="height: 5%">
                        
                         <td style="width: 10%" align="right" colspan="2" >
                            <b>Order Type</b>
                        </td>
                        <td style="width: 15%">
                            <gw:list id="lstOrderType" styles='width:100%' />
                        </td>
                         <td style="width: 10%" align="right" >
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(1)">Style No</b>
                         </td>
                        <td style="width: 15%">
                            <gw:textbox id="txtStylePK" styles='width:100%;display:none' />
                            <gw:textbox id="txtStyleNo"  styles="width:100%" />
                            <gw:textbox id="txtStyleNM"  styles="width:100%;display:none" />
                        </td>
                        
                        <td style="width: 8%" align="right">
                            Ex Rate
                        </td>
                        <td style="width: 15%" align="left">
                            <gw:textbox id="txtExRate" type="number" format="###,###.###" styles="width:100%" />
                        </td>
                        <td style="width: 8%" align="right">
                            U.Price
                        </td>
                        <td style="width: 19%" align="right" colspan="4">
                            <gw:textbox id="txtUPrice"  type="number" format="###,###.###" styles="width:100%" />
                         </td>
                    </tr>
                     <tr style="height: 5%">
                       
                        <td style="width: 10%" align="right" colspan="2">
                           <b>Buyer-Brand</b>
                        </td>
                        <td style="width: 15%">
                           <gw:textbox id="txtBuyerPK"  styles="width:100%;display:none" />
                           <gw:textbox id="txtBuyerNo"  styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                             Gender
                        </td>
                        <td style="width: 15%" align="left">
                             <gw:list id="lstGender"  styles="width:100%" />
                        </td>
                        <td style="width: 8%" align="right">
                            ETD
                        </td>
                        <td style="width: 15%" align="left">
                            <gw:datebox id="dtEtd" lang="1" />
                        </td>
                        <td style="width: 8%" align="right">
                           ETA
                        </td>
                        <td style="width: 19%" align="right"  colspan="4">
                           <gw:datebox id="dtEta" lang="1"  nullaccept="true"/>
                        </td>
                    </tr>
                    <tr>
                         <td style="width: 10%" align="right" colspan="2" >
                            <b>Currency</b>
                        </td>
                        <td style="width: 15%">
                            <gw:list id="lstCurrency" styles='width:100%' />
                        </td>
                        <td  style="width: 10%" align="right">
                            Description
                        </td>
                        <td style="width: 10%" align="right" colspan="8">
                            <gw:textbox id="txtDescription"  styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td colspan="12">
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 10%" align="right">
                                        Total Qty:    
                                    </td>
                                    <td style="width: 15%">
                                       <gw:textbox id="txtQty"  styles="width:100%; color:Red;border:none" type="number" format="###,###.###" onenterkey="TotalAmount()"/>
                                    </td>
                                     <td style="width: 15%" align="right">
                                        Total Amount:
                                    </td>
                                    <td style="width: 15%">
                                         <gw:textbox id="txtAmount"  styles="width:100%; color:Red;border:none" type="number" format="###,###.###" onenterkey="TotalAmount()" />
                                    </td>
                                   
                                    <td style="width: 25%">
                                    </td> 
                                    <td align="right" style="width: 5%">
                                        <gw:imgbtn id="btnNew_2" img="new" alt="Get Item from Sale Order" text="Add" onclick="OnNew(2)" />
                                    </td>
                                    <td align="right" style="width: 5%">
                                        <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete(2)" />
                                    </td>
                                    <td align="right" style="width: 5%">
                                        <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 80%">
                        <td colspan ="12">
                        <gw:grid id='grdDetail'
                            header='Seq|_PK|_TST_ORDERM_PK|_TST_STYLE_PK|Style ID|Style NM|_TST_STYLECOLOR_PK|Color|_TST_STYLESIZE_PK|Size|Gender|Ord Qty|U.Price|Ord AMT|ETD|ETA|Status|Description'
                            format='0|0|0|0|0|0|0|0|0|0|0|1|1|1|4|4|0|0'
                            aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            defaults='|||||||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1'
                            widths='800|0|0|0|1500|2000|0|1500|0|1500|1500|1500|1500|1500|1200|1200|1200|2000'
                            sorting='T'
                            styles='width:100%; height:100%'
                            acceptNullDate="true"
                            onafteredit="CheckEdit()"
                            oncellclick="checkData()" 
                            />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
      <!------------------------------------------------------------------------------------------->
</body>
 <gw:textbox id="txtMasterPK"  styles="width:100%;display:none" />
</html>
