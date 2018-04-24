<%@ Page Language="C#" %>

<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.Web.Security" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>MATERIAL TAKE IN</title>
</head>
<%ESysLib.SetUser("inv");%>

<script src="../../../system/lib/ajax.js"></script>

<script language="javascript" type="text/javascript">

//-----------------------------------------------------

var flag;

var G1_PK    = 0 ;

//---------------------------------------------------------
var G1_TIN_MATTAKEIND_PK    = 0,
    G1_TIN_MATTAKEIN_PK     = 1 ,   
    G1_TPR_PURORDD_PK       = 2,
    G1_TPR_REQIQCD_PK       = 3,
    G1_No                   = 4 ,   
    G1_TCO_BUSPARTNER_PK    = 5,
    G1_Supplier               = 6,
    G1_TakeIn_DT            = 7 ,   
    G1_TIN_WAREHOUSE_PK     = 8,
    G1_po_no                = 9,
    G1_TCO_ITEM_PK          = 10,
    G1_Item_Code            = 11,
    G1_Item_Name            = 12,   
    G1_UOM                  = 13, 
    G1_TakeIn_Qty           = 14,
    G1_Item_Price           = 15,
    G1_Amount               = 16,
    G1_Lot_No               = 17,
    G1_test_no              = 18,
    G1_tin_whloc_pk         = 19,
    G1_Loc_ID               = 20,   
    G1_CCY                  = 21,
    G1_Description          = 22,
    G1_rout_pk              = 23,
    G1_takein_type          = 24,
    G1_item_group           = 25;
//---------------------------------------------------------
var iCodeID = "" ; 
var initFlag = 1;
//-----------------------------------------------------
function BodyInit()
 {
    System.Translate(document);  // Translate to language session    

    txtVoucherNo.SetEnable(false);
    txtStaff.SetEnable(false);
    txtDeptName.SetEnable(false);
    txtDeptCode.SetEnable(false);
    txtSupplier.SetEnable(false);
    //-------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate=dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;
    dtFrom.value=ldate ;
    //----------------------------
    
    BindingDataList();    
    //----------------------------
         
    //SetGridFormat();  
    //----------------------------
    OnNew();
    
 }
 //---------------------------------------------------------------------------------------------------
 
 function BindingDataList()
 {  
     var data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>";   
     
     cboCompany.SetDataText(data);
     cboCompany.value="<%=Session["COMPANY_PK"]%>"; 
     //-----------------------
     
     data = "<%=ESysLib.SetListDataSQL("select v.pk, v.wh_name from inv.tin_warehouse v where del_if =0 and WH_ID in ('MAT-DO','MAT-OS')  order by v.wh_name")%>";
     lstWH.SetDataText(data); 
     //-----------------------          
 }
 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
    var ctr = grdTakeinItems.GetGridControl(); 
    
    ctr.ColFormat(G1_TakeIn_Qty) = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_Item_Price) = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_Amount)     = "#,###,###,###,###,###.##";
 }
 //----------------------------------------------------------
function AddDigit(value, number)
{
    newstr = value;
    for(i=value.length; i< number; i++)
    {
        newstr = '0' + newstr;
    }
    return newstr;
}
 //---------------------------------------------------------------------------------------------------
  
function OnNew()
{
    initFlag =0 ;
    data_shmm00040_1.StatusInsert();
    btnSave.SetEnable(true);
    //-------------------------------------------
    cboCompany.value = "<%=Session["COMPANY_PK"]%>";

    txtStaff.text    = "<%=Session["USER_NAME"]%>";
    txtStaffPK.text  = "<%=Session["EMPLOYEE_PK"]%>";
//    txtDeptPK.text   = "<%=Session["DEPT_PK"]%>";
    txtDeptCode.text = '5054';
    txtDeptName.text = 'PC';
    //------------------------------------------- 
    grdTakeinItems.ClearData();
    OnChangeType();
    flag="view"; 
}  

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdVouchers':
            data_shmm00040.Call("SELECT");
        break;
    
        case 'data_shmm00040_1':
        
