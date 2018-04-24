<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Incoming Entry</title>
</head>
<%  
    ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>
<script>

//-----------------------------------------------------

var flag;

var GS_MASTER_PK    = 0,
    GS_SLIP_NO      = 1,
    GS_DATE         = 2,
    GS_INVOICE      = 3,
    GS_STATUS       = 4;

//=================================================================================
var G1_DETAIL_PK        = 0,
    G1_MASTER_PK        = 1,
    G1_SEQ              = 2,
    G1_TLG_IT_ITEM_PK   = 3,
    G1_ITEM_CODE        = 4,
    G1_ITEM_NAME        = 5,
    G1_LOT_NO           = 6,
    G1_NET_KG           = 7,
    G1_BALES            = 8,
    G1_NET_LBS          = 9,
    G1_UNIT_PRICE       = 10,
    G1_AMOUNT           = 11,
    G1_AVERAGE          = 12,
    G1_DESCRIPTION      = 13;
    
var arr_FormatNumber = new Array();    
 //===============================================================================================
function OnToggle()
{ 
    var left  = document.all("t-left");    
    var right = document.all("t-right");
    var imgArrow  = document.all("imgArrow");  
    
    if ( imgArrow.status == "expand" )
    {
        left.style.display     = "none";
        right.style.display    = "";                              
                
        imgArrow.status = "collapse";  
        imgArrow.src = "../../../system/images/button/next.gif";                              
    }
    else 
    {
        left.style.display     = "";
        right.style.display    = "";
        
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/button/previous.gif";
    }
}

 //===============================================================================================
function BodyInit()
 {
    System.Translate(document);  // Translate to language session    
    txtUser_PK.text = "<%=session("USER_PK")%>";
	txtEmpPK.text = "<%=Session("EMPLOYEE_PK")%>"  ;
    txtCompany_PK.text = "<%=session("COMPANY_PK")%>";
	txtLang.text = "<%=Session("SESSION_LANG")%>";
	
	txtSlipNo.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtSupplierName.SetEnable(false);
    txtPLName.SetEnable(false);    
   
    idBtnApprove.SetEnable(false);
    idBtnCancel.SetEnable(false);
    idBtnAutoSlip.SetEnable(false);    
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //---------------------------- 
    FormFormat();
    BindingDataList();    
    //----------------------------      
 }
 //==================================================================================
 
 function BindingDataList()
 { 
    var data = ""; 
    //----------------------- 
    data = "<%=ESysLib.SetListDataSQL("SELECT TRANS_CODE ,TRANS_CODE || ' - ' || trans_name  FROM tlg_in_trans_code  WHERE del_if = 0 and trans_type = 'I' and TRANS_CODE = 'I10' ORDER BY trans_code" )%>";    
    lstTransType.SetDataText(data);
    //---------------------------
    data = "<%=ESysLib.SetListDataFUNC("SELECT lg_f_logistic_code('LGCM0100') FROM DUAL" )%>";    
    lstCCY.SetDataText(data);               
    
    data = "<%=ESysLib.SetListDataSQL("SELECT a.CODE, a.CODE_NM FROM TLG_LG_CODE a, TLG_LG_CODE_GROUP b WHERE  b.GROUP_ID='LGKB0030' AND a.TLG_LG_CODE_GROUP_PK=b.PK and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 ORDER BY a.CODE , a.CODE_NM ") %> ";                 
    lstShipComp.SetDataText(data); 
    lstShipComp.value = '' ;
	 
    data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0 order by PARTNER_NAME ")%>"; 
    lstCompany.SetDataText(data);	 
    lstCompany.value= txtCompany_PK.text;
    
    pro_kbin00050_lst.Call();  
 }
 function FormFormat()
 {    
     //-----------------------
     var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_NET_KG)    = "#,###,###,###,###.##R";
    ctr.ColFormat(G1_BALES)     = "#,###,###,###,###.##R";
    ctr.ColFormat(G1_NET_LBS)   = "#,###,###,###,###.##R";
    ctr.ColFormat(G1_AVERAGE)   = "#,###,###,###,###.##R";

     ctr.ColFormat(G1_UNIT_PRICE)   = "#,###,###,###,###.####R";
     ctr.ColFormat(G1_AMOUNT)       = "#,###,###,###,###.####R";
 }
 //==================================================================================
