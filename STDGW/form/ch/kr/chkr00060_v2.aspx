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
    
var G1_PK               = 0,
    G1_THR_TRAIN_REQ_PK = 1,
    G1_No               = 2,
    G1_TRAINEE_PK       = 3,
    G1_EMP_ID           = 4,
    G1_EMP_NAME         = 5,
    G1_TCO_DEPT_PK      = 6,
    G1_DEPT_NM          = 7,
    G1_THR_GROUP_PK     = 8,
    G1_TEAM_SECTION     = 9,
    G1_PLAN_COST        = 10,
    G1_STATUS           = 11,
    G1_START_DT         = 12,
    G1_END_DT           = 13,
    G1_DESCRIPTION      = 14;
    
var G2_PK               = 0,
    G2_EMP_ID           = 1,
    G2_FULL_NAME        = 2,
    G2_TCO_DEPT_PK      = 3,
    G2_DEPT_NM          = 4,
    G2_THR_GROUP_PK     = 5,
    G2_GROUP_NM         = 6;
    G2_COURSE_PK        = 7;
    
//-------------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    //---------------------------------- 

    txtMasterPK.text = "<%=Request.QueryString("master_pk")%>";
    var replicate = "<%=request.QueryString("replicate")%>";
    
    //---------------------------------- 

    txtAppNo.SetEnable(false);
    txtCourseName.SetEnable(false);
    txtInstitution.SetEnable(false);
    txtLocation.SetEnable(false);
    txtReqEmpID.SetEnable(false);
    txtReqEmp.SetEnable(false);
    lstDept.SetEnable(false);
    lstGroup.SetEnable(false);
    lstStatus.SetEnable(false);
    txtApproverID.SetEnable(false);
    txtApprover.SetEnable(false);
    //-------------------------
    
    SetGridFormat();
    BindingDataList();

    lstDeptSearch.value = "<%=Session("DEPT_PK")%>";
    //lstDeptSearch.SetEnable(0);
    
    //----------------------------------            
    //----------------POSCO------------------
    txtReqEmpPK.text = user_pk
    //----------------POSCO------------------
    if(txtMasterPK.text != ""){
        data_chkr00060.Call("SELECT");
    }
    else{
        OnNew();
        data_chkr00060_4.Call();
    }

    if(txtAppNo.text=="")
    {
        idBtnSubmit.SetEnable(0);
        idlbStatus.text = "";
        idStatus.text = "";
    }
    else 
    {
        idBtnSubmit.SetEnable(1);
        idlbStatus.text = "Status";
        idStatus.text = lstStatus.text;
    }
        
}
//---------------------------------------------------------------------  

 function BindingDataList()
 {      
     var data ;
    
     //-----------------------
     data = "<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0090' order by code_nm")%>";
     lstStatus.SetDataText(data);     
     //-----------------------             
     data = "<%=ESysLib.SetListDataSQL("select pk,org_id ||'-'|| org_nm from comm.tco_org a where  del_if=0 order by org_nm")%>"; 
     lstDept.SetDataText(data);
     
     lstDeptSearch.SetDataText(data + "|ALL|Select All");  
     lstDeptSearch.value = 'ALL';
     
     //-----------------------      
     data = "<%=ESysLib.SetListDataSQL("select 'Y','YES' from dual union all select 'N','NO' from dual ")%>"; 
     lstMandantory.SetDataText(data);
     //-----------------------             
            
 }
 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_PLAN_COST)       = "###,###.##";
 }
