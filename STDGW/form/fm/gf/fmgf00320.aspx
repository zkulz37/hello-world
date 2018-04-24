<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1" runat="server">
    <title>Daily Item Openning Balance</title>
</head>
<script>
var vPage = 0 ;
var currentPage = 0;
//---------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;
 
var iColtac_stockdd_pk      = 0,
    iColNo                  = 1,
    iColtac_abacctcode_pk   = 2,
    iColCode_Acc            = 3,
    iColName_Acc            = 4,
    iColtco_item_pk         = 5,
    iColCode_Item           = 6,
    iColName_Item           = 7,
    iColItem_UOM            = 8,
    iCol_tin_warehouse_pk   = 9,    
    iColWarehouse           = 10,
    iColtpr_line_pk         = 11,
    iColLine                = 12,
    iColtac_abplcenter_pk   = 13,
    iColPL_Name             = 14,
    iColLast_Quantity       = 15,
    iColLast_FAmt           = 16,
    iColLast_Amt            = 17,
    iColInput_Qty           = 18,
    iColInput_FAmt          = 19,
    iColin_ccy        		= 20,
    iColInput_Amt           = 21,
    iColOutput_Qty          = 22,
    iColOutput_FAmt         = 23,
    iColOutput_Amt          = 24,
    iColThis_Qty            = 25,
    iColThis_FAmt           = 26,
    iColThis_Amt            = 27,
    iColThis_Qty_Bal        = 28,
    iColThis_FAmt_Bal       = 29,
    iColThis_Amt_Bal        = 30,
    iCol_std_ym             = 31,        
    iColTCO_BUSPARTNER_PK   = 32,    
    iColCust_nm             = 33,
    iColRemark              = 34,
    iColStockTr             = 35,
    iColCompany_pk          = 36;

var iG1_Account_Code        = 0 ,
    iG1_Account_Code_Eng    = 1 ,
    iG1_tac_abacctcode_pk   = 2 ,
    iG1_Account_Name_Local  = 3 ;
    
var iOld_InputAmt ;

//----------------------------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("tLEFT");    
    var right = document.all("tRIGHT");   
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
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 
//------------------------------------------------------------------------
	        
function BodyInit()
{  
   BindingData();       
   idBtnUndel.SetEnable( false );
   txtOpenAmt.SetEnable(false);
   txtBalanceAmt.SetEnable(false);
   txtAccountCode.SetEnable(false);
   txtAccountName.SetEnable(false);
   txtPLCode.SetEnable(false);
   txtPLName.SetEnable(false);
	idGrid.GetGridControl().FrozenCols = iColName_Item;
   idGrid.GetGridControl().ScrollTrack=true;    
   setPage(vPage);
}

//---------------------------------------------------------------------
function BindingData()
{
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);    
    var data = "<%=ESysLib.SetListDataSQL("SELECT pk,wh_name  FROM inv.tin_warehouse  WHERE del_if = 0 ORDER BY wh_name  ASC" )%>||ALL";    
    lstWH.SetDataText(data);    
    lstWH.value = '';    
    <%=ESysLib.SetGridColumnComboFormat("idGrid" , 20, "SELECT A.CODE, A.CODE_NM FROM COMM.TCO_ABCODE A, COMM.TCO_ABCODEGRP B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0  AND A.TCO_ABCODEGRP_PK = B.PK AND B.ID = 'ACAB0110' AND A.USE_IF = 1 ORDER BY A.CODE ") %> ;        
}

