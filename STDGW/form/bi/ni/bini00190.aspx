<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Stock Incoming Request</title>
</head>
<%  
	ESysLib.SetUser(Session("APP_DBUSER"))
    Dim l_user As String
    l_user = ""
%>

<script src="../../../system/lib/ajax.js"></script>

<script language="javascript" type="text/javascript">
//--------------------------------------

var flag;

var G1_PK    = 0 ;

var G2_DETAIL_PK    = 0 ,
    G2_MASTER_PK    = 1 ,
    G2_SEQ          = 2 ,
    G2_REF_NO       = 3 ,
    G2_ST_ITEM_PK   = 4 ,
    G2_ST_CODE      = 5 ,
    G2_ST_NAME      = 6 ,
    G2_ITEM_PK      = 7 ,
    G2_ITEM_CODE    = 8 ,
    G2_ITEM_NAME    = 9 ,
    G2_REQ_QTY_01   = 10 ,
    G2_REQ_UOM_01   = 11 ,
    G2_UNIT_PRICE   = 12 ,
    G2_AMOUNT       = 13 ,
    G2_LOT_NO       = 14 ,
    G2_REMARK       = 15 ;
   
//---------------------------------------------------------
 function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand"){
        left.style.display="none";
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
    else{
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="80%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 
//----------------------------------------------------------------------------------------
function BodyInit()
 {    
    System.Translate(document);  // Translate to language session
	txtUser_PK.text = "<%=Session("USER_PK")%>"  ; 
    txtChargerName.text="<%=Session("USER_NAME")%>"  ; 
    txtChargerPK.text="<%=Session("USER_PK")%>"  ; 
     
    txtChargerName.SetEnable(false);
    txtReqEmpName.SetEnable(false);
    txtVoucherNo.SetEnable(false);
    txtSupplierName.SetEnable(false);
    txtPLName.SetEnable(false);
    //-----------------------------------------
    var now = new Date(); 
    var lmonth, ldate;
    
    ldate = dtFrom.value ;         
    ldate = ldate.substr(0,4) + ldate.substr(4,2) + '01' ;          
    dtFrom.value=ldate ; 
    //-------------------------
    
    BindingDataList();    
    SetGridFormat();       
    OnToggleGrid(); 
    //------------------------- 
    OnAddNew('Master');  
 }
//---------------------------------------------------------------------------------------------------
 function BindingDataList()
 {  
     var data;
     
     data = "<%=ESysLib.SetListDataSQL("SELECT pk, wh_id || ' * ' || wh_name FROM tlg_in_warehouse  where del_if=0 order by wh_id ")%>";   
     cboWH.SetDataText(data);
                    
 }
 
 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    ctr.ColFormat(G2_REQ_QTY_01) = "#,###,###,###,###,###.##";
    ctr.ColFormat(G2_UNIT_PRICE) = "#,###,###,###,###,###.##";
    ctr.ColFormat(G2_AMOUNT)     = "#,###,###,###,###,###.##";
 }

//--------------------------------------------------------------------------------------------------

