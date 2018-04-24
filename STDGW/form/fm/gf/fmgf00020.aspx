<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("acnt")%>
<head id="Head1"  runat="server">
    <title>Consumption Slip Entry</title>
</head>

<script>
   
    var  user_pk = "<%=Session("EMPLOYEE_PK")%>" ;
    var  user_name = "<%=Session("USER_NAME")%>" ;
    var  user_id = "<%=Session("USER_ID")%>" ;
    var p_update = 0 ;
//-----------------------------------------------------
//grdSearch
var G1_pk               = 0,
    G1Voucher_No        = 1,
    G1Trans_DT          = 2,
    G1ACC_Voucher_No    = 3,
    G1ACC_Seq_No        = 4 ,
    G1TR_STATUS         = 5;  
    
//grdDetail    
var 
    G2_Debit_Acc_Cd                 = 1,
    G2_Debit_Acc_Nm                 = 2,
    G2_debit_account_pk             = 3,    
    G2_credit_account_pk            = 4,
    G2_Credit_Acc_Cd                = 5,
    G2_Credit_Acc_Nm                = 6,
    G2_tac_omcost_pricerd_pk        = 7,
    G2_tac_omcost_pricer_pk         = 8,        
    G2_tco_item_pk                  = 9,
    G2_Item_Code                    = 10,
    G2_Item_Name                    = 11,
    G2_UOM                          = 12,
    G2_Qty                          = 13,
    G2_U_Price                      = 14,
    G2_Trans_Amount                 = 15,
    G2_Amount_Books                 = 16,
    G2_CCY                          = 17,
    G2_Description                  = 18,
    G2_Local_Description            = 19,
    G2_tin_warehouse_pk             = 20,
    G2_WH_Name                      = 21,
    G2_tac_abplcenter_pk            = 22,
    G2_PL_Name                      = 23,
    G2_tac_stocktr_pk               = 24;
//---------------------------------------------------------

function BodyInit()
{
    System.Translate(document);
    rbTrStatus.value = ' ';
    BindingDataList() ;
    //Proposed by
    txtUserID.SetEnable(false);
    txtUserName.SetEnable(false);
    txtDept.SetEnable(false);    
    //Voucher number
    txtVoucherNo.SetEnable(true);
    chkAuto_YN.value = 'F';
    idBtnCancel.SetEnable(false);
    idBtnProcess.SetEnable(false);
    //Trans Date
    var str = dtTranTo.value ;
    str = str.substring(0, 6) + '01' ;
    
    dtTranFrom.value = str.substr(0, 6) + "01";
    //Trans Group
    txtTransCd.SetEnable(false);
    txtTransNm.SetEnable(false);
    //Account Code
    txtAc_cd.SetEnable(false);
    txtAc_nm.SetEnable(false);
    var ls_trtype_pk, ls_trtype_code, ls_trtype_nm, ls_slipremarkeng , ls_slipremarklocal ;
    ls_trtype_pk = "<%=ESysLib.SetDataSQL("select pk from acnt.tac_abtrtype where TRIM(TR_TYPE) = 'Y010' and del_if = 0 ")%>";
    ls_trtype_code = 'Y010';
    ls_trtype_nm = "<%=ESysLib.SetDataSQL("select TR_TPNM from acnt.tac_abtrtype where TRIM(TR_TYPE) = 'Y010' and del_if = 0 ")%>";
    ls_slipremarkeng = "<%=ESysLib.SetDataSQL("select SLIPREMARKENG from acnt.tac_abtrtype where TRIM(TR_TYPE) = 'Y010' and del_if = 0 ")%>";
    ls_slipremarklocal = "<%=ESysLib.SetDataSQL("select SLIPREMARKLOCAL from acnt.tac_abtrtype where TRIM(TR_TYPE) = 'Y010' and del_if = 0 ")%>";
    txtTransCd.text     = ls_trtype_code;
    txtTransNm.text     = ls_trtype_nm;
    txtTrTypePk.text    = ls_trtype_pk; 
    txtDesc.text        = ls_slipremarkeng ;
    txtLocalDesc.text   = ls_slipremarklocal ;
    txtdescr.text       = ls_slipremarkeng ;
    txtlocaldescr.text  = ls_slipremarklocal ;
    txttrs_type_pk.text = ls_trtype_pk ;
    txttrs_type_cd.text = ls_trtype_code ;
    txttrs_type_nm.text = ls_trtype_nm ;
    fmgf00020_5.Call();
    
 }
//-----------------------------------------------------
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

//-----------------------------------------------------
 function BindingDataList()
 {
    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT to_char(PK), PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0")%>";
    lstCompany.SetDataText(ls_data);
    ls_data = "<%=ESysLib.SetListDataSQL("select A.CODE, A.CODE_NM FROM TAC_COMMCODE_DETAIL A, TAC_COMMCODE_MASTER B WHERE A.DEL_IF = 0 AND B.DEL_IF = 0 AND A.TAC_COMMCODE_MASTER_PK = B.PK AND B.ID = 'ACBG0130' and ( code = 'XNL' or code = 'XDC' ) order by ORD " )%>|ALL|Select All"; 
    lstTranType.SetDataText(ls_data);
    lstTranType.value = "XNL" ;
    

    ls_data = "<%=ESysLib.SetGridColumnDataSQL("SELECT a.CODE, a.CODE FROM COMM.TCO_ABCODE a, COMM.TCO_ABCODEGRP b WHERE  b.ID='ACAB0110' AND a.TCO_ABCODEGRP_PK=b.PK and a.use_if = 1 and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM" ) %> ";       
    grdDetail.SetComboFormat(G2_CCY, ls_data);
    
}
 //-----------------------------------------------------
 