//            if ( data_shmm00040_1.GetStatus() == 20 && initFlag ==0 )
//            {
//                if ( confirm('Do you want to save first !!!'))
//                {
//                    OnSave('data_shmm00040_1');
//                }
//                else
//                {
//                    if ( grdVouchers.row > 0 )
//                    {
//                        txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G1_PK );
//                    }
//                    flag = 'view' ;
//                    data_shmm00040_1.Call("SELECT");
//                }                
//            } 
//            else
            {
                if ( grdVouchers.row > 0 )
                {
                    txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G1_PK );
                }
                flag = 'view' ;
                data_shmm00040_1.Call("SELECT");
            }                               
        break;
        
        case 'grdTakeinItems':            
            data_shmm00040_2.Call("SELECT");
        break;
    }
}
//-------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case "data_shmm00040_1": 
        
            //-------------------        
            if ( flag == "save" )
            {
               for (var i = 1; i<grdTakeinItems.rows; i++)   
               {
                    if ( grdTakeinItems.GetGridData( i, G1_TIN_MATTAKEIN_PK) == '' )
                    {
                        grdTakeinItems.SetGridText(i, G1_TIN_MATTAKEIN_PK,  txtMasterPK.GetData());
			
                    }  
                   
                    grdTakeinItems.SetGridText(i, G1_takein_type,  lstTIType.value);  
                    grdTakeinItems.SetGridText(i, G1_TakeIn_DT,  dtVoucherDate.value ); //99999
               }                                     
               //---------------------   
               OnSave('data_shmm00040_2');                
            }
            else
            {                
                if ( txtMasterClose.text == 'Y' )
                {
                    btnSave.SetEnable(false);
                }    
                else
                {
                    btnSave.SetEnable(true);
                }
                //---------------------------- 
                OnSearch('grdTakeinItems');
                
                  
            } 
            
            txtMasterClose.text == 'Y'?lblStatus.text='Closed':lblStatus.text='Open' ;    
                
        break;

        case "data_shmm00040_2":
            if ( flag != 'view' ) 
            {
                //OnSearch('grdVouchers');
                
            }
//            if ( grdTakeinItems.rows > 1 )
//            {
//                 grdTakeinItems.SetCellBgColor( 1, G1_Warehouse, grdTakeinItems.rows-1, G1_Warehouse, 0xCCFFFF );
//                 grdTakeinItems.SetCellBgColor( 1, G1_Loc_ID, grdTakeinItems.rows-1, G1_Loc_ID, 0xCCFFFF );
//            }                  
        break;
         
   }            
}