function OnSearch(pos)
{
    switch (pos)
    {
        case 'grdVouchers':
            data_bini00190.Call("SELECT");
        break;
    
        case 'Master':
        
            if ( data_bini00190_1.GetStatus() == 20 && grdDetail.rows > 1 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
                else
                {
                    if ( grdVouchers.row > 0 )
                    {
                        txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G1_PK );
                    }
                    flag = 'view' ;
                    data_bini00190_1.Call("SELECT");
                }                
            } 
            else
            {
                if ( grdVouchers.row > 0 )
                {
                    txtMasterPK.text = grdVouchers.GetGridData( grdVouchers.row, G1_PK );
                }
                else
                {
                    txtMasterPK.text = '' ;
                }
                
                flag = 'view' ;
                data_bini00190_1.Call("SELECT");
            }                               
        break;
        
        case 'grdDetail':            
            data_bini00190_2.Call("SELECT");
        break;
    }
}
//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_bini00190_1": 
            if ( flag == 'save')
            {
                for(var i=0; i<grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G2_MASTER_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G2_MASTER_PK, txtMasterPK.text);
                    }    
                }
                 OnSave('Detail');                
            }
            else
            {
                //---------------------------- 
                OnSearch('grdDetail');   
            }            
        break;
        
        case "data_bini00190_2":
            if ( grdDetail.rows > 1 )
            {
	            grdDetail.SetCellBold( 1, G2_REQ_QTY_01, grdDetail.rows - 1, G2_REQ_QTY_01, true);
                grdDetail.SetCellBold( 1, G2_AMOUNT,     grdDetail.rows - 1, G2_AMOUNT,     true);
	            
                grdDetail.SetCellBold( 1, G2_ITEM_CODE, grdDetail.rows - 1, G2_ITEM_CODE, true);
                grdDetail.SetCellBold( 1, G2_LOT_NO,    grdDetail.rows - 1, G2_LOT_NO,    true);
                
                grdDetail.SetCellBold( 1, G2_REF_NO, grdDetail.rows - 1, G2_REF_NO, true);
                //--------------------------------
            }     
        break;
        
        case 'pro_bini00190':
            alert(txtReturnValue.text);
        break;   
        
        case 'pro_bini00190_2':
            alert(txtReturnValue.text);
        break; 
        case 'pro_bini00190_1':
            alert(txtReturnValue.text);
            flag = 'view' ;
            OnSearch('Master');
        break;         
    }
}
//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
        case 'Requester':
		
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtReqEmpName.text = obj[2];
                txtReqEmpPK.text   = obj[0];
            }
        break;
        
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtChargerName.text = obj[2];
                txtChargerPK.text   = obj[0];
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
        
        case 'Supplier' :
             var path = System.RootURL + "/form/fp/ab/fpab00120.aspx?partner_type=AP";
	         var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	         if ( object != null )
	         {
	            txtSupplierPK.text   = object[0];
                txtSupplierName.text = object[2];                
	         }
        break;
           

    }	       
}
//===================================================================================================
function OnProcess(pos)
{
    switch(pos)
    {
        case 'POP_REQ':
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to make POP Req?'))
                {
                    pro_bini00190.Call();
                } 
            }                       
        break;
        case 'Submit':
            if ( txtMasterPK.text != '' )
            {        
                if ( confirm('Do you want to Submit this Slip ?'))
                {
                    pro_bini00190_1.Call();
                } 
            }  
            else
            {
                alert("Please Select one Slip to Submit !!")
            }                     
        break;
        case 'InCome':
            if ( txtMasterPK.text != '' )
            {        
                if(lbStatus.text=="SUBMITTED")
                {
                    if ( confirm('Do you want to make Income for this Slip ?'))
                    {
                        pro_bini00190_2.Call();
                    }
                }
                else
                {
                    alert("This Slip not yet Submit!");
                } 
            }  
            else
            {
                alert("Please Select one Slip to make Income !!")
            }                     
        break;
    }
}
//===================================================================================================
function OnAddNew(pos)
{
    switch (pos)
    {
        case 'Master':              
            data_bini00190_1.StatusInsert();
            
            txtVoucherNo.text   = '***New Voucher***';
            //-------------------------------------------
            txtChargerName.text = "<%=Session("USER_NAME")%>";
            txtChargerPK.text   = "<%=Session("USER_PK")%>";
            //------------------------------------------- 
            grdDetail.ClearData();
            
            flag = "view";        
        break;  
        
        case 'FreeItem':
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';//purchase_yn=Y
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {                    
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_SEQ, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_MASTER_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_PK,    arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE,  arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME,  arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_UOM_01, arrTemp[5]);//item_uom                          
                    }		            
             }        
        break;
        
        case 'STITEM' :
             var path = System.RootURL + '/form/fp/ab/fpab00210.aspx?group_type=Y|Y|Y|Y|Y|Y';//purchase_yn=Y
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {                    
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_SEQ, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_MASTER_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ST_ITEM_PK, arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ST_CODE,    arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ST_NAME,    arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_UOM_01, arrTemp[5]);//item_uom                          
                    }		            
             }                
        break;  
        
        case 'STOCK':
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=Y|Y|Y|Y|Y|Y';//purchase_yn=Y
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {                    
                    var arrTemp;
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_SEQ, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_MASTER_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_PK,    arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE,  arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME,  arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_UOM_01, arrTemp[5]);//item_uom  
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_QTY_01, "");//qty
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_LOT_NO, "");//lot no                         
                    }		            
             }          
        break;
       
       case 'PO':
             var path = System.RootURL + '/form/fp/ab/fpab00020.aspx?type=INCOME';
             var object = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');
             
             if ( object != null )
             {
                    var arrTemp;
                    
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            

                            grdDetail.SetGridText( grdDetail.rows-1, G2_SEQ, grdDetail.rows-1);
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_MASTER_PK, txtMasterPK.text); //master_pk	    	                                                                          
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REF_NO,  arrTemp[1]);//Ref No  
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_PK,    arrTemp[7]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_CODE,  arrTemp[8]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_ITEM_NAME,  arrTemp[9]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_UOM_01, arrTemp[13]);//item_uom  
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G2_REQ_QTY_01, arrTemp[12]);//qty                            
                            //----------------
                            if ( arrTemp[20] != '' && arrTemp[20] != txtSupplierPK.text && txtSupplierPK.text == '' )
                            {
                                txtSupplierPK.text = arrTemp[20] ;
                            }  
                            //----------------
                            if ( arrTemp[21] != '' && arrTemp[21] != txtPLPK.text && txtPLPK.text == '' )
                            {
                                txtPLPK.text = arrTemp[21] ;
                            }                             
                            //----------------
                            if ( txtRefNo.text != arrTemp[1] && arrTemp[1] != '' )
                            {
                                if ( txtRefNo.text == '' )
                                {
                                    txtRefNo.text = arrTemp[1];
                                } 
                                else
                                {
                                    txtRefNo.text = txtRefNo.text + ',' + arrTemp[1];
                                }   
                            }
                            //-----------------                                                                                            
                    }		            
             }        
        break;       
    }
}
//--------------------------------------------------------------------------------------------------
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_bini00190_1.Call();
                flag='save';
            }            
        break;
        
        case 'Detail':        
            data_bini00190_2.Call();
        break;
    }
}
//-------------------------------------------------------------------------------------
function Validate()
{        
    for(var i=0; i< grdDetail.rows; i++)
    {
        if(Number(grdDetail.GetGridData( i, G2_REQ_QTY_01 ))==0)
        {
            alert("Input req Qty. at " + i + ",pls!")
            return false;
        }
    }
    return true;
}
//--------------------------------------------------------------------------------------------------
function OnUnDelete()
{
    grdDetail.UnDeleteRow();
}
//--------------------------------------------------------------------------------------------------
function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_bini00190_1.StatusDelete();
                data_bini00190_1.Call();
            }   
        break;

        case 'Detail':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdDetail.GetGridData( grdDetail.row, G2_DETAIL_PK ) == '' )
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

