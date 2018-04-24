<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Take Out Mat Entry</title>
</head>

<script>
//---------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;
 //grdConsumption
 var iCon_prod_code     = 2 ,
     iCon_prod_qty      = 5 ,
     iCon_Mat_code      = 7 ,
     iCon_Need_qty      = 10,
     iCon_Map_qty       = 11,
     iCon_STOCKNORMD_PK = 13;
 //grdMatInTr 
 var iStockTr_pk             = 0 ,
     iMat_TR_Date           = 1,
     iMat_InType             = 2,
     iMat_Stock_tr_no       = 3,
     iMat_TCO_ITEM_PK       = 4,
     iMat_TCO_ITEM_CODE     = 5,
     iMat_TCO_ITEM_NAME     = 6,
     iMat_TCO_ITEM_UOM      = 7,
     iMat_input_qty          = 8 , 
     iMat_proc_qty           = 9,
     iMat_wh                = 10,
     iMat_description       = 11;
 //grdMatInTr2
 var 
    iMat2_pk                = 0,
    iMat2_STOCKNORMD_PK     = 1,
    iMat2_STOCKTR_PK        = 2,
    iMat2_TR_Date           = 3,
    iMat2_InType            = 4,
    iMat2_Stock_tr_no       = 5,
    iMat2_TCO_ITEM_PK       = 6,
    iMat2_TCO_ITEM_CODE     = 7,
    iMat2_TCO_ITEM_NAME     = 8,
    iMat2_TCO_ITEM_UOM      = 9,
    iMat2_qty               = 10,
    iMat2_wh                = 11,
    iMat2_description       = 12;
//------------------------------------------------------------------------
 var needQty =0;                                            // need - map
 var material_qty = 0;                                      // input - process
 	        
function BodyInit()
{  
    FormatGrid(); 
    BindingDataList();
    //-----------------        
}

//---------------------------------------------------------------------
function BindingDataList()
{
    var data="";    
    data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE_NM FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='ACFC0020' AND a.TCO_ABCODEGRP_PK=b.PK and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM" ) %> ";       
    grdMatInTr.SetComboFormat(iMat_InType,data);
    grdMatInTr2.SetComboFormat(iMat2_InType,data);
    
    grdConsumption.GetGridControl().AllowSelection = 0
    grdMatInTr.GetGridControl().AllowSelection = 0

}
//---------------------------------------------------------------------
function OnPopUp(iObj)
{
    var i ;
    switch(iObj)
    {
      
        case 1:
            var path = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=N&item_code="+ txtItemCode.text +"&item_name=" ;
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');      
            if(obj != null)
            {
                 txtItemCode.text = obj[1]
            }   
        break;
        
        case 2:
            var path = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=Y&item_code="+ txtMatCode.text +"&item_name=";
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
             if(obj != null)
            {
                 txtMatCode.text = obj[1]
            }   
        break;
         
        case 3:
            var path = System.RootURL + "/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=Y&item_code="+ txtMatCode1.text +"&item_name=";
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
             if(obj != null)
            {
                 txtMatCode1.text = obj[1]
            }   
        break;
       
    }
}
//---------------------------------------------------------
function FormatGrid()
{

      grdConsumption.GetGridControl().MergeCells = 2 ; 
            
      grdConsumption.GetGridControl().MergeCol(0) = true ; 
      grdConsumption.GetGridControl().MergeCol(1) = true ; 
      grdConsumption.GetGridControl().MergeCol(2) = true ; 
      grdConsumption.GetGridControl().MergeCol(3) = true ; 
      grdConsumption.GetGridControl().MergeCol(4) = true ;
      grdConsumption.GetGridControl().MergeCol(5) = true ;

      var trl
      //grdConsumption
      trl = grdConsumption.GetGridControl();
      trl.FrozenCols = 4;
      trl.ColFormat(iCon_prod_qty)       = "###,###,###,###,###.##";
      trl.ColFormat(iCon_Need_qty)       = "###,###,###,###,###.##";
      trl.ColFormat(iCon_Map_qty)        = "###,###,###,###,###.##";
     //grdMatInTr
      trl = grdMatInTr.GetGridControl();
      trl.FrozenCols = 3;
      trl.ColFormat(iMat_input_qty)      = "###,###,###,###,###.##";
      trl.ColFormat(iMat_proc_qty)       = "###,###,###,###,###.##";
      //grdMatInTr2
      trl = grdMatInTr2.GetGridControl();
      trl.FrozenCols = 5;
      trl.ColFormat(iMat2_qty)           = "###,###,###,###,###.##";
 }
 
 //---------------------------------------------------------------------