function OnSearch(pos)
{
    switch(pos)
    {
        case '1':   
            fmgf00020.Call();
        break;
        case '2':
			txttac_omcost_pricer_PK.text = grdSearch.GetGridData(grdSearch.row, G1_pk);
            if ( grdMaster.GetStatus() == 20 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('1');
                }
                else
                {
                    //txttac_omcost_pricer_PK.text = grdSearch.GetGridData(grdSearch.row, G1_pk);
                    grdMaster.Call("SELECT");                    
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    //txttac_omcost_pricer_PK.text = grdSearch.GetGridData(grdSearch.row, G1_pk);
                }
                grdMaster.Call("SELECT");
                txtVoucherNo.enabled = true ;
            }                                   
        break;
    }
}
//-----------------------------------------------------------------
function OnAddNew(iObj)
{
    switch(iObj)
    {
        case 'master':
            if(grdMaster.GetStatus() != 20)
            {
                grdMaster.StatusInsert();
                ResetMaster();
                txtVoucherNo.text = "**New Slip No**" ;                
                txtVoucherNo.enabled = true;
                //nhan vien nhap lieu, bo phan
                fmgf00020_5.Call();
                //clear data details
                grdDetail.ClearData();                 
                //description
                txtDesc.text                = txtdescr.text ;
                txtLocalDesc.text           = txtlocaldescr.text ;
                //transaction type
                txtTransCd.text             = txttrs_type_cd.text ;
                txtTransNm.text             = txttrs_type_nm.text ;
                txtTrTypePk.text            = txttrs_type_pk.text ;
                //trans type
                lstTranType.value = 'XNL';
            }
            else
            {
                alert("Already add new. Pls input data !!!");
            }            
            InActiveButton() ;
            idBtnSave.SetEnable(true) ;
        break;
        case 'detail':
            var arr, i, lrow ;
            var url = System.RootURL + '/form/fm/gf/fmgf00021.aspx' ;
            var obj = System.OpenModal( url ,1000 , 600 ,  'resizable:yes;status:yes'); 
            if(obj != null)
            {
                for( i = 0; i < obj.length ; i++)
                {
                    grdDetail.AddRow();
                    lrow = grdDetail.rows - 1;
                    arr = obj[i];
                    grdDetail.SetGridText(lrow, G2_tac_stocktr_pk, arr[0] );
                    grdDetail.SetGridText(lrow, G2_tac_abplcenter_pk, arr[4] );
                    grdDetail.SetGridText(lrow, G2_tin_warehouse_pk, arr[6] );
                    grdDetail.SetGridText(lrow, G2_tco_item_pk, arr[12] );
                    grdDetail.SetGridText(lrow, G2_Item_Code, arr[13] );
                    grdDetail.SetGridText(lrow, G2_Item_Name, arr[14] );
                    grdDetail.SetGridText(lrow, G2_UOM, arr[15] );
                    grdDetail.SetGridText(lrow, G2_WH_Name, arr[7] );
                    grdDetail.SetGridText(lrow, G2_PL_Name, arr[5] );
                    grdDetail.SetGridText(lrow, G2_credit_account_pk, arr[9] );
                    grdDetail.SetGridText(lrow, G2_Credit_Acc_Cd, arr[10] );
                    grdDetail.SetGridText(lrow, G2_Credit_Acc_Nm, arr[11] );
                    grdDetail.SetGridText(lrow, G2_Qty, arr[17] );
                    grdDetail.SetGridText(lrow, G2_U_Price, arr[18] );
                    grdDetail.SetGridText(lrow, G2_Trans_Amount, arr[21] );
                    grdDetail.SetGridText(lrow, G2_Amount_Books, arr[21] );                    
                }
            }
            idBtnSave.SetEnable(true) ;
        break;
    }
}
//-----------------------------------------------------------------
function ResetMaster()
{
    //master info
    txttac_omcost_pricer_PK.text = '';
    txttac_hgtrh_pk.text = "";
    txtVoucherNo.text = "";
    
    txtemp_pk.text = "" ;
    txtUserID.text = "" ;
    txtUserName.text = "" ;
    txtDept.text = '';
    txtDeptPK.text = "";    

    txtTrTypePk.text = "";
    txtTransCd.text = "";
    txtTransNm.text = "";
    
    txttac_abacctcode_pk.text = '';
    txtAc_cd.text = '';
    txtAc_nm.text = '';

    txtDesc.text = '';
    txtLocalDesc.text = '';
    lstTranType.value = "ALL" ;
}
//-----------------------------------------------------------------
function OnSave(iObj)
{
    if(p_update == 2)
    {
        iObj = '2';
    }
    if(CheckSave('master'))
    {
        switch(iObj)
        {
            case '1':
                grdMaster.Call();
                p_update = 1;         
                rbTrStatus.value = 1 ;                                   
            break;
            case '2':
                fmgf00020_2.Call();                
                //rbTrStatus.value = 1 ;                
            break;
        }
    }
}
//-----------------------------------------------------------------
function CheckSave(iObj)
{
    switch(iObj)
    {
        case 'master':
            var l_Auto_YN = chkAuto_YN.value ;
            if(Trim(l_Auto_YN) == 'F')
            {
                if(Trim(txtVoucherNo.text) == "**New Slip No**" || Trim(txtVoucherNo.text) == "" )
                {
                    alert("Please enter the Voucher No!!!");
                    txtVoucherNo.GetControl().focus();
                    return false;
                }
            }
            if( Trim(txttac_abacctcode_pk.text) == '' )
            {
                alert('Must select debit account code!!!');
                return false;
            }
            if( Trim(lstTranType.value) == 'ALL' )
            {
                alert('Must select the transaction type!!!');
                return false;
            }
                        
            return true;
        break;
        
    }
}
//-----------------------------------------------------------------
function SetParentPKGrid()
{
    var i ;
    for( i = 1; i < grdDetail.rows; i++)
    {
        grdDetail.SetGridText(i, G2_pk, txttac_omcost_pricer_PK.text );
    }
}
//-----------------------------------------------------------------
 function OnDataReceive(po_oData)
 {
      switch (po_oData.id)         
      {
        case "grdMaster" :
            if ( p_update == 1 )
            {
                p_update = 0 ;
                SetParentPKtoGrid();                
                OnSave('2');
            }
            else
            {
                fmgf00020_2.Call('SELECT');
            } 
            InActiveButton();
        break;        
        case "fmgf00020_2" :
            var ctrl = grdDetail.GetGridControl();  
            ctrl.ColFormat(G2_Qty)          = "###,###,###,###,###.##";
            ctrl.ColFormat(G2_U_Price)      = "###,###,###,###,###.##";
            ctrl.ColFormat(G2_Trans_Amount) = "###,###,###,###,###.##";
            ctrl.ColFormat(G2_Amount_Books) = "###,###,###,###,###.##";
            CalcuSubTotal();            
            InActiveButton();                            
        break;
        case 'fmgf00020_3':
            alert(txtRtnProcess.text);
            rbTrStatus.value = '2';
            InActiveButton();
            idBtnProcess.SetEnable(false);
            fmgf00020.Call('SELECT');
        break ;
        case 'fmgf00020_4':
            alert(txtRtnProcess.text);
            rbTrStatus.value = ' ';        
            InActiveButton();
            idBtnCancel.SetEnable(false);
            fmgf00020.Call('SELECT');
        break ;
      }  
 }
