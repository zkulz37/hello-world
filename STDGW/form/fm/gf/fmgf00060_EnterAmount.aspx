<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>FG Incoming Entry</title>
</head>

<script>
   
    var  user_pk   = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name = "<%=Session("USER_NAME")%>" ;
    var  user_id   = "<%=Session("USER_ID")%>" ;
//-----------------------------------------------------
var p_update = 0 ; // status of save master or not
var bStatus =0
//---------------------------------------------------------
var iCol_PK                 = 0 ,
    iCol_take_in_pk         = 1 ,
    iCol_TAC_ABACCTCODE_PK  = 2 ,
    iCol_TCO_ITEM_PK        = 3 ,
    iCol_Item_Code          = 4 ,
    iCol_Item_Name          = 5 ,
    iCol_UOM                = 6 ,
    iCol_Take_In_Qty        = 7 ,
    iCol_UPrice             = 8 ,
    iCol_Amount             = 9 ,
    iCol_Acount_Code        = 10 ,
    iCol_Acount_Name        = 11 ,
    iCol_TIN_WAREHOUSE_PK   = 12 ,
    iCol_Ware_House         = 13 ,
    iCol_company            = 14 ,
    iCol_Close              = 15 ;

//---------------------------------------------------------
 /*excel cols*/
    var xls_acc_code =1,
        xls_acc_name =2,
        xls_item_code =3,
        xls_item_nm =4,
        xls_uom =5,
        xls_qty =6,
        xls_warehouse =7,
        xls_company = 8;
 /*excel cols*/   
 
 //--------------------------------------------------------
 
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

function BodyInit()
{
    BindingDataList() ;
	var l_fr = dtToDate.value ;
	l_fr = l_fr.substr(0, 6) + "01";
    dtFromDate.SetDataText(l_fr);
    AddOnClick(1) ;
    SetStatus();
    txtTransCode.SetEnable(false);    
    txtTransName.SetEnable(false);
    txtDebitCode.SetEnable(false);    
    txtDebitName.SetEnable(false);
    chkAuto_YN.value = 'F';
    txtSlipNo1.SetEnable(true);
    
}

//-----------------------------------------------------
 function BindingDataList()
 {
     var data="";  
    //----------------------------   
    data = "<%=ESysLib.SetListDataSQL("SELECT pk, wh_name FROM inv.tin_warehouse WHERE del_if = 0 ORDER BY wh_name ASC " )%>";    
    lstWH.SetDataText(data); 
     
    data     = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0 ")%>";
    lstCompany.SetDataText( data);
    //----------------------------
    // set data for trans type
    var ls_trtype_pk, ls_trtype_code, ls_trtype_nm ;
    ls_trtype_pk = "<%=ESysLib.SetDataSQL("select pk from acnt.tac_abtrtype where TRIM(TR_TYPE) = 'Y011' and del_if = 0 ")%>";
    ls_trtype_code = 'Y011';
    ls_trtype_nm = "<%=ESysLib.SetDataSQL("select TR_TPNM from acnt.tac_abtrtype where TRIM(TR_TYPE) = 'Y011' and del_if = 0 ")%>";
    txtTransCode.text = ls_trtype_code;
    txtTransName.text = ls_trtype_nm;
    txtabtypetr_pk.text = ls_trtype_pk; 
	var ls_data = "<%=ESysLib.SetListDataSQL("select TRIM(CODE) code, A.code_nm FROM TAC_COMMCODE_DETAIL A, TAC_COMMCODE_MASTER B WHERE A.DEL_IF=0 and b.del_if = 0 and a.TAC_COMMCODE_MASTER_PK = b.pk AND TRIM(b.ID) = 'EACAB049' and a.code <> 'O1' ")%>";	
	lstGetData.SetDataText(ls_data);	
    
 }
 //---------------------------------------------------------
 function SetStatus()
 {
    btnUnDelete_1.SetEnable(false);
    btnDelete_1.SetEnable(false);
 } 