function  OnChangeDate()
{
	var	ldate=dtVoucherDate.value ;       
    ldate = ldate.substr(2,4)  ; 
    lstInType.value = ldate;
}
 //==================================================================================
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_kbin00050_1.StatusInsert();
            
            txtSlipNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtStaffName.text = "<%=Session("USER_NAME")%>";
            txtStaffPK.text   = "<%=Session("EMPLOYEE_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            flag = "view";        
            pro_kbin00050_4.Call();
        break;  
        
        case 'PO2':
             var path = System.RootURL + '/form/kb/in/kbin00052.aspx';
             var object = System.OpenModal( path ,1000 , 600 ,  'resizable:yes;status:yes',this);
             
             if ( object != null )
             {
                    var arrTemp;
	                //-----------------                  
                    for ( var i=0; i< object.length; i++)
                    {
                        var arrTemp = object[i];
                        
                        grdDetail.AddRow();
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_SEQ, grdDetail.rows-1);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_MASTER_PK, txtMasterPK.text); //master_pk
                        
                        grdDetail.SetGridText( grdDetail.rows-1, G1_TLG_IT_ITEM_PK, arrTemp[6]);//item_pk	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_CODE,   arrTemp[7]);//item_code	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_ITEM_NAME,   arrTemp[8]);//item_name
                        
                        if(txtLotNo.text != "")
                        {
                            var seq =(Number(grdDetail.rows-1) < 10) ? ("0" + (grdDetail.rows-1)) : (grdDetail.rows-1)
                            grdDetail.SetGridText( grdDetail.rows-1, G1_LOT_NO,  txtLotNo.text + "-" + seq);//item_name
                        }
                        grdDetail.SetGridText( grdDetail.rows-1, G1_NET_KG, arrTemp[9]);//in qty 01	    
                        grdDetail.SetGridText( grdDetail.rows-1, G1_NET_LBS, Number(grdDetail.GetGridData( grdDetail.rows-1, G1_NET_KG))*0.204634);
                        grdDetail.SetGridText( grdDetail.rows-1, G1_UNIT_PRICE,       arrTemp[13] );//Item Price
                    } 
                    //------------------- 
                               
             }                                                                 
        break;   
    }
}  
//=============================================================================================
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdSearch':
            data_kbin00050.Call("SELECT");
        break;
    
        case 'grdMaster':
            var s_status = grdSearch.GetGridData( grdSearch.row, GS_STATUS );

            
            if ( data_kbin00050_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdSearch.row > 0 )
                    {
                        txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, GS_MASTER_PK );
                    }
                    flag = 'view' ;
                    data_kbin00050_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdSearch.row > 0 )
                {
                    txtMasterPK.text = grdSearch.GetGridData( grdSearch.row, GS_MASTER_PK );
                }
                
                flag = 'view' ;
                data_kbin00050_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_kbin00050_2.Call("SELECT");
        break;
    }
}

