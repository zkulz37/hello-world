<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>APPLICATION ENTRY</title>
</head>
<%  ESysLib.SetUser("HR")%>

<script>
var  user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;
var flag;

//-------------------
var G1_PK               = 0 ,
    G1_TPR_POREQ_PK     = 1 ,
    G1_TPR_MATCONS_PK   = 2 ,
    G1_TAC_ABPL_PK      = 3 ,
    G1_NO               = 4 ,
    G1_TPR_WH_PK        = 5 ,
    G1_Warehouse        = 6 ,
    G1_TakeIn_DT        = 7 ,
    G1_tco_itemgrp_pk   = 8 ,
    G1_Grp_Name         = 9
    G1_TCO_ITEM_PK      = 10 ,
    G1_Item_Code        = 11 ,
    G1_Item_Name        = 12 ,
    G1_UOM              = 13 ,
    G1_Spec             = 14 ,
    G1_Req_Qty          = 15 ,
    G1_Unit_Price       = 16 ,
    G1_Amount           = 17 ,
    G1_PO_Qty           = 18 ,
    G1_TakeIn_Qty       = 19 ,
    G1_Description      = 20 ,
    G1_REF_TABLE        = 21 ,
    G1_REF_PK           = 22 ;
    
var G2_no =4,
    G2_status =23;    
    
//-------------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    //---------------------------------- 

    var master_pk = "<%=request.QueryString("master_pk")%>";
    var replicate = "<%=request.QueryString("replicate")%>";
    
    //---------------------------------- 

    //lstStatus.SetEnable(false);
    txtStaffName.SetEnable(false);
    txtProject.SetEnable(false);
    txtMRNo.SetEnable(false);
    //-------------------------
    
    SetGridFormat();
    BindingDataList();
    //----------------------------------            
    //----------------POSCO------------------
    txtEmpPK.text = user_pk
    //----------------POSCO------------------
    //--------------------
    if ( replicate == 'Y' )
    {
        txtReplicateYN.text = 'Y' ;
    }
    else
    {
        txtReplicateYN.text = 'N' ;
    }    
    //=============================
    if ( master_pk != '' )
    {
        txtMasterPK.text = master_pk ;
        data_chlc00020_1.Call("SELECT");        
    }
    else
    {        
        OnNew();
        dso_emp_info.Call();
    }
    //--------------------
}
//---------------------------------------------------------------------  

 function BindingDataList()
 {      
     var data ;
     
     data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM comm.TCO_company  where del_if=0")%>";   
     
     cboCompany.SetDataText(data);
     cboCompany.value = "<%=Session("COMPANY_PK") %>";
     //-----------------------
     
     data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_LOGISTIC_CODE('LGIN0010') FROM DUAL")%>";  
     lstStatus.SetDataText(data);
    
     data = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('PRCP0130','','') FROM DUAL")%>"; 
     lstDeliLoc.SetDataText(data);
     
     data = "<%=ESysLib.SetListDataSQL("SELECT   pk, org_nm FROM comm.tco_org a  WHERE del_if = 0 AND (a.leaf_yn <> 'N' OR a.leaf_yn IS NULL) ORDER BY org_nm")%>"; 
     lstOrg.SetDataText(data);
     //lstOrg.value =''
     //----------------------- 
     
     var data = "<%=ESysLib.SetListDataSQL("SELECT PK, LINE_NAME FROM prod.TPR_LINE Where Del_if=0 ")%>";  
     lstLine.SetDataText(data);               
 }
 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_Req_Qty)       = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_PO_Qty)        = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_TakeIn_Qty)    = "#,###,###,###,###,###.##";
    
    ctr.ColFormat(G1_Unit_Price)    = "#,###,###,###,###,###.##";
    ctr.ColFormat(G1_Amount)        = "#,###,###,###,###,###.##";
 }