//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Charger':
            var path = System.RootURL +  '/form/sh/ab/shab00020.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtStaff.text    = obj[5];
                txtStaffPK.text  = obj[0];
            }
        break; 
        
        case 'Supplier' :
            if(grdTakeinItems.rows>1)
            {
                alert("Cannot change Supplier when you already have some item");
            }
            else
            {
                var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	            var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	            if ( object != null )
	            {
	                txtSupplierPK.text   = object[0];
	                txtSupplierID.text     = object[1];
                    txtSupplier.text     = object[2];                
	            }
            }
             
        break;
        
        case 'Dept': // PL
            var fpath = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGIV0050";
            var object = System.OpenModal( fpath , 550 , 400 , 'resizable:yes;status:yes'); 
            if (object != null)
            {                  
               txtDeptName.text = object[3]; 
               txtDeptCode.text  = object[1]; 
            }
        break;    

        case 'POItem':
            if(txtSupplierPK.text!="")
            {
                var path = System.RootURL + '/form/sh/mm/shmm00041.aspx?supplierpk='+txtSupplierPK.text;
                 var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
                 if ( object != null )
                 {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                        arrTemp = object[i];
                            
                        grdTakeinItems.AddRow();                            
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TIN_MATTAKEIN_PK, txtMasterPK.text); //master_pk	    	                                               
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TCO_BUSPARTNER_PK,txtSupplierPK.text);//Buss PK
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Supplier,         txtSupplier.text);//Buss Name
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_po_no ,               arrTemp[1]);//PO No
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TPR_PURORDD_PK,   arrTemp[4]);//PO Detail PK	    
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TCO_ITEM_PK, arrTemp[6]);//item_pk	    
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_Code,   arrTemp[7]);//item_code	    
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_Name,   arrTemp[8]);//item_name	    
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_UOM,         arrTemp[12]);//item_uom
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TakeIn_Qty, arrTemp[11]);//PO QTY - Take In Qty
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_Price, arrTemp[13] );//Item Price
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Amount,     Number(arrTemp[11])*Number(arrTemp[13]));//Amount
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_rout_pk, arrTemp[16] );
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TakeIn_DT, dtVoucherDate.value );//Take In Date

                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TIN_WAREHOUSE_PK , lstWH.value     );
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_item_group ,        arrTemp[17] );
                            
                    }		            
                 }         
            }
            else
            {
                alert("Please select Supplier frist");
            }
        break;  
        
        case 'FreeItem':
            if(txtSupplierPK.text!="")
            {
                var path = System.RootURL + '/form/sh/mm/shmm00042.aspx?supplierpk='+txtSupplierPK.text;
                 var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
                 if ( object != null )
                 {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                        arrTemp = object[i];
                            
                        grdTakeinItems.AddRow();                            
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TIN_MATTAKEIN_PK, txtMasterPK.text); //master_pk	    	                                               
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TCO_BUSPARTNER_PK,txtSupplierPK.text);//Buss PK
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Supplier,         txtSupplier.text);//Buss Name
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_po_no ,               arrTemp[1]);//PO No
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TPR_PURORDD_PK,   arrTemp[0]);//PO Detail PK	    
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TCO_ITEM_PK, arrTemp[4]);//item_pk	    
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_Code,   arrTemp[5]);//item_code	    
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_Name,   arrTemp[6]);//item_name	    
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_UOM,         arrTemp[11]);//item_uom
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TakeIn_Qty, arrTemp[7]);//PO QTY - Take In Qty
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_Price, arrTemp[10] );//Item Price
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Amount,     Number(arrTemp[7])*Number(arrTemp[10]));//Amount
                        //grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_rout_pk, arrTemp[16] );
                        
                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TakeIn_DT, dtVoucherDate.value );//Take In Date

                        grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TIN_WAREHOUSE_PK , lstWH.value     );
                        //grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Warehouse ,        lstWH.GetText() );
                            
                    }		            
                 }         
            }
            else
            {
                alert("Please select Supplier frist");
            }
        break;
        
        case 'Item':
             var path = System.RootURL + '/form/ep/fm/epfm00011.aspx?';
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdTakeinItems.AddRow();                            
                            
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TIN_MATTAKEIN_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TCO_ITEM_PK, arrTemp[0]);//item_pk	    
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_Code,   arrTemp[1]);//item_code	    
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_Name,   arrTemp[2]);//item_name
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_UOM,         arrTemp[10]);//item_uom                            
                            
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_No,           arrTemp[3]);//PO No	 
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TPR_LOTNO_PK, arrTemp[4]);//pk lot_no
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Lot_No,       arrTemp[5]);//lot_no

                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_tpr_itembcm_pk, arrTemp[17]);//tpr_itembcm_pk                            
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_BC,        arrTemp[7] );//bc 

                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TPR_REQIQCD_PK,    arrTemp[14] );//TPR_REQIQCD_PK
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TPR_PURORDD_PK,    arrTemp[15] );//TPR_PURORDD_PK
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TCO_BUSPARTNER_PK, arrTemp[16] );//Supplier pk
                            
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TakeIn_DT, dtVoucherDate.value );//Take In Date

                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TIN_WAREHOUSE_PK , lstWH.value     );
                            //grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Warehouse ,        lstWH.GetText() );
                            
                    }		            
             }        
        break;     
        case 'IQCReq':
             var path = System.RootURL + '/form/ep/fm/epfm00012.aspx';
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes',this);
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdTakeinItems.AddRow();                            
                            
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TIN_MATTAKEIN_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TCO_ITEM_PK, arrTemp[5]);//item_pk	    
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_Code,   arrTemp[6]);//item_code	    
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Item_Name,   arrTemp[7]);//item_name
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TakeIn_Qty,  arrTemp[8]);//IQC QTY - Take In Qty
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_UOM,         arrTemp[9]);//item_uom                            
                            
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_No, arrTemp[4]);//PO No	 

                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TPR_REQIQCD_PK, arrTemp[0] );//TPR_REQIQCD_PK
                            
                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TakeIn_DT, dtVoucherDate.value );//Take In Date

                            grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_TIN_WAREHOUSE_PK , lstWH.value     );
                            //grdTakeinItems.SetGridText( grdTakeinItems.rows-1, G1_Warehouse ,        lstWH.GetText() );
                            
                    }		            
             }        
        break;   
        case 'TIType':
             var path = System.RootURL + "/form/fp/ab/fpab00220.aspx?code_group=LGPO2001";
	         var object = System.OpenModal( path ,800 ,600 ,'resizable:yes;status:yes');
	         
	         if ( object != null )
	         {	        	                   
	            if ( object[0] == 1 )
	            {
	                txtLGGroupCodeID.text = 'LGPO2001';
	                rtnLGCode             = object[1];
	                
                    data_fpab00220_2.Call("SELECT");                                
	            }
	            else
	            {
	                lstTIType.value = object[1];      
	            }    	                
	         }                
        break;                                               
    }	       
}