function OnSearch(pos)
{
      switch (pos)         
      {		        
            case 'grdConsumption' :
                 fmgf00011.Call("SELECT");
            break ; 
            case 'grdMatInTr' :
                fmgf00011_1.Call("SELECT");
            break ; 
            case 'grdMatInTr2' :
                fmgf00011_2.Call("SELECT");
            break ; 
      }      

}
//------------------------------------------------------------------
function OnMapp()
{
    var ctrl = grdMatInTr.GetGridControl();
    if (txtStocknormdPk.text != "")
    {
     if(ctrl.SelectedRows == 0)
        {
               return ;
        }
        else
	    {
	        var rowNo =0;
	         for(i=0;i<ctrl.SelectedRows;i++)
			    {	  
			        rowNo = ctrl.SelectedRow(i)
			        //Check valid
			        if (MappingValid(rowNo,grdConsumption.row))
					{
					     material_qty = grdMatInTr.GetGridData(rowNo , iMat_input_qty) - grdMatInTr.GetGridData(rowNo , iMat_proc_qty)
		                if (material_qty >0 && needQty >0)
		                {
		                    grdMatInTr2.AddRow()
		                    grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_STOCKNORMD_PK , txtStocknormdPk.text);
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_STOCKTR_PK,grdMatInTr.GetGridData(rowNo , iStockTr_pk) )
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_TR_Date,grdMatInTr.GetGridData(rowNo , iMat_TR_Date ))
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_InType ,grdMatInTr.GetGridData(rowNo , iMat_InType ))
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_Stock_tr_no, grdMatInTr.GetGridData(rowNo , iMat_Stock_tr_no ))
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_TCO_ITEM_PK,grdMatInTr.GetGridData(rowNo , iMat_TCO_ITEM_PK ))
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_TCO_ITEM_CODE,grdMatInTr.GetGridData(rowNo , iMat_TCO_ITEM_CODE ))
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_TCO_ITEM_NAME,grdMatInTr.GetGridData(rowNo , iMat_TCO_ITEM_NAME ))
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_TCO_ITEM_UOM,grdMatInTr.GetGridData(rowNo , iMat_TCO_ITEM_UOM ))
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_qty,(material_qty >needQty? needQty:material_qty) )
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_wh,grdMatInTr.GetGridData(rowNo , iMat_wh ))
    		                grdMatInTr2.SetGridText(grdMatInTr2.rows -1 , iMat2_description,grdMatInTr.GetGridData(rowNo , iMat_description ))
                              //update process qty
                              var newValue =0 
                               if (needQty < material_qty)
                               {
                                    newValue = needQty + parseFloat(grdMatInTr.GetGridData(rowNo , iMat_proc_qty )+"")
                                    grdMatInTr.SetGridText(rowNo , iMat_proc_qty,newValue );
                                    //-----------
                               }else
                               {
                                    //-----------
                                    newValue = material_qty + parseFloat(grdMatInTr.GetGridData(rowNo , iMat_proc_qty )+"")
                                    grdMatInTr.SetGridText(rowNo , iMat_proc_qty,newValue );
                                    //-----------
                               }
		                }  
					}	        
			    }
	    }
    }else
    {
        alert("Please select a Stock Norm !")
    }
}
//---------------------------------------------------------------------
function MappingValid(grdMatInTr_Row,grdConsumption_Row)
{
    var temp
     //Check material
    temp = grdMatInTr.GetGridData(grdMatInTr_Row,iStockTr_pk)
    for(var i =1 ; i<grdMatInTr2.rows ; i++ )
        {
            if (grdMatInTr2.GetGridData(i,iMat2_STOCKTR_PK)== temp )
            {
                alert("This material is already mapping!!")
                grdMatInTr2.SelectRow(i);
                grdMatInTr2.GetGridControl().TopRow = i;
                return false;// invalid
            }
        }
    //Check consumption
    var tempqty,sumqty =0 
    temp = grdConsumption.GetGridData(grdConsumption_Row,iCon_STOCKNORMD_PK)
    tempqty = grdConsumption.GetGridData(grdConsumption_Row,iCon_Need_qty)
     for(var i =1 ; i<grdMatInTr2.rows ; i++ )
        {
            if (grdMatInTr2.GetGridData(i,iMat2_STOCKNORMD_PK)== temp )
            {
               if(Number(grdMatInTr2.GetGridData(i,iMat2_qty)))
                sumqty = sumqty + parseFloat(grdMatInTr2.GetGridData(i,iMat2_qty)+"");
            }
        }
    if (sumqty >= tempqty)
    {
        if(confirm("Mapping quantity of this consumption is enough.Do you want to continue!!"))
            return true; //warmning
        else
            return false;
    }
    return true;
}
//---------------------------------------------------------------------
function OnSave()
{
    if(SaveValid())
    {
     fmgf00011_2.Call()
    }
}
//----------------------------------------------------------------------
function SaveValid()
{
      for(var i =1 ; i<grdMatInTr2.rows ; i++ )
        {
             if (grdMatInTr2.GetGridData(i,iMat2_qty)=="")
            {
                alert("Input Material mapping quantity!! ")
                grdMatInTr2.SelectRow(i);
                grdMatInTr2.GetGridControl().TopRow = i;
                return false;
            }
        }
      return true;
}
//----------------------------------------------------------------------
var vOldValue =0;
function CheckValue()
{
    var row, col
    col = event.col
    row = event.row
    if (col==iMat2_qty)
    {
        var value = grdMatInTr2.GetGridData(row ,col)
        if(!Number(value)|| value <0)
        {
            grdMatInTr2.SetGridText(row ,col,"")
        }else
        {
            ResetProcessQty(row,value);
        }
    }
}
//---------------------------------------------------------------------

 function OnDataReceive(po_oData)
 { 
      switch (po_oData.id)         
      {		
            case 'fmgf00011':
                   OnSearch('grdMatInTr2');
            break; 
            case 'fmgf00011_2':
                    OnSearch('grdMatInTr');
            break;       
            case "pro_fmgf00011" :
                 alert(txtReturnValue.text);
            break;        
      }  
 }
 