//--------------------------------------------------------
function SetParentPKtoGrid()
{
    var i;
    for (i = 1; i < grdDetail.rows ; i++)
    {
        grdDetail.SetGridText(i, G2_tac_omcost_pricer_pk, txttac_omcost_pricer_PK.text);
    }
}
//--------------------------------------------------------
function OnPopUp(iObj)
{
    var lrow, lcol ;
    switch(iObj)
    {
        case 'Proposed By':
            var path = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx";
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            lrow = grdDetail.row ;
            lcol = grdDetail.col;
            if(object!=null)
            {
                txtemp_pk.text = object[0];                
                txtUserID.text = object[1];
                txtUserName.text = object[2];
                txtDept.text = object[4];
                txtDeptPK.text = "";                
            }        
        break;
        case 'Debit Account':
            var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + txtTransCd.text + "&val1=" + txtTransNm.text + "&val2=D" + "&val3=" + lstCompany.value + "&dsqlid=ACNT.SP_SEL_ACCOUNT_NEW_DRCR" ;
            var object      =   System.OpenModal(  fpath , 550 , 550 , 'resizable:yes;status:yes');	        
            lrow = grdDetail.row ;
            lcol = grdDetail.col ;            
            if(object!=null)
            {               
                var tmp = object[0];
                if( tmp != null && Trim(tmp[1]) != '' )
                {
                    txtAc_cd.text = tmp[4];
                    txtAc_nm.text = tmp[5];
                    txttac_abacctcode_pk.text = tmp[1] ;                    
                }
            }                        
        break;
        case 'Trans Group':
            var path = System.RootURL + '/form/gf/hg/gfhg00010_transaction.aspx?compk='+ lstCompany.value;
            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            if( object != null )
            {
		        var tmp = object[0];
		        if (tmp[1] != null)
		        {
		            txtTransCd.text = tmp[1];
		            txtTransNm.text = tmp[2];
		            txtTrTypePk.text = tmp[0];
		            txtDesc.text = tmp[3];
		            txtLocalDesc.text = tmp[4];
                }                
            }            
        break;
    }
}
//--------------------------------------------------------
function OnDelete(iObj)
 {
    var i ;
    switch(iObj)
    {
        case 'detail':
	        var ctrl = grdDetail.GetGridControl();
	        var n    = ctrl.rows;
	        var row  = ctrl.row;
        	
	        if ( n > 1 ) {
        	
		        if ( row < 0 ) 
		        {		
		            alert('Must select a row to remove!');
		        }		
		        else 
		        {        		
			        if ( grdDetail.GetGridData( row, G2_tac_omcost_pricerd_pk ) == "" ) 
			        {
			            alert('Must select a row is not a total row!');
			        }
			        else 
			        {        				
				        if ( confirm ( "Do you want to delete?" ) ) 
				        {		
				            var ctrl = grdDetail.GetGridControl();
				            for( i = 1; i < grdDetail.rows; i++)
				            {
				                if(ctrl.IsSelected(i) == true)
					                grdDetail.DeleteRow();				        					                
                            }					            
                            p_update = 2;
				        }
				        InActiveButton();
			        }
		        }
	        }        
        break;
        case 'master':
            if(grdDetail.rows > 1)
                alert('Must delete all details firstly!!!');
            else
            {
                if ( confirm ( "Do you want to delete this Slip Entry?" ) )
                      {
                        grdMaster.StatusDelete();                        
                        if ( txttac_omcost_pricer_PK.text != "" )                    
                        {
                            grdMaster.Call()                        
                        }
                        else                    
                            alert("Please, Select a Slip entry !")
                     }        
            }                              
        break;
    }
 }