//-------------------------------------------------------------------------------------
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'data_shmm00040_1':
            if( Validate() )
            {
            
                data_shmm00040_1.Call();
                flag='save';
            }            
        break;
        case 'data_shmm00040_2':        
            data_shmm00040_2.Call();
        break;
    }
}

//-------------------------------------------------------------------------------------

function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdTakeinItems" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                if ( event_col == G1_Lot_No && event_row > 0 )
                {
                
                     var path = System.RootURL + '/form/fp/ab/fpab00280.aspx' ;
                         path = path + '?item_pk='  + grdTakeinItems.GetGridData( grdTakeinItems.row, G1_TCO_ITEM_PK ) ;
                         path = path + '&item_code='+ grdTakeinItems.GetGridData( grdTakeinItems.row, G1_Item_Code   ) ;
                         path = path + '&item_name='+ grdTakeinItems.GetGridData( grdTakeinItems.row, G1_Item_Name   ) ;
                         path = path + '&item_uom=' + grdTakeinItems.GetGridData( grdTakeinItems.row, G1_UOM         ) ;
                         
                     var obj = System.OpenModal( path , 800 , 500 ,  'resizable:yes;status:yes');
                     if ( obj != null )
                     {
                         grdTakeinItems.SetGridText( event_row, G1_TPR_LOTNO_PK, obj[0]) ;//stock_pk	    	    
                         grdTakeinItems.SetGridText( event_row, G1_Lot_No,       obj[1]) ;//stock_noe
                     }	            
                }
                else if ( event_col == G1_Loc_ID && event_row > 0 )
                {
                      
                     var path = System.RootURL + '/form/fp/ab/fpab00160.aspx';
	                 var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	                 
	                 if ( obj != null )
	                 {
	                     grdTakeinItems.SetGridText( event_row, G1_tin_whloc_pk, obj[0] ); //G1_tin_whloc_pk
                         grdTakeinItems.SetGridText( event_row, G1_Loc_ID,       obj[7] ); //Loc_ID
                     }	                
                }                
            break;                     
      }         
}   

//------------------------------------------------------------------------------------------------

 function OnDelete(index)
 {        
    switch (index)
    {
        case 'Voucher':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_shmm00040_1.StatusDelete();
                data_shmm00040_1.Call();
            }   
        break;

        case 'GridItem':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdTakeinItems.GetGridData( grdTakeinItems.row,  G1_TIN_MATTAKEIND_PK ) == '' )
                {
                    grdTakeinItems.RemoveRow();
                }
                else
                {   
                    grdTakeinItems.DeleteRow();
                }    
            }            
        break;            

    }     
}
 //------------------------------------------------------------------------------------- 
 