//--------------------------------------------------------------------------------------------------
function SetStatus(status)
{
    idBtnSave.SetEnable(false);
    btnDeleteDTL.SetEnable(false);
    idBtnSubmit.SetEnable(false);   
    lstDept.SetEnable(false);     
    txtReqEmp.SetEnable(false);  
    txtReqEmpID.SetEnable(false); 
    txtApprover.SetEnable(false); 
   
    switch(status)
    {
        case '10':
            idBtnSave.SetEnable(true);
            btnDeleteDTL.SetEnable(true);
            idBtnSubmit.SetEnable(true);
        break;
        case '20':
            
        break;
        case '30':
            
        break;
        case '70':
            idBtnSave.SetEnable(true);
            btnDeleteDTL.SetEnable(true);
            idBtnSubmit.SetEnable(true);            
        break;        
        case '80':
            idBtnSave.SetEnable(true);
            btnDeleteDTL.SetEnable(true);
            idBtnSubmit.SetEnable(true);            
        break;        
    }

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
                txtReqEmp.text   = obj[2];
                txtReqEmpID.text     = obj[1];
                txtReqEmpPK.text     = obj[0];
                lstDept.value       = obj[13];
                lstGroup.value      = obj[14];
                txtApproverPK.text  = obj[15];  
                txtApproverID.text  = obj[16];
                txtApprover.text    = obj[17]; 
                //data_chkr00060_3.Call();
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
             var path = System.RootURL + '/form/fp/ab/PopUpGetItem.aspx?purchase_yn=Y';
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
                txtApproverID.text  = obj[1];
                txtApproverPK.text  = obj[0];
            }
        break;    
        case "AppNo":           
            var fpath = System.RootURL + "/form/ch/kr/chkr00060_AppNo_code.aspx?idcode=Training";
            var obj  = System.OpenModal(  fpath , 900 , 450 , 'resizable:yes;status:yes');
        break;          
        case 'Course':
            var path = System.RootURL + '/form/ch/kr/chkr00061.aspx?';
            var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )      
            {  
                txtCoursePK.text    = obj[0];
                txtCourseName.text  = obj[3];
                txtInstitution.text = obj[9];
                txtLocation.text    = obj[10];

                data_chkr00060_2.Call("SELECT");
            }
        break;    
        case 'Request':
            var path = System.RootURL + '/form/ch/kr/chkr00062.aspx';
            var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )      
            {  
                idBtnNew.SetEnable(true);
                txtMasterPK.text    = obj[0];
                data_chkr00060.Call('SELECT');
            }
        break;                          
    }	       
}
//-------------------------------------------------------------------------------------
function OnNew()
{
    data_chkr00060.StatusInsert();
   
    lstStatus.value = "10";     
    //-------------------------------------------

    txtReqEmp.text       = "<%=Session("USER_NAME")%>";
    txtReqEmpPK.text     = "<%=Session("EMPLOYEE_PK")%>";
    txtReqEmpID.text     = "<%=Session("EMP_ID")%>";
    lstDept.value        = "<%=Session("DEPT_PK")%>";
    txtApproverPK.text   = txtManager_PK.text;   
    txtApproverID.text   = txtManager_ID.text;   
    txtApprover.text     = txtManager_NM.text;    

    //------------------------------------------- 
    grdDetail.ClearData();
    
    flag="view"; 
    SetStatus('10');
    idBtnNew.SetEnable(false);
}  

//-------------------------------------------------------------------------------------
function OnSearch(pos)
{
    switch (pos)
    {    
        case 'grdMaster':
        
            if ( data_chkr00060.GetStatus() == 20 )
            {
                if ( confirm('Do you want to save first !!!'))
                {
                    OnSave('Master');
                }
            }
            else
            {
                data_chkr00060.Call("SELECT");
            } 
        break;
        
        case 'grdDetail':            
            data_chkr00060_1.Call("SELECT");
        break;
    }
}