//-------------------------------------------------------------------------------------------
function MergeColumn()
{
    grdMaster.GetGridControl().MergeCells = 2 ;    
    grdMaster.GetGridControl().MergeCol(0) = true ; 
    grdMaster.GetGridControl().MergeCol(1) = true ; 
    grdMaster.GetGridControl().MergeCol(2) = true ; 
    grdMaster.GetGridControl().MergeCol(3) = true ; 
    grdMaster.GetGridControl().MergeCol(4) = true ;
    grdMaster.GetGridControl().MergeCol(5) = true ;
    grdMaster.GetGridControl().MergeCol(6) = true ;
    grdMaster.GetGridControl().MergeCol(7) = true ;
    grdMaster.GetGridControl().MergeCol(8) = true ;
    grdMaster.GetGridControl().MergeCol(9) = true ;
    grdMaster.GetGridControl().MergeCol(10) = true ;
    grdMaster.GetGridControl().MergeCol(11) = true ;
    grdMaster.GetGridControl().MergeCol(12) = true ;
    grdMaster.GetGridControl().MergeCol(13) = true ;
    grdMaster.GetGridControl().MergeCol(14) = true ;
    grdMaster.GetGridControl().MergeCol(15) = true ;
    grdMaster.GetGridControl().MergeCol(16) = true ;
    grdMaster.GetGridControl().MergeCol(17) = true ;
    grdMaster.GetGridControl().MergeCol(18) = true ;
    grdMaster.GetGridControl().MergeCol(19) = true ;
    grdMaster.GetGridControl().MergeCol(20) = true ;
    grdMaster.GetGridControl().MergeCol(21) = true ;
    grdMaster.GetGridControl().MergeCol(22) = true ;
    grdMaster.GetGridControl().MergeCol(23) = true ;
    grdMaster.GetGridControl().MergeCol(24) = true ;
    grdMaster.GetGridControl().MergeCol(25) = true ;
    grdMaster.GetGridControl().MergeCol(26) = true ;
    grdMaster.GetGridControl().MergeCol(27) = true ;
    grdMaster.GetGridControl().MergeCol(28) = true ;
    grdMaster.GetGridControl().MergeCol(29) = true ;
    grdMaster.GetGridControl().MergeCol(30) = true ;
}
//---------------------------------------------------------------------
function OnPopUp(iObj)
{
    var i, plOption, plValue;
    switch(iObj)
    {
        case 'Account':
            if(Trim(lstCompany.value)=='')
            {
                alert('Must select Company!!!');
                return ;
            }            
            var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_code=&comm_nm=&dsqlid=ACNT.SP_SEL_fmgf00050_3&val1=" + lstCompany.value + "&val2=" + lstWH.value + "&val3=" ;

            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if(object!=null)
            {
                txtAccountCode.text = object[0];
                txtAccountName.text = object[1];
                txtTAC_ABACCTCODE_PK.text = object[3];
            }
        break;
        case 'PL':            
            if(Trim(lstCompany.value)=='')
            {
                alert('Must select Company!!!');
                return ;
            }              
            /*var path = System.RootURL + "/form/gf/co/gfco002005.aspx?dsqlid=ACNT.SP_SEL_fmgf00050_2&company=" + lstCompany.value + "&col_code=PL Code&col_nm=PL Name&comm_nm=" +  + "&val1=" + lstWH.value ;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
            if(object != null)
            {
                txttac_abplcenter_pk.text = object[2];
                txtPLCode.text = object[0];
                txtPLName.text = object[1];
            }*/
		    var fpath   = System.RootURL + "/form/gf/co/gfco002005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ACNT.SP_SEL_PL_POPUP&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME"; //lay tac_abplcenter_pk
            var object  = System.OpenModal(fpath , 600 , 500 , 'resizable:yes;status:yes'); 
            if ( object != null )  
            {
                if (object[0] != 0)
                {
                    txttac_abplcenter_pk.text = object[2] ;     // PK
                    txtPLCode.text = object[0];     // PL code
                    txtPLName.text = object[1];     // PL Name
                }
                //txtSEQ.GetControl().focus();
            }
            else
            {
                //txtSEQ.GetControl().focus();
            }            
            break;
        case 'Item':                   
            var path = System.RootURL + "/form/fm/gf/PopUpGetOneItem.aspx?purchase_yn=&item_code=" + txtItemCode.text + "&item_name=" + txtItemName.text ;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
            if(object != null)
            {
                txtItemCode.text = object[1];
                txtItemName.text = object[2];
            }            
        break ;
    }
}
//---------------------------------------------------
function OnAddNew()
{
    var iNewrow, ctrl, arr, i;
    if(Trim(lstCompany.value)=='')
    {
        alert('Must Select Company!!!');
        return;
    }
    /*else if(Trim(lstWH.value)=='')
    {
        alert('Must Select Warehouse!!!');
        return;
    }*/
    
    var path = System.RootURL + "/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y" ;
    var object = System.OpenModal( path , 1000 , 600 ,  'resizable:yes;status:yes');        
    if( object!=null)
    {
        for(i = 0; i < object.length; i++)
        {
             arr = object[i];
             idGrid.AddRow();
             iNewrow = idGrid.rows - 1;
             idGrid.SetGridText(iNewrow, iColtco_item_pk, arr[0] );
             idGrid.SetGridText(iNewrow, iColCode_Item, arr[1] );
             idGrid.SetGridText(iNewrow, iColName_Item, arr[2] );                     
             idGrid.SetGridText(iNewrow, iColItem_UOM, arr[5]);  
             idGrid.SetGridText(iNewrow, iCol_std_ym, dbDay.value );
			 if(lstWH.value != "")
			 {
				idGrid.SetGridText(iNewrow, iCol_tin_warehouse_pk, lstWH.value );                          			
				idGrid.SetGridText(iNewrow, iColWarehouse, lstWH.GetText() );     
			 }	
             idGrid.SetGridText(iNewrow, iColtac_abplcenter_pk, txttac_abplcenter_pk.text );
             idGrid.SetGridText(iNewrow, iColPL_Name, txtPLName.text );  
             idGrid.SetGridText(iNewrow, iColCompany_pk, lstCompany.value );  
             
             if(arr[19] != null && Trim(arr[19]) != '' )
             {
                 idGrid.SetGridText(iNewrow, iColtac_abacctcode_pk, arr[19] );     
                 idGrid.SetGridText(iNewrow, iColCode_Acc, arr[20] );
                 idGrid.SetGridText(iNewrow, iColName_Acc, arr[21] );             
             }
             else if( Trim(txtTAC_ABACCTCODE_PK.text) != '' )
             {
                 idGrid.SetGridText(iNewrow, iColtac_abacctcode_pk, txtTAC_ABACCTCODE_PK.text );     
                 idGrid.SetGridText(iNewrow, iColCode_Acc, txtAccountCode.text );
                 idGrid.SetGridText(iNewrow, iColName_Acc, txtAccountName.text );                             
             }
        }
    }  
}
//---------------------------------------------------
function OnSearch(iObj)
{
    switch(iObj)
    {
        case 'fmgf00320':                            
            if(grdSearch.row > 0)
                fmgf00320.Call('SELECT');
            else
            {
                if( grdSearch.rows > 1)
                {
                    txtTAC_ABACCTCODE_PK_2.text = grdSearch.GetGridData(1, iG1_tac_abacctcode_pk ) ;
                    txtdateto_Balance.text = dbDay.value ;
                    txtAccountCode_2.text = grdSearch.GetGridData(1, iG1_Account_Code);
                    fmgf00320.Call('SELECT');
                }             
            }                
        break;
        case 'fmgf00050_1':
            fmgf00050_1.Call('SELECT');
            setPage(0);
        break;
        case 'fmgf00320_1':
            fmgf00320_1.Call();           
        break;        
    }    
}
//--------------------------------------------------
function OnSave(iObj)
{
    var i;
    switch(iObj)
    {
        case 'fmgf00320':        
        for( i = 1; i < idGrid.rows ; i++)
        {
            idGrid.SetGridText(i , iColThis_Qty_Bal, '');
            idGrid.SetGridText(i , iColThis_FAmt_Bal, ''); 
            idGrid.SetGridText(i , iColThis_Amt_Bal, ''); 			
			if(idGrid.GetGridData(i, iColtac_stockdd_pk)=="")
			{
				idGrid.SetGridText(i , iColCompany_pk, lstCompany.value);
				idGrid.SetGridText(i , iCol_std_ym, dbDay.value);
				idGrid.SetRowStatus(i, Number("0x20"));
			}
        }    
            //if(OnValidateData('Add'))
                fmgf00320.Call();
        break;
    }
}
//---------------------------------------------------
function OnUndoDelete()
{
    var i, lOpenAmt = 0;
    if(idGrid.row > 0)
    {
        idGrid.UnDeleteRow();
        idBtnDel.SetEnable(true );
        idBtnUndel.SetEnable(false ); 
        for ( i = 1 ; i < idGrid.rows ; i++)
        {
            if(idGrid.GetRowStatus(i)!=64)
            {
                if( idGrid.GetGridData(i, iColInput_Amt ) != '' )    
                {
                    lOpenAmt += parseFloat( idGrid.GetGridData(i, iColInput_Amt) ) ;
                }
            }
        }
        txtOpenAmt.text = lOpenAmt.toFixed(3)+"" ;
    }           
}
//---------------------------------------------------
function OnDelete()
{    
    var i, lOpenAmt = 0 ;
    if(idGrid.row > 0)
    {
        idGrid.DeleteRow();    
        idBtnDel.SetEnable(false) ;
        idBtnUndel.SetEnable( true );
        for ( i = 1 ; i < idGrid.rows ; i++)
        {
            if(idGrid.GetRowStatus(i)!=64)
            {
                if( idGrid.GetGridData(i, iColInput_Amt ) != '' )    
                {
                    lOpenAmt += parseFloat( idGrid.GetGridData(i, iColInput_Amt) ) ;
                }
            }
        }
        txtOpenAmt.text = lOpenAmt.toFixed(3)+"" ;
    }        
}
//---------------------------------------------------
function OnValidateData(p_action)
{
    var i, lTotRows ;
    if(p_action="Add")
    {
        lTotRows = idGrid.rows ;
        for(i = 1; i < lTotRows; i++)
        {
            if(idGrid.GetGridData(i, iColCode_Acc) != 'TOTAL' )
            {
                if(Trim(idGrid.GetGridData(i, iColtco_item_pk))=='' )
                {
                    alert('Select Item Code for row ' + i);
                    return false;
                }
                else if(Trim(idGrid.GetGridData(i, iCol_tin_warehouse_pk))=='' )
                {
                    alert('Select Warehouse for row ' + i);
                    return false;
                }
                else if(Trim(idGrid.GetGridData(i, iColLast_Quantity))=='' )
                {
                    alert('Input Quantity for row ' + i);
                    return false;
                }
            }
        }
    }
    return true;
}
//------------------------------------------------
function OnFormartData(iObj)
{
    var ctrl;
    switch(iObj)
    {
        case 'idGrid':
            ctrl = idGrid.GetGridControl();
            ctrl.ColFormat(iColInput_Qty)   = "###,###,###,###,###.##";
            ctrl.ColFormat(iColInput_FAmt)  = "###,###,###,###,###.##";
            ctrl.ColFormat(iColInput_Amt)   = "###,###,###,###,###.##";
            
            ctrl.ColFormat(iColLast_Quantity)   = "###,###,###,###,###.##";
            ctrl.ColFormat(iColLast_FAmt)  = "###,###,###,###,###.##";
            ctrl.ColFormat(iColLast_Amt )   = "###,###,###,###,###.##";
      
            ctrl.ColFormat(iColThis_Qty_Bal)   = "###,###,###,###,###.##";
            ctrl.ColFormat(iColThis_FAmt_Bal)  = "###,###,###,###,###.##";
            ctrl.ColFormat(iColThis_Amt_Bal)   = "###,###,###,###,###.##";
            
            ctrl.ColFormat(iColOutput_Qty)   = "###,###,###,###,###.##";
            ctrl.ColFormat(iColOutput_FAmt)  = "###,###,###,###,###.##";
            ctrl.ColFormat(iColOutput_Amt)   = "###,###,###,###,###.##";
            //ctrl.FrozenCols = iColtco_item_pk ;
        break;
    }    
}
//---------------------------------------------------
function OnDataReceive(iObj)
{
    var i, lOpenAmt = 0, lnewrow ;
    var ctrl, lInQty = 0, lInAmt = 0, lInTrAmt = 0 ;
    switch(iObj.id)
    {
        case 'fmgf00320':
            OnFormartData('idGrid');
            for ( i = 1; i < idGrid.rows ; i++)
            {
                if( idGrid.GetGridData(i, iColInput_Amt) != '' )
                    lOpenAmt += parseFloat(idGrid.GetGridData(i, iColInput_Amt));    
            }   
            txtOpenAmt.text =  lOpenAmt.toFixed(3)+""; 
            if(idGrid.rows > 1)
            {
                idBtnDel.SetEnable(true) ;
                idBtnUndel.SetEnable( false );                
            }         
            else
            {
                idBtnDel.SetEnable(false) ;
                idBtnUndel.SetEnable( false );                            
            }
            GridSataus();
            //Dsql_SF_A_GET_BALANCE.Call();
        break;
        case 'fmgf00050_1':
            txtTAC_ABACCTCODE_PK_2.text = grdSearch.GetGridData(1, iG1_tac_abacctcode_pk ) ;
//            txttac_abplcenter_pk_2.text = grdSearch.GetGridData(lrow, iG1_tac_abplcenter_pk ) ;
            txtdateto_Balance.text = dbDay.value ;
            txtAccountCode_2.text = grdSearch.GetGridData(1, iG1_Account_Code);
            OnSearch('fmgf00320_1');           
		break ;
        case 'pro_fmgf00050':
            alert(txtReturnValue.text)
            fmgf00320.Call("SELECT");
        break;
        case 'pro_fmgf00050_1':
            alert(txtReturnValue.text)
            fmgf00320.Call("SELECT");
        break;
        case 'pro_fmgf00050_2':
            alert(txtReturnValue.text)
            fmgf00320.Call("SELECT");
        break;
        case 'fmgf00320_1':
            vPage = Math.ceil( parseInt(txtRecords.text) / 50) ;
            setPage(vPage) ;
            lblRecord2.text = txtRecords.text + " record(s)";
            txtPage.text = 1;
            page1.innerText = '1';            
            currentPage = 1;
            LoadDataPage(page1,1) ;        
        break;
    }
}
//---------------------------------------------------
function GridSataus()
{
    for ( i = 1; i < idGrid.rows ; i++)
	{
		if ( idGrid.GetGridData( i, iColStockTr ) != "" )
		{
			idGrid.GetGridControl().Cell( 7 , i , 0 , i, iColStockTr ) = Number("0x808080");      
		}  
	}    
}
//---------------------------------------------------
function OnCellEnter(iObj)
{
    var lRow, lCol, lInputAmt, lOpenAmt, i ;
    switch(iObj.id)
    {
        case 'idGrid':
            lRow = idGrid.row ;
            lCol = idGrid.col;
            lOpenAmt = 0 ;
            if(lCol ==iColInput_FAmt && Trim(txtRate.text) !='') 
            {
                if(OnEditChange('txtRate')==true)
                {
                    lInputAmt = parseFloat(idGrid.GetGridData(lRow, iColInput_FAmt)) * parseFloat(txtRate.text);
                    idGrid.SetGridText(lRow, iColInput_Amt, lInputAmt);                 
                    lOpenAmt = parseFloat( txtOpenAmt.text ) ;
                    lOpenAmt = lOpenAmt - iOld_InputAmt + parseFloat(idGrid.GetGridData( lRow, iColInput_Amt)) ;
                    txtOpenAmt.text =  lOpenAmt.toFixed(3)+"";                         
                }
            }
            else if ( lCol == iColInput_Amt )            
            {
                lOpenAmt = parseFloat( txtOpenAmt.text ) ;
                lOpenAmt = lOpenAmt - iOld_InputAmt + parseFloat(idGrid.GetGridData( lRow, iColInput_Amt)) ;
                txtOpenAmt.text =  lOpenAmt.toFixed(3)+"";                                     
            }
        break;
    }
}
//-----------------------------------------------------------------------
function OnEditChange(iObj)
{
    var lRate;
    switch(iObj)
    {
        case 'txtRate':            
            if(isNaN(Trim(txtRate.text)))
            {
                alert('Enter a valid number for Rate!'); 
                txtRate.text = '0' ;                                   
                return false;
            }
            return true;
        break;
    }
}
//------------------------------------------------------------------------
function OnImport()
{
     var url = System.RootURL + '/form/fm/gf/fmgf00051.aspx?tco_company_pk=' + lstCompany.value ;
	 var obj = System.OpenModal( url ,1000 , 600 ,  'resizable:yes;status:yes'); 
}
//---------------------------------------------------------
function OnDoubleClick(iObj)
{
    var lrow  = event.row ;
    var lcol  = event.col ;
    switch(iObj.id)
    {
        case 'idGrid':
            if( lcol==iColCode_Acc || lcol==iColName_Acc )
            {
                if(Trim(lstCompany.value)=='')
                {
                    alert('Must select Company!!!');
                    return ;
                }            
                var path = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_code=&comm_nm=&dsqlid=ACNT.SP_SEL_fmgf00050_3&val1=" + lstCompany.value + "&val2=" + idGrid.GetGridData(lrow, iCol_tin_warehouse_pk) + "&val3=" ;
                var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
                if(object!=null)
                {
                    idGrid.SetGridText(lrow, iColCode_Acc, object[0]);
                    idGrid.SetGridText(lrow, iColName_Acc, object[1]);
                    idGrid.SetGridText(lrow, iColtac_abacctcode_pk, object[3]);
                }                
            }
            else if( lcol==iColPL_Name )
            {
                if(Trim(lstCompany.value)=='')
                {
                    alert('Must select Company!!!');
                    return ;
                }            
                var path = System.RootURL + "/form/gf/co/gfco002005.aspx?dsqlid=ACNT.SP_SEL_fmgf00050_2&company=" + lstCompany.value + "&col_code=PL Code&col_nm=PL Name&comm_nm=" + "&val1=" + idGrid.GetGridData(lrow, iCol_tin_warehouse_pk) ;
                var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
                if(object != null)
                {
                    idGrid.SetGridText(lrow, iColtac_abplcenter_pk, object[2]);                    
                    idGrid.SetGridText(lrow, iColPL_Name, object[1]);
                }            
            }
            else if( lcol==iColWarehouse )
            {            
                 var url = System.RootURL + '/form/fp/ab/PopUpGetWareHouse.aspx' ;
	             var obj = System.OpenModal( url ,800 , 600 ,  'resizable:yes;status:yes');             
	             if(obj!=null)
	             {
	                idGrid.SetGridText(lrow, iCol_tin_warehouse_pk, obj[0] );	                
	                idGrid.SetGridText(lrow, iColWarehouse, obj[2] );
	             }            
            }
            else if( lcol==iColCust_nm )
            {            
                 var url = System.RootURL + '/form/fm/gf/PopUpGetPartner.aspx' ;
	             var obj = System.OpenModal( url ,800 , 600 ,  'resizable:yes;status:yes');             
	             if(obj!=null)
	             {
	                idGrid.SetGridText(lrow, iColTCO_BUSPARTNER_PK, obj[0] );	                
	                idGrid.SetGridText(lrow, iColCust_nm, obj[2] );
	             }            
            }            
            break;            
    }
}
//-----------------------------------------------------------------------------
function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}
//----------------------------------------------------------------------------
function OnGridClick(iData)
{
    var lrow = grdSearch.row ;
    switch(iData.id)
    {
        case 'grdSearch':
            //txttin_warehouse_pk.text = grdSearch.GetGridData(lrow, iG1_tin_warehouse_pk ) ;
            txtTAC_ABACCTCODE_PK_2.text = grdSearch.GetGridData(lrow, iG1_tac_abacctcode_pk ) ;
//            txttac_abplcenter_pk_2.text = grdSearch.GetGridData(lrow, iG1_tac_abplcenter_pk ) ;
            txtdateto_Balance.text = dbDay.value ;
            txtAccountCode_2.text = grdSearch.GetGridData(lrow, iG1_Account_Code);
            OnSearch('fmgf00320_1');
        break ;
    }
}
//--------------------------------------------------------------------------------
//function OnMonthlyClosing()
//{
//    pro_fmgf00050.Call();
//}
//--------------------------------------------------------------------------------
//function OnConfirm()
//{
//    pro_fmgf00050_1.Call();
//}
//--------------------------------------------------------------------------------
//function OnMonthlyOpen()
//{
//    pro_fmgf00050_2.Call();
//}
//---------------------------------------------------
function OnCellBeforeEdit(iObj)
{
    switch(iObj.id)
    {
        case 'idGrid':
            if(event.col == iColInput_FAmt || event.col == iColInput_Amt )
            {
                if(idGrid.GetGridData(event.row,iColInput_Amt ) != '' )
                {
                    iOld_InputAmt = parseFloat(idGrid.GetGridData(idGrid.row, iColInput_Amt) );                    
                }
                else
                {
                    iOld_InputAmt = 0 ;
                }
            }
        break ;
    }
}
//--------------------------------------------------------------------------------
function OnReset()
{
    txtTAC_ABACCTCODE_PK.text = '' ;
    txttac_abplcenter_pk.text = '' ;
    txtAccountCode.text = '' ;
    txtAccountName.text = '' ;
    txtPLCode.text = '' ;
    txtPLName.text = '' ;
    txtItemCode.text = '' ;
    txtItemName.text = '' ;    
}
//----------------------Page divide-----------------------------------
function LoadDataPage(obj,init)
{
   if (obj.style.cursor == 'hand'||init==1)
   {
        switch(obj.id)
        {
            case 'page1':
                if (vPage>0)
                {
                    page1.style.cursor = 'none' ;
                    page1.style.color = 'red';
                    page2.style.cursor = 'hand' ;
                    page2.style.color = 'blue';
                    page3.style.cursor = 'hand' ;
                    page3.style.color = 'blue';
                    currentPage =1
                }
            break;
            case 'page2':
                page1.style.cursor = 'hand' ;
                page1.style.color = 'blue';
                page2.style.cursor = 'none' ;
                page2.style.color = 'red';
                page3.style.cursor = 'hand' ;
                page3.style.color = 'blue';
                currentPage =2
            break;
            case 'page3':
                page1.style.cursor = 'hand' ;
                page1.style.color = 'blue';
                page2.style.cursor = 'hand' ;
                page2.style.color = 'blue';
                page3.style.cursor = 'none' ;
                page3.style.color = 'red';
                currentPage =3
            break;
        }
        var page =  obj.innerText
        //alert(page);
        txtPage.text = page
        currentPage = page
        OnSearch('fmgf00320')
    }
}
//---------------------------------------------------------------------------------------------------
function setPage(pPage)
{     
       pagePrev.style.cursor = 'none' ;
       pagePrev.style.color = 'gray';
       
        switch(vPage)
        {
            case 0:
                 page1.innerText = 1;
                 page2.innerText = "";
                 page3.innerText = "";
                 page1.style.cursor ='none';
                 page1.style.color = 'gray';
                 pageNext.style.cursor ='none';
                 pageNext.style.color = 'gray';
            break;   
            case 1:
                 page1.innerText = 1;
                 page2.innerText = "";
                 page3.innerText = "";
                 page1.style.cursor ='none';
                 page1.style.color = 'red';
                 pageNext.style.cursor ='none';
                 pageNext.style.color = 'gray';
            break;   
            case 2:
                 page1.innerText = 1;
                 page2.innerText = 2;
                 page3.innerText = "";
                 pageNext.style.cursor ='none';
                 pageNext.style.color = 'gray';
            break;
            case 3:
                 page1.innerText = 1;
                 page2.innerText = 2;
                 page3.innerText = 3;
                 pageNext.style.cursor ='none';
                 pageNext.style.color = 'gray';
            break;
            default:
                page1.innerText = 1;
                page2.innerText = 2;
                page3.innerText = 3;
                pageNext.style.cursor ='hand';
                pageNext.style.color = 'blue';
            
        }
}
function PrevPage()
{
     var lastPage =  page3.innerText
     var firstPage =  page1.innerText
      if(firstPage > 1 && pagePrev.style.cursor == 'hand')
      {
            page1.innerText = parseInt(page1.innerText + "") -1;
            page2.innerText = parseInt(page2.innerText+ "") -1;
            page3.innerText = parseInt(page3.innerText+ "") -1;
            CurrentState(page1)
            CurrentState(page2)
            CurrentState(page3)
            if (page3.innerText < vPage)
            {
                pageNext.style.cursor ='hand';
                pageNext.style.color = 'blue';

            }
             if (page1.innerText == 1)
            {
                pagePrev.style.cursor = 'none' ;
                pagePrev.style.color = 'gray';

            }
        }     
}