//--------------------------------------------------------------------------------------------------
function SetStatus(status)
{
    idBtnSave.SetEnable(false);
    idBtnSubmit.SetEnable(false);   
    lstOrg.SetEnable(false);  
    txtStaffName.SetEnable(false);  
    txtStaffID.SetEnable(false); 
    txtApprover.SetEnable(false); 
   
    switch(status)
    {
        case '10':
            idBtnSave.SetEnable(true);
            idBtnSubmit.SetEnable(true); 
            lbStatus.text = 'Saved';
        break;
        case '20':
            lbStatus.text = 'Submitted';
        break;
        case '30':
            lbStatus.text = 'Approved';
        break;
        case '40':
            idBtnSave.SetEnable(true);
            idBtnSubmit.SetEnable(true);
            lbStatus.text = 'Requestted Information';
        break;
        case '50':
            lbStatus.text = 'Rejected';
        break;
        case '60':
            lbStatus.text = 'Cancel Request';
        break;
        case '70':
            lbStatus.text = 'Revised';
        break;
        case '80':
            lbStatus.text = 'Approved (GA)';
        break;
        case '90':
            idBtnSave.SetEnable(true);
            idBtnSubmit.SetEnable(true);
            lbStatus.text = 'Requestted Information (GA)';
        break;
        case '100':
            lbStatus.text = 'Rejected (GA)';
        break;
        case '110':
            lbStatus.text = 'Ordered';
        break;
        case '120':
            lbStatus.text = 'Delivered';
        break;
        case '130':
            lbStatus.text = 'Distributed';
        break;
    }
     for(i=0; i<grdDetail.rows; i++)
            grdDetail.SetGridText(i, G2_status, lbStatus.text);
}
//--------------------------------------------------------------------------------------------------
function OnPopUp(pos)
{
    switch(pos)
    {
    case 'dept':
        var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
        //var obj = System.OpenModal( fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogHeight:20;edge:sunken;scroll:no;unadorned:yes;help:no');
        if (obj!=null)
        {
            txtUpperDept.text=obj;
            datDeptData.Call()
        }
        break;
     case 'delivery':
         var fpath = System.RootURL + "/form/fp/ab/PopUpChangeCommonCode.aspx?code=PRCP0130";
         var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	         if ( object != null )
	         {	        	                   
	            if(object[0]==1)
	            {
	                txtComCodeID.text = 'PRCP0130';                                                 
                    iCodeID           = object[1];
                    
                    datGetNewCode.Call("SELECT");                
	            }
	            else
	                lstDeliLoc.value = object[1];	            
	         }     
     break;
        case 'Charger':
            var path = System.RootURL + '/form/ch/ae/chae00010_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {
                txtStaffName.text    = obj[2];
                txtStaffID.text    = obj[1];
                txtStaffPK.text  = obj[0];
                lstOrg.value = obj[13];
                dso_emp_info.Call();
            }
        break; 

        case 'Project': // Project
            fpath  = System.RootURL + "/form/bd/dp/bddp00012.aspx";
            oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
            
            if ( oValue != null )
            {
                txtProjectPK.text = oValue[0]; 
                txtProject.text = oValue[2];
            }
        break;
                
        case 'FreeItem':
             var path = System.RootURL + '/form/fp/ab/fpab00070.aspx?group_type=|||||Y';
             var object = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TPR_POREQ_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TCO_ITEM_PK, arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Item_Code,   arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Item_Name,   arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UOM,         arrTemp[5]);//item_uom
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Unit_Price ,         arrTemp[7]);//price
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TakeIn_DT, dtDocDate.value );//expect take in date
                            
                    }		            
             }        
        break;  
        
        case 'Consumption':
             var path = System.RootURL + '/form/fp/ab/fpab00030.aspx';
             var object = System.OpenModal( path , 900 , 600 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow(); 
                                                       
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TPR_POREQ_PK, txtMasterPK.text); //master_pk	    	                                               
                                                        
                            grdDetail.SetGridText( grdDetail.rows-1, G1_NO,             arrTemp[1] );//PO No
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TPR_MATCONS_PK, arrTemp[21]);//Consumption PK	    
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TCO_ITEM_PK, arrTemp[7] );//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Item_Code,   arrTemp[8] );//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Item_Name,   arrTemp[9] );//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UOM,         arrTemp[10]);//item_uom
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Req_Qty, Number(arrTemp[14]) - Number(arrTemp[15]) - Number(arrTemp[16]) ); //Adjust QTY - Booked Qty - MR Qty
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TakeIn_DT, dtDocDate.value );//date                           
                    }		            
             }        
        break;  
         
        case 'CreateItem':
             var path = System.RootURL + '/form/ds/bs/dsbs00012.aspx?purchase_yn=Y';
             var object = System.OpenModal( path , 1000 , 700 ,  'resizable:yes;status:yes');
             if ( object != null )
             {
                    var arrTemp
                    for( var i=0; i < object.length; i++)	  
                    {	
                            arrTemp = object[i];
                                
                            grdDetail.AddRow();                            
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TPR_POREQ_PK, txtMasterPK.text); //master_pk	    	                                               
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TCO_ITEM_PK, arrTemp[0]);//item_pk	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Item_Code,   arrTemp[1]);//item_code	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_Item_Name,   arrTemp[2]);//item_name	    
                            grdDetail.SetGridText( grdDetail.rows-1, G1_UOM,         arrTemp[5]);//item_uom
                            
                            grdDetail.SetGridText( grdDetail.rows-1, G1_TakeIn_DT, dtDocDate.value );//expect take in date
                            
                    }		            
             }        
        break; 
        case 'Approver':
            var path = System.RootURL + '/form/ch/mb/chmb00010_search_emp.aspx?kind=2';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )
            {  
                txtApprover.text    = obj[2];
                txtApproverPK.text  = obj[0];
            }
        break;                                           
    }	       
}

