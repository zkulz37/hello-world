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
    G1_DESCRIPTION      = 12,
    G1_FSTATUS          = 13,
    G1_IS_PARTICIPATE   = 14;
    
    //_PK|App No|Course Name|Require DT
var G2_PK               = 0,
    G2_APP_NO           = 1,
    G2_COURSE_NAME      = 2,
    G2_REQUIRE_DT       = 3,
    G2_STATUS           = 4,
    G2_PK_STATUS        = 5;
    
//-------------------------------------------------------------------

function BodyInit()
{
    System.Translate(document);  // Translate to language session
    //---------------------------------- 

    txtMasterPK.text = "<%=Request.QueryString("master_pk")%>";
    var replicate = "<%=request.QueryString("replicate")%>";
    Approver_PK.text = "<%=Session("EMPLOYEE_PK")%>"
    //---------------------------------- 

    txtAppNo.SetEnable(false);
    txtCourseName.SetEnable(false);
    txtInstitution.SetEnable(false);
    txtLocation.SetEnable(false);
    txtReqEmpID.SetEnable(false);
    txtReqEmp.SetEnable(false);
    lstDept.SetEnable(false);
    lstGroup.SetEnable(false);
    //lstStatus.SetEnable(false);
    txtApproverID.SetEnable(false);
    txtApprover.SetEnable(false);
    lstMandantory.SetEnable(false);
    idBtnApp.SetEnable(0);
    idBtnRej.SetEnable(0);
    idBtnCancel.SetEnable(0);
    //-------------------------
    
    SetGridFormat();
    BindingDataList();

    //----------------------------------            
    //----------------POSCO------------------
    txtReqEmpPK.text = user_pk
    //----------------POSCO------------------
    
    dtReqDT.SetEnable(0);
    dtReqDT.value ="";
    lstDept.value ="";
    

        
}
//---------------------------------------------------------------------  

 function BindingDataList()
 {      
     var data ;
    
      
     //-----------------------             
     data = "<%=ESysLib.SetListDataSQL("select pk,org_id ||'-'|| org_nm from comm.tco_org a where  del_if=0 order by org_nm")%>"; 
     lstDept.SetDataText(data);

     //-----------------------      
     data = "<%=ESysLib.SetListDataSQL("select 'Y','YES' from dual union all select 'N','NO' from dual ")%>"; 
     lstMandantory.SetDataText(data);
     //-----------------------             
            
     var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0090' and nvl(num_1,0)=1 ")%>";
       grdDetail.SetComboFormat(G1_STATUS,t1);
 }
 //---------------------------------------------------------------------------------------------------
 function SetGridFormat()
 {
    var ctr = grdDetail.GetGridControl(); 
    
    ctr.ColFormat(G1_PLAN_COST)       = "###,###.##";
 }
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//--------------------------------------------------------------------------------------------------
function SetStatus(status)
{ 
    lstDept.SetEnable(false);     
    txtReqEmp.SetEnable(false);  
    txtReqEmpID.SetEnable(false); 
    txtApprover.SetEnable(false); 
   
    

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
            }
        break;    
        case 'Request':
            var path = System.RootURL + '/form/ch/kr/chkr00090_course.aspx';
            var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )      
            {  
                
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
            //alert(txtMasterPK.text);        
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
            
            var SumApp = 0;
            for(i=1; i<grdDetail.rows; i++)
            {
                grdDetail.SetGridText(i,G1_No,i);
                if(grdDetail.GetGridData(i, G1_STATUS)=="50") // reject
                     grdDetail.SetCellBgColor(i,1,i ,grdDetail.cols-1, 0x99FFFF );
                     
                if(grdDetail.GetGridData(i, G1_STATUS)=="30") // appro
                     SumApp++;
            }
           
            
            idRecord.text = grdDetail.rows-1 +" Record(s)"
            auto_resize_column(grdDetail,0,grdDetail.cols-1,10); 
            
            idlbStatus.text = "Status";
            idStatus.text = lstStatus.GetText(); 
              
            idBtnCancel.SetEnable(0);
            if(lstStatus.value != "100")
            {
              idBtnRej.SetEnable(0);
              idBtnApp.SetEnable(0);
              
              if(lstStatus.value == "30"){
                idBtnCancel.SetEnable(SumApp);
                if(SumApp > 0){
                    if(grdDetail.GetGridData(1, G1_IS_PARTICIPATE) == "1")
                        idBtnCancel.SetEnable(0);
                }
              }
            }  
            else 
            {
              idBtnRej.SetEnable(1);
              idBtnApp.SetEnable(1);
            }
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
       {
            if(lstStatus.value=="30")
                OnSave('Detail');
            data_chkr00060_1.Call('SELECT');
       }
       break;
       case 'datCourse':
       {
            auto_resize_column(grdCourse,0,grdCourse.cols-1,10);
            for(i=1; i<grdCourse.rows; i++)
            {
                 if(grdCourse.GetGridData(i,G2_PK_STATUS)=="50") // reject
                     grdCourse.SetCellBgColor(i,1,i ,grdCourse.cols-1, 0x99FFFF );
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
function OnSelectEmp()
{
    if(grdCourse.row > 0)
    {
       var tranee_pk = grdCourse.GetGridData(grdCourse.row, G2_PK);
       
       if(CheckExist(tranee_pk) == false && lstStatus.value == '10')
       {
           
            grdDetail.AddRow();
            grdDetail.SetGridText(grdDetail.rows-1, G1_No, grdDetail.rows-1);
            grdDetail.SetGridText(grdDetail.rows-1, G1_TRAINEE_PK   , grdCourse.GetGridData(grdCourse.row, G2_PK));
            grdDetail.SetGridText(grdDetail.rows-1, G1_EMP_ID       , grdCourse.GetGridData(grdCourse.row, G2_EMP_ID));
            grdDetail.SetGridText(grdDetail.rows-1, G1_EMP_NAME     , grdCourse.GetGridData(grdCourse.row, G2_FULL_NAME));
            grdDetail.SetGridText(grdDetail.rows-1, G1_TCO_DEPT_PK  , grdCourse.GetGridData(grdCourse.row, G2_TCO_DEPT_PK));
            grdDetail.SetGridText(grdDetail.rows-1, G1_DEPT_NM      , grdCourse.GetGridData(grdCourse.row, G2_DEPT_NM));
            grdDetail.SetGridText(grdDetail.rows-1, G1_THR_GROUP_PK , grdCourse.GetGridData(grdCourse.row, G2_THR_GROUP_PK));
            grdDetail.SetGridText(grdDetail.rows-1, G1_TEAM_SECTION , grdCourse.GetGridData(grdCourse.row, G2_GROUP_NM));

            idRecord.text = grdDetail.rows-1 +" Record(s)"
        }
        else if(lstStatus.value != '10')
           {
                alert("Course has submited."); 
           }
        else 
            alert("Employee " + grdCourse.GetGridData(grdCourse.row, G2_FULL_NAME) + " was selected.");
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
    
}

//-----------------------------------------------------------------------------------
function OnApprove()
{   
    if(confirm("Do you want to approve?\nBạn muốn chấp nhận?"))
    {
        lstStatus.value = '30'      // Manager Approve
        data_chkr00060_6.Call();
    }
}
//-----------------------------------------------------------------------------------
function OnReject()
{   
    if(confirm("Do you want to reject?\nBạn muốn từ chối?"))
    {
        lstStatus.value = '50'      // Manager Reject
        data_chkr00060_6.Call();
    }
}
//-----------------------------------------------------------------------------------
function OnCancel()
{   
    if(confirm("Do you want to cancel?\nBạn muốn từ chối?"))
    {
        data_chkr00060_1.Call();
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
function CheckReject()
 {
    if(grdDetail.col == G1_STATUS && grdDetail.GetGridData(grdDetail.row, G1_STATUS)=="50") // reject
        grdDetail.SetCellBgColor(grdDetail.row,1,grdDetail.row ,grdDetail.cols-1, 0x99FFFF );
    else grdDetail.SetCellBgColor(grdDetail.row,1,grdDetail.row ,grdDetail.cols-1, 0xFFFFFF );
 }
 //------------------------------------
 function CheckCancel(){
    if((lstStatus.value == "30" && grdDetail.GetGridData(grdDetail.row, G1_FSTATUS) == "50") || (lstStatus.value == "30" && grdDetail.GetGridData(grdDetail.row, G1_FSTATUS) != "50" && grdDetail.GetGridData(grdDetail.row, G1_IS_PARTICIPATE) != "0")){
        grdDetail.row = -1;
    }
 }
 //------------------------------------
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
 function OnClick()
 {
    if(grdCourse.rows>0)
    {
        txtMasterPK.text    = grdCourse.GetGridData(grdCourse.row, G2_PK);
        data_chkr00060.Call('SELECT');
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
           <dso id="4" type="grid" user="prod" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="hr.sp_sel_chkr00060_1_M" procedure="hr.sp_upd_chkr00060_1_M"> 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" />               
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!--------------------------------------------------------------------------->
    <gw:data id="datCourse" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod" function="HR.sp_sel_course_approve" > 
                <input bind="grdCourse">
                    <input bind="Approver_PK" />             
                    <input bind="dtFrom" />
                    <input bind="dtTo" />
                    <input bind="txtCourse" />
                    <input bind="lstStatusApp" />
                </input> 
                <output bind="grdCourse" /> 
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
            <dso  type="process" procedure="hr.sp_pro_chkr00060_6_M" > 
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
    
    <table style="width: 100%; height: 100%" border="1">
        <tr>
            <td style="width: 30%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 1%">
                        <td align="right" style="width: 10%">
                            Require Date &nbsp;
                        </td>
                        <td colspan="2" style="width: 90%" nowrap>
                            <table style="width: 100%; height: 100%">
                                <tr style="height: 100%">
                                    <td style="width: 40%">
                                        <gw:datebox id="dtFrom"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
                                    </td>
                                    <td style="width: 10%">
                                        ~
                                    </td>
                                    <td style="width: 40%">
                                        <gw:datebox id="dtTo"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    <tr style="height: 1%">
                        <td align="right" style="width: 30%; white-space: nowrap">
                            Application No/Name &nbsp;
                        </td>
                        <td colspan=2 width="80%">
                            <gw:textbox id="txtCourse" onenterkey="data_chkr00060_2.Call('SELECT');"/>
                        </td>
                         
                    </tr>
                    <tr style="height: 1%">
                        <td align="right" style="width: 30%; white-space: nowrap">
                            Status &nbsp;
                        </td>
                        <td width="79%">
                            <gw:list id="lstStatusApp" styles="width:100%" value="30" >
                                 <data>
                                        <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0090' and nvl(num_1,0) = 1 order by code_nm")%>|ALL|Select All
                                 </data>
					    </gw:list>
                        </td>
                         <td width="1%" align="right">
                            <gw:imgBtn id="idSearch" img="search" text="Search" styles='width:100%' onclick="datCourse.Call('SELECT');" />
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="3">
                            <gw:grid id='grdCourse' header='_PK|App No|Course Name|Require DT|Status|_PK_STATUS'
                                format='0|0|0|0|0|0' aligns='0|0|0|0|0|0' defaults='|||||' editcol='0|0|0|0|0|0'
                                widths='0|1200|2000|1200|1200|0' sorting='T' oncellclick="OnClick()"
                                styles='width:100%; height:100%'  />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 70%">
                <table style="width: 100%; height: 100%">
                    <tr style="height: 2%">
                        <td colspan="6">
                            <table style="width: 100%; height: 100%">
                                <tr>
                                   <td align="right" style="width: 10%">
                                        <gw:label id="idlbStatus" styles="width:100%;font-weight: bold" text=""></gw:label>
                                    </td>
                                     <td align="center" style="width: 30%">
                                         <gw:label id="idStatus" styles="width:100%;color:red;font-weight: bold" text=""></gw:label>
                                    </td>
                                    <td align="center" style="width: 52%">
                                    <td style="width: 2%" align="right"> 
                                        
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:imgBtn id="idBtnPopup" img="popup" alt="Find Application" text="Search" styles='width:100%' onclick="OnPopUp('Request')" />
                                    </td>
                                    <td style="width: 2%" align="right">
                                        <gw:icon id="idBtnRej" img="in" text="Reject" styles='width:100%' onclick="OnReject()" />
                                    </td>
                                    <td style="width: 2%">
                                        <gw:icon id="idBtnApp" img="in" text="Approve" styles='width:100%' onclick="OnApprove()" />
                                    </td>
                                    <td style="width: 2%">
                                        <gw:icon id="idBtnCancel" img="in" text="Save" styles='width:100%' onclick="OnCancel()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%" nowrap>
                            <b>Application No</b>
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
                            <b>Approver</b></td>
                        <td style="width: 30%; white-space: nowrap">
                            <gw:textbox id="txtApproverPK" styles="width:100%;display:none" />
                            <gw:textbox id="txtApproverID" styles="width:30%" />
                            <gw:textbox id="txtApprover" styles="width:70%" />
                        </td>
                    </tr>
                    <tr style="height: 2%">
                        <td align="right" style="width: 10%">
                            <b>Course Name</b></td>
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
                                    <td align="right" style="width: 17%">
                                        
                                    </td>
                                    <td style="width: 10%">
                                        <gw:label id="idRecord" styles="width:100%;color:red;font-weight: bold" text="0 record(s)"></gw:label>
                                    </td>
                                    <td style="width: 1%">
                                    </td>
                                    <td style="width: 1%">
                                        
                                    </td>
                                    <td style="width: 1%">
                                        
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 90%">
                        <td colspan="11">
                            <gw:grid id='grdDetail' 
                                header='_PK|_THR_TRAIN_REQ_PK|No|_TRAINEE_PK|Emp ID| Emp Name|_TCO_DEPT_PK|Department|_THR_GROUP_PK|Team/Section|_Plan Cost|Status|Description|_FStatus|_is_participate'
                                format='0|0|0|0|0|0|0|0|0|0|0|2|0|0|0' 
                                aligns='0|0|0|0|0|0|0|0|0|0|3|1|0|0|0' 
                                defaults='||||||||||||||'
                                editcol='0|0|1|0|0|0|0|0|0|0|1|1|1|0|0' 
                                widths='1000|1000|1000|1000|1500|3000|1000|2000|1000|2000|1500|1500|1000|0|0'
                                sorting='T' 
                                onafteredit="CheckReject()"
                                onbeforeedit="CheckCancel()"
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

    <gw:textbox id="Approver_PK" style="display:none" />
    
    <gw:list id="lstStatus" styles="display:none" >
         <data>
                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0090' and nvl(num_1,0) = 1 order by code_nm")%>
         </data>
	</gw:list>
</body>
</html>