function OnCheckStatus()
{
            if(lblStatus.text == 'SAVED' || lblStatus.text == 'CANCEL')
            {
                idBtnApprove.SetEnable(true);
                idBtnCancel.SetEnable(false);
                idBtnAutoSlip.SetEnable(false);
            }
            else
            {
                idBtnApprove.SetEnable(false);
                if(txtAccSlipNo.text == "")
                {
                    idBtnCancel.SetEnable(true) ;
                    idBtnAutoSlip.SetEnable(true) ;
                }
                else
                {
                    idBtnCancel.SetEnable(false) ;
                    idBtnAutoSlip.SetEnable(false) ;
                }
            } 
}
//=============================================================================================
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_kbin00050_1":
            OnCheckStatus();
            if ( flag == 'save')
            {
                for(var i=1; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_MASTER_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_MASTER_PK, txtMasterPK.text);
                    } 
                }
                OnSave('Detail');                
            }
            else
            {
                OnSearch('grdDetail');   
            }
                   
        break;

        case "data_kbin00050_2":
            if ( grdDetail.rows > 1 )
            {
                var dBales = 0;
                for ( var i = 1 ; i < grdDetail.rows ; i++)
                {
                    dBales   += Number(grdDetail.GetGridData( i, G1_BALES)) ;
                }        
                lblSOBales.text = addCommas(dBales);    
            }         
        break;

        case 'pro_kbin00050_lst':
            lstWH.SetDataText(txtWHStr.text);
            lstWH2.SetDataText(txtWHStr.text +"||");
            lstWH2.value =''
            OnAddNew('Master');
        break;    
		
		case 'data_fpab00220_2':
			 if ( txtLGGroupCodeID.text == 'LGIN0301')
			 {
				 lstInType.SetDataText(txtLGCodeList.text);
				 lstInType.value = rtnLGCode;
			 }
		break;
        
        case 'pro_kbin00050_1':
            alert(txtReturnValue.text);
            data_kbin00050_1.Call('SELECT');
        break; 
		
		case 'pro_kbin00050_2':
		    alert(txtReturnValue.text);
		    data_kbin00050_1.Call('SELECT');
		break;        		

		case 'pro_kbin00050_3':
            alert(txtReturnValue.text);
            data_kbin00050_1.Call('SELECT');
		break;

		case 'pro_kbin00050_4':
            TotalAmount();
        break;

   }            
}
//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
		case 'WAREHOUSE':
            var path = System.RootURL + '/form/fp/ab/fpab00240.aspx' ;
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                lstWH.value = obj[0];                 
            }
        break; 
			
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtStaffName.text = obj[2];
                txtStaffPK.text   = obj[0];
            }
        break;            

        case 'Supplier' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtSupplierPK.text   = object[0];
                txtSupplierName.text = object[2];                
	         }
        break;
        
        case 'PL': // PL
            fpath  = System.RootURL + "/form/fp/ab/fpab00380.aspx";
            oValue = System.OpenModal( fpath , 800 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtPLPK.text   = oValue[6]; 
                txtPLName.text = oValue[2] + ' - ' + oValue[5] ;
            }
        break;        

		case 'Shipper':
                 var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGKB0030";
	             var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
    	         
	             if ( object != null )
	             {	        
	                if ( object[0] == 1 )
	                {
	                    txtLGGroupCodeID.text = 'LGKB0030';
	                    rtnLGCode             = object[1];
    	                
                        data_fpab00220_2.Call("SELECT");                                
	                }
	                else
	                {
	                    lstShipComp.value = object[1];      
	                }    	                
	             }                              
            break;  
            
		case 'Invoice' :
             var path = System.RootURL + "/form/kb/in/kbin00051.aspx";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtPONo.text   = object[0];
                txtLCNo.text = object[1];                
                txtBLNo.text = object[2];                
                txtMark.text = object[3];                
                lstShipComp.value = object[4];   
                txtInvoiceNo.text = object[5];     
                pro_kbin00050.Call();         
	         }
        break;
        
		case 'Report':			 
			 if( txtMasterPK.text != "" )
	        {
		        var path = System.RootURL + '/form/bi/ni/bini00033.aspx';
		        var object = System.OpenModal( path ,400, 300 ,  'resizable:yes;status:yes',this);	
 	        }
	        else
	        {
		        alert("Please, select one slip no to print!");
	        }	
		break;                
    }	       
}
//======================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'AutoSlip' :
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to process?'))
                {
                    pro_kbin00050_1.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}			                         
        break;
        
        case 'Approve':
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to approve this Slip?'))
                {
                    pro_kbin00050_2.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}        
        break;
        
        case 'OutGo' :
            if ( txtMasterPK.text != '' )
            {
                if ( confirm('Do you want to make outgoing slip?'))
                {
                    pro_kbin00050_1.Call();
                } 
            }
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}			                  
        break;   
        
        case 'Trans' :
            if ( txtMasterPK.text != '' )
            {
                if ( confirm('Do you want to make transfer slip?'))
                {
                    pro_kbin00050_2.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}			                 
        break; 
		
        case 'Cancel' :
            if ( txtMasterPK.text != '' )
            {
                if ( confirm('Do you want to cancel this slip?'))
                {
                    pro_kbin00050_3.Call();
                } 
            } 
			else
			{
				alert("PLS SELECT ONE SLIP.");
			}			                 
        break; 		
		
		case 'CAL-AMOUNT':
			if ( confirm('Do you want to auto calculate Amount ?') )
            {
                InputProcess();
			}
		break;               
    }
}
//======================================================================
function InputProcess()
{
    for(var row = 1; row < grdDetail.rows; row++)
    {
         var dQuantiy = grdDetail.GetGridData( row, G1_NET_LBS) ;
         var dPrice   = grdDetail.GetGridData( row, G1_UNIT_PRICE) ;
         var dBales   = grdDetail.GetGridData( row, G1_BALES) ;
         
         var dNetBales= Number(dQuantiy) * 2.20460000186 ;
         grdDetail.SetGridText( row, G1_NET_LBS, dNetBales);
         
         var dAmount = Number(dNetBales) * Number(dPrice);
         grdDetail.SetGridText( row, G1_AMOUNT, dAmount);
         
         var dDverage = Number(dQuantiy)/Number(dBales);
         grdDetail.SetGridText( row, G1_AVERAGE, dDverage);
         lblSOBales.text = addCommas(Number(lblSOBales.text) + Number(dBales));
    }
            TotalAmount();  
}
//=================================================================================
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_kbin00050_1.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_kbin00050_2.Call();
        break;
    }
}

//=================================================================================

function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                 var event_col = event.col ;
                 var event_row = event.row ;

                 if ( event_col == G1_REQ_UOM || event_col == G1_IN_UOM || event_col == G1_REF_UOM )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00640.aspx?p_item_pk=' + grdDetail.GetGridData( event_row, G1_INCOME_ITEM_PK ) + '&p_uom=' + grdDetail.GetGridData( event_row, G1_IN_UOM );
	                   var obj = System.OpenModal( path ,550 , 300, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[0]);
	                   }	
                 }
                 else if ( event_col == G1_IN_ITEM_CODE || event_col == G1_IN_ITEM_NAME )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00110.aspx?group_type=||Y|Y||';
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                       
                       if ( object != null )
                       {
                            grdDetail.SetGridText( event_row, G1_INCOME_ITEM_PK, object[0] );
                            grdDetail.SetGridText( event_row, G1_IN_ITEM_CODE,   object[1] );
                            grdDetail.SetGridText( event_row, G1_IN_ITEM_NAME,   object[2] );
                       }                       
                 }
				 else if ( event_col == G1_LOT_NO )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00690.aspx?item_pk=' + grdDetail.GetGridData( event_row, G1_INCOME_ITEM_PK ) + '&item_code=' + grdDetail.GetGridData( event_row, G1_IN_ITEM_CODE ) + '&item_name=' + grdDetail.GetGridData( event_row, G1_IN_ITEM_NAME ) + '&lot_no=' + grdDetail.GetGridData( event_row, G1_LOT_NO ) + '&partner_pk=' + txtSupplierPK.text + '&partner_name=' + txtSupplierName.text  ;
                       var object = System.OpenModal( path , 800 , 600,  'resizable:yes;status:yes');
                                                               
                 }
            break;             
      }         
}   