//-------------------------------------------------------------------------------------

function OnGridCellDoubleClick(oGrid)
{
      switch (oGrid.id)         
      {		        
            case "grdDetail" :
            
                var event_col = event.col ;
                var event_row = event.row ;

                if ( event_col == G1_Warehouse && event_row > 0 )
                {
                      
                     var path = System.RootURL + '/form/fp/ab/PopUpGetWareHouse.aspx';
	                 var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
	                 
	                 if ( obj != null )
	                 {
                         grdDetail.SetGridText(event_row, G1_TPR_WH_PK, obj[0] );//tpr_warehouse_pk
                         grdDetail.SetGridText(event_row, G1_Warehouse, obj[2] );//wh_name	                          
                     }	                
                }                
            break;             
      }         
}   
 
//---------------------------------------------------------------------------------------------------
  
function OnNew()
{
    data_chlc00020_1.StatusInsert();
    txtSumQty.text = ''
    txtAmount.text = ''
    
    lstStatus.value = "10";     
    //-------------------------------------------
    cboCompany.value = "<%=Session("COMPANY_PK") %>";

    txtStaffName.text    = "<%=Session("USER_NAME")%>";
    txtStaffPK.text      = "<%=Session("EMPLOYEE_PK")%>";
    txtStaffID.text      = "<%=Session("EMP_ID")%>";
    lstOrg.value        = "<%=Session("DEPT_PK")%>";
    txtApproverPK.text   = txtManager_PK.text;   
    txtApprover.text     = txtManager_NM.text;    

    //------------------------------------------- 
    grdDetail.ClearData();
    
    flag="view"; 
    SetStatus('10');
 
}  

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {    
        case 'grdMaster':
        
            if ( data_chlc00020_1.GetStatus() == 20 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
            }
            else
            {
                data_chlc00020_1.Call("SELECT");
            } 
        break;
        
        case 'grdDetail':            
            data_chlc00020_2.Call("SELECT");
        break;
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_chlc00020_1":   
            SetStatus(lstStatus.value);       
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_TPR_POREQ_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_TPR_POREQ_PK, txtMasterPK.text);
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
       
       case "data_chlc00020_2":
       
            if ( txtReplicateYN.text == 'Y' )
            {
                txtReplicateYN.text = 'N';
                OnCopy();
            }
            for(i=1; i<grdDetail.rows; i++)
            {
                grdDetail.SetGridText(i,G2_no,i);
            }
       break;
       
       case "pro_chlc00020":
            alert(txtReturnValue.text); 
            //-----------
            OnSearch('grdMaster');
        break;
           
       case "pro_chlc00020_3":
            alert(txtReturnValue.text);
            txtMasterPK.text = txtReturnPK.text ;
            
            flag = 'view' ;
            data_chlc00020_1.Call("SELECT");             
       break;
       
       case"datDeptData":          
              obj=lstOrg.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=obj.options.length-1;
       break; 
       case 'dso_emp_info':
            txtApproverPK.text   = txtManager_PK.text;   
            txtApprover.text     = txtManager_NM.text;    
       break;
    }
}