//--------------------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "data_chkr00060":   
            SetStatus(lstStatus.value);       
            if ( flag == 'save')
            {
                for(var i=0; i < grdDetail.rows;i++)
                {
                    if ( grdDetail.GetGridData( i, G1_THR_TRAIN_REQ_PK) == '' )
                    {
                        grdDetail.SetGridText( i, G1_THR_TRAIN_REQ_PK, txtMasterPK.text);
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
       
       case "data_chkr00060_1":
       
            if ( txtReplicateYN.text == 'Y' )
            {
                txtReplicateYN.text = 'N';
                OnCopy();
            }
            for(i=1; i<grdDetail.rows; i++)
            {
                grdDetail.SetGridText(i,G1_No,i);
            }
            
            idRecord.text = grdDetail.rows-1 +" Record(s)"     
            auto_resize_column(grdDetail,0,grdDetail.cols-1,10);   

            idlbStatus.text = "Status";
            idStatus.text = lstStatus.GetText();                   
            OnChangeDept();
            //data_chkr00060_2.Call('SELECT');
       break;
       
       case "pro_chkr00060":
            alert(txtReturnValue.text); 
            //-----------
            OnSearch('grdMaster');
        break;
       
       case"datDeptData":          
              obj=lstDept.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=obj.options.length-1;
       break; 
       case 'data_chkr00060_4':
            txtApproverPK.text   = txtManager_PK.text;  
            txtApproverID.text   = txtManager_ID.text;
            txtApprover.text     = txtManager_NM.text;
            OnChangeDept();  
            data_chkr00060_2.Call('SELECT');
       break;
       case 'data_chkr00060_6':
            idBtnSubmit.SetEnable(false);  
            idBtnSave.SetEnable(false);
            btnDeleteDTL.SetEnable(false);
            lstStatus.value = '100';

            data_chkr00060_1.Call('SELECT');


       break;
       case 'data_chkr00060_2':
            for(var i=0;i<grdEmp.rows; i++)
                {
                    if(grdEmp.GetGridData(i, G2_COURSE_PK) == txtCoursePK.text && txtCoursePK.text !="")
                    {
                        grdEmp.SetCellBgColor(i,G2_PK,i ,G2_COURSE_PK,0x3366FF);
                    }
                }

       break;
       case 'datcheck_exist':
       { 
            if(txtFlag_Exist.text =="Y")
            {
                alert("This trainee has exist in this course.\n Nhân viên này đã tồn tại trong khóa đào tạo này.");
                return;
            }
            else
            {
                if(CheckExist(txtTrainee_PK.text) == false && lstStatus.value == '10')
                   {
           
                        grdDetail.AddRow();
                        grdDetail.SetGridText(grdDetail.rows-1, G1_No, grdDetail.rows-1);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_TRAINEE_PK   , grdEmp.GetGridData(grdEmp.row, G2_PK));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_EMP_ID       , grdEmp.GetGridData(grdEmp.row, G2_EMP_ID));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_EMP_NAME     , grdEmp.GetGridData(grdEmp.row, G2_FULL_NAME));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_TCO_DEPT_PK  , grdEmp.GetGridData(grdEmp.row, G2_TCO_DEPT_PK));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_DEPT_NM      , grdEmp.GetGridData(grdEmp.row, G2_DEPT_NM));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_THR_GROUP_PK , grdEmp.GetGridData(grdEmp.row, G2_THR_GROUP_PK));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_TEAM_SECTION , grdEmp.GetGridData(grdEmp.row, G2_GROUP_NM));

                        idRecord.text = grdDetail.rows-1 +" Record(s)"
                    }
                    else if(lstStatus.value != '10')
                       {
                            alert("Course has submited."); 
                       }
                    else 
                        alert("Employee " + grdEmp.GetGridData(grdEmp.row, G2_FULL_NAME) + " was selected.");
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
        case 'Master':// delete master
            if(confirm('Do you want to delete this Voucher?'))
            {
                flag='delete';
                data_chkr00060.StatusDelete();
                data_chkr00060.Call();
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
                idRecord.text = grdDetail.rows-1 +" Record(s)"
            }            
        break;     
    }     
}
//---------------------------------------------------------------------------------------
function OnSelectEmp(obj)
{
    if(txtCourseName.text =="")
    {
        alert("You have to choose course name.\nBạn phải chọn khóa đào tạo.");
        return;
    }
    else
    {
        if(obj=="1")
        {
            if(grdEmp.row > 0)
            {
               txtTrainee_PK.text = grdEmp.GetGridData(grdEmp.row, G2_PK);
               datcheck_exist.Call();
            }
        }
        else if(obj=="2")
        { 
           var ctrl=grdEmp.GetGridControl();
            for(var i=1; i<= ctrl.SelectedRows; i++)
            {
                if(grdEmp.GetGridData(ctrl.SelectedRow(i-1),G2_COURSE_PK) == txtCoursePK.text)
                {
                    alert("Employee "+ grdEmp.GetGridData(ctrl.SelectedRow(i-1),G2_FULL_NAME) +" has exist in this course.\n Mã nhân viên "+ grdEmp.GetGridData(ctrl.SelectedRow(i-1),G2_FULL_NAME) +" đã tồn tại trong khóa đào tạo này.");
                    return;
                }
                else 
                { 
                    
                    txtTrainee_PK.text = grdEmp.GetGridData(ctrl.SelectedRow(i-1), G2_PK);
                    if(CheckExist(txtTrainee_PK.text) == false && lstStatus.value == '10')
                    {
           
                        grdDetail.AddRow();
                        grdDetail.SetGridText(grdDetail.rows-1, G1_No, grdDetail.rows-1);
                        grdDetail.SetGridText(grdDetail.rows-1, G1_TRAINEE_PK   , grdEmp.GetGridData(ctrl.SelectedRow(i-1), G2_PK));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_EMP_ID       , grdEmp.GetGridData(ctrl.SelectedRow(i-1), G2_EMP_ID));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_EMP_NAME     , grdEmp.GetGridData(ctrl.SelectedRow(i-1), G2_FULL_NAME));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_TCO_DEPT_PK  , grdEmp.GetGridData(ctrl.SelectedRow(i-1), G2_TCO_DEPT_PK));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_DEPT_NM      , grdEmp.GetGridData(ctrl.SelectedRow(i-1), G2_DEPT_NM));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_THR_GROUP_PK , grdEmp.GetGridData(ctrl.SelectedRow(i-1), G2_THR_GROUP_PK));
                        grdDetail.SetGridText(grdDetail.rows-1, G1_TEAM_SECTION , grdEmp.GetGridData(ctrl.SelectedRow(i-1), G2_GROUP_NM));

                        idRecord.text = grdDetail.rows-1 +" Record(s)"
                    }
                    else if(lstStatus.value != '10')
                       {
                            alert("Course has submited."); 
                            return;
                       }
                    else 
                        alert("Employee " + grdEmp.GetGridData(ctrl.SelectedRow(i-1), G2_FULL_NAME) + " was selected.");
                }
            }
           
        }
     }
}