//-----------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 1 :        
            fmgf00060.Call("SELECT")            
        break;        
        case 2 :        
            txtMasterPK.text = grdSearch.GetGridData(event.row,0);
            txtSEQ.text = grdSearch.GetGridData(event.row, 4);
            fmgf00060_1.Call("SELECT")            
        break;
    }
}
//-----------------------------------------------------
function OnDataReceive(obj)
{
    var takein_qty  = 0;
    var amount = 0;
    var i;
    switch (obj.id)
    {
        case "fmgf00060_1" :
                // master save -- > call save details
               if (p_update == 1 )
               {
                    SetParentPKtoGrid();
                    //Set Warehouse, company 
                    for(i = 1; i < grdDetail.rows; i++)
                    {
                        grdDetail.SetGridText(i, iCol_TIN_WAREHOUSE_PK, lstWH.value); // warehouse pk
                        grdDetail.SetGridText(i, iCol_Ware_House, lstWH.GetText()); // warehouse name
                        grdDetail.SetGridText(i, iCol_company, lstCompany.value); // company
                        grdDetail.SetGridText(i, iCol_Close, 'N'); // default is N: not yet approved
                    }         
                    fmgf00060_2.Call();
                    p_update = 0 ;               
               }
               else
               {
                    fmgf00060_2.Call("SELECT");
               }
               StatusConfirm();
        break;
        case "fmgf00060_2":
           //-------------------------
            var iNumRecord = grdDetail.rows-1 ;
            
            if (iNumRecord>0)
            {
                btnDelete_1.SetEnable(true)
            }
            else
            {
                 btnDelete_1.SetEnable(false)
                 btnUnDelete_1.SetEnable(true)
            }
            //------------------------FOrmat Column
            var fg = grdDetail.GetGridControl();
            fg.ColFormat(iCol_Take_In_Qty) = "###,###,###,###.##R";
            fg.ColFormat(iCol_UPrice) = "###,###,###,###.####R";
            fg.ColFormat(iCol_Amount) = "###,###,###,###,###R";
//            //------------------------ Gran Total
            for ( i = 1 ; i < grdDetail.rows ; i++ )
            {
                if ( grdDetail.GetGridData( i, iCol_Close ) == -1 )
                {
                    grdDetail.GetGridControl().Cell( 7 , i , 0 , i, iCol_Close ) = 0x808080;      
                }
                if( grdDetail.GetGridData(i, iCol_Take_In_Qty) != '') 
                {
                    takein_qty += Number(grdDetail.GetGridData(i, iCol_Take_In_Qty)) ;
                }
                if( grdDetail.GetGridData(i, iCol_Amount) != '') 
                {
                    amount += Number(grdDetail.GetGridData(i, iCol_Amount)) ;
                }
                
            }  
            if(grdDetail.rows > 1)
            {                       
                grdDetail.AddRow();
                grdDetail.SetCellBgColor(grdDetail.rows-1, 0, grdDetail.rows-1, grdDetail.cols - 1, 0xA9EBD7);
                grdDetail.SetGridText(grdDetail.rows - 1, iCol_Item_Code, 'TOTAL'); 
                grdDetail.SetGridText(grdDetail.rows - 1, iCol_Take_In_Qty, takein_qty); 
                grdDetail.SetGridText(grdDetail.rows - 1, iCol_Amount, amount); 
            }            
            //------------------------
            ButtonStatus();
        break;
        case "fmgf00060_3":
           //-------------------------
            var iNumRecord = grdDetail.rows-1 ;
            
            if (iNumRecord>0)
            {
                btnDelete_1.SetEnable(true)
            }
            else
            {
                 btnDelete_1.SetEnable(false)
                 btnUnDelete_1.SetEnable(true)
            }
            //------------------------
            for ( i = 1 ; i < grdDetail.rows ; i++ )
            {
                if ( grdDetail.GetGridData( i, iCol_Close ) == -1 )
                {
                    grdDetail.GetGridControl().Cell( 7 , i , 0 , i, iCol_Close ) = 0x808080;      
                } 
            } 
            //------------------------
        break;
        case "pro_fmgf00060":
            alert(txtReturnValue.text);
            fmgf00060_3.Call("SELECT");
        break;        
         case "pro_fmgf00060_1":
            alert(txtReturnValue.text);
            fmgf00060_3.Call("SELECT");
        break;
        case 'pro_fmgf00060_2':                
            alert(txtReturnValue.text);
            fmgf00060_1.Call("SELECT");
        break ;
        case 'pro_fmgf00060_5':                
            alert(txtReturnValue.text);
            fmgf00060_1.Call("SELECT");
             break;   
        case 'fmgf00060':
            if(grdSearch.rows > 1)
            {
                txtMasterPK.text = grdSearch.GetGridData(1, 0);
                txtSEQ.text = grdSearch.GetGridData(1, 4);
            }   
            fmgf00060_2.Call('SELECT');
        break ;     
    }
}
//-----------------------------------------------------
 
 function SetParentPKtoGrid()
 {
        for ( i = 1; i < grdDetail.rows ; i++ )
        {
            if ( grdDetail.GetGridData(i,iCol_take_in_pk ) == "" )
            {
                grdDetail.SetGridText( i ,iCol_take_in_pk  , txtMasterPK.text ) ;                
            }
        }
 }
 
 //-----------------------------------------------------
 