function NextPage()
{
  var lastPage =  page3.innerText
    if(lastPage < vPage && pageNext.style.cursor =='hand')
    {
		page1.innerText = parseInt(page1.innerText + "") +1;
		page2.innerText = parseInt(page2.innerText+ "") +1;
		page3.innerText = parseInt(page3.innerText+ "") +1;
		CurrentState(page1);
		CurrentState(page2);
		CurrentState(page3);
		if (page3.innerText==vPage)
		{
			pageNext.style.cursor ='none';
			pageNext.style.color = 'gray';
		}
		 if (page1.innerText != '1')
		{
			pagePrev.style.cursor ='hand';
			pagePrev.style.color = 'blue';
		}
    }    
}

function CurrentState(obj)
{
     if(obj.innerText == currentPage)
    {
        obj.style.cursor ='none';
        obj.style.color = 'red';
    }else
    {
        obj.style.cursor ='hand';
        obj.style.color = 'blue';
    }
}

function OnToggle()
 {
    var left1  = document.all("tLEFT");    
    var right1 = document.all("tRIGHT");   
//     var left2  = document.all("left2");    
//    var right3 = document.all("right2"); 
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left1.style.display="none";  
//        left2.style.display="none";       
        imgArrow.status = "collapse";
        right1.style.width="100%";
//        right2.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left1.style.display="";
//        left2.style.display="";
        imgArrow.status = "expand";
//        right2.style.width="75%";
        right1.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }

//-------------------------------------------------------------------------
</script>

<body>
    <!------------------------------------------------------------------>
    <gw:data id="fmgf00320" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid"  function="acnt.sp_sel_fmgf00320" parameter="0,2,3,5,6,8,9,10,13,14,15,16,17,31,32,34,36" procedure="ACNT.sp_upd_fmgf00320" > 
                <input bind="idGrid" >                 
                    <input bind="lstCompany"/>
                    <input bind="dbDay"/>                    
                    <input bind="txtTAC_ABACCTCODE_PK_2"/>
					<input bind="lstWH"/>
                    <input bind="txttac_abplcenter_pk"/>
                    <input bind="txtItemCode"/>
                    <input bind="txtItemName"/>
					<input bind="txttco_item_pk"/>
                    <input bind="txtPage" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------->
    <gw:data id="fmgf00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid"  function="ACNT.sp_sel_fmgf00050_1" > 
                <input bind="grdSearch" >   
                    <input bind="lstCompany"/>
                </input>
                <output  bind="grdSearch" />
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------->         
    <gw:data id="fmgf00320_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process"  procedure="ACNT.sp_sel_fmgf00320_1"  > 
                <input>                              
                    <input bind="lstCompany" />
                    <input bind="dbDay" />
                    <input bind="lstWH" />
                    <input bind="txtTAC_ABACCTCODE_PK_2" />
                    <input bind="txttac_abplcenter_pk" />                    
                    <input bind="txtItemCode" />
                    <input bind="txtItemName" />
                </input>
                <output>
                    <output  bind="txtRecords" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------->
    
    <table width="100%" style="height: 100%" border="1">
        <tr style="height: 15%;">
            <td colspan="2">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%" >
                    <tr>
                        <td style="width: 12%"></td>
                        <td style="width: 15%"></td>
                        <td style="width: 12%"></td>
                        <td style="width: 12%"></td>
                        <td style="width: 5%"></td>
                        <td style="width: 9%"></td>
                        <td style="width: 2%"></td>
                        <td style="width: 10%"></td>
                        <td style="width: 3%"></td>
                        <td style="width: 3%"></td>
                        <td style="width: 3%"></td>
                        <td style="width: 3%"></td>
                        <td style="width: 10%"></td>
                    </tr>
                    <tr>
                        <td align="right">Company&nbsp;</td>
                        <td align="left">
                            <gw:list id="lstCompany" styles="width:100%; "  />
                        </td>
                        <td align="right">Date&nbsp;</td>
                        <td align="left">
                            <gw:datebox id="dbDay" type="day" lang="1" onchange="OnSearch('fmgf00050_1')" />
                        </td>
                        <td align="left">Ex Rate&nbsp</td>
                        <td align="left">
                            <gw:textbox id="txtRate" styles="width:100%; " onchange="OnEditChange('txtRate')" />
                        </td>
                        <td align="left">
                            <gw:imgbtn id="idBtnReset" img="reset" alt="Reset" text="Reset" styles="width:100%; " onclick="OnReset()" />                        
                        </td>
                        <td align = "right">
                            <gw:imgbtn align="right" id="idBtnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('fmgf00050_1')" />
                        </td>
                        <td align="right">
                            <gw:imgbtn id="idBtnNew" img="new" alt="New" text="New" onclick="OnAddNew()" />
                        </td>
                        <td align="right">
                            <gw:imgbtn id="idBtnSave" img="save" alt="Save" text="Save" onclick="OnSave('fmgf00320')" />
                        </td>
                        <td align="right">
                            <gw:imgbtn id="idBtnDel" img="delete" alt="Delete" text="Delete" onclick="OnDelete()" />                                 
                        </td>
                        <td align="right">
                            <gw:imgbtn id="idBtnUndel" img="udelete" alt="Undelete" text="UndoDelete" onclick="OnUndoDelete()" />                                 
                        </td>
                        <td align="right">
                            <gw:button id="idBtnImport" text="Import excel" onclick="OnImport()" styles="width:100%; " />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">WH&nbsp</td>
                        <td align="left">
                            <gw:list id="lstWH" styles="width: 100%" onchange="OnSearch('fmgf00320_1')" />
                        </td>
                        <td align="right">
                            <a title="Click here to select account code" onclick="OnPopUp('Account')" href="#tips">Account</a>&nbsp</td>
                        <td align="left">
                            <gw:textbox id="txtAccountCode"  styles="width:100%; " csstype="mandatory" />
                        </td>
                        <td align="left" colspan="3">
                            <gw:textbox id="txtAccountName" csstype="mandatory" styles="width:100%; " onkeypress="Upcase()" />
                        </td>
                        <td align="right"><a title="Click here to select PL" onclick="OnPopUp('PL')" href="#tips">PL</a>&nbsp</td>
                        <td align="left" colspan="2">
                            <gw:textbox id="txtPLCode" onkeypress="Upcase()" styles="width:100%; " />
                        </td>
                        <td colspan="3" align="left">
                            <gw:textbox id="txtPLName" onkeypress="Upcase()" styles="width:100%; " />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" >Openning Amt&nbsp</td>
                        <td align="right" >
                            <gw:textbox id="txtOpenAmt" text="0" csstype="mandatory" type="number" format="###,###.##" styles="width:100%; " />
                        </td>
                        <td align="right" ><b>Balance Amt</b>&nbsp</td>
                        <td align="left" colspan = "4" >
                            <gw:textbox id="txtBalanceAmt" csstype="mandatory" text="0"
                                type="number" format="###,###.##" styles="width:100%; " />
                        </td>                        
                        <td align="right" ><a title="Click here to select Item" onclick="OnPopUp('Item')" href="#tips">Item&nbsp</a></td>                                    
                        <td align="left" colspan="2">
                            <gw:textbox id="txtItemCode" styles="width:100%; " />
                        </td>
                        <td align="left" colspan="3" >
                            <gw:textbox id="txtItemName" styles="width:100%; " />
                        </td>
                    </tr>
                 </table>
            </td>
        </tr>                                
        <tr style="height:85%" >
            <td id="tLEFT" style="width:25%" >
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%" >
                    <tr>
                        <td style="width: 100%;">
                            <gw:grid id="grdSearch" 
                                header="Acc.Code|Acc.Name(Eng)|_tac_abacctcode_pk|Acc.Name(Local)"
                                format="0|0|0|0" 
                                aligns="0|0|0|0" 
                                defaults="|||" 
                                editcol="0|0|0|0"
                                widths="1000|2000|0|2000" 
                                styles="width:100%; height:100% " 
                                sorting="T"
                                parameter="0,1,2,3" 
                                onafteredit="" 
                                onclick="OnGridClick(this)"
                                acceptnulldate="T" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="tRIGHT" style="width: 75%;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%" >
                    <tr style="height:7%" >
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:100%" >
                                <tr>
                                    <td  style="width: 70%;"  align="left">
                                        <gw:label id="lblRecord2" styles="color: blue">record(s)</gw:label>
                                    </td>                       
                                    <td  style="width: 6%;"  align="right">
                                        <b id="pagePrev" style="color: Blue; cursor: hand" onclick="PrevPage()"><u> << </u></b></td>
                                    <td  width="6%"  align="center" style="color: gray; cursor: none">
                                        <b ><u id="page1"   style="color: Blue; cursor: hand" onclick="LoadDataPage(this,0)"> 1 </u></b></td>
                                    <td  width="6%"  align="center">
                                        <b><u style="color: Blue; cursor: hand" onclick="LoadDataPage(this,0)" id="page2">  </u></b></td>
                                    <td  width="6%"  align="center">
                                        <b><u id="page3" style="color: Blue; cursor: hand;" onclick="LoadDataPage(this,0)">  </u></b></td>
                                    <td  style="width: 6%;" align="left">
                                        <b id="pageNext"  style="color: gray; cursor: none" onclick="NextPage()"><u > >> </u></b></td>                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height:90%">
                        <td colspan="6" style="width: 100%;">
                            <gw:grid id="idGrid" 
								header="_tac_stockdd_pk|No|_tac_abacctcode_pk|Account Code|Account Name|_tco_item_pk|Item Code|Item Name|UOM|_tin_warehouse_pk|Warehouse|_tpr_line_pk|_Line|_tac_abplcenter_pk|PL Name|Begin Qty|Begin Trans Amt|Begin Book Amt|_Input Qty|_Input TrAmt|Ccy|_Input Amt|_Output Qty|_Output FAmt|_Output Amt|_This Qty|_This FAmt|_This Amt|_Qty Bal|_TrAmt Bal|_Amt Bal|_std_ym|_TCO_BUSPARTNER_PK|Cust Name|Remark|_stock_tr|_tco_company_pk"
                                format="0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|0|0|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0"
                                aligns="0|0|0|1|0|1|0|0|1|1|0|0|0|0|0|0|0|0|0|3|1|0|0|0|0|0|0|3|3|3|3|0|0|0|0|0"
                                defaults="||||||||||||||||||||VND|||||||||||||||" 
                                editcol="0|0|0|1|0|0|1|0|0|0|1|0|0|0|0|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0"
                                widths="0|700|0|1500|3000|0|1500|3000|800|0|2000|0|1500|0|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0|1500|0|0|2000|0|0"
                                styles="width:100%; height:100% " 
                                sorting="T" 
                                parameter="0,2,3,4,5,6,8,9,10,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36"
                                onafteredit="OnCellEnter(this)" 
                                oncelldblclick="OnDoubleClick(this)" 
                                onbeforeedit="OnCellBeforeEdit(this)"
                                acceptnulldate="T" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <!------------------------------------------------------------------------>
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    <!------------------------------------------------------------------------>
    <gw:textbox id="txtTco_company_pk" text="" styles='display:none;' />
    <gw:textbox id="txtTAC_ABACCTCODE_PK" text="" styles='display:none;' />
    <gw:textbox id="txttac_abplcenter_pk" text="" styles='display:none;' />
    <gw:textbox id="txttco_item_pk" text="" styles='display:none;' />
    <gw:textbox id="txtUOM" text="" styles='display:none;' />
    <gw:textbox id="txttin_warehouse_pk" text="" styles='display:none; ' />
    <gw:textbox id="txtTAC_ABACCTCODE_PK_2" text="" styles='display:none; ' />
    <gw:textbox id="txttac_abplcenter_pk_2" text="" styles='display:none; ' />
    <gw:textbox id="txtdateto_Balance" text="" styles='display:none; ' />
    <gw:textbox id="txtAccountCode_2" text="" styles='display:none; ' />    
    <!------------------------------------------------------------------------>
    <gw:textbox id="txtReturnValue" maxlen="100" styles='width:100%;display:none' />    
    <!------------------------------------------------------------------------>
    <gw:textbox id="txtPage" styles='display:none' />    
    <gw:textbox id="txtRecords" styles='display:none' />    
</body>
</html>