//-------------------------------------------------------------------------------------

function Validate()
{   
//    if(txtdatetmp.value > dtReqDT.value)
//    {
//        alert("The require date must be greater now!!");
//        return false;
//    }
    
    if(txtCoursePK.text == '')
    {
        alert("Select a course please!!");
        return false;
    }
    //---------------
    if(grdDetail.rows <=1)
    {
        alert("Please select Employee to train!!");
        return;
    } 
//    for( var i = 1; i < grdDetail.rows; i++)
//    {
//        //---------------
//        if ( Number(grdDetail.GetGridData(i,G1_PLAN_COST )) == 0)
//        {
//            alert("Input Plan cost at " + i + ",pls!")
//            return false;
//        }
//    }
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
                data_chkr00060.Call();
                flag='save';
            }            
        break;
        case 'Detail':        
            data_chkr00060_1.Call();
        break;
    }
    idBtnNew.SetEnable(true);
}

//-----------------------------------------------------------------------------------

function OnConfirm()
{   
    if ( txtMasterPK.text != '' )
    {
        if(lstStatus.value !='10')
        {
            alert("This request is already submitted!");
            return;
        }   
        if(grdDetail.rows <=1)
        {
            alert("Please select Employee to train!!");
            return;
        } 
        else
        {
            for(i=1; i< grdDetail.rows ;i++)
            {
                if(grdDetail.GetGridData(i, G1_PK) =='')
                {
                    alert("You haven't saved!Please click save first!!");
                    return;
                }
            }
        }
        
        data_chkr00060_6.Call();
    }
    else
    {
        alert('PLS SELECT SAVED REQUEST!!!');
    }
}
//---------------------------------------------------------------------
function OnCopy()
{
     if ( txtMasterPK.text != '' )
     {
        pro_chkr00060_3.Call()
     }
     else
     {
        alert('PLS SELECT SAVED MR !!!');
     }
}