function AddOnClick(obj)
{
    // add new master
      switch (obj)         
      {	  
            case 1  :    
            // add new master
                
                if ( fmgf00060_1.GetStatus() != 20 )
                {
                    fmgf00060_1.StatusInsert() ;
                    
                    txtSlipNo1.text = "**New Slip No**";
                    grdDetail.ClearData();
                }
                else
                {
                    alert('Already Add New. Pls Input data !!!');
                }
                ButtonStatus();
            break;

     //add detail 
            case 2  :    
            // add detail      
            if(lstGetData.value == "FR") // User Select Item Entry Manually
            {            
	             var path = System.RootURL + '/form/fp/ab/fpab00040.aspx?purchase_yn=N';
	             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	             if ( obj != null )
	             {
	                    var arrTemp
                        for( var i=0; i < obj.length; i++)	  
                        {	
                                arrTemp = obj[i];
                                     
                                grdDetail.AddRow();
                                
                                grdDetail.SetGridText( grdDetail.rows-1, iCol_TAC_ABACCTCODE_PK , arrTemp[19]);//acount_pk	    
                                grdDetail.SetGridText( grdDetail.rows-1, iCol_Acount_Code, arrTemp[20]);//acount_code	    
                                grdDetail.SetGridText( grdDetail.rows-1, iCol_Acount_Name, arrTemp[21]);//acount_name	
                                
                                grdDetail.SetGridText( grdDetail.rows-1, iCol_TCO_ITEM_PK,   arrTemp[0]);//item_pk	    
                                grdDetail.SetGridText( grdDetail.rows-1, iCol_Item_Code, arrTemp[1]);//item_code	    
                                grdDetail.SetGridText( grdDetail.rows-1, iCol_Item_Name, arrTemp[2]);//item_name	    
                                grdDetail.SetGridText( grdDetail.rows-1, iCol_UOM,   arrTemp[5]);//item_uom  
                                
                                grdDetail.SetGridText( grdDetail.rows-1, iCol_TIN_WAREHOUSE_PK, arrTemp[14] );//warehouse_pk	 
                                grdDetail.SetGridText( grdDetail.rows-1, iCol_Ware_House,   lstWH.GetText() );//warehouse_name  
                        }		            
	             }	
	             ButtonStatus(); 	              
            }
            else if(lstGetData.value == "ED") // Enter manually or copy excel file
            {
                grdDetail.AddRow();
            }	             
            break;	  	        
     }         
}
//-----------------------------------------------------
function OnChangeItem()
{
    var col, row
    
    col = event.col
    row = event.row
    
    if ( col == iCol_Ware_House)
    {
         var path = System.RootURL + '/form/fp/ab/PopUpGetWareHouse.aspx';
         var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                       
         if ( obj != null )
         {
             grdDetail.SetGridText( row, iCol_TIN_WAREHOUSE_PK, obj[0] );//warehouse_pk	 
             grdDetail.SetGridText( row, iCol_Ware_House,   obj[2] );//warehouse_name         
	      }
    }
    else if(col ==iCol_Item_Code ||col ==iCol_Item_Name )
    {
         var path = System.RootURL + '/form/fp/ab/PopUpGetOneItem.aspx?purchase_yn=N';
             var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             if ( obj != null )
             {
                grdDetail.SetGridText( row, iCol_TCO_ITEM_PK ,   obj[0]);//item_pk	    
                grdDetail.SetGridText( row, iCol_Item_Code, obj[1]);//item_code	    
                grdDetail.SetGridText( row, iCol_Item_Name, obj[2]);//item_name	    
                grdDetail.SetGridText( row, iCol_UOM,    obj[5]);//st_item_uom  
                grdDetail.SetGridText( row, iCol_TIN_WAREHOUSE_PK, obj[14] );//warehouse_pk	 
                grdDetail.SetGridText( row, iCol_Ware_House,   lstWH.GetText() );//warehouse_name                                                                           
             }	
    }
    else if(col==iCol_Acount_Code ||col==iCol_Acount_Name)
    {
		var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "155" + "&comm_nm2=" + "" + "&val1=" + 'Y' + "&val2=" + 'Y' + "&val3=" + lstCompany.GetData() + "&dsqlid=ACNT.SP_SEL_ACCT_POPUP";
		o = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
		if (o != null)
		{
			if(o[0] != 0)
			{
				grdDetail.SetGridText( row, iCol_TAC_ABACCTCODE_PK ,   o[3]);//acount_pk
				grdDetail.SetGridText( row, iCol_Acount_Code, o[0]);//acount_code	    
				grdDetail.SetGridText( row, iCol_Acount_Name, o[1]);//acount_name
			}			
		}		
    }
}
//-----------------------------------------------------