//---------------------------------------------------------------------

function OnProcess(pos)
{
      switch (pos)         
      {		        
            case 'AutoProcess' :
                pro_fmgf00011.Call();
            break ; 
      }      

}
//----------------------------------------------------------
function ResetProcessQty(pRow,pNewValue)
{
    if (pNewValue != vOldValue)
    {
        var tempValue = 0;
        for(var i =1 ; i<grdMatInTr.rows -1 ; i++ )
        {
            if (grdMatInTr.GetGridData(i,iStockTr_pk)== grdMatInTr2.GetGridData(pRow,iMat2_STOCKTR_PK))
            {
                tempValue = grdMatInTr.GetGridData(i,iMat_proc_qty)
                grdMatInTr.SetGridText(i,iMat_proc_qty,tempValue - vOldValue + pNewValue)
            }
        }
    }
}
//---------------------------------------------------------------------
function OnGridClick(grid)
{ 
    var row = event.row
    switch (grid.id)
    {
        case 'grdConsumption' :
             txtStocknormdPk.text = grid.GetGridData(row,iCon_STOCKNORMD_PK)
             txtMatCode1.text = grid.GetGridData(row,iCon_Mat_code)
             needQty = grid.GetGridData(row,iCon_Need_qty) - grid.GetGridData(row,iCon_Map_qty)
             OnSearch('grdMatInTr2')
        break;
    }
   
}
//---------------------------------------------------------------------
function OnDelete()
{
        var row = grdMatInTr2.row
            if ( row < 0 ) 
            {			
		            alert("Please select a Record to delete .");
            }			
            else 
            {
                 if ( grdMatInTr2.GetGridData( row, iMat2_pk ) == "" ) 
	            {					
	                  ResetProcessQty(row,0);
    				  grdMatInTr2.RemoveRow();		
		        }
	            else 
	            {
		            if ( confirm( "Do you want to mark this row to delete?" ) ) 
		            {
			            grdMatInTr2.DeleteRow();
		            }
		            checkData();
	            }
            }
}
//---------------------------------------------------------
 function OnUnDelete() {

    var row = grdMatInTr2.row		
		if ( row < 0 ) {		
		}		
		else {
		
			if ( grdMatInTr2.GetGridData( row, 0) == "" ) {
			}
			else {
				
				if ( confirm ( "Do you want to undelete?" ) ) {				
					grdMatInTr2.UnDeleteRow()
				}
				checkData();
			}
		}
}
//----------------------------------------------------------
function checkData() 
{
	var n    = grdMatInTr2.rows;
	var row  = event.row;	
	vOldValue = grdMatInTr2.GetGridData( row,iMat2_qty)
	if ( n > 1 ) 
	{	
		if ( row < 0 ) 
		{
		}
		else 
		{			
			if ( grdMatInTr2.GetRowStatus(row ) >= 64 ) 
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

</script>

<body>
    <!--------------------------------------------------------------->
    <gw:data id="fmgf00011" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="ACNT.sp_sel_fmgf00011" > 
                <input bind="grdConsumption" >
                    <input bind="dtTrans" />
                    <input bind="txtItemCode" />
                    <input bind="txtMatCode" />
                    <input bind="chkBalance" />
                </input>
                <output  bind="grdConsumption" />
            </dso> 
        </xml> 
    </gw:data>
     <!--------------------------------------------------------------->
    <gw:data id="fmgf00011_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="ACNT.sp_sel_fmgf00011_1" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" procedure="ACNT.sp_upd_fmgf00011_1"> 
                <input bind="grdMatInTr2" >
                    <input bind="txtStocknormdPk" />
                </input>
                <output  bind="grdMatInTr2" />
            </dso> 
        </xml> 
    </gw:data>
     <!--------------------------------------------------------------->
    <gw:data id="fmgf00011_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"  function="ACNT.sp_sel_fmgf00011_2" > 
                <input bind="grdMatInTr" >
                    <input bind="dtTrans" />
                    <input bind="txtMatCode1" />
                </input>
                <output  bind="grdMatInTr" />
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 5%">
            <td colspan="2">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%" align="right">
                            Month</td>
                        <td style="width: 10%" align="right">
                            <gw:datebox id="dtTrans" lang="1" type="month" onchange="OnSearch(1)" />
                        </td>
                        <td style="width: 5%" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(1)">Product</b></td>
                        <td style="width: 15%" align="left">
                            <gw:textbox id="txtItemCode" csstype="mandatory" styles="width: 100%" onenterkey="OnSearch('grdConsumption')" />
                        </td>
                        <td style="width: 5%" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(2)">Material</b></td>
                        <td style="width: 15%" align="left">
                            <gw:textbox id="txtMatCode" csstype="mandatory" styles="width: 100%" onenterkey="OnSearch('grdConsumption')" />
                        </td>
                        <td style="width: 10%" align="right">
                            <b>Balance</b>
                        </td>
                        <td style="width: 5%">
                            <gw:checkbox id="chkBalance" defaultvalue="Y|N" value="Y" />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 5%">
                            <gw:imgbtn id="btnSearch1" img="search" onclick="OnSearch('grdConsumption')" />
                        </td>
                        <td style="width: 10%" align="right">
                            <gw:icon id="idBtnProcess" img="in" text="Auto Process" styles='width:100%' onclick="OnProcess('AutoProcess')" />
                        </td>
                        <td style="width: 10%" align="right">
                            <gw:icon id="idBtnMapping" img="in" text="Mapping" styles='width:100%' onclick="OnProcess('Mapping')" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 40%">
            <td style="width: 100%" colspan="2">
                  <gw:grid id='grdConsumption'
                    header='Take in DT|_PRODUCT_PK|Prod Code|Prod Name|Prod UOM|Prod Qty|_Item_PK|MAT Code|MAT Name|MAT UOM|Need Qty|Map Qty|_TAC_STOCKNORM_PK|_TAC_STOCKNORMD_PK'
                    format='4|0|0|0|0|1|0|0|0|0|1|1|0|0'
                    aligns='0|0|0|0|1|0|0|0|0|1|0|0|0|0'
                    defaults='|||||||||||||'
                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='1200|0|1500|2500|1000|1500|0|1500|2500|1000|1500|1500|0|0'
                    sorting='T'
                    styles='width:100%; height:100%' oncellclick="OnGridClick(this)"
                   />
            </td>
        </tr>
        <tr style="height: 55%">
            <td style="width: 50%">               
                <table width="100%" style="height:100%">
                    <tr style="height:5%; width:100%">
                        <td style="width: 10%" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnPopUp(3)">Material</b></td>
                        <td style="width: 80%" align="left">
                            <gw:textbox id="txtMatCode1" csstype="mandatory" styles="width: 100%" onenterkey="OnSearch('grdMatInTr')" />
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnSearch2" img="search" onclick="OnSearch('grdMatInTr')" />
                        </td>
                        <td style="width: 5%" align="right">
                            <gw:imgbtn id="btnAdd" img="select" onclick="OnMapp()" />
                        </td>
                    </tr>
                    <tr style="height:95%">
                        <td colspan ="4">
                             <gw:grid id='grdMatInTr'
                            header='_PK|TR Date|TR In Type|StockTR No|_TCO_ITEM_PK|Item Code|Item Name|Item UOM|Input Qty|Process Qty|Ware House|Description'
                            format='0|4|0|0|0|0|0|0|1|1|0|0'
                            aligns='0|0|0|0|0|0|0|1|0|0|0|0'
                            defaults='|||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|0|0'
                            widths='0|1200|1500|1500|0|1500|2500|1000|1500|1500|1500|2000'
                            sorting='T'
                            styles='width:100%; height:100%'
                            />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 50%;height: 55%">
                 <table width="100%" style="height:100%">
                    <tr style="height:5%; width:100%">
                        <td style="width: 90%" align="right"> 
                            <gw:imgbtn id="btnDelete" img="delete" onclick="OnDelete()" />
                        </td>
                        <td style="width: 5%" align="right"> 
                            <gw:imgbtn id="btnUnDelete" img="UDelete" onclick="OnUnDelete()" />
                        </td>
                        <td style="width: 5%" align="right">           
                            <gw:imgbtn id="btnSave" img="save" onclick="OnSave()" />
                        </td>
                    </tr>
                    <tr style="height:95%">
                        <td colspan="3">
                            <gw:grid id='grdMatInTr2'
                            header='_PK|_TAC_STOCKNORMD_PK|_TAC_STOCKTR_PK|TR Date|TR In Type|Stock TR No|_TCO_ITEM_PK|Item Code|Item Name|Item UOM|Qty|Ware House|Description'
                            format='0|0|0|4|0|0|0|0|0|0|1|0|0'
                            aligns='0|0|0|0|0|0|0|0|0|1|0|0|0'
                            defaults='||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|1|0|0'
                            widths='0|0|0|1200|1500|1500|0|1500|2500|1000|1500|1500|2000'
                            sorting='T'
                            styles='width:100%; height:100%' onafteredit="CheckValue()" oncellclick="checkData()"
                            />
                        </td>
                    </tr>
                </table>  
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------------------------->
    <gw:textbox id="txtReturnValue" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtStocknormdPk" maxlen="100" styles='width:100%;display:none' />
</body>
</html>