//=================================================================================

function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_kbin00050_1.StatusDelete();
                data_kbin00050_1.Call();
            }   
        break;

        case 'Detail':
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
//=================================================================================
 
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}

//=================================================================================
function Validate()
{   
    //---------------
    for( var i = 1; i < grdDetail.rows; i++)
    {
        //---------------
        if ( Number(grdDetail.GetGridData( i, G1_NET_KG)) == 0 )
        {
            alert("Input take in Qty. at " + i + ",pls!")
            return false;
        }
        //---------------
    }
    //----------------
    return true;
}

//=================================================================================
var gPreviousRow = -1 ;
function CheckInput()
{   
    var col, row
    
    col = event.col;
    row = event.row; 
    
    if ( col == G1_NET_KG || col == G1_BALES || col == G1_UNIT_PRICE)
    {
        var dQuantiy ;
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText( row, col, System.Round( dQuantiy, 2 ));
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
        //----------------------Calculate Amount -----
            if ( col == G1_NET_KG || col == G1_BALES || col == G1_UNIT_PRICE )
            {
                var dQuantiy = grdDetail.GetGridData( row, G1_NET_KG) ;
                var dPrice   = grdDetail.GetGridData( row, G1_UNIT_PRICE) ;
                var dBales   = grdDetail.GetGridData( row, G1_BALES) ;
                
                var dNetBales= Number(dQuantiy) * 2.20460000186 ;
     
                grdDetail.SetGridText( row, G1_NET_LBS, System.Round(dNetBales,2));
                
                var dAmount =Number(dNetBales) * Number(dPrice);
                grdDetail.SetGridText( row, G1_AMOUNT, dAmount);
                
                var dDverage = Number(dQuantiy)/Number(dBales);
                grdDetail.SetGridText( row, G1_AVERAGE, dDverage);
            } 
            TotalAmount();  
    }
    else if(col == G1_NET_LBS)
    {
        var dPrice   = grdDetail.GetGridData( row, G1_UNIT_PRICE) ;
        var dNetBales= grdDetail.GetGridData( row, G1_NET_LBS) ;

        var NetLBS = 0;
        for ( i=1; i<grdDetail.rows; i++ )
        {
		    NetLBS  += Number(grdDetail.GetGridData( i, G1_NET_LBS ));
        }
        lblNetW_LBS.text  = addCommas(System.Round( NetLBS,  2 ));
        lblGrossW_LBS.text = addCommas(System.Round(Number(NetLBS) + Number(lblTareW_LBS.text),  2 ));

        var dAmount = grdDetail.GetGridData( row, G1_AMOUNT);
        var remain = Number(txtItemAmt.text) - dAmount;

        dAmount = Number(dNetBales) * Number(dPrice);
        grdDetail.SetGridText( row, G1_AMOUNT,  dAmount );
        txtItemAmt.text = dAmount + remain;
        txtTotalAmt.text = Number(txtItemAmt.text) + Number(txtTaxAmt.text);
    }
    else if(col == G1_AMOUNT)
    {
        TotalAmount(); 
    }
}
function OnTax()
{
    var dTaxAmt = Number(txtItemAmt.text) * (Number(txtTax.text)/100);
    txtTaxAmt.text   = System.Round( dTaxAmt,   4 ) ;
    txtTotalAmt.text = Number(txtItemAmt.text) + Number(txtTaxAmt.text);
    txtExAmt.text    = System.Round(txtTotalAmt.text, 4) * Number(txtExRate.text);
}
//====================================================
function TotalAmount()
{ 
    //---------CALCULATE AMOUNT---------------- 
	var sumItemAmt  = 0 ;
	var sumTaxAmt   = 0 ;
    var sumTotalAmt = 0 ;
    var sumNetQty   = 0 ;
    var sumBales    = 0 ;
    var sumNetLBS   = 0 ;
    for ( i=1; i<grdDetail.rows; i++ )
    {
		sumItemAmt  = sumItemAmt  + Number(grdDetail.GetGridData( i, G1_AMOUNT ));
		sumNetQty  = sumNetQty  + Number(grdDetail.GetGridData( i, G1_NET_KG ));
		sumBales  = sumBales  + Number(grdDetail.GetGridData( i, G1_BALES ));
        sumNetLBS = sumNetLBS + System.Round( Number(grdDetail.GetGridData( i, G1_NET_LBS )),2);
    }
    sumTaxAmt   = sumItemAmt  * (Number(txtTax.text)/100);
    sumTotalAmt = sumTaxAmt + sumItemAmt;
    
	txtItemAmt.text  = System.Round( sumItemAmt,  4 ) ;
	txtTaxAmt.text   = System.Round( sumTaxAmt,   4 ) ;
    txtTotalAmt.text = System.Round( sumTotalAmt, 4 ) ;
    txtExAmt.text    = System.Round(txtTotalAmt.text, 4) * Number(txtExRate.text);
    txtNetW.text     = System.Round( sumNetQty, 4 ) ;
    lblSOBales.text  = addCommas(sumBales);
    lblNetW_LBS.text  = addCommas(System.Round( sumNetLBS,  2 ));
    OnNetW();
} 
//=================================================================================
function OnPrint()
{    
    if(txtMasterPK.text != "")
    {
        var url =System.RootURL + '/reports/bi/ni/rpt_kbin00050.aspx?master_pk=' + txtMasterPK.text ;
        //var url =System.RootURL + '/reports/ep/fm/rpt_kbin00050_multi.aspx?master_pk=' + txtMasterPK.text ;
	    window.open(url, "_blank"); 
	}
	else
	{
	    alert("Pls select one slip.");
	}
}
//=================================================================================
function OnPrint1()
{    
    if(txtMasterPK.text != "")
    {
        var url =System.RootURL + '/reports/bi/ni/rpt_kbin00050_1.aspx?master_pk=' + txtMasterPK.text ;
        //var url =System.RootURL + '/reports/ep/fm/rpt_kbin00050_multi.aspx?master_pk=' + txtMasterPK.text ;
	    window.open(url, "_blank"); 
	}
	else
	{
	    alert("Pls select one slip.");
	}
}
//==================================================================================
function OnReport(pos)
{
    switch(pos)
    {
        case'0':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00031.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
		
        case'1':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00032.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank");			 
        break;
		
        case'2':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00033.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
		
        case'3':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00034.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank");
		break;	
			 
	    case'4':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00036.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
		
		case 'DORCO':
            var url =System.RootURL + '/reports/bi/ni/rpt_bini00031_DORCO.aspx?master_pk=' + txtMasterPK.text ;
	        window.open(url, "_blank"); 
        break;
    }
}
//=================================================================================
function OnMaxSeq()
{
    var maxSeq = 0 ;
    if(grdDetail.rows < 1)
    {
        return maxSeq;
    }
    else
    {
        for (var i = 1; i < grdDetail.rows; i++)
        {
            if ( Number( grdDetail.GetGridData(i,G1_SEQ) ) > maxSeq )
            {
                maxSeq = Number( grdDetail.GetGridData(i,G1_SEQ) )
            }
        }
        return maxSeq;
    }
}
//=================================================================================
function OnCopy()
{
    var i, j, lNewRow,dBales = 0;
    
    for (i = 1; i < grdDetail.rows ; i++)
    {
        if(grdDetail.GetGridControl().IsSelected(i))
        {            
            seqInit = OnMaxSeq();
            seqInit = parseInt(seqInit) + 1;
            
            grdDetail.AddRow();
            lNewRow = grdDetail.rows - 1;
            
            for ( j = 0 ; j <= G1_DESCRIPTION ; j++)
            {
                if (j != G1_SEQ && j != G1_DETAIL_PK )
                {
                    grdDetail.SetGridText(lNewRow, j, grdDetail.GetGridData(i, j));
                } 
                if(txtLotNo.text != "")
                {
                    var seq =(Number(lNewRow) < 10) ? ("0" + lNewRow) : lNewRow
                    grdDetail.SetGridText( lNewRow, G1_LOT_NO,  txtLotNo.text + "-" + seq);
                }
                grdDetail.SetGridText( lNewRow, G1_SEQ, seqInit);//sequence
            }
        }
    }
    TotalAmount();
}
//=================================================================================
function url_encode(s) 
{
	string = s.replace(/\r\n/g,"\n");
	var utftext = "";

	for (var n = 0; n < string.length; n++) 
	{

		var c = string.charCodeAt(n);

		if (c < 128) 
		{
			utftext += String.fromCharCode(c);
		}
		else if ((c > 127) && (c < 2048)) 
		{
			utftext += String.fromCharCode((c >> 6) | 192);
			utftext += String.fromCharCode((c & 63) | 128);
		}
		else 
		{
			utftext += String.fromCharCode((c >> 12) | 224);
			utftext += String.fromCharCode(((c >> 6) & 63) | 128);
			utftext += String.fromCharCode((c & 63) | 128);
		}
	}
	return escape(utftext);
}
//====================================================================================
function addCommas(nStr)
{
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1))
	{
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}
 //================================================================================================