//------------------------------------------------------------------------------------------
function OnPrint()
{
    if(txtMasterPK.text=="")
    {
        alert("Please select Voucher !!!");
    }
    else
    {
        //var url = System.RootURL + "/system/ReportEngine.aspx?export_pdf=Y&file=ep/fm/rpt_bini00190.rpt&procedure=INV.sp_rpt_bini00190_1|INV.sp_rpt_bini00190_2&parameter=" + txtMasterPK.text +"|"+ txtMasterPK.text;   
        
        var url =System.RootURL + '/reports/ep/fm/rpt_bini00190.aspx?p_master_pk='+ txtMasterPK.text;
        window.open(url);          
    }
}
 
//-----------------------------------------------

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G2_REQ_QTY_01 || col == G2_UNIT_PRICE || col == G2_AMOUNT )
    {
        var dQuantiy
        
        dQuantiy =  grdDetail.GetGridData(row,col) ;
        
        if (Number(dQuantiy))
        {   
            if (dQuantiy >0)
            {
                grdDetail.SetGridText(row,col,parseFloat(dQuantiy+"").toFixed(2));
            }
            else
            {
                alert(" Value must greater than zero !!");
                grdDetail.SetGridText(row,col,"");
            }
        }
        else
        {
            grdDetail.SetGridText(row,col,"") ;
        }                     
    }
    //----------------------Calculate Amount -----
    if ( col == G2_REQ_QTY_01 || col == G2_UNIT_PRICE )
    {
        dQuantiy = grdDetail.GetGridData( row, G2_REQ_QTY_01) ;
        dPrice   = grdDetail.GetGridData( row, G2_UNIT_PRICE) ;
        
        if(dQuantiy!=""&& dPrice!="")
        {    
            var dAmount = dQuantiy * dPrice;
            
            grdDetail.SetGridText( row, G2_AMOUNT, parseFloat(dAmount+"").toFixed(2));
        }
        else
        {
            grdDetail.SetGridText( row, G2_AMOUNT,"");
        }            
    }    
    //----------------------    
}

 //=======================================================================================
  