function SaveOnClick(pos)
{
      switch (pos)         
      {	  
            case 1  :                
                if ( CheckSaveMaster() )
                {
                    fmgf00060_1.Call();
                    p_update = 1 ;
                }
            break ;
       }            
}

//-----------------------------------------------------
function CheckSaveMaster()
{
    if(Trim(chkAuto_YN.value) == 'F')
    {
        if(Trim(txtSlipNo1.text) == "" || Trim(txtSlipNo1.text)=="**New Slip No**" )
        {
            alert('Please enter the TakeIn No!!!');
            txtSlipNo1.GetControl().focus();
            return false ;                
        }
    }
	if(Trim(txttac_abacctcode_pk.text) == "")
	{
		alert('Please input account code for Credit account!!!');
		return false;
	}
    for (i = 1; i< grdDetail.rows ; i++)
    {
        if(grdDetail.GetGridData(i, iCol_Item_Code)!="TOTAL")
        {
            if (grdDetail.GetGridData(i,iCol_Take_In_Qty)=="")
            {
                alert("Please, input quantity for row " + i + " !!!")
                grdDetail.DeselectRow(grdDetail.row);
                grdDetail.SelectRow(i);
                return false;
            }
            /*if (Trim(grdDetail.GetGridData(i, iCol_Acount_Code))=="")
            {
                    alert("Please, input Account for row "+i+" !!!")
                    grdDetail.DeselectRow(grdDetail.row);
                    grdDetail.SelectRow(i);
                    return false;
            }*/
           /* if (grdDetail.GetGridData(i,iCol_Ware_House )=="")
            {
                    alert("Please, input Warehouse for row "+i+" !!!");
                    grdDetail.DeselectRow(grdDetail.row);
                    grdDetail.SelectRow(i);
                    return false;
            }
            */
        }
    }    
    return true; // entered data valid
}
//----------------------Detail--------------------------------------
function OnDelete(obj)
 {
      switch (obj)         
      {	  
            case 1  :  

                var ctrl = grdDetail.GetGridControl();
	            var n    = ctrl.rows;
	            var row  = ctrl.row;
            	
	            if ( row < 0 ) 
	            {			
			            alert("Please select a Record to delete .");
	            }			
	            else 
	            {
		            if ( grdDetail.GetGridData( ctrl.row, iCol_PK ) == "" ) 
		            {						
        				
					            grdDetail.RemoveRow();					
			        }        			
			        else if(grdDetail.GetGridData(ctrl.row, iCol_Close) == '-1')
			        {
			            alert('Cannot delete because the slip has been processed');
			            return ;
			        }
		           else if ( confirm( "Do you want to mark this row to delete?" ) ) 
		           {
			            {
				            grdDetail.DeleteRow();
			            }
			            checkData();
		            }
	            }
	            
	        break;
	            
            case 0  :  
                var i ;
                for ( i = 1; i < grdDetail.rows ; i++)
                {
                    if(grdDetail.GetGridData(i, iCol_Close) == '-1')
                    {
                        alert('Cannot delete because the slip has been processed');
                        return ;
                    }    
                }     
                if ( confirm ( "Do you want to delete this request?" ) )
                {

                    fmgf00060_1.StatusDelete();
                    
                    if (txtMasterPK.text!="")                    
	                    fmgf00060_1.Call();    	                
	                else
    	            
	                    alert("Please,Select a FG Take in !")
 	             }
     	         
     	    break; 
      } 	        
 }

//---------------------------------------------------------
 function OnUnDelete() 
 {

	var ctrl = grdDetail.GetGridControl();

	var row  = ctrl.row;

		if ( row > 0 )
		{
			if ( grdDetail.GetGridData( ctrl.row, iCol_PK) == "" ) 
			{
			}
			else 
			{				
				if ( confirm ( "Do you want to undelete?" ) ) 
				{				
					grdDetail.UnDeleteRow()
				}
				checkData();
			}
		}
}