function OnNetW()
{
     if (IsNumeric(txtNetW.text))
     {
         //lblNetW_LBS.text  = Number(txtNetW.text.replace(/,/g,"")) * 2.20460000186 ;   
         //lblNetW_LBS.text  = addCommas(System.Round( lblNetW_LBS.text,  2 ));
     }  
     if (IsNumeric(txtTareW.text))
     {
         txtGrossW.text = Number(txtNetW.text) + Number(txtTareW.text);
         lblTareW_LBS.text  = Number(txtTareW.text.replace(/,/g,"")) * 2.20460000186 ;   
         lblTareW_LBS.text  = addCommas(System.Round( lblTareW_LBS.text,  2 ));
     }        
     if (IsNumeric(txtGrossW.text))
     {
         lblGrossW_LBS.text  = Number(lblNetW_LBS.text.replace(/,/g,"")) + Number(lblTareW_LBS.text.replace(/,/g,""));   
         lblGrossW_LBS.text  = addCommas(System.Round( lblGrossW_LBS.text,  2 ));
     }
}
function OnTareW()
{
     if (IsNumeric(txtTareW.text))
     {
         txtGrossW.text = Number(txtNetW.text) + Number(txtTareW.text);
         lblTareW_LBS.text  = Number(txtTareW.text) * 2.20460000186 ;   
         lblTareW_LBS.text  = addCommas(System.Round( lblTareW_LBS.text,  2 ));
     }
     if (IsNumeric(txtGrossW.text))
     {
        lblGrossW_LBS.text  = Number((lblNetW_LBS.text).replace(/,/g,"")) + Number((lblTareW_LBS.text).replace(/,/g,""));
        lblGrossW_LBS.text  = addCommas(System.Round(lblGrossW_LBS.text,  2));
     }
}
</script>
<body>
    <!------------------------------------------------------------------>
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
	           <output>
	                <output bind="txtLGCodeList" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_kbin00050_lst" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="<%=l_user%>lg_sel_kbin00050_3" > 
                <input>
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="txtWHStr" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-----------------------grdSearch---------------------------------------->
    <gw:data id="data_kbin00050" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1,2,3,4,5" function="<%=l_user%>lg_sel_kbin00050_1" > 
                <input> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="lstWH2" />
                    <input bind="txtNoSearch" />
					<input bind="txtEmpPK" />
					<input bind="chkUser" />                      
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_kbin00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31" function="<%=l_user%>lg_sel_kbin00050_2"  procedure="<%=l_user%>lg_upd_kbin00050_1"> 
                <inout>      
                     <inout  bind="txtMasterPK" />
                     <inout  bind="dtVoucherDate" />
                     <inout  bind="txtSlipNo" />                          
                     <inout  bind="txtSupplierPK" />
                     <inout  bind="txtSupplierName" />
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaffName" />
                     <inout  bind="txtPONo" />
                     <inout  bind="lstWH" />
                     <inout  bind="txtLCNo" />
                     <inout  bind="txtPLPK" />
                     <inout  bind="txtPLName" />
                     <inout  bind="txtInvoiceNo" />
                     <inout  bind="lstShipComp" /> 
					 <inout  bind="txtBLNo" />
					 <inout  bind="txtTax" />
                     <inout  bind="txtMark" /> 
                     <inout  bind="lstCCY" /> 
                     <inout  bind="txtLotNo" /> 
                     <inout  bind="txtNetW" /> 
                     <inout  bind="lblNetW_LBS" />
                     <inout  bind="txtTareW" /> 
                     <inout  bind="lblTareW_LBS" />
                     <inout  bind="txtGrossW" /> 
                     <inout  bind="lblGrossW_LBS" />
                     <inout  bind="txtItemAmt" /> 
                     <inout  bind="txtTaxAmt" /> 
                     <inout  bind="txtTotalAmt" />
                     <inout  bind="txtExRate" />
                     <inout  bind="txtExAmt" />
                     <inout  bind="txtRemark" />  
                     <inout  bind="lblStatus" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_kbin00050_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13" function="<%=l_user%>lg_sel_kbin00050_4"   procedure="<%=l_user%>lg_upd_kbin00050_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <gw:data id="pro_kbin00050" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="<%=l_user%>LG_PRO_KBIN00050"> 
                <input> 
			        <input bind="txtPONo" />  		
			    </input> 
                <output>
                    <output bind="txtSupplierPK" />
                    <output bind="txtSupplierName" />
                </output>           
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------AUTO SLIP-------------------------------------->
    <gw:data id="pro_kbin00050_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbin00050_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------APPROVE---------------------------------------->
    <gw:data id="pro_kbin00050_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbin00050_2" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------CANCEL---------------------------------------->
    <gw:data id="pro_kbin00050_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_kbin00050_3" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------GET CURRENCY------------------------------->
    <gw:data id="pro_kbin00050_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>sp_get_rate" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="lstCCY" />
                    <input bind="dtVoucherDate" />
                </input> 
                <output>
                    <output bind="txtExRate" />
                    <output bind="txtNull" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="t-left" style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            Date
                        </td>
                        <td style="white-space: nowrap; width: 94%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdSearch')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            W/H
                        </td>
                        <td style="width: 95%" colspan="2">
                            <gw:list id="lstWH2" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 5%" align="right">
                            No.
                        </td>
                        <td style="width: 95%" colspan="1">
                            <gw:textbox id="txtNoSearch" styles="width: 100%" onenterkey="OnSearch('grdSearch')" />
                        </td>
                        <td>
                            <gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdSearch')">User
							</gw:checkbox>
                        </td>
                    </tr>
                    <tr style="height: 98%">
                        <td colspan="3">
                            <gw:grid id='grdSearch' header='_PK|Slip No|Date|Invoice No|Status' format='0|0|4|0|0'
                                aligns='0|0|0|0|0' check='||||' editcol='0|0|0|0|0' widths='1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' oncellclick="OnSearch('grdMaster')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="t-right" style="width: 70%">
                <table style="width: 100%; height: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="width: 100%; height: 1%" colspan="16">
                            <table style="width: 100%; height: 100%" cellpadding="1" cellspacing="1" border="0">
                                <tr>
                                    <td align="right" style="width: 1%; white-space: nowrap">
                                        <gw:icon id="idBtnApprove" img="2" text="Approve" styles='width:100%' onclick="OnProcess('Approve')" />
                                    </td>
                                    <td style="width: 1%" align="center">
                                        <gw:icon id="idBtnCancel" img="2" text="Cancel" styles='width:100%' onclick="OnProcess('Cancel')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:icon id="idBtnAutoSlip" img="2" text="AutoSlip" styles='width:100%' onclick="OnProcess('AutoSlip')" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap">
                                        ACC Slip No
                                    </td>
                                    <td>
                                        <gw:textbox id="txtAccSlipNo" csstype="mandatory" styles="width:50%;" />
                                    </td>
                                    <td style="width: 1%; white-space: nowrap">
                                        <gw:label id="lblStatus" text="" styles="color:red" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPopUp('Report')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnAddNew('Master')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Master')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('Master')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Slip No
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtSlipNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Date
                        </td>
                        <td style="width: 20%" align="left">
                            <gw:datebox id="dtVoucherDate" lang="1" onchange="OnChangeDate()" />
                        </td>
                        <td align="right" style="width: 5%">
                            <a title="Supplier" onclick="OnPopUp('Supplier')" href="#tips" style="color=#0000ff">
                                <b>Supplier</b></a>
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtSupplierPK" styles="display:none" />
                            <gw:textbox id="txtSupplierName" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            P/O No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtPONo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            L/C
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtLCNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a title="Charger" onclick="OnPopUp('Charger')" href="#tips" style="color: #0000ff">
                                <b>Charger</b></a>
                        </td>
                        <td colspan="11">
                            <gw:textbox id="txtStaffName" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a onclick="OnPopUp('Shipper')" href="#tips" style="color: #0000ff"><b>Shipper</b></a>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:list id="lstShipComp" styles="width:100%;" />
                        </td>
                        <td align="right">
                            <a title="P/L" onclick="OnPopUp('PL')" href="#tips" style="color: #0000ff"><b>P/L</b></a>
                        </td>
                        <td>
                            <gw:textbox id="txtPLPK" styles="display:none" />
                            <gw:textbox id="txtPLName" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a title="WareHouse" onclick="OnPopUp('WAREHOUSE')" href="#tips" style="color: #0000ff">
                                <b>W/H</b></a>
                        </td>
                        <td style="white-space: nowrap" colspan="11">
                            <gw:list id="lstWH" styles='width:100%' csstype="mandatory" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            <a title="Invoice No" onclick="OnPopUp('Invoice')" href="#tips" style="color: #0000ff">
                                <b>Invoice No</b></a>
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtInvoiceNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            B/L No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtBLNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 1%; white-space: nowrap">
                            Tax %
                        </td>
                        <td style="width: 5%;">
                            <gw:textbox id="txtTax" styles="display:100%" type="number" format="#,###,###" onchange="OnTax()" onenterkey="OnTax()" />
                        </td>
                        <td align="right" style="width: 1%; white-space: nowrap">
                            CCY
                        </td>
                        <td style="width: 8%">
                            <gw:list id="lstCCY" styles="width:100%;" onchange="pro_kbin00050_4.Call()" />
                        </td>
                        <td colspan="8">
                            <gw:textbox id="txtExRate" styles="width:100%;" type="number" format="#,###,###,###R"
                                onchange="TotalAmount()" onenterkey="TotalAmount()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Lot No
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtLotNo" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Mark
                        </td>
                        <td style="white-space: nowrap">
                            <gw:textbox id="txtMark" styles="width:100%" />
                        </td>
                        <td align="right">
                            Ex Amt
                        </td>
                        <td colspan="15">
                            <gw:textbox id="txtExAmt" styles="width:100%;" type="number" format="#,###,###.0000R"
                                readonly="T" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right">
                            Remark
                        </td>
                        <td colspan="15">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="16">
                            <table style="height: 100%; width: 100%; background-color: #CCFFFF" cellpadding="1">
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Item Amt
                                </td>
                                <td style="width: 25%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtItemAmt" styles="width:100%;" type="number" format="#,###,###.0000R"
                                        readonly="T" />
                                </td>
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Tax Amt
                                </td>
                                <td style="width: 25%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtTaxAmt" styles="width:100%;" type="number" format="#,###,###.0000R"
                                        readonly="T" />
                                </td>
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Total Amt
                                </td>
                                <td style="width: 35%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtTotalAmt" styles="width:100%;" type="number" format="#,###,###.0000R"
                                        readonly="T" />
                                </td>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="16">
                            <table style="height: 100%; width: 100%; background-color: #FAE396" cellpadding="1">
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Net Weight
                                </td>
                                <td style="width: 25%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtNetW" styles="width:100%;" type="number" format="#,###,###.###"
                                        readonly="T" onchange="OnNetW()" />
                                </td>
                                <td style="white-space: nowrap">
                                    <gw:label id="lblNetW_LBS" styles='width:100%;color:cc0000;font:9pt' />
                                </td>
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Tare Weight
                                </td>
                                <td style="width: 25%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtTareW" styles="width:100%;" type="number" format="#,###,###.###"
                                        onchange="OnTareW()" />
                                </td>
                                <td style="white-space: nowrap">
                                    <gw:label id="lblTareW_LBS" styles='width:100%;color:cc0000;font:9pt' />
                                </td>
                                <td style="width: 5%; white-space: nowrap" align="right">
                                    Gross Weight
                                </td>
                                <td style="width: 35%; white-space: nowrap" style="white-space: nowrap">
                                    <gw:textbox id="txtGrossW" styles="width:100%;" type="number" format="#,###,###.###"
                                        onchange="OnNetW()" readonly="T" />
                                </td>
                                <td style="white-space: nowrap">
                                    <gw:label id="lblGrossW_LBS" styles='width:100%;color:cc0000;font:9pt' />
                                </td>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="16">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td style="width: 10%" align="left">
                                        <img status="expand" id="imgArrow" src="../../../system/images/button/previous.gif"
                                            style="cursor: hand" onclick="OnToggle()" />
                                    </td>
                                    <td style="width: 5%; white-space: nowrap" style="white-space: nowrap">
                                        <gw:label id="lblBales" styles='width:100%;font:9pt' text="Sum of Bales: " />
                                    </td>
                                    <td style="white-space: nowrap">
                                        <gw:label id="lblSOBales" styles='width:100%;color:cc0000;font:9pt' />
                                    </td>
                                    <td style="width: 64%" align="right">
                                    </td>
                                    <td style="width: 15%; white-space: nowrap" align="center">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnPO2" img="2" text="P/O" styles='width:100%' onclick="OnAddNew('PO2')" />
                                    </td>
                                    <td style="width: 1%" align="right">
                                        <gw:imgbtn img="copy" alt="Copy" id="btnCopy" onclick="OnCopy()" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="16">
                            <gw:grid id='grdDetail' header='_tlg_kb_cotton_income_d_pk|_tlg_kb_cotton_income_m_pk|Seq|_tlg_it_item_pk|Item Code|Item Name|Lot No|Net KG|Bales|Net LBS|Unit Price|Amount|Average|Description'
                                format='0|0|0|0|0|0|0|1|1|1|1|1|1|0' aligns='0|0|1|0|0|0|0|0|0|0|0|0|0|0|0' check='|||||||||||||'
                                editcol='0|0|1|0|0|1|1|1|1|1|1|1|1|1' widths='0|0|500|0|1200|2500|1000|1000|1000|1000|1000|1000|1000|1000'
                                sorting='T' autosize='T' styles='width:100%; height:100%' onafteredit='CheckInput()' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<gw:textbox id="txtNull" styles="display:none;" />
<gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
<gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
<gw:list id="lstTransType" styles='width:100%;display: none' />
<gw:list id="lstCompany" styles="width:100%;display: none" />
<gw:textbox id="txtCompany_PK" styles='display:none;width:100%' />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />
<gw:textbox id="txtWHStr" styles="width: 100%;display: none" />
<!---------------------------------------------------------------------------------->
<gw:textbox id="txtLGCodeList" styles='display:none;width:100%' />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' />
<gw:textbox id="txtLang" styles='width:100%;display:none' />
<gw:textbox id="txtItemCD_Search" maxlen="100" styles='width:100%;display:none' />
<gw:textbox id="txtItemNM_Search" maxlen="100" styles='width:100%;display:none' />
<!---------------------------------------------------------------------------------->
<gw:grid id="grdItem_Search" header="pk|item_cd|item_nm" format="0|0|0" aligns="0|0|0"
    defaults="||" editcol="1|1|1" widths="0|0|0" styles="width:100%; height:200;display:none"
    sorting="F" param="0,1,2" />
<!--------------------------------------------------------------------------------->
<gw:textbox id="txtNumReqQty" styles='width:100%;display:none' />
<gw:textbox id="txtNumInQTy" styles='width:100%;display:none' />
<gw:textbox id="txtNumRefQTy" styles='width:100%;display:none' />
<gw:textbox id="txtNumPrice" styles='width:100%;display:none' />
<gw:textbox id="txtNumItemAmt" styles='width:100%;display:none' />
<gw:textbox id="txtNumRate" styles='width:100%;display:none' />
<gw:textbox id="txtNumTaxAmt" styles='width:100%;display:none' />
<gw:textbox id="txtNumTotalAmt" styles='width:100%;display:none' />
<gw:textbox id="txtMaskReqQty" styles='width:100%;display:none' />
<gw:textbox id="txtMaskRefQTy" styles='width:100%;display:none' />
<gw:textbox id="txtMaskInQTy" styles='width:100%;display:none' />
<gw:textbox id="txtMaskPrice" styles='width:100%;display:none' />
<gw:textbox id="txtMaskAmount" styles='width:100%;display:none' />
<gw:textbox id="txtMaskRate" styles='width:100%;display:none' />
<gw:textbox id="txtMaskVatAmt" styles='width:100%;display:none' />
<gw:textbox id="txtMaskTotalAmt" styles='width:100%;display:none' />
<!--------------------------------------------------------------------------------->
</html>