function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                /*var event_col = event.col ;
                var event_row = event.row ;

                 if ( event_col == G2_REQ_UOM_01 )
                 {
                       var path = System.RootURL + '/form/fp/ab/fpab00230.aspx';
	                   var obj = System.OpenModal( path ,550 , 500, 'resizable:yes;status:yes');
    	               
	                   if ( obj != null )
	                   {
	                        grdDetail.SetGridText( event_row, event_col, obj[1]);
	                   }	
                 }*/
            break;             
      }         
}   
//======================================================================
function OnToggleGrid()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";

		grdDetail.GetGridControl().ColHidden(G2_ST_CODE) = true ;
		grdDetail.GetGridControl().ColHidden(G2_ST_NAME) = true ;
		
        imgMaster.src = "../../../system/images/iconmaximize.gif";
		imgMaster.alt="Show all column";
		
    }
    else
    {
        imgMaster.status = "expand";
        
		grdDetail.GetGridControl().ColHidden(G2_ST_CODE) = false;
		grdDetail.GetGridControl().ColHidden(G2_ST_NAME) = false ;
		
        imgMaster.src = "../../../system/images/close_popup.gif";
		imgMaster.alt="Hide unuse column";
    }
}
//=======================================================================================

</script>

<body>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bini00190" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bini00190" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bini00190_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bini00190_1" > 
                <input>
                    <input bind="txtMasterPK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!---------------------------------------------------------------->
    <gw:data id="pro_bini00190_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="<%=l_user%>lg_pro_bini00190_2" > 
                <input>
                    <input bind="txtMasterPK" /> 
                    <input bind="txtUser_PK" /> 
                </input> 
                <output>
                    <output bind="txtReturnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!-----------------------grdVouchers---------------------------------------->
    <gw:data id="data_bini00190" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1" function="<%=l_user%>lg_sel_bini00190" > 
                <input> 
                    <input bind="txtNoSearch" /> 
                    <input bind="dtFrom" /> 
                    <input bind="dtTo" /> 
					<input bind="txtUser_PK" />
					<input bind="chkUser" />
                </input> 
                <output bind="grdVouchers" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_bini00190_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" function="<%=l_user%>lg_sel_bini00190_1"  procedure="<%=l_user%>lg_upd_bini00190_1"> 
                <inout>             
                     <inout  bind="txtMasterPK" />                     
                     <inout  bind="txtVoucherNo" />
                     <inout  bind="txtChargerPK" />
                     <inout  bind="txtChargerName" />
                     <inout  bind="dtVoucherDate" />
                     <inout  bind="txtSupplierPK" />
                     <inout  bind="txtSupplierName" />
                     <inout  bind="cboWH" />
                     <inout  bind="txtReqEmpPK" /> 
                     <inout  bind="txtReqEmpName" />  
                     <inout  bind="txtRemark" />                     
                     <inout  bind="lbStatus" />
                     <inout  bind="txtPLPK" />
                     <inout  bind="txtPLName" />
                     <inout  bind="txtRefNo" />
                </inout>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="data_bini00190_2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="<%=l_user%>lg_sel_bini00190_2"   procedure="<%=l_user%>lg_upd_bini00190_2"> 
                <input bind="grdDetail">                    
                    <input bind="txtMasterPK" /> 
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td id="left" style="width: 25%">
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 20%">
                            Date
                        </td>
                        <td style="width: 79%; white-space: nowrap">
                            <gw:datebox id="dtFrom" lang="1" width="10%" />
                            ~
                            <gw:datebox id="dtTo" lang="1" width="10%" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="OnSearch('grdVouchers')" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 20%">
                            No.
                        </td>
                        <td colspan="1">
                            <gw:textbox id="txtNoSearch" style="width: 100%" onenterkey="OnSearch('grdVouchers')" />
                        </td>
                        <td>
                            <gw:checkbox id="chkUser" styles="color:blue" defaultvalue="Y|N" value="Y" onchange="OnSearch('grdVouchers')">User
							</gw:checkbox>
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td colspan="3">
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 1%">
                                    <td style="width: 10%">
                                        <gw:icon id="idBtnIncome" img="2" text="InCome" styles='width:100%' onclick="OnProcess('InCome')" />
                                    </td>
                                    <td style="width: 50%">
                                    </td>
                                    <td style="width: 40%">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 96%">
                        <td colspan="3">
                            <gw:grid id="grdVouchers" header="_PK|Date|Voucher No|Ref No" format="0|4|0|0" aligns="0|0|0|0"
                                defaults="|||" editcol="0|0|0|0" widths="0|1200|1200|1200" styles="width:100%; height:100%"
                                sorting="T" param="0,1,2,3" oncellclick="OnSearch('Master')" />
                        </td>
                    </tr>
                </table>
            </td>
            <td id="right" style="width: 75%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td align="right" style="width: 5%; white-space: nowrap">
                            Voucher No
                        </td>
                        <td style="width: 30%">
                            <gw:textbox id="txtVoucherNo" onkeypress="ChangeUpper()" csstype="mandatory" styles="width:100%;" />
                        </td>
                        <td align="right" style="width: 5%">
                            Date
                        </td>
                        <td style="width: 15%">
                            <gw:datebox id="dtVoucherDate" lang="1" />
                        </td>
                        <td style="width: 5%">
                        </td>
                        <td style="width: 30%" align="center">
                            <gw:label id="lbStatus" styles='width:100%;color:cc0000;font:9pt;align:left' text='status' />
                        </td>
                        <td style="width: 5%">
                            <gw:icon id="idBtnSubmit" img="2" text="Submit" styles='width:100%' onclick="OnProcess('Submit')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:icon id="idBtnPOPREQ" img="2" text="POP Req" styles='width:100%' onclick="OnProcess('POP_REQ')" />
                        </td>
                        <td style="width: 1%" align="right">
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint()" />
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
                    <tr>
                        <td align="right" style="width: 5%">Charger</td>
                        <td colspan="3">
                            <gw:textbox id="txtChargerName" styles="width:100%" />
                            <gw:textbox id="txtChargerPK" styles="display:none" />
                        </td>
                        <td style="width: 5%" align="right">&nbsp;</td>
                        <td style="width: 25%" colspan="7">&nbsp;</td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%; white-space: nowrap">
                            <a title="PL" onclick="OnPopUp('PL')" style="color: #0000ff; cursor: hand"><b>P/L</b></a>
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtPLName" styles="width: 100%" />
                            <gw:textbox id="txtPLPK" styles="width: 100%;display: none" />
                        </td>
                        <td align="right" style="width: 5%">
                            W/H
                        </td>
                        <td colspan="7">
                            <gw:list id="cboWH" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 5%">
                            <a title="Supplier" onclick="OnPopUp('Supplier')" href="#tips" style="text-decoration: none;
                                color=#0000ff">Supplier</a>
                        </td>
                        <td colspan="3">
                            <gw:textbox id="txtSupplierPK" styles="width:100%;display:none" />
                            <gw:textbox id="txtSupplierName" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 5%">
                            Ref No
                        </td>
                        <td colspan="7">
                            <gw:textbox id="txtRefNo" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td style="width: 10%" align="right">
                            Remark</td>
                        <td style="width: 25%" colspan="11">
                            <gw:textbox id="txtRemark" styles="width:100%;" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td colspan="12">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                    <td align="center" style="width: 1%">
                                        <img status="expand" id="imgMaster" alt="Show all column" src="../../../system/images/close_popup.gif"
                                            style="cursor: hand" onclick="OnToggleGrid()" />
                                    </td>
                                    <td style="width: 94%">
                                    </td>
                                    <td align="right" style="width: 1%">
                                        <gw:icon id="idBtnPO" img="2" text="P/O" styles='width:100%' onclick="OnAddNew('PO')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="idBtnItem" img="2" text="Item" styles='width:100%' onclick="OnAddNew('FreeItem')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:icon id="idBtnSTItem" img="2" text="ST Item" styles='width:100%' onclick="OnAddNew('STITEM')" />
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
                    <tr style="height: 94%">
                        <td colspan="12">
                            <gw:grid id='grdDetail' header='_PK|_ST_OUTGO_REQ_M_PK|Seq|Ref No|_ST_ITEM_PK|ST Code|ST Name|_ITEM_PK|Item Code|Item Name|Req Qty|UOM|U/P|Amount|Lot No|Description'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|1|0|0|0|0|0|0|0|3|1|3|3|0|0'
                                check='||||||||||0n|||||' editcol='0|0|1|1|0|0|0|0|0|0|1|0|1|1|1|1' widths='0|0|800|1500|0|2000|2500|0|2000|2500|1200|1000|1200|1200|1500|1000'
                                sorting='T' styles='width:100%; height:100%' onafteredit="CheckInput()" oncelldblclick="OnGridCellDoubleClick(this)" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
<!------------------------------------------------------------------------------------>
<gw:textbox id="txtMasterPK" styles="width:100%; display:none" onenterkey="" />
<gw:textbox id="txtUser_PK" styles="width: 100%;display: none" />
<gw:textbox id="txtReturnValue" styles="width:100%; display:none" onenterkey="" />
<gw:textbox id="txtReqEmpName" styles="display=none" />
<gw:textbox id="txtReqEmpPK" styles="display=none" />
<!------------------------------------------------------------------------------------>
</html>