function OnUnDelete()
{              
     grdTakeinItems.UnDeleteRow();
}

//-------------------------------------------------------------------------------------
function Validate()
{   
    //---------------
    for( var i = 1; i < grdTakeinItems.rows; i++)
    {
        //---------------
        if ( Number(grdTakeinItems.GetGridData(i,G1_TakeIn_Qty)) == 0)
        {
            alert("Input take in Qty. at " + i + ",pls!")
            return false;
        }
        //---------------
        if ( grdTakeinItems.GetGridData(i,G1_TIN_WAREHOUSE_PK) == "")
        {
            alert("Input Warehouse at " + i + ",pls!")
            return false;
        }
        //---------------
        if ( grdTakeinItems.GetGridData(i,G1_item_group) != "0" && grdTakeinItems.GetGridData(i,G1_test_no) == "")
        {
            alert("Input Test No at "+i+" ,pls !");
            return false;
        }
        if ( grdTakeinItems.GetGridData(i,G1_item_group) != "0" && grdTakeinItems.GetGridData(i,G1_Lot_No) == "")
        {
            alert("Input Lot No at "+i+" ,pls !");
            return false;
        }
    }
    //----------------
    return true;
}

//---------------------------------------------------------------------------------------------------

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G1_TakeIn_Qty || col == G1_Item_Price || col == G1_Amount )
    {
        var dQuantiy ;
        
        dQuantiy =  grdTakeinItems.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdTakeinItems.SetGridText( row, col, parseFloat(dQuantiy+"").toFixed(2));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdTakeinItems.SetGridText( row, col, "");
            }
        }
        else
        {
            grdTakeinItems.SetGridText(row,col,"") ;
        }     
    }
    //----------------------Calculate Amount -----
    if ( col == G1_TakeIn_Qty || col == G1_Item_Price )
    {
        dQuantiy = grdTakeinItems.GetGridData( row, G1_TakeIn_Qty) ;
        dPrice   = grdTakeinItems.GetGridData( row, G1_Item_Price) ;
        
        if(dQuantiy!=""&& dPrice!="")
        {    
            var dAmount = dQuantiy * dPrice;
            
            grdTakeinItems.SetGridText( row, G1_Amount, parseFloat(dAmount+"").toFixed(2));
        }
        else
        {
            grdTakeinItems.SetGridText( row, G1_Amount,"");
        }            
    }    
    //----------------------
}
//----------------------------------------------------------------------------------------
function OnChangeType()
{
    if(lstTIType.value == '01')
    {
        btnGetFreeItem.style.display="none"; 
        btnGetPOItem.style.display=""; 
    }
    else
    {
        btnGetFreeItem.style.display=""; 
        btnGetPOItem.style.display="none"; 
    }
    
}
//----------------------------------------------------------------------------------------
function OnPrint() 
{
//     var para1 ="",para2="",para3="",para4="",para5="";
//     if(grdTakeinItems.rows>1)
//     {
//        para1=grdTakeinItems.GetGridData(1,G1_TCO_ITEM_PK);
//        para2=grdTakeinItems.GetGridData(1,G1_Item_Code);
//        para3=grdTakeinItems.GetGridData(1,G1_Item_Name);
//     }
//        para4=txtDeptCode.text;
//        para5=txtSupplierPK.text;
//        
//     var fpath = System.RootURL + "/form/sh/mm/shmm00060.aspx?para1="+para1+'&para2='+para2+'&para3='+para3+'&para4='+para4+'&para5='+para5;
//     var object = System.OpenModal( fpath , 750 , 500 , 'resizable:yes;status:yes'); 
}
//----------------------------------------------------------------------------------------
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
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }

</script>