//------------------------------------------------------------------------------------------------

 function OnDelete(index)
 {        
    switch (index)
    {
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_chlc00020_1.StatusDelete();
                data_chlc00020_1.Call();
            }   
        break;

        case 'Detail':
            if(confirm('Do you want to delete this Item?'))
            {
                if ( grdDetail.GetGridData( grdDetail.row, G1_PK ) == '' )
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
//------------------------------------------------------------------------------------- 
 
function OnUnDelete()
{              
     grdDetail.UnDeleteRow();
}
//-------------------------------------------------------------------------------------

function Validate()
{   
    //---------------
    for( var i = 1; i < grdDetail.rows; i++)
    {
        //---------------
        if ( Number(grdDetail.GetGridData(i,G1_Req_Qty)) == 0)
        {
            alert("Input take in Qty. at " + i + ",pls!")
            return false;
        }
        //---------------
    }
    //----------------
    return true;
}

//-------------------------------------------------------------------------------------
function OnSave(pos)
{    
    switch(pos)
    { 
        case 'Master':
            if( Validate() )
            {
                data_chlc00020_1.Call();
                flag='save';
            }            
        break;
        case 'Detail':        
            data_chlc00020_2.Call();
        break;
    }
}

//---------------------------------------------------------------------------------------------------

function CheckInput()
{   
    var col, row
    
    col = event.col
    row = event.row  
    
    if ( col == G1_Req_Qty || col == G1_Unit_Price || col == G1_Amount )
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
        
        //---------CALCULATE AMOUNT----------------
        if ( col == G1_Req_Qty || col == G1_Unit_Price )
        {
            var dAmount;
            
            dAmount = Number(grdDetail.GetGridData( row, G1_Req_Qty )) * Number(grdDetail.GetGridData( row, G1_Unit_Price )) ;
            
            grdDetail.SetGridText( row, G1_Amount, parseFloat(dAmount+"").toFixed(2) ) ;
        }
        //-----------------------------------------    
        TotalAmount()
    }
}
    
//--------------------------------------------------------------------- 

function OnConfirm()
{
    if ( txtMasterPK.text != '' )
    {
        if(lstStatus.value =='30')
        {
            alert("This request is already confirmed!");
            return;
        }    
        pro_chlc00020.Call();
    }
    else
    {
        alert('PLS SELECT SAVED MR !!!');
    }
}
//---------------------------------------------------------------------
function OnCopy()
{
     if ( txtMasterPK.text != '' )
     {
        pro_chlc00020_3.Call()
     }
     else
     {
        alert('PLS SELECT SAVED MR !!!');
     }
}

//------------------------------------
function TotalAmount()
 {
    var sumQty,sumAmount 
    sumQty =0
    sumAmount =0
    for(i=1; i<grdDetail.rows; i++ )
    {
        var dValueQty ,dValueAmount
        
       dValueQty = grdDetail.GetGridData(i,G1_Req_Qty) ;
       
       if ( Number(dValueQty) )
       {
            sumQty = sumQty + parseFloat(dValueQty);
            dValueAmount =  Number(grdDetail.GetGridData(i,G1_Amount))
            sumAmount = sumAmount + dValueAmount;
       }
       
    }
    txtSumQty.text = sumQty.toFixed(3)+""
    txtAmount.text = sumAmount.toFixed(3)+""
 }
</script>

<body>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chlc00020_1" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,19" function="hr.sp_sel_chlc00020_1" procedure="hr.sp_upd_chlc00020_1">
                <input>
                    <inout bind="txtMasterPK" />
                    <inout bind="cboCompany" />
                    <inout bind="txtMRNo" />
                    <inout bind="dtDocDate" />
                    <inout bind="lstStatus" />
                    <inout bind="txtStaffPK" />
                    <inout bind="txtStaffID" />
                    <inout bind="txtStaffName" />                    
                    <inout bind="txtProjectPK" />
                    <inout bind="txtProject" />
                    <inout bind="lstLine" />
                    <inout bind="lstOrg" />
                    <inout bind="lstDeliLoc" />
                    <inout bind="txtAtt01" />
                    <inout bind="txtRemark" />   
                    <inout bind="txtAmount" />
                    <inout bind="txtSumQty" />
                    <inout bind="txtResp" />
                    <inout bind="txtRespCancel" />
                    <inout bind="txtApproverPK" /> 
                    <inout bind="txtApprover" />
                </input>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chlc00020_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="hr" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23" function="hr.sp_sel_chlc00020_2" procedure="hr.sp_upd_chlc00020_2"> 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" />               
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="pro_chlc00020" onreceive="OnDataReceive(this)"> 
        <xml>                                                               
             <dso id="1" type="process"  procedure="hr.sp_pro_chlc00020"> 
                <input> 
			        <input bind="txtMasterPK" />  	
			        <input bind="lstStatus" />  		
			    </input> 
                <output>
                    <output bind="txtReturnValue" /> 
                </output>           
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="datGetNewCode" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="list" procedure="prod.sp_sel_new_commoncode" > 
                <input> 
                     <inout bind="txtMasterPK" />
                </input>
	           <output>
	                <output bind="txtCodeTemp" /> 
	           </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="datDeptData" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!------------------------------------------------------------------>
    <gw:data id="pro_chlc00020_3" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="process"  procedure="hr.sp_upd_chlc00020_3">
                <input> 
			        <input bind="txtMasterPK" />  		
			    </input> 
                <output>
                    <output bind="txtReturnValue" />
                    <output bind="txtReturnPK" />
                </output> 
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------------>
    <gw:data id="dso_emp_info" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_cc_expense_empid" > 
                <input>
                 <input bind="txtStaffPK" />                                       
                </input> 
                <output>
                    <output bind="txtEmployee_ID" />                    
                    <output bind="txtEmployee_NM" />
                    <output bind="txtManager_PK" />
                    <output bind="txtManager_NM" />
                    <output bind="txtJoin_DT" />
                    <output bind="txtDeptPK" />
                    <output bind="txtManager_DEPT" />
                    <output bind="txtBankType" />
                    <output bind="txtAccount" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    <!--------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%">
        <tr style="height: 2%">
            <td align="right" style="width: 10%">
            </td>
            <td style="width: 25%">
            </td>
            <td align="right" style="width: 10%">
            </td>
            <td style="width: 25%">
            </td>
            <td align="right" style="width: 10%">
            </td>
            <td style="width: 10%">
            </td>
            <td style="width: 2%">
                <%--<gw:icon id="idBtnNew" img="in" text="New" styles='width:100%' onclick="OnNew()" />--%>
            </td> 
            <td style="width: 2%" align="right">
                <gw:icon id="idBtnSave" img="in" text="Save" styles='width:100%' onclick="OnSave('Master')" />
            </td>
            <td style="width: 2%">
                <gw:icon id="idBtnSubmit" img="in" text="Submit" styles='width:100%' onclick="OnConfirm()" />
            </td>
            <td style="width: 2%">
            </td>
            <td style="width: 2%">
            </td>
        </tr>
        <tr style="height: 2%">
            <td align="right" style="width: 10%">
                <a title="Click here to select Requester" onclick="OnPopUp('Charger')" href="#tips"
                    style="text-decoration: none; color: #0000ff"><b>Emp ID</b></a>
            </td>
            <td style="width: 25%">
                <gw:textbox id="txtStaffID" styles="width:100%" /> 
            </td>
            <td style="width: 10%" align="right">
                Name</td>
            <td style="width: 25%">
                <gw:textbox id="txtStaffName" styles="width:100%" />
                <gw:textbox id="txtStaffPK" styles="display:none" />
            </td>
            <td align="right" style="width: 10%">
                <b>Department</b>
            </td>
            <td colspan="6">
                <gw:list id="lstOrg" styles="width:100%" />
            </td>
        </tr>
        <tr style="height: 2%">
            <td align="right" style="width: 10%">
                Application No
            </td>
            <td style="width: 25%">
                <gw:textbox id="txtMRNo" styles="width: 100%" csstype="mandatory" />
            </td>
            <td style="width: 10%" align="right">
                <a title="Click here to select Requester" onclick="OnPopUp('Approver')" href="#tips"
                    style="text-decoration: none; color: #0000ff"><b>Approver</b></a></td>
            <td style="width: 25%">  
                <gw:textbox id="txtApprover" styles="width:100%" /><gw:textbox id="txtApproverPK" styles="width:100%;display:none" />
            </td>
            <td align="right" style="width: 10%">
                <a title="Click here to select Deli" onclick="OnPopUp('delivery')" href="#tips" style="text-decoration: none;
                    color: #0000ff"><b>Deli Loc</b></a>
            </td>
            <td colspan="6">
                <gw:list id="lstDeliLoc" styles="width:100%;" />
            </td>
        </tr>
        <tr style="height: 2%">
            <td align="right" style="width: 10%">
                Purpose
            </td>
            <td style="width: 25%" colspan="3">
                <gw:textbox id="txtAtt01" styles="width:100%;" />
            </td>
            <td align="right" style="width: 10%">
                Status
            </td>
            <td colspan="6">
                <gw:label id="lbStatus" styles="width:100%;color:red" />
            </td>
        </tr>
        <tr style="height: 2%">
            <td align="right" style="width: 10%">
                Remark
            </td>
            <td style="width: 25%" colspan="3">
                <gw:textbox id="txtRemark" styles="width:100%;" />
            </td>
            <td align="right" style="width: 10%">
                
            </td>
            <td colspan="6">
            </td>
        </tr>
        <tr style="height: 2%">
            <td style="width: 10%" align="right">
            </td>
            <td>
            </td>
            <td align="right">
                Amount
            </td>
            <td>
                <gw:textbox id="txtAmount" styles="width: 100%;color:Red;border:none" type="number"
                    format="###,###,###.###" />
            </td>
            <td>
            </td>
            <td>
            </td>
            <td style="width: 2%">
            </td>
            <td style="width: 2%">
            </td>
            <td style="width: 2%">
                <gw:imgbtn id="idGetItem" img="popup" alt="Get Item" onclick="OnPopUp('FreeItem')" />
            </td>
            <td style="width: 2%">
                <gw:imgbtn id="btnDeleteDTL" img="delete" alt="Delete" onclick="OnDelete('Detail')" />
            </td>
            <td style="width: 2%">
                <gw:imgbtn id="btnUnDeleteDTL" img="udelete" alt="UnDelete" onclick="OnUnDelete()" />
            </td>
        </tr>
        <tr style="height: 90%">
            <td colspan="11">
                <gw:grid id='grdDetail' header='_PK|_TPR_POREQ_PK|_TPR_MATCONS_PK|_TAC_ABPL_PK|NO|_TPR_WH_PK|_Warehouse|Req Date|_tco_itemgrp_pk|Grp Name|_TCO_ITEM_PK|Item Code|Item Name|UOM|_Spec|Req Qty|U/P|Amount|_PO Qty|_TakeIn Qty|Description|_REF_TABLE|_REF_PK|_status'
                    format='0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' 
                    aligns='0|0|0|0|0|0|0|1|0|0|0|0|0|1|0|3|3|3|3|3|0|0|0|0'
                    editcol='0|0|0|0|1|0|0|1|0|0|0|0|0|0|1|1|0|0|0|0|1|0|0|0' 
                    widths='1000|1000|1000|1000|1000|1000|2000|1200|1000|1500|1000|1500|3000|800|1500|1200|1200|1200|1200|1200|1000|1000|1000|0'
                    sorting='T' onafteredit="CheckInput()" oncelldblclick="OnGridCellDoubleClick(this)"
                    styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtReturnValue" styles="width: 100%;display: none" />
    <gw:textbox id="txtEmpPK" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtComCodeID" styles='width:100%;display:none' />
    <gw:textbox id="txtCodeTemp" styles='width:100%;display:none' />
    <gw:textbox id="txtUpperDept" styles='width:100%;display:none' />
    <!--------------------------------------------------------------------------->
    <gw:list id="cboCompany" styles="width:100%;display:none" />
    <gw:list id="lstStatus" styles="width: 100%;display:none" />
    <gw:list id="lstLine" styles="width:100%;display:none" />
    <gw:textbox id="txtProject" styles="width: 100%;display:none" />
    <gw:textbox id="txtProjectPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtSumQty" styles="display:none" type="number" format="###,###,###.###" />
    <gw:datebox id="dtDocDate" lang="<%=Application("Lang")%>" mode="01" style="display: none" />
    <gw:textarea id="txtRespCancel" styles="display: none" />
    <gw:textarea id="txtResp" styles="display: none" />
    <!--------------------------------------------------------------------------->
    <gw:textarea id="txtReplicateYN" styles="display: none" />
    <gw:textbox id="txtReturnPK" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->    
    <gw:textbox id="txtEmployee_ID" style="display:none" />
    <gw:textbox id="txtEmployee_NM" style="display:none" />
    <gw:textbox id="txtManager_PK" style="display:none" /> 
    <gw:textbox id="txtManager_NM" style="display:none" />
    <gw:textbox id="txtManager_DEPT" style="display:none" />
    <gw:textbox id="txtJoin_DT" style="display:none" />
    <gw:textbox id="txtBankType" style="display:none" />
    <gw:textbox id="txtAccount" style="display:none" />
    <gw:textbox id="txtDeptPK" style="display:none" />
</body>
</html>