//---------------------------------------------------------

function editDetail()
{
   //check data valid
  var col, row
    col = event.col
    row = event.row
    if (col==iCol_Take_In_Qty)
    {
        var dQuantiy =  grdDetail.GetGridData(row,col);
        if ( !Number(dQuantiy) )
        { 
             grdDetail.SetGridText(row,col,"")
        }
        var dPrice = grdDetail.GetGridData(row, iCol_UPrice);        
        var dAmount = Number(dQuantiy) * Number(dPrice);
        grdDetail.SetGridText(row, iCol_Amount, dAmount);
    }
    else if(col == iCol_UPrice)
    {
        var dPrice =  grdDetail.GetGridData(row,col);
        if ( !Number(dPrice) )
        { 
             grdDetail.SetGridText(row,col,"")
        }
        var dQuantiy = grdDetail.GetGridData(row, iCol_Take_In_Qty);        
        var dAmount = Number(dQuantiy) * Number(dPrice);
        grdDetail.SetGridText(row, iCol_Amount, dAmount);    
    }
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
				btnDelete_1.SetEnable(false);
				btnUnDelete_1.SetEnable(true);
			}
			else 
			{
				btnDelete_1.SetEnable(true);
				btnUnDelete_1.SetEnable(false);
			}
		}	
	}
	ButtonStatus();	
}
//---------------------------------------------------------------
// Pop up on Trans Type and Debit Account columns
function OnPopUp(iObj)
{
    switch(iObj)
    {
        case 'Trans Type':
            var path = System.RootURL + '/form/gf/hg/gfhg00010_transaction.aspx?compk='+ lstCompany.value;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if( object != null )
            {
		        var tmp = object[0];
		        if (tmp[1] != null)
		        {
		            txtTransCode.text = tmp[1];
		            txtTransName.text = tmp[2];
		            txtabtypetr_pk.text = tmp[0];
                }                
            }
        break ;                    
    case 'Debit Account':
        var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + txtTransCode.text + "&val1=" + txtTransName.text + "&val2=C" + "&val3=" + lstCompany.value + "&dsqlid=ACNT.SP_SEL_ACCOUNT_NEW_DRCR" ;
        var object  =   System.OpenModal(  fpath , 550 , 550 , 'resizable:yes;status:yes');	        
        if(object!=null)
        {               
            var tmp = object[0];
            if( tmp != null && Trim(tmp[1]) != '' )
            {
                txtDebitCode.text = tmp[4];
                txtDebitName.text = tmp[5];
                txttac_abacctcode_pk.text = tmp[1] ;                    
            }
        }                                                    
    break ;    
    }
}
//---------------------------------------------------------------
function OnGridCellDblClick(iObj)
{
    var lcol = event.col;
    var lrow = event.row ;
    if( lcol == 4 && Trim(grdSearch.GetGridData(lrow, lcol)) != '' )
    {
        var pk = grdSearch.GetGridData(lrow, 4);
        //var status = grdSearch.GetGridData(lrow, G1TR_STATUS);

        var fpath = System.RootURL + '/form/gf/br/gfbr00030_popup.aspx?PK_ROW=' + pk + '&APPRCANCEL=2';
        var wWidth = 950;
        var wHeight = 565;
        var x = Math.round((screen.availWidth - wWidth)/2);
        var y = Math.round((screen.availHeight - wHeight)/2);

        var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
        "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
        "lef="+ x +",top=" + y;

        var object = System.OpenModal(fpath, wWidth, wHeight, features);                
    }            
}
//---------------------------------------------------------------
// process auto-generate voucher_no or not
function OnAutoYNChange()
{
    if(chkAuto_YN.value == 'T')
    {
        txtSlipNo1.SetEnable(false);
    }
    else
    {
        txtSlipNo1.SetEnable(true);
        txtSlipNo1.GetControl().focus();
    }
}
//---------------------------------------------------------------
function ButtonStatus()
{
    var i;
    btnNew_1.SetEnable(true);
    btnDelete_1.SetEnable(true);
    btnDelete.SetEnable(true);
    btnUpdate.SetEnable(true);
    for(i = 1; i < grdDetail.rows - 1; i++)
    {
        if(grdDetail.GetGridData(i, iCol_Close) == '-1')
        {
            btnNew_1.SetEnable(false);
            btnDelete_1.SetEnable(false);
            btnDelete.SetEnable(false);
            btnUpdate.SetEnable(false);
            break ;
        }
    }    
}
//---------------------------------------------------------------
function OnConfirm()
{
    if(confirm('Are you sure you want to confirm this slip?'))
    {
        pro_fmgf00060_2.Call();
    }
}
//---------------------------------------------------------------
function OnCancel()
{
    if(confirm('Are you sure you want to cancel this slip?'))
    {
        txtHGTRHPK.SetDataText(grdSearch.GetGridData(grdSearch.row, 4)); // TAC_HGTRH_PK
        txtMasterPK.SetDataText(grdSearch.GetGridData(grdSearch.row, 0)); // MASTER_PK
        pro_fmgf00060_5.Call();
    }
}
//---------------------------------------------------------------
function StatusConfirm()
{
    var l_status = lblStatus.GetData();
    if(l_status.toUpperCase() == "CONFIRMED")
    {
        idBtnClose.SetEnable(false);
        idBtnUnClose.SetEnable(true);
    }
    else
    {
        idBtnClose.SetEnable(true);
        idBtnUnClose.SetEnable(false);
    }
}
//---------------------------------------------------------------
// Only print out the confirmed vouchers
function OnExcel()
{
    if(Trim(txtMasterPK.text) == '')
    {
        alert('Please choose the Slip No to print out...');
        return ;
    }        
    
    if(lstReport.value == "1")
    {        
        var url =System.RootURL + '/reports/fm/gf/fmgf00060.aspx?tac_fgtakein_pk=' + txtMasterPK.text + '&company_pk=' + lstCompany.value ;
        System.OpenTargetPage(url); 
    }
    else if(lstReport.value == "0")
    {     
        if(grdSearch.row > 0)
        {  
            if(grdSearch.GetGridData(grdSearch.row, 4) != "") 
            {
				var url = System.RootURL + "/reports/gf/hg/60080010_envn.aspx?seq=" + grdSearch.GetGridData(grdSearch.row, 4);
				System.OpenTargetPage(url);        			
			}
        }				
    }
    
}
//---------------------------------------------------------------
</script>