<body>
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_shmm00040" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" parameter="0,1" function="inv.sp_sel_shmm00040" > 
                <input> 
                    <input bind="txtNoSearch" /> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
                    <input bind="txtPartner" />
                </input> 
                <output bind="grdVouchers" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------------->
    <gw:data id="data_shmm00040_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="inv.sp_sel_shmm00040_1"  procedure="inv.sp_upd_shmm00040_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />
                     <inout  bind="cboCompany" />
                     <inout  bind="txtVoucherNo" />
                     <inout  bind="dtVoucherDate" />                          
                     <inout  bind="txtStaffPK" />
                     <inout  bind="txtStaff" />
                     <inout  bind="lstWH" />
                     <inout  bind="txtSupplierPK" />
                     <inout  bind="txtSupplierID" />
                     <inout  bind="txtSupplier" />
                     <inout  bind="txtRemark" />
                     <inout  bind="txtDeptCode" />  
                     <inout  bind="txtDeptName" />  
                     <inout  bind="txtMasterClose" />
                     <inout  bind="lstTIType" />                    
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_shmm00040_2" onreceive="OnDataReceive(this)"> 
        <xml>                                   
            <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25" function="inv.sp_sel_shmm00040_2"   procedure="inv.sp_upd_shmm00040_2"> 
                <input bind="grdTakeinItems">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdTakeinItems" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_fpab00220_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="prod.sp_sel_fpab00220_2" > 
                <input> 
                    <input bind="txtLGGroupCodeID" />
                </input>
	           <output>
	                <output bind="lstTIType" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            No.
                        </td>
                        <td style="width: 79%">
                            <gw:textbox id="txtNoSearch" styles="width: 100%" onenterkey="OnSearch('grdVouchers')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdVouchers')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            Supplier
                        </td>
                        <td style="width: 79%">
                            <gw:textbox id="txtPartner" styles="width: 100%" onenterkey="OnSearch('grdVouchers')" />
                        </td>
                        
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 20%" align="right">
                            Date</td>
                        <td colspan="2" style="white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                    </tr>
                    <tr style="height: 96%">
                        <td colspan="3">
                            <gw:grid id="grdVouchers" header="_PK|Date|Voucher No|Supplier|Dept" format="0|4|0|0|0" aligns="0|1|0|0|0"
                                defaults="||||" editcol="0|0|0|0|0" widths="0|1200|1200|1200|1200" styles="width:100%; height:100%"
                                sorting="T" param="0,1,2" oncellclick="OnSearch('data_shmm00040_1')" autosize="T"/>
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            Company
                        </td>
                        <td style="width: 25%">
                            <gw:list id="cboCompany" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%">
                            <a title="Click here to select Requester" onclick="OnPopUp('Charger')" href="#tips"
                                style="text-decoration: none; color=#0000ff"><b>Charger</b></a>
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtStaff" styles="width:100%" />
                            <gw:textbox id="txtStaffPK" styles="display:none" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Voucher Date
                        </td>
                        <td style="width: 10%">
                            <gw:datebox id="dtVoucherDate" lang="1" />
                        </td>
                        <td style="width: 6%">
                        </td>
                        <td style="width: 1%" align="right">
                            <%--<gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />--%>
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="OnNew()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="OnDelete('Voucher')" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="OnSave('data_shmm00040_1')" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Voucher No
                        </td>
                        <td style="width: 25%">
                            <gw:textbox id="txtVoucherNo" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            Take In WH
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstWH" styles='width:100%' />
                        </td>
                        <td align="right" style="width: 10%">
                            <a title="Click here to select Requester" onclick="OnPopUp('Supplier')" href="#tips"
                                style="text-decoration: none; color: #0000ff"><b>Supplier</b></a>
                        </td>
                        <td colspan="6" style="white-space: nowrap">
                            <gw:textbox id="txtSupplierID" styles="width:30%" readonly="true" />
                            <gw:textbox id="txtSupplier" styles="width:70%;" onenterkey="" />
                            <gw:textbox id="txtSupplierPK" styles="display=none" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" style="width: 10%; white-space: nowrap">
                            <a title="PL" onclick="OnPopUp('Dept')" style="color: #0000ff; cursor: hand"><b>Dept</b></a>
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtDeptCode" styles="width: 30%" />
                            <gw:textbox id="txtDeptName" styles="width: 70%" />
                            <gw:textbox id="txtDeptPK" styles="width: 100%;display: none" />
                        </td>
                        <td align="right">
                            <a onclick="OnPopUp('TIType')" href="#tips" style="color: #0000ff">T/I Type</a>
                        </td>
                        <td style="width: 25%">
                            <gw:list id="lstTIType" styles="width:100%;" onchange="OnChangeType()">
                                <data>
                                    <%=ESysLib.SetListDataSQL("select  code,code_nm  from sale.lg_code a, sale.lg_code_group b  where a.lg_code_group_pk = b.pk and b.group_id = 'LGPO2001' and a.code <>'03' and a.use_if = 'Y' and a.del_if = 0 and b.del_if = 0 order by a.def_yn desc, ord")%>
                                </data>
                            </gw:list>
                        </td>
                        <td colspan="5">
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 10%" align="right">
                            Remark
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                        <td align="right">
                        </td>
                        <td align="center">
                            <gw:label id="lblStatus" styles='width:100%;color:cc0000;font:9pt;align:left;display:none'
                                text='status' />
                        </td>
                        <td align="right">
                        </td>
                        <td align="right">
                            <gw:imgbtn id="btnGetFreeItem" img="popup" alt="Get free Item" text="Get free Item"
                                onclick="OnPopUp('FreeItem')" />
                        </td>
                        <td align="right">
                            <gw:imgbtn id="btnGetPOItem" img="popup" alt="Get item from PO" text="Get Item from PO"
                                onclick="OnPopUp('POItem')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnDeleteItem" img="delete" alt="Delete" text="Delete" onclick="OnDelete('GridItem')" />
                        </td>
                        <td>
                            <gw:imgbtn id="btnUnDelete" img="udelete" alt="Undelete" text="Undelete" onclick="OnUnDelete()" />
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="11">
                            <gw:grid id='grdTakeinItems' header='_TIN_MATTAKEIND_PK|_TIN_MATTAKEIN_PK|_TPR_PURORDD_PK|_TPR_REQIQCD_PK|_No|_TCO_BUSPARTNER_PK|_Supplier|_TakeIn DT|_TIN_WAREHOUSE_PK|P/O No.|_TCO_ITEM_PK|Item Code|Item Name|UOM|Receipt Qty|U/Price|Amount|Lot No|Test No|_tin_whloc_pk|Loc ID|_CCY|Description|_rout_pk|_takein_type|_item_group'
                                defaults='|||||||||||||||||||||||||' format='0|0|0|0|0|0|0|4|0|0|0|0|0|0|-6|-0|-0|0|0|0|0|0|0|0|0|0'
                                aligns='0|0|0|0|0|0|0|1|0|0|0|0|0|1|3|3|3|0|0|0|0|0|0|0|0|0' check='||||||||||||||0n|||||||||||'
                                editcol='0|0|0|0|0|0|0|1|0|0|0|0|0|0|1|1|0|1|1|0|0|0|1|0|0|0' widths='0|0|0|0|0|0|1500|1000|0|1500|0|1500|2000|800|1200|1200|1200|1000|1000|0|1000|1000|1000|0|0|0'
                                sorting='T' onafteredit="CheckInput()" styles="width:100%; height:100%" oncelldblclick="OnGridCellDoubleClick(this)"
                                autosize='T' />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="display:none;" />
<!------------------------------------------->
<gw:textbox id="txtComCodeID" styles='width:100%;display:none' />
<gw:textbox id="txtCodeTemp" styles='width:100%;display:none' />
<!------------------------------------------------------------------------------>
<gw:textbox id="txtMasterClose" styles="width:100%; display:none" />
<gw:textbox id="txtLGGroupCodeID" styles='display:none;width:100%' text="LGPO2001" />
<!---------------------------------------------------------------------------------->
<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
    position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
</html>