//--------------------------------------------------------
function InActiveButton() 
{
    
	var ctrl = grdDetail.GetGridControl();
	var n    = ctrl.rows;
	var row  = ctrl.row;	
	if ( n > 1 ) //detail has rows
	{
	    //delete master
	    idBtnDelete.SetEnable(false);	
	    //processed or saved
		if ( row < 0 ) //not selected detail
		{
			idBtnDelete_2.SetEnable(true);
			idBtnUnDel.SetEnable(false);
		}
		else //selected detail
		{			
			if ( grdDetail.GetRowStatus( ctrl.row ) >= 64 ) 
			{
				idBtnDelete_2.SetEnable(false);
				idBtnUnDel.SetEnable(true);
			}
			else 
			{
				idBtnDelete_2.SetEnable(true);
				idBtnUnDel.SetEnable(false);
			}
		}	
	}
	else //detail empty
	{
	    idBtnDelete.SetEnable(true);
        idBtnProcess.SetEnable(false) ;
        idBtnCancel.SetEnable(false) ;
        idBtnDelete_2.SetEnable(false);        	    
	}	
	//first priority processing
    if( Trim(lblStatus.text) == 'Saved' )       
    {
        if( n > 1)
            idBtnProcess.SetEnable(true) ;
        else
            idBtnProcess.SetEnable(false) ;
        idBtnCancel.SetEnable(false) ;
        idBtnSave.SetEnable(true);
//        idBtnNew_2.SetEnable(true);            
        //idBtnDelete.SetEnable(false);
    }
    else if(Trim(lblStatus.text) == 'Processed' )
    {
        idBtnProcess.SetEnable(false) ;
        idBtnCancel.SetEnable(true) ;
        idBtnSave.SetEnable(false);
//        idBtnNew_2.SetEnable(false);
        idBtnDelete.SetEnable(false);
        idBtnDelete_2.SetEnable(false);
    }
    else
    {
        idBtnProcess.SetEnable(false) ;
        idBtnCancel.SetEnable(false) ;
        idBtnSave.SetEnable(false);
//        idBtnNew_2.SetEnable(false);
        idBtnDelete.SetEnable(false);
        idBtnDelete_2.SetEnable(false);    
    }		    	
	idBtnProcess.SetEnable(true);    
		idBtnCancel.SetEnable(true);    
}
//--------------------------------------------
 function OnUnDelete(iObj) {

	var ctrl = grdDetail.GetGridControl();
	var n    = ctrl.rows;
	var row  = ctrl.row;
	switch(iObj)
	{
	    case'detail':
	        if ( n > 1 ) {
        	
		        if ( row < 0 ) {		
		        }		
		        else {
        		
			        if ( grdDetail.GetGridData( ctrl.row, G2_tac_omcost_pricerd_pk) == "" ) {
			            alert('Must select a row is not a total row');
			        }
			        else {
        				
				        if ( confirm ( "Do you want to undelete?" ) ) {				
					        grdDetail.UnDeleteRow()
				        }
				        InActiveButton();
			        }
		        }
	        }
	    break;
	}
}
//--------------------------------------------
function OnGridCellDblClick(iObj)
{
    switch(iObj.id)
    {
        case 'grdDetail':
            var lcol = event.col;
            var lrow = event.row ;
        if(grdSearch.row < 1)
            return ;
        
        if(Trim(lblStatus.text) == 'Saved')    
        {
            if( (lcol == G2_Credit_Acc_Cd ) && ( Trim(grdDetail.GetGridData(lrow, G2_tco_item_pk )) != '') ) //G2_Debit_Acc_Nm
            {
                var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + txtTransCd.text + "&val1=" + txtTransNm.text + "&val2=C" + "&val3=" + lstCompany.value + "&dsqlid=ACNT.SP_SEL_ACCOUNT_NEW_DRCR" ;
                var object      =   System.OpenModal(  fpath , 550 , 550 , 'resizable:yes;status:yes');	                        
                if(object != null )
                {
                    tmp1 = object[0];
                    if(tmp1 != null)
                    {
			            grdDetail.SetGridText( lrow,    G2_credit_account_pk,   tmp1[2] ); //ACPK
			            grdDebit.SetGridText( lrow,     G2_Credit_Acc_Cd,       tmp1[5] ); //Account Code
			            grdDebit.SetGridText( lrow,     G2_Credit_Acc_Nm,        tmp1[6] ); //Account Name
			        }
                }            
            }                
            else if( (lcol == G2_Debit_Acc_Cd ) && ( Trim(grdDetail.GetGridData(lrow, G2_tco_item_pk )) != '') ) //G2_Debit_Acc_Nm
            {
                var fpath   = System.RootURL + "/form/gf/co/ffco002004.aspx?comm_nm="+ '' + "&comm_code=" + '' + "&comm_nm2=" + txtTransCd.text + "&val1=" + txtTransNm.text + "&val2=D" + "&val3=" + lstCompany.value + "&dsqlid=ACNT.SP_SEL_ACCOUNT_NEW_DRCR" ;
                var object      =   System.OpenModal(  fpath , 550 , 550 , 'resizable:yes;status:yes');	                        
                if(object != null )
                {
                    tmp1 = object[0];
                    if(tmp1 != null)
                    {
			            grdDetail.SetGridText( lrow, G2_debit_account_pk, tmp1[2] ); //ACPK
			            grdDebit.SetGridText( lrow, G2_Debit_Acc_Cd, tmp1[5] ); //Account Code
			            grdDebit.SetGridText( lrow, G2_Debit_Acc_Nm, tmp1[6] ); //Account Name
			        }
                }            
            }                
            else if ( (lcol == G2_PL_Name) && ( Trim(grdDetail.GetGridData(lrow, G2_tco_item_pk )) != '') )
            {
                var path = System.RootURL + "/form/gf/co/gfco002005.aspx?dsqlid=ACNT.SP_SEL_fmgf00050_2&company=" + lstCompany.value+"&col_code=PL Code&col_nm=PL Name&comm_code=" + "&comm_nm=" ;
                var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');        
                if(object != null)
                {
                    grdDetail.SetGridText(lrow, G2_tac_abplcenter_pk, object[2] );                    
                    grdDetail.SetGridText(lrow, G2_PL_Name, object[1] ); 
                }                    
            }
            else if( (lcol == G2_WH_Name) && ( Trim(grdDetail.GetGridData(lrow, G2_tco_item_pk )) != '') )
            {
                var fpath   = System.RootURL + "/form/fp/ab/PopUpGetWareHouse.aspx" ;
                aValue      = System.OpenModal(  fpath , 800 , 400 , 'resizable:yes;status:yes');	
                if ( aValue != null ) 
                {
                    grdDetail.SetGridText(lrow, G2_tin_warehouse_pk, aValue[0]);
                    grdDetail.SetGridText(lrow, G2_WH_Name, aValue[2]);
                }                
            }
        }            
        break;    
    case 'grdSearch':        
            var lcol = event.col;
            var lrow = event.row ;
            if( lcol == G1ACC_Seq_No && Trim(grdSearch.GetGridData(lrow, lcol)) != '' )
            {
                var pk = grdSearch.GetGridData(lrow, G1ACC_Seq_No);
                var status = grdSearch.GetGridData(lrow, G1TR_STATUS);

                var fpath = System.RootURL + '/form/gf/br/gfbr00030_popup.aspx?PK_ROW=' + pk + '&APPRCANCEL=' + status;
                var wWidth = 950;
                var wHeight = 565;
                var x = Math.round((screen.availWidth - wWidth)/2);
                var y = Math.round((screen.availHeight - wHeight)/2);

                var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
                "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
                "lef="+ x +",top=" + y;

                var object = System.OpenModal(fpath, wWidth, wHeight, features); 
                               
            }        
        break;
    }
}
//---------------------------------------------------------------------------
function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}
//---------------------------------------------------------------------------
function CalcuSubTotal()
{                
        var ctr=grdDetail.GetGridControl(); 
        ctr.OutlineBar =2 ;        
        var color;
        var caption;
        var operator;        
        for (var igroup=0;igroup<=1;igroup++)
        {
            switch (igroup)
            {
                case 0:
                {
                    color=0xCCFFFF ;
                    caption='Grand Total';
                    break;
                }
                case G2_Debit_Acc_Cd:
                {
                    color = 0xCCFFFF ;
                    caption='Acc:%s';
                    break;
                }                
            }
            
            for(var itotal = G2_Qty; itotal <= G2_Amount_Books; itotal++)
            {
                if( itotal != G2_U_Price )
                {
                    ctr.ColFormat(itotal) = "(#,###.##)";
                    ctr.SubTotal(2,igroup, itotal,'',color,0x000000,'1',caption,'',true);
                }
            }
        auto_resize_column(grdDetail,0,grdDetail.cols-1,10); 
    }            
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//--------------------------------------------------
function OnProcess()
{
    if(Trim(txtTrTypePk.text) == '')
    {
        alert('Please choose Transaction Group');
        return;
    }
        var fpath = System.RootURL + '/form/fm/gf/fmgf00131_makeslip.aspx';
        var wWidth = 500;
        var wHeight = 260;
        var x = Math.round((screen.availWidth - wWidth)/2);
        var y = Math.round((screen.availHeight - wHeight)/2);

        var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
        "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
        "lef="+ x +",top=" + y;

        var object = System.OpenModal(fpath, wWidth, wHeight, features);                        
        if(object != null )
        {
            var arr = new Array();
            arr = object;
            if(arr[0] != '0')
            {
                txttrans_dt.SetDataText(object[0]);
               txttrans_dt_TO.SetDataText(object[1]);
		       //alert(txttrans_dt);
		       //alert(txttrans_dt_TO);
               fmgf00020_3.Call();
            }               
        }
	
    //fmgf00020_3.Call();
}
//--------------------------------------------------
function OnCancel()
{
    var lrow = grdSearch.row;
    //alert('test');
    /*
	if(lrow > 0)
    {
        txttac_hgtrh_pk.text = grdSearch.GetGridData(lrow, G1ACC_Seq_No);
        txttac_omcost_pricer_PK.text = grdSearch.GetGridData(lrow, G1_pk);
        fmgf00020_4.Call();
    }
    else
    {
        alert('Must select voucher to cancel!!!');
    }
	*/
        var fpath = System.RootURL + '/form/fm/gf/fmgf00131_makeslip.aspx';
        var wWidth = 500;
        var wHeight = 260;
        var x = Math.round((screen.availWidth - wWidth)/2);
        var y = Math.round((screen.availHeight - wHeight)/2);

        var features = "toolbar=no,location=no,directories=no,status=no,menubar=no," + 
        "scrollbars=no,resizable=no,copyhistory=no,width="+wWidth+",height="+wHeight +
        "lef="+ x +",top=" + y;

        var object = System.OpenModal(fpath, wWidth, wHeight, features);                        
        if(object != null )
        {
            var arr = new Array();
            arr = object ;
            if(arr[0] != '0')
            {
                txttrans_dt.SetDataText(object[0]);
               txttrans_dt_TO.SetDataText(object[1]);
		       //alert(txttrans_dt);
		       //alert(txttrans_dt_TO);
               fmgf00020_4.Call();
            }               
        }
	
}
//--------------------------------------------------
function OnExcel(iReport)
{
    switch(iReport)
    {
        case '1':
            if(grdSearch.rows > 1 && grdSearch.row > 0)
            {
                var url =System.RootURL + '/reports/gf/hg/60080010_envn.aspx?seq=' + grdSearch.GetGridData(grdSearch.row, 4);
                System.OpenTargetPage(url); 
            }                
        break ;
    }
}
//--------------------------------------------------
function OnAutoChange()
{
    var l_Auto_YN = chkAuto_YN.value ;
    if(Trim(l_Auto_YN) == 'T')
    {
        txtVoucherNo.SetEnable(false); //auto-generate voucher no
    }
    else
    {
        txtVoucherNo.SetEnable(true); //user enter voucher no
        txtVoucherNo.GetControl().focus();
    }
}
//--------------------------------------------------
</script>
<body>
<!------------------------------------------------------------------------>
<gw:data id="fmgf00020" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="grid" function="acnt.sp_sel_fmgf00020" > 
            <input bind="grdSearch" > 
                 <input bind="txtVoucherNo_2" />
                 <input bind="dtTranFrom" /> 
                 <input bind="dtTranTo" /> 
                 <input bind="rbTrStatus" />                                  
             </input> 
            <output bind="grdSearch" /> 
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<gw:data id="grdMaster" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="acnt.sp_sel_fmgf00020_1" procedure="acnt.sp_upd_fmgf00020_1" > 
            <inout>
                <inout bind="txttac_omcost_pricer_PK" />
                <inout bind="lstCompany" />
                <inout bind="txtVoucherNo" />
                <inout bind="dtTransDT" />
                <inout bind="txtDept" />
                <inout bind="txtemp_pk" />
                <inout bind="txtUserID" />
                <inout bind="txtUserName" />
                <inout bind="lstTranType" />
                <inout bind="txttac_abacctcode_pk" />
                <inout bind="txtAc_cd" />
                <inout bind="txtAc_nm" />
                <inout bind="txtDesc" />
                <inout bind="txtLocalDesc" />
                <inout bind="txtDeptPK" />
                <inout bind="lblStatus" />                
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<gw:data id="fmgf00020_2" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24" function="acnt.sp_sel_fmgf00020_2" procedure="acnt.sp_upd_fmgf00020_2" > 
            <input bind="grdDetail" > 
                 <input bind="txttac_omcost_pricer_PK" />
             </input> 
            <output bind="grdDetail" /> 
        </dso> 
    </xml> 
</gw:data>
<!-- Make Slip -->
<!------------------------------------------------------------------------>
    <gw:data id="fmgf00020_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="acnt.sp_pro_fmgf00020_3" > 
                <input>                    
                    <input bind="lstCompany" />                     
                    <input bind="txttrans_dt" />
					<input bind="txttrans_dt_TO" />
                    <input bind="txtemp_pk" /> 
                    <input bind="txtDeptPK" />
                    <input bind="txtDesc" />
                    <input bind="txtLocalDesc" />
                    <input bind="txtTrTypePk" />                    
                    <input bind="txtVoucherType" />                    
                    <input bind="chkAuto_YN" />
                    <input bind="chkEndMonth" />
                </input> 
                <output>
                    <output bind="txtRtnProcess" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-- Cancel Make Slip -->
<!------------------------------------------------------------------------>
    <gw:data id="fmgf00020_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="acnt.sp_pro_fmgf00020_4" > 
                <input>
                    <input bind="lstCompany" />                     
                    <input bind="txttrans_dt" />
					<input bind="txttrans_dt_TO" />
                </input> 
                <output>
                    <output bind="txtRtnProcess" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>
   <gw:data id="fmgf00020_5" > 
        <xml> 
            <dso  type="process" procedure="acnt.sp_pro_fmgf00020_5" > 
                <input>
                    <input bind="txtemp_pk" />
                </input>
                <output>
                    <output bind="txtUserID" />
                    <output bind="txtUserName" />
                    <output bind="txtDept" />
                    <output bind="txtemp_pk" />
                    <output bind="txtDeptPK" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>

    <table border="1" style="width:100%; height:100%;" cellpadding="0" cellspacing="0">
        <tr style="width: 100%; height:100%;"  >
            <td id="tLEFT" style="width:22%;" >
                <table style="width:100%; " border="0" cellpadding="0" cellspacing="0">
                    <tr style="height:4%;">
                        <td align="right" style="width:50%;"><b style="width:100%">Trans Date</b></td>
                        <td align="left" style="width: 20%"><gw:datebox id="dtTranFrom" lang="1" /></td>
                        <td colspan="2" align="left" style="width: 30%">~<gw:datebox id="dtTranTo" lang="1" /></td>                        
                    </tr>  
                    <tr style="height:4%;">
                        <td style="width:50%;" align="right">Voucher No</td>
                        <td colspan="2" style="width:40%;" align="left"><gw:textbox id="txtVoucherNo_2" csstype="mandatory" styles="width: 100%" onkeypress="Upcase()" /></td>
                        <td style="width:10%;" align="right"><gw:imgbtn id="idBtnSearch" img="search" alt="Search" text="Search" styles="width: 100%" onclick="OnSearch('1')" /></td>
                    </tr>        
                    <tr style="height:4%;">
                        <td align="right" style="width: 50%; "><font color="red">Status</font></td>
                        <td colspan="3" align="left">
                            <font color="black" >
                            <gw:radio id="rbTrStatus" value="1" styles="width: 100%; " onchange="OnSearch('1')">                             
                            <span value=" ">All</span>
                            <span value="1">Saved</span>
                            <span value="2">Processed</span>
                            </gw:radio>
                            </font>
                        </td>
                    </tr>
                    <tr style="height:88%;">
                        <td colspan="4" style="width:100%;">
                            <gw:grid id='grdSearch'
                                header='_pk|Voucher No|Trans DT|ACC Voucher No|ACC Seq No|_TR_STATUS'
                                format='0|0|4|0|0|0'
                                aligns='0|0|0|0|0|0'
                                defaults='|||||' editcol='0|1|1|1|1|0'                   		
                                widths='0|2000|1000|1500|800|0'
	                            acceptNullDate='T'
                                sorting='T' styles='width:100%; height:100%'
                                oncellclick="OnSearch('2')"  
                                oncelldblclick="OnGridCellDblClick(this)"                              
                                 />                                    
                        </td>
                    </tr>                                        
                </table>
            </td>        
            <td id="tRIGHT" style="width: 78%;" >
                <table style="width:100%; height:100%;" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 10%; "></td>
                        <td style="width: 8%; "></td>
                        <td style="width: 22%; "></td>
                        <td style="width: 12%; "></td>
                        <td style="width: 2%; "></td>
                        <td style="width: 14%; "></td>
                        <td style="width: 10%; "></td>
                        <td style="width: 10%; "></td>
                        <td style="width: 3%; "></td>
                        <td style="width: 3%; "></td>
                        <td style="width: 3%; "></td>
                        <td style="width: 3%; "></td>
                    </tr>
                    <tr style="height:4%;">
                        <td align="right" >Company</td>
                        <td colspan="2" align="left" ><gw:list id="lstCompany" styles="width: 100%" /></td>
                        <td align="right" styles="width:100%" >Voucher No</td>
                        <td align="right" ><gw:checkbox id="chkAuto_YN" onchange="OnAutoChange()" /></td>
                        <td align="left" ><gw:textbox id="txtVoucherNo" styles="width: 100%" csstype="mandatory" onkeypress="Upcase()" /></td>
                        <td align="right" styles="width:100%" >Trans Date</td>
                        <td align="left" ><gw:datebox id="dtTransDT" styles="width: 100%" lang="1" /></td>                        
                        <td align="right" ><gw:imgbtn id="idBtnNew" img="new" alt="New" text="New" onclick="OnAddNew('master')" /></td>
                        <td align="right" ><gw:imgbtn id="idBtnSave" img="save" alt="Save" text="Save" onclick="OnSave('1')" /></td>
                        <td align="right" ><gw:imgbtn id="idBtnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('master')" /></td>
                        <td align="center" ><gw:imgbtn id="idBtnExcel" img="excel" alt="Excel" text="Excel" styles="width: 100%" onclick="OnExcel('1')" /></td>                                                                                        
                    </tr>
                    <tr style="height:4%;">
                        <td align="right" styles="width:100%" ><a title="Click here to select Employee" onclick="OnPopUp('Proposed By')" href="#tips">Proposed By</a></td>
                        <td align="left" ><gw:textbox id="txtUserID" styles="width:100%" /></td>
                        <td align="left" ><gw:textbox id="txtUserName" styles="width:100%" /></td>
                        <td align="right" styles="width:100%" >Department</td>
                        <td align="left" colspan="2" ><gw:textbox id="txtDept" styles="width:100%" /></td>
                        <td align="right" styles="width:100%" >Trans Type</td>
                        <td colspan = "5" align="left" ><gw:list id="lstTranType" styles="width: 100%" /></td>                        
                    </tr>   
                    <tr style="height:4%;">
                        <td align="right" ><a title="Click here to select Trans Group" onclick="OnPopUp('Trans Group')" href="#tips">Trans Type</a></td>
                        <td align="left" ><gw:textbox id="txtTransCd" styles="width: 100%; " csstype="mandatory" /></td>
                        <td align="left" ><gw:textbox id="txtTransNm" styles="width: 100%" csstype="mandatory" /></td>                        
                        <td align="right" ><a title="Click here to select Debit Account" onclick="OnPopUp('Debit Account')" href="#tips">Debit Account</a></td>                        
                        <td align="left" colspan="2" ><gw:textbox id="txtAc_cd" styles="width: 100%" csstype="mandatory" /></td>
                        <td align="left" colspan="6" ><gw:textbox id="txtAc_nm" styles="width: 100%" csstype="mandatory" /></td>                                                                                                
                    </tr>                    
                    <tr style="height:4%;">
                        <td align="right" >Description</td>
                        <td align="left" colspan="2" ><gw:textbox id="txtDesc" styles="width: 100%" /></td>
                        <td align="right" >Local Desc</td>
                        <td colspan="8" align="left" ><gw:textbox id="txtLocalDesc" styles="width: 100%" /></td>                                                                          
                    </tr>
                    <tr style="height:4%;">
                        <td colspan="1" align="right" >Status:</td>
                        <td colspan="2" ><font color="black" ><b><gw:label id="lblStatus" text="" styles="width: 100%; " /></b></font></td>
                        <td colspan="1" align="right" >End of Month&nbsp;</td>
                        <td colspan="2" ><gw:checkbox id="chkEndMonth" value="F" /></td>
                        <td></td>
                        <td align="right" ><gw:button id="idBtnCancel" alt="Cancel" text="Cancel" onclick="OnCancel()" /></td>
                        <td align="right" colspan="2" ><gw:button id="idBtnProcess" alt="Process" text="Make Slip" onclick="OnProcess()" /></td>                        
                        <td align="right" ><gw:imgbtn id="idBtnDelete_2" img="delete" alt="Delete Detail" text="Delete" onclick="OnDelete('detail')" /></td>
                        <td align="right" ><gw:imgbtn id="idBtnUnDel" img="udelete" alt="Undo Delete" text="Undo Delete" styles="width:3%;" onclick="OnUnDelete('detail')" /></td>
                    </tr>                    
                    
                    <tr style="height:80%;">
                        <td colspan="12" align="left" style="width:100%;" >
                            <gw:grid id='grdDetail' 
                                header='|Debit Acc.Cd|Debit Acc.Nm|_debit_account_pk|_credit_account_pk|Credit Acc.Cd|Credit Acc.Nm|_tac_omcost_pricerd_pk|_tac_omcost_pricer_pk|_tco_item_pk|Item Code|Item Name|UOM|Qty|U Price|Trans Amount|Amount Books|CCY|Description|Local Description|_tin_warehouse_pk|WH Name|_tac_abplcenter_pk|PL Name|_tac_stocktr_pk'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                aligns='0|1|0|0|1|1|0|0|0|0|0|0|1|3|3|1|3|3|0|0|0|0|0|0|0'
                                defaults='||||||||||||||||||||||||' editcol='0|1|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1'                   		
                                widths='1100|3000|0|0|1100|3000|0|0|0|1500|3000|800|2000|2000|0|800|1500|2500|2000|2000|0|2000|0|2000|0'
                                parameter='0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24'
	                            acceptNullDate='T'
                                sorting='T' styles='width:100%; height:100%;' 
                                oncelldblclick = "OnGridCellDblClick(this)"
                                onafteredit=""
                                />                                                                   
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
<gw:textbox id="txttac_omcost_pricer_PK" styles="display:none; " />        
<gw:textbox id="txtemp_pk" styles="display:none; " />
<gw:textbox id="txttac_abacctcode_pk" styles="display:none; " />
<gw:textbox id="txtDeptPK" styles="display:none; " />
<gw:textbox id="txtRtnProcess" styles="display:none; " />
<gw:textbox id="txtTrTypePk" styles="display:none; " />
<gw:textbox id="txttac_hgtrh_pk" styles="display:none; " />
<gw:textbox id="txtVoucherType" text="XNL" styles="display:none; " />
<gw:textbox id="txttrs_type_pk" styles="display:none; " />
<gw:textbox id="txttrs_type_cd" styles="display:none; " />
<gw:textbox id="txttrs_type_nm" styles="display:none; " />
<gw:textbox id="txtdescr" styles="display:none; " />
<gw:textbox id="txtlocaldescr" styles="display:none; " />
<gw:textbox id="txttrans_dt" styles="display:none; " />
<gw:textbox id="txttrans_dt_TO" styles="display:none; " />
</body>
</html>