//------------------------------------
function TotalAmount()
 {
    var dValueAmount=0;
      
    for(i=1; i<grdDetail.rows; i++ )
    {       
       if ( !isNaN(grdDetail.GetGridData(i,G1_PLAN_COST)) )
       {         
            dValueAmount = Number(dValueAmount) + Number(grdDetail.GetGridData(i,G1_PLAN_COST));
       }       
    }
   // txtPlanCost.text = ''+ dValueAmount;//.toFixed(3)+"";
 }
 function OnChangeDept(){
   // data_chkr00060_3.Call();
 }
 function CheckExist(p_tranee_pk)
 {
    for(var i=1;i<grdDetail.rows;i++){
        if(grdDetail.GetGridData(i,G1_TRAINEE_PK) == p_tranee_pk){
            return true;
        }
    }
    return false;
 }
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
function OnShowPopup(o)
{
        if(o=='1')
        {
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
            if (obj!=null)
            { 
                lstDeptSearch.value = obj;
            }
        }
}
</script>

<body>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chkr00060" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18" function="hr.sp_sel_chkr00060" procedure="hr.sp_upd_chkr00060">
                <input>
                    <inout bind="txtMasterPK" /> 
                    <inout bind="txtAppNo" />
                    <inout bind="dtReqDT" />
                    <inout bind="txtCoursePK" />
                    <inout bind="txtCourseName" />
                    <inout bind="txtInstitution" />
                    <inout bind="txtLocation" />
                    <inout bind="txtReqEmpPK" />                    
                    <inout bind="txtReqEmpID" />
                    <inout bind="txtReqEmp" />
                    <inout bind="lstDept" />
                    <inout bind="lstGroup" />
                    <inout bind="lstStatus" />
                    <inout bind="lstMandantory" />
                    <inout bind="txtApproverPK" />   
                    <inout bind="txtApproverID" /> 
                    <inout bind="txtApprover" />
                    <inout bind="txtReason" />
                </input>
            </dso>
        </xml>
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chkr00060_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod" parameter="0,1,2,3,4,5,6,7,8,9,10,12" function="hr.sp_sel_chkr00060_1" procedure="hr.sp_upd_chkr00060_1"> 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" />               
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chkr00060_2" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod" function="hr.sp_sel_chkr00060_2" > 
                <input bind="grdEmp">
                    <input bind="lstDeptSearch" />    
                    <input bind="txtCoursePK" />         
                    <input bind="txtEmp" />
                </input> 
                <output bind="grdEmp" /> 
            </dso> 
        </xml> 
    </gw:data>    
    
 
    <!--------------------------------------------------------------------------->
    <gw:data id="data_chkr00060_4" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_approver" > 
                <input>
                 <input bind="txtReqEmpPK" />                                     
                </input> 
                <output>
                    <output bind="txtManager_PK" />
                    <output bind="txtManager_ID" />
                    <output bind="txtManager_NM" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    
    <!------------------------------------------------------------------------>
    <gw:data id="data_chkr00060_6" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_chkr00060_6" > 
                <input>
                 <input bind="txtMasterPK" />  
                 <input bind="lstStatus" />                                    
                </input> 
                <output>
                    <output bind="txtRtnValue" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="datcheck_exist" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="HR.sp_pro_check_exist_train" > 
                <input>
                    <input bind="txtTrainee_PK" />    
                    <input bind="txtCoursePK" />                                 
                </input> 
                <output>
                    <output bind="txtFlag_Exist" />
                </output>
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td style="width: 10%">
                            <a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Organization</a>
                        </td>
                        <td colspan="3" style="width: 90%" nowrap>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 100%">
                                    <td style="width: 100%" >
                                        <gw:list id="lstDeptSearch" styles="width:100%" onchange="OnChangeDept()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    <tr style="height: 1%">
                        <td style="width: 30%; white-space: nowrap">
                            EmpID/Name
                        </td>
                        <td width="58%">
                            <gw:textbox id="txtEmp" onenterkey="data_chkr00060_2.Call('SELECT');"/>
                        </td>
                         <td width="1%">
                            <gw:imgBtn id="idSearch" img="search" text="Search" styles='width:100%' onclick="data_chkr00060_2.Call('SELECT');" />
                        </td>
                        <td width="1%">
                            <gw:imgBtn id="btnSelect" img="select" alt="Search item" onclick="OnSelectEmp(2)" />
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="4">
                            <gw:grid id='grdEmp' header='_PK|Emp ID|Emp Name|_TCO_DEPT_PK|_DEPT_NM|_THR_GROUP_PK|_GROUP_NM|_COURSE_PK'
                                format='0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0' defaults='|||||||' editcol='1|1|1|1|1|1|1|0'
                                widths='1000|1500|2000|1000|1000|1500|1000|1500' sorting='T' oncelldblclick="OnSelectEmp(1)"
                                styles='width:100%; height:100%'  />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td colspan="6">
                            <table style="width: 100%; height: 100%" >
                                <tr>
                                    <td align="right" style="width: 10%">
                                        <gw:label id="idlbStatus" styles="width:100%;font-weight: bold" text=""></gw:label>
                                    </td>
                                     <td align="center" style="width: 30%">
                                         <gw:label id="idStatus" styles="width:100%;color:red;font-weight: bold" text=""></gw:label>
                                    </td>
                                    <td align="center" style="width: 52%">
                                         
                                    </td>
                                    <td style="width: 2%" align="right"> 
                                        <gw:imgBtn id="idBtnPopup" img="popup" alt="Find Application" text="Search" styles='width:100%' onclick="OnPopUp('Request')" />
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:imgBtn id="idBtnNew" img="new" alt="Add New" text="New" styles='width:100%' onclick="OnNew('Master')" />
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:imgBtn id="idBtnSave" img="save" text="Save" styles='width:100%' onclick="OnSave('Master')" />
                                    </td>
                                    <td style="width: 2%">
                                        <gw:icon id="idBtnSubmit" img="in" text="Submit" styles='width:100%' onclick="OnConfirm()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%" nowrap>
                            <a title="Click here to select Application No formula" onclick="OnPopUp('AppNo')" href="#tips"
                                style="text-decoration: none; color: #0000ff">
                                <b>
                                    Application No
                                </b>
                            </a>
                        </td>
                        <td style="width: 20%">
                            <gw:textbox id="txtAppNo" styles="width: 100%" csstype="mandatory" />
                        </td>
                        <td align="right" style="width: 10%">
                            Require Date</td>
                        <td align="left" style="width: 20%">
                            <gw:datebox id="dtReqDT" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 10%" align="right">
                            Requester
                        </td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtReqEmpPK" styles="display:none" /> 
                            <gw:textbox id="txtReqEmpID" styles="width:30%" />
                            <gw:textbox id="txtReqEmp" styles="width:70%" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%">
                            <b>Department</b>
                        </td>
                        <td align="right" style="width: 20%">
                            <gw:list id="lstDept" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 10%">
                            Team/Section</td>
                        <td align="right" style="width: 20%">
                            <gw:list id="lstGroup" styles="width:100%" />
                        </td>
                        <td style="width: 10%" align="right">
                            <a title="Click here to select Requester" onclick="OnPopUp('Approver')" href="#tips"
                                style="text-decoration: none; color: #0000ff"><b>Approver</b></a></td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtApproverPK" styles="width:100%;display:none" />
                            <gw:textbox id="txtApproverID" styles="width:30%" />
                            <gw:textbox id="txtApprover" styles="width:70%" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%">
                            <a title="Click here to select Course" onclick="OnPopUp('Course')" href="#tips"
                                style="text-decoration: none; color: #0000ff"><b>Course Name</b></a></td>
                        <td>
                            <gw:textbox id="txtCoursePK" styles="width: 100%;display: none" />
                            <gw:textbox id="txtCourseName" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 10%">
                            Institution</td>
                        <td>
                            <gw:textbox id="txtInstitution" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 10%">
                            Location</td>
                        <td>
                            <gw:textbox id="txtLocation" styles="width:100%" />
                        </td>
                    </tr>
                    <tr style="height: 10%">
                        <td align="right">
                            Mandatory
                        </td>
                        <td>
                            <gw:list id="lstMandantory" styles="width:100%" />
                        </td>
                        <td align="right" style="width: 10%" rowspan="2">
                            Reason</td>
                        <td colspan="3" rowspan="2">
                            <gw:textarea id="txtReason" styles="width:100%;height:99%" />
                        </td>
                    </tr>
                    <tr style="height: 10%">
                        <td align="right">
                           
                        </td>
                        <td>
                            
                        </td>
                        <td align="right" style="width: 10%">
                           </td>
                        <td colspan="3">
                            
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td colspan="6">
                            <table>
                                <tr>
                                    <td colspan="2" align="left" style="width: 10%">
                                        
                                    </td>
                                    
                                    <td align="right" style="width: 10%">
                                       </td>
                                    <td align="right" style="width: 20%">
                                        
                                    </td>
                                    <td align="right" style="width: 10%">
                                        </td>
                                    <td align="right" style="width: 20%">
                                        <gw:label id="idRecord" styles="width:100%;color:red;font-weight: bold" text="0 record(s)"></gw:label>
                                    </td>
                                    <td style="width: 7%">
                                    
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 1%">
                                        
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteDTL" img="delete" alt="Delete" onclick="OnDelete('Detail')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 90%">
                        <td colspan="11">
                            <gw:grid id='grdDetail' header='_PK|_THR_TRAIN_REQ_PK|No|_TRAINEE_PK|Emp ID| Emp Name|_TCO_DEPT_PK|Department|_THR_GROUP_PK|Team/Section|_Plan Cost|Status|Start DT|End DT|Description'
                                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|3|1|1|1|0' defaults='||||||||||||||'
                                editcol='0|0|1|0|0|0|0|0|0|0|1|0|0|0|1' widths='1000|1000|1000|1000|1500|3000|1000|2000|1000|2000|1500|1500|1000|1000|1000'
                                sorting='T' onafteredit="TotalAmount()" oncelldblclick="OnGridCellDoubleClick(this)"
                                styles='width:100%; height:100%' />
                        </td>
                    </tr>                    
                </table>
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtReplicateYN" style="display:none" />
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtManager_PK" style="display:none" />  
    <gw:textbox id="txtManager_ID" style="display:none" />
    <gw:textbox id="txtManager_NM" style="display:none" /> 
    <gw:textbox id="txtGroupList" style="display:none" />
    <gw:textbox id="txtRtnValue" style="display:none" />
    <gw:datebox id="txtdatetmp" style="display:none" />
    <gw:textbox id="txtTrainee_PK" style="display:none" />
    <gw:textbox id="txtFlag_Exist" style="display:none" />
    <gw:list id="lstStatus" style="display:none" />
    
</body>
</html>