<body>
    <!-------------------------------user right ------------------------------->
    <gw:data id="fmgf00060" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso id="1" type="grid" function="acnt.sp_sel_fmgf00060" > 
                    <input bind="grdSearch" > 
                         <input bind="txtSlipNo" /> 
                         <input bind="dtFromDate" /> 
                         <input bind="dtToDate" /> 
                     </input> 
                    <output bind="grdSearch" /> 
                </dso> 
            </xml> 
        </gw:data>
    <!-------------------------------user right ------------------------------->
    <gw:data id="fmgf00060_1" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso  type="control" function="acnt.sp_sel_fmgf00060_1" parameter="0,1,2,3,4" procedure="acnt.sp_upd_fmgf00060_1" > 
                    <inout > 
                         <inout bind="txtMasterPK" /> 
                         <inout bind="txtSlipNo1" /> 
                         <inout bind="dtDate" /> 
						 <inout bind="lstCompany" /> 
						 <inout bind="txttac_abacctcode_pk" />
						 <inout bind="txtDebitCode" /> 
						 <inout bind="txtDebitName" />	
						 <inout bind="lblStatus" />		
						 <inout bind="txtSeq1" />			 
                    </inout> 
                 </dso> 
            </xml> 
        </gw:data>
    <!-------------------------------------------------------------->
    <gw:data id="fmgf00060_2" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso id="1" type="grid" function="acnt.sp_sel_fmgf00060_4" parameter ="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" procedure="acnt.sp_upd_fmgf00060_4"> 
                    <input bind="grdDetail" > 
                         <input bind="txtMasterPK" /> 
                    </input> 
                    <output bind="grdDetail" /> 
                </dso> 
            </xml> 
     </gw:data>
    <!-------------------------------------------------------------->
    <gw:data id="pro_fmgf00060_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="ACNT.sp_pro_fmgf00060_2" > 
                <input>
                    <input bind="lstCompany" /> 
                    <input bind="txtMasterPK" /> 
                    <input bind="txtSlipNo1" /> 
                    <input bind="dtDate" /> 
                    <input bind="txtClose_YN" />
                    <input bind="txtabtypetr_pk" />
                    <input bind="txttac_abacctcode_pk" />  
                    <input bind="txtSEQ" />
                    <input bind="txtVoucherType" />                      
                    <input bind="chkAuto_YN" />
                </input> 
                <output>
                    <output bind="txtMasterPK" />
                </output>            
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------->
    <gw:data id="pro_fmgf00060_5" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="ACNT.sp_pro_fmgf00060_5" > 
                <input>
                    <input bind="txtHGTRHPK" /> 
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtMasterPK" />
                </output>            
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------->
    

    <table class="table" width="100%" cellpadding="0" cellspacing="0" border="1" style="height:100%" >
        <tr style="height:100%" >
            <td id="left" style="width: 30%" valign="top" >
                <!-- Table1 contain master buttons and text box -->
                <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                    <tr style="height:5%">
                        <td style="width: 100%;" >
                            <table width="100%" style="height: 100%" cellpadding="0" cellspacing="0" >
                                <tr>
                                    <td align="right" style="width: 25%">Slip No</td>
                                    <td style="width: 60%">
                                        <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%" />
                                    </td>
                                    <td style="width: 20%" align='right'>
                                        <gw:imgbtn id="btnSearch1" img="search" onclick='OnSearch(1)' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height:5%"  >
                        <td style="width: 100%">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                                <tr>
                                    <td align="right" style="width: 25%">Trans Date</td>
                                    <td style="width: 30%"><gw:datebox id="dtFromDate" lang="1" /></td>
                                    <td style="width: 15%" align="center">~</td>
                                    <td style="width: 30%"><gw:datebox id="dtToDate" lang="1" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height:90%" >
                        <td>
                            <gw:grid id="grdSearch" 
							header="_PK|Slip No|Trans Date|Acc.Voucher No|SEQ" 
							format="0|0|0|0|0" 
							aligns="0|0|1|0|0"
                            defaults="||||" 
							editcol="0|0|0|0|0" 
							widths="0|2000|1200|1600|1000" 
							styles="width:100%; height:100%"
                            sorting="T" 
							acceptNullDate="true" 
							oncellclick="OnSearch(2)" 
							oncelldblclick="OnGridCellDblClick(this)" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 70%; height:100%" valign="top">
                <table style="width: 100%; height:100%" cellpadding="0" cellspacing="0" border="0" >
                    <tr style="height:5%" >
                        <td>
                            <table style="width: 100%; height:100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="width: 10%" align="right">Slip No</td>
                                    <td align="right" style="width:3%; "><gw:checkbox id="chkAuto_YN" onchange="OnAutoYNChange()" /></td >
                                    <td style="width: 15%">
                                        <gw:textbox id="txtSlipNo1" csstype="mandatory" styles="width:100%" />
                                    </td>
                                    <td style="width: 10%" align="right">Trans Date</td>
                                    <td style="width: 10%" align="right">
                                        <gw:datebox id="dtDate" lang="1" styles="width:100%" />
                                    </td>
                                    <td align="right" style="width: 10%">File Path</td>
                                    <td style="width: 27%">
                                        <input type="file" id="idtext" styles="width:100%" onchange="ReadFiles()" onkeypress="ReadFiles()"><br>
                                    </td>
                                    <td style="width: 3%" align="right">
                                        <gw:imgbtn id="btnNew" img="new" alt="New Reurn Goods" text="Add" onclick="AddOnClick(1)" />
                                    </td>
                                    <td style="width: 3%" align="right">
                                        <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete(0)" />
                                    </td>
                                    <td style="width: 3%" align="right">
                                        <gw:imgbtn id="btnUpdate" img="save" alt="Save" text="Save" onclick="SaveOnClick(1)" />
                                    </td>
                                    <td style="width: 3%" align="right">
                                        <gw:imgbtn id="btnPrint" img="excel" alt="Report" text="Report" onclick="OnExcel()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height:1%" >
                        <td style="width: 100%">
                            <hr noshade size="2" width="100%" style="color: Silver">
                        </td>
                    </tr>
                    <tr style="height:15%" >
                        <td>
                            <table style="width: 100%; height:100%" border="0" cellpadding="0" cellspacing="0" >
                                <tr style="height:35%">
                                    <td style="width: 10%" align="right">Company</td>
                                    <td style="width: 15%">
                                        <gw:list id="lstCompany" styles="width: 100%" />
                                    </td>
                                    <td align="right" style="width: 10%">Get Data</td>
                                    <td align="right" style="width: 15%"><gw:list id="lstGetData" styles="width:100%;" /></td>
                                    <td style="width: 3%">
                                    </td>
                                    <td style="width: 8%">                                        
                                        <gw:icon id="idBtnClose" img="in" text="Confirm" styles='width:100%' onclick="OnConfirm()" />
                                    </td>
                                    <td style="width: 8%">
                                        <gw:icon id="idBtnUnClose" img="in" text="Cancel" styles='width:100%' onclick="OnCancel()" />                                        
                                    </td>
                                    <td style="width: 8%" align="right">Seq</td>                                                                                                                
                                    <td style="width: 14%"><gw:textbox id="txtSeq1" styles="width:100%;" /></td>                                                                                                                    
                                    <td align="right" style="width: 3%">
                                        <gw:imgbtn id="btnNew_1" img="new" alt="New From Item" text="Add" onclick="AddOnClick(2)" />
                                    </td>
                                    <td align="right" style="width: 3%">
                                        <gw:imgbtn id="btnDelete_1" img="delete" alt="Delete" text="Delete" onclick="OnDelete(1)" />
                                    </td>
                                    <td align="right" style="width: 3%">
                                        <gw:imgbtn id="btnUnDelete_1" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                                <tr style="height:30%">
                                    <td style="width: 10%" align="right"><a title="Click here to select transaction type" onclick="OnPopUp('Trans Type')" href="#tips">Trans Type</a></td>
                                    <td style="width: 15%"><gw:textbox id="txtTransCode" styles="width:100%;" /></td>
                                    <td align="right" style="width: 25%" colspan="2">                                        
                                        <gw:textbox id="txtTransName" styles="width:100%;" />
                                    </td>
                                    <td style="width: 11%" colspan="2" align="right">
                                        <a title="Click here to select transaction type" onclick="OnPopUp('Debit Account')" href="#tips">Credit Acct</a>                                        
                                    </td>
                                    <td style="width: 8%" align="left">                                        
                                        <gw:textbox id="txtDebitCode" styles="width:100%;" />
                                    </td>
                                    <td style="width: 31%" colspan="5" align="left">                                        
                                        <gw:textbox id="txtDebitName" styles="width:100%;" />
                                    </td>
                                </tr>
								<tr style="height:30%">
								    <td style="width: 10%" align="right">Status</td>
								    <td style="width: 15%" align="center"><gw:label id="lblStatus" styles="width:100%;" /></td>
								    <td style="width: 10%" align="right" >Report</td>
								    <td style="width: 15%" align="left" ><gw:list id="lstReport" styles="width:100%;" >
								    <data>DATA|0|Acct. Slip|1|P. nhập kho</data></gw:list>
								    </td>
								    <td style="width: 11%" colspan="2" align="right">WH</td>
                                    <td align="right" style="width: 39%" colspan="6">
                                        <gw:list id="lstWH" styles='width:100%' />
                                    </td>								    
								</tr>
                            </table>
                        </td>
                    </tr>
					<tr style="height:79%">
                        <td style="border-bottom:1.0pt solid silver; border-right:1.0pt solid silver">
                            <gw:grid id="grdDetail" 
                                header="_PK|_p_take_in_pk|_TAC_ABACCTCODE_PK|_TCO_ITEM_PK|Item Code|Item Name|UOM|TakeIn Qty|U/Price|Amount|Account Code|Account Name|_TIN_WAREHOUSE_PK|Warehouse|_company|Close"
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|3" 
                                aligns="0|0|0|0|0|0|0|3|1|3|3|3|0|0|0|0" 
                                defaults="|||||||||||||||"
                                editcol="0|0|0|0|0|0|0|1|1|1|1|1|0|0|0|0" 
                                widths="0|0|0|1500|2000|0|1500|2000|1000|1500|1500|1500|0|2000|0|0"
                                sorting="T" 
                                styles="width:100%; height:100%" 
                                onafteredit="editDetail()" 
                                oncelldblclick="OnChangeItem()"
                                oncellclick="checkData()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!----------------------------------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!----------------------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles='width:100%;display:none' />
    <gw:textbox id="txtHGTRHPK" styles='width:100%;display:none' />
    <!----------------------------------------------------------------------------------------->
    <gw:textbox id="txtReturnValue" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txtabtypetr_pk" maxlen="100" styles='width:100%;display:none' />
    <gw:textbox id="txttac_abacctcode_pk" styles='width:100%;display:none' />    
    <gw:textbox id="txtClose_YN" styles='width:100%;display:none' />
    <gw:textbox id="txtSEQ" styles='display:none' />
    <gw:textbox id="txtVoucherType" text="NTP" styles='display:none' />
    <!----------------------------------------------------------------------------------------->
</body>
</html>
