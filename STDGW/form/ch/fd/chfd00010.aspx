<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var b_status="";
var b_search=false;
var binit=true;
var value_before;
function BodyInit()
{        
  
   SetDisableInit();
   grdTrans_Exp.GetGridControl().ColFormat(3) = "(###,###,###.##)";   
   grdOther_Exp.GetGridControl().ColFormat(2) = "(###,###,###.##)"; 
     
   <%=ESysLib.SetGridColumnComboFormat("grdCompanion",0,"select code,CODE_NM from vhr_hr_code where id='HR0061' order by code_nm") %>
   <%=ESysLib.SetGridColumnComboFormat("grdOther_Exp",0,"select code,CODE_NM from vhr_hr_code where id='HR0062' order by code_nm") %>
   <%=ESysLib.SetGridColumnComboFormat("grdTrans_Exp",2,"select code,CODE_NM from vhr_hr_code where id='HR0063' order by code_nm") %>   
   OnReset();
   SetGridHeader(grdSchedule);
   txtEmp_PK.text="<%=session("EMPLOYEE_PK")%>";
   txtMaker.text="<%=session("EMPLOYEE_PK")%>";
   txtApplicant_PK.text="<%=Request.querystring("p_biz_trip_pk")%>";
   if (txtApplicant_PK.text!="")
        datApplicant.Call("SELECT");       
   else
      datBiz_Emp_Infor.Call();
}
//------------------------
function SetDisableInit()
{
   txtEmp_ID.SetEnable(false);
   txtFull_Name.SetEnable(false);
   txtDepartment.SetEnable(false);
   txtApprover_ID.SetEnable(false);
   txtApprover_Name.SetEnable(false);
   txtOther_Sum.SetEnable(false);
   txtTrans_Sum.SetEnable(false);
   SetEnableButton(false);
   ibtnApprove.SetEnable(false);
   ibtnReplicate.SetEnable(false);
   txtTotal_Expenses.SetEnable(false);
   txtCost_Center.SetEnable(false);
   txtCost_Acc_Code.SetEnable(false);
   txtCost_Acc_Name.SetEnable(false);
   ibtnDelete.SetEnable(false);
   txtNight_Day.SetEnable(false);
   txtApp_Type_T.SetEnable(false);
   txtApp_Status_T.SetEnable(false);
}
function SetGridHeader(obj)
{
    var stt;
    var fg=obj.GetGridControl(); 
    if (binit==true)
        fg.rows=fg.rows+1;
    fg.FixedRows = 2;
    fg.FixCols=1;
    fg.MergeCells =5 ;
    stt=0;//num column
    fg.MergeCol(stt) =true ;
    fg.Cell(0, 0, stt, 1, stt) = "From"; //fg.Cell(0,row, from_col, row, to_col) 
    fg.MergeCol(stt+1) =true ;
    fg.Cell(0, 0, stt+1, 1, stt+1) = "To"; 
    fg.MergeRow(0) =true ;
    fg.Cell(0, 0, 2, 0, 3) = "Departure";
    fg.Cell(0, 1, 2, 1, 2) = "Country";
    fg.Cell(0, 1, 3, 1, 3) = "City";
    fg.Cell(0, 0, 4, 0, 5) = "Arrival";
    fg.Cell(0, 1, 4, 1, 4) = "Country";
    fg.Cell(0, 1, 5, 1, 5) = "City";
    fg.MergeCol(6) =true ;
    fg.Cell(0, 0,6, 1, 6) = "Plan"; 
    obj.SetCellBold(1,0,1,6,true);
    binit=false
}
//-------------------------------------------------
function SetEnableButton(b)
{
    
    ibtnExcel.SetEnable(b);
    ibtnApprove.SetEnable(b);
    ibtnAdd_C.SetEnable(b);
    ibtnAdd_S.SetEnable(b);
    ibtnAdd_T.SetEnable(b);
    ibtnAdd_O.SetEnable(b);
    ibtnSave_C.SetEnable(b);
    ibtnSave_S.SetEnable(b);
    ibtnSave_T.SetEnable(b);
    ibtnSave_O.SetEnable(b);
    ibtnDelete_C.SetEnable(b);
    ibtnDelete_S.SetEnable(b);
    ibtnDelete_T.SetEnable(b);
    ibtnDelete_O.SetEnable(b);
}
//-------------------------------------------------
function OnNew()
{
    OnReset();
}
//--------------------------------------------------
function OnReset()
{
    datApplicant.StatusInsert();
    txtEmp_PK.text="";
    txtApplicant_PK.text="";
    txtEmp_ID.text="";
    txtFull_Name.text="";
    txtDepartment.text="";
    txtTelephone.text="";
    txtApprover_PK.text="";
    txtApprover_ID.text="";
    txtApprover_Name.text="";
    txtTotal_Expenses.text="";
    grdCompanion.ClearData();
    grdSchedule.ClearData();
    grdTrans_Exp.ClearData();
    grdOther_Exp.ClearData();
    txtTrans_Sum.text="";
    txtOther_Sum.text="";
    SetEnableButton(false);
    ibtnAdd.SetEnable(false);
    ibtnSave.SetEnable(true);
}
//-------------------------------------------------
function OnSave()
{
    
        if (txtApplicant_PK.text=="")
        {
            if (CheckSave())
            {
                if (confirm("Do you want to insert new data? \n Bạn có muốn tạo mới thông tin?"))
                {
                    b_status="Insert";
                    datApplicant.Call();
                }
            }
        }
        else
        {
            if (confirm("Do you want to save data? \n Bạn có muốn cập nhật thông tin?"))
            {
                b_status="Update";
                datApplicant.StatusUpdate();
                datApplicant.Call();
            }
        }
}
//------------------------------------------
function OnDelete()
{
    datApplicant.StatusDelete();
    datApplicant.Call();
}
//------------------------------------------
function OnSearch()
{
    var fpath = System.RootURL + "/form/ch/fd/chfd00010_search_biz_trip.aspx?emp_id=" + txtEmp_ID.text;
    var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	if (obj!=null)
	{
	    txtApplicant_PK.text=obj[0];
	    b_status="";
	    SetEnableButton(true);
	    datApplicant.Call("SELECT");
	}
}
//------------------------------------------
function OnShowPopup(objid)
{
    switch (objid)
    {
        case 1:
        {
            var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
            var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	        if (obj!=null)
	        {
                txtEmp_PK.text=obj[0];
                txtEmp_ID.text=obj[1];
                txtFull_Name.text=obj[2];
                txtDepartment.text=obj[4];
                txtApprover_PK.text=obj[15];
                txtApprover_ID.text=obj[16];
                txtApprover_Name.text=obj[17];
                
	        }
	        break;
	    }
	    case 2:
	    {
	        var strcom
            var fpath = System.RootURL + "/form/ch/fd/chfd00020_search_emp.aspx";
            var obj  = System.OpenModal(  fpath , 800 , 500 , 'resizable:yes;status:yes');
            if (obj!=null)
	        {
                txtApprover_PK.text=obj[0];
                txtApprover_ID.text=obj[1];
                txtApprover_Name.text=obj[2];
	        }
            break;
        }
        case 3:
	    {
	        var strcom
            var fpath = System.RootURL + "/form/ch/fd/chfd00010_emp_id_code.aspx?idcode=BIZ";
            var obj  = System.OpenModal(  fpath , 900 , 450 , 'resizable:yes;status:yes');
            break;
        }
        case 5:
	    {
	        var fpath = System.RootURL + "/form/gf/co/ffco002000.aspx?comm_nm=" + "" + "&comm_code=" + "" + "&comm_nm2=" + "" + "&val1=" + '' + "&val2=" + '' + "&val3=" + txtCompany.text + '' + "&dsqlid=ACNT.SP_SEL_ACCT_PARTNER";
            var obj = System.OpenModal( fpath , 550 , 550 , 'resizable:yes;status:yes'); 
            if ((obj != null) &&(obj[0]!="0"))
            {
                txtCost_Acc_PK.text=obj[3];//pk
                txtCost_Acc_Code.text=obj[0];//code
                txtCost_Acc_Name.text=obj[1];//name
                
            }
        }
    }    
}
//--------------------------------------------------
function OnDelete()
{
    if (confirm("Do you want to delete this infor? \n Bạn muốn xóa thông tin này?"))
    {
        b_status="Delete";
        b_delete="true";
        datApplicant.StatusDelete();
        datApplicant.Call();
    }
}

//--------------------------------------------------
function OnDataReceive(obj)
{   
    switch(obj.id)
    {
        case "datApplicant":
        {
            ibtnAdd.SetEnable(true);
            if (b_status=="Insert")
            {
                SetEnableButton(true);
                ibtnApprove.SetEnable(true);
                if (txtApplicant_PK.text!="")
                    alert("Insert Successful! \n Tạo mới thành công");
                else
                    alert("Insert fail! \n Tạo mới thất bại");
                b_status="";
            }
            else if (b_status=="Update")
            {
                b_status="";
                if (txtApplicant_PK.text!="")
                {
                    alert("Update Successful! \n Cập nhật thành công");
                    b_search=true;//search cac tab detail
                    datTrans_Exp.Call("SELECT");
                }
                else
                    alert("Update fail! \n Cập nhật thất bại");
            }
            else if (b_status=="Delete")//delete
            {
                b_status="";
                if (txtApplicant_PK.text!="-1")
                {
                    alert("Delete Successful! \n Xóa thành công");
                    
                }
                else
                    alert("Delete fail! \n Xóa thất bại");
            }
            else // if (b_status=="")
            {
                if ((txtStatus.text=="01" || txtStatus.text=="05") && txtApp_Type.text=="01") // dang o muc app_type = new
                {
                    SetEnableButton(true);
                    ibtnSave.SetEnable(true);
                }
                else
                {
                    SetEnableButton(false);
                    ibtnSave.SetEnable(false);
                }
                if (txtStatus.text=="01" || txtStatus.text=="05")//xem co quyen approve ko?
                    ibtnApprove.SetEnable(true);
                else
                    ibtnApprove.SetEnable(false);
                if (txtApp_Type.text=="01") //xem co quyen replicate ko?
                    ibtnReplicate.SetEnable(true);
                else
                    ibtnReplicate.SetEnable(false);
                if (txtStatus.text=="01" && txtApp_Type.text=="01")//xem co quyen approve ko?
                    ibtnDelete.SetEnable(true);
                else
                    ibtnDelete.SetEnable(false);
                datCompanion.Call("SELECT");
                b_search=true;//search cac tab detail
            }
            
            break;
        }   
        case "datFind_Applicant":
            if (txtApplicant_PK.text=='-1')
                alert("Do not have this applicant! \n Không có đơn này!");
            else
                datApplicant.Call("SELECT");
            break;
        case "datCompanion":
            if (b_search==true)
            {
                datSchedule.Call("SELECT");
            }
            break;
       case "datSchedule":
       {
            SetGridHeader(grdSchedule);
            if (b_search==true)
            {
                datTrans_Exp.Call("SELECT");
            }
            
            break;
       }
       case "datTrans_Exp":
       {
            txtTrans_Sum.text=String(SumMoney(grdTrans_Exp,3));
            if (b_search==true)
            {
                datOther_Exp.Call("SELECT");
                
            }
            else
                txtTotal_Expenses.text=String(SumMoney(grdTrans_Exp,3) + SumMoney(grdOther_Exp,2));
            break;
        }
        case "datOther_Exp":
        {
            if (b_search==true)
            {
                b_search=false;
            }
            txtOther_Sum.text=String(SumMoney(grdOther_Exp,2));
            txtTotal_Expenses.text=String(SumMoney(grdTrans_Exp,3) + SumMoney(grdOther_Exp,2));
            break;
        }
        case "datGetApprove":
        {
            if (txtStatus.text!="-1")
            {
                alert("Approving successful! \n Đề nghị thành công!");
                ibtnApprove.SetEnable(false);
                SetEnableButton(false);
                ibtnSave.SetEnable(false);
            }
            else
                alert("Approving failed! \n Đề nghị thất bại!");
            break;
        }
        case "datBizReplicate":
        {
            if (txtResult.text!="-1")
            {
                alert("Replicating successful! \n Sao chép thành công!")
                txtApplicant_PK.text=txtResult.text;
                b_status="";
	            SetEnableButton(true);
                datApplicant.Call("SELECT");
            }    
            else
                alert("Replicating failed! \n Sao chép thất bại!");
        }
    }
}
//----------------------------------------------
function OnNewDetail(objgrd,app_pk,currency)
{
    objgrd.AddRow();
    var irow=objgrd.rows-1;
    var bnew;
    bnew=true;
    if (objgrd==grdCompanion)
    {
        var fpath = System.RootURL + "/form/ch/fd/chfd_search_emp.aspx" ;
        var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	    if (obj!=null)
	    {   
	        if(obj[1]==txtEmp_ID.text)
	        {
	            alert("This employee register app already.\nNhân viên này trùng với nhân viên đăng ký đơn, vui lòng chọn nhân viên khác.")
	            objgrd.RemoveRowAt(irow);
	            bnew=false;
	        }
	        else
	        {
	            objgrd.SetGridText(irow,0,'01');//type
	            objgrd.SetGridText(irow,1,obj[4]);//dept
                objgrd.SetGridText(irow,2,obj[6]);//wgroup
                objgrd.SetGridText(irow,3,obj[1]);//id
                objgrd.SetGridText(irow,4,obj[2]);//full name
                objgrd.SetGridText(irow,5,obj[10]);//pos
                objgrd.SetGridText(irow,7,obj[0]);//emp_pk
                objgrd.SetGridText(irow,9,obj[13]);//dept_pk
                objgrd.SetGridText(irow,10,obj[14]);//wgroup_pk
                objgrd.SetGridText(irow,11,obj[12]);//pos_code
            }
	    }
	    else
	    {    
	        objgrd.RemoveRowAt(irow);
	        bnew=false;
	    }   
    }
    if (bnew==true)
    {
        if (currency!=-1)
            objgrd.SetGridText(irow,currency,lstCurrency.GetText());
        objgrd.SetGridText(irow,app_pk,txtApplicant_PK.text);
    }
    
  
}
//----------------------------------------
function OnSaveDetail(objdat)
{
    var bsave=false;
    if (confirm("Do you want to save? \n Bạn có muốn lưu không?"))
    {
        if (objdat==datSchedule )
        {    
            if (CheckSchedule()==true)
                bsave=true;
        }
        else if(objdat==datTrans_Exp)
        {
            if (CheckTrans()==true)
                bsave=true;
        }        
        else if(objdat==datOther_Exp)
        {
            if (CheckOther()==true)
                bsave=true;
        }  
        else
                bsave=true;
        if (bsave==true)
            objdat.Call();
    }
}
//----------------------------------------
function OnDeleteDetail(objgrd)
{
    if (confirm("Do you want to delete? \n Bạn có muốn xóa không?"))
        objgrd.DeleteRow();
}
//----------------------------------------
function CheckSave()
{
    if (txtEmp_PK.text=="") 
    {
        alert("Please select employee! Vui lòng chọn người nhân viên!");
        return false;
    }
    if (txtApprover_PK.text=="")
    {
        alert("Please select approver! Vui lòng chọn người đi chấp thuận!");
        return false;
    }
    if(dtFrom.value=="" ||dtTo.value=="")
    {
        alert("Please input Biz period!\nBạn phải nhập thời hạn từ ngày đến ngày");
        return false;
    }    
    
    return true;
}
//-------------------------------------------
function CheckSchedule()
{
    var icfrom,icto;
    icfrom=0;
    icto=1;
    for(var i=2;i<grdSchedule.rows;i++)
    {
       
            if (grdSchedule.GetGridData(i,icfrom)=="")
            {
                alert("Please input From Date at row " + (i-1) );
                return false;
            }
            else if (grdSchedule.GetGridData(i,icto)=="")
            {
                alert("Please input To Date at row " + (i-1) );
                return false;
            }
    }
    return true;      
}
function CheckTrans()
{
    var ctrl=grdTrans_Exp.GetGridControl();
    for(var i=1;i<ctrl.rows;i++)
    {
       
            if (grdTrans_Exp.GetGridData(i,3)=="")
            {
                alert("Please input amount at row " + i );
                return false;
            }
    }
    return true;      
    
}
function CheckOther()
{
    var ctrl=grdOther_Exp.GetGridControl();
    for(var i=1;i<ctrl.rows;i++)
    {
       
            if (grdOther_Exp.GetGridData(i,2)=="")
            {
                alert("Please input amount at row " + i );
                return false;
            }
    }
    return true;     
}
//---------------------------------------------
function CheckCurrency(objgrd,objcol)
{
    var irow=objgrd.row;
    if (objgrd.col==objcol)
        if (isNaN(objgrd.GetGridData(objgrd.row,objgrd.col)))
        {
            var irow=objgrd.row;
            alert("Please input currency format onto this column \n Vui lòng nhập bằng định dạng tiền vào cột này");
            objgrd.SetGridText(irow,objcol,value_before);
        }
        
}
//---------------------------------------
function SumMoney(objgrd,objcol)
{
    var isum,irow,icol;
    isum=0;
    for (var i=1;i<objgrd.rows;i++)
    {
        if (objgrd.GetGridData(i,objcol) !="")
            isum+=Number(objgrd.GetGridData(i,objcol));
    }
    return isum;
}
//-----------------------------
function on_edit_before(objgrd)
{
    value_before=objgrd.GetGridData(event.row,event.col);
    //alert(value_before);
}
//-------------------------------
function OnApprove()
{
    if (confirm("Do you want to approve this? \n Bạn có muốn đề nghị cái này không?"))
        datGetApprove.Call();
}
//-------------------------------
function OnReplicate()
{
    if (confirm("Do you want to replicate this applicant? \n Bạn có muốn tạo bảng copy của đơn này không?"))
    {
        datBizReplicate.Call();
    }
}
//--------------------------------
function OnEnterApp()
{
    datFind_Applicant.Call();
}
function check_date()
{
    var ctrl=grdSchedule.GetGridControl();
    if(ctrl.rows>1)
    {
        
        if(ctrl.col==0)
        {
            if(Number(grdSchedule.GetGridData(ctrl.row,0))<Number(dtFrom.value)||Number(grdSchedule.GetGridData(ctrl.row,0))>Number(dtTo.value))  
            {
                alert("Schedule from date must between biz period");
                grdSchedule.SetGridText(ctrl.row,0,'');
                return;
            }
            if(grdSchedule.GetGridData(ctrl.row,0)!=""&&grdSchedule.GetGridData(ctrl.row,1)!=""&&Number(grdSchedule.GetGridData(ctrl.row,0))>Number(grdSchedule.GetGridData(ctrl.row,1)))
            {
                alert("Schedule from date must smaller then to date");
                grdSchedule.SetGridText(ctrl.row,0,'');
                return;
            }
            
            
        }    
        if(ctrl.col==1)
        {
            if(Number(grdSchedule.GetGridData(ctrl.row,1))<Number(dtFrom.value)||Number(grdSchedule.GetGridData(ctrl.row,1))>Number(dtTo.value))  
            {
                alert("Schedule to date must between biz period");
                grdSchedule.SetGridText(ctrl.row,1,'');
            }
            if(grdSchedule.GetGridData(ctrl.row,0)!=""&&grdSchedule.GetGridData(ctrl.row,1)!=""&&Number(grdSchedule.GetGridData(ctrl.row,0))>Number(grdSchedule.GetGridData(ctrl.row,1)))
            {
                alert("Schedule from date must smaller then to date");
                grdSchedule.SetGridText(ctrl.row,1,'');
                return;
            }        
        }
     }   
      
}
</script>
<body bgcolor='#F5F8FF'>
<!---------------------main employee tab data control------------------>
<!------------------------------------>
<gw:data id="datApplicant" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="control" parameter="0,1,2,5,6,7,9,10,11,12,13,14,15,16,18,19,20,21,30" function="hr.sp_sel_biz_applicant" procedure="hr.sp_upd_biz_applicant"> 
                <inout>
                    <inout bind="txtApplicant_PK" /> 
                    <inout bind="txtEmp_PK"/>
                    <inout bind="txtEmp_ID"/>
                    <inout bind="txtFull_Name"/>
                    <inout bind="txtDepartment"/>
                    <inout bind="txtTelephone"/>
                    <inout bind="txtApprover_PK"/>
                    <inout bind="txtApprover_ID"/>
                    <inout bind="txtApprover_Name"/>
                    <inout bind="txtCost_Center_PK"/>
                    <inout bind="txtCost_Acc_PK"/>
                    <inout bind="lstObject"/>
                    <inout bind="lstType"/>
                    <inout bind="txtDescription"/>
                    <inout bind="txtVisting_Place"/>
                    <inout bind="dtFrom"/>
                    <inout bind="dtTo"/>
                    <inout bind="txtTotal_Expenses"/>
                    <inout bind="txtStatus"/>
                    <inout bind="txtStatus_Times"/>
                    <inout bind="txtApplication_No"/>
                    <inout bind="lstCurrency"/>
                    <inout bind="txtNight_Day"/>
                    <inout bind="txtApp_Type"/>
                    <inout bind="txtCompany"/>
                    <inout bind="txtCost_Center"/>
                    <inout bind="txtCost_Acc_Code"/>
                    <inout bind="txtCost_Acc_Name"/>
                    <inout bind="txtApp_Type_T"/>
                    <inout bind="txtApp_Status_T"/>
                    <inout bind="txtMaker"/>
                </inout> 
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datCompanion" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_biz_companion" procedure="hr.sp_upd_biz_companion" parameter="0,3,4,6,7,8,9,10,11,12"> 
                <input>
                    <input bind="txtApplicant_PK" />
                </input>
                <output  bind="grdCompanion" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datSchedule" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_biz_schedule" procedure="hr.sp_upd_biz_schedule" parameter="0,1,2,3,4,5,6,7,8"> 
                <input>
                    <input bind="txtApplicant_PK" />
                </input>
                <output  bind="grdSchedule" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datGetApprove" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_approve" > 
                <input>                    
                   <input bind="txtApplicant_PK" />
                </input> 
                <output>
                    <output bind="txtStatus" />
                    <output bind="txtApp_Status_T" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datBizReplicate" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_biz_replicate" > 
                <input>                    
                   <input bind="txtApplicant_PK" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datFind_Applicant" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_find_applicant" > 
                <input>                    
                   <input bind="txtApplication_No" />
                </input> 
                <output>
                    <input bind="txtApplicant_PK" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datTrans_Exp" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_biz_Trans_Exp" procedure="hr.sp_upd_biz_Trans_Exp" parameter="0,1,2,3,4,5,6,7"> 
                <input>
                    <input bind="txtApplicant_PK" />
                </input>
                <output  bind="grdTrans_Exp" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datOther_Exp" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_biz_Other_Exp" procedure="hr.sp_upd_biz_Other_Exp" parameter="0,1,2,3,4,5,6"> 
                <input>
                    <input bind="txtApplicant_PK" />
                </input>
                <output  bind="grdOther_Exp" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datBiz_Emp_Infor" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_biz_empid" > 
                <input>
                    <input bind="txtEmp_PK" />
                </input> 
                <output>
                    <output bind="txtEmp_ID" />
                    <output bind="txtFull_Name" />
                    <output bind="txtApprover_ID" />
                    <output bind="txtApprover_Name" />
                    <output bind="txtTmp" />
                    <output bind="txtDepartment" />
                    <output bind="txtTmp" />
                    <output bind="txtApprover_PK" />
                    <inout bind="txtCompany"/>
                    <inout bind="txtCost_Center_PK"/>
                    <inout bind="txtCost_Center"/>
                </output>
            </dso> 
        </xml> 
</gw:data>

<!---------------------expand employee tab data control------------------>
 
 <table id="main" width="100%" cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;">
    <tr style="height:35%;" >
        <td>
            <fieldset style="height:100%;" > 
            <legend><font color="#e9361d" size="2" >Basic Information</font></legend>
                <table width="100%" id="tbloth" style="height:90%" border=0 cellpadding="1" cellspacing="0">
                    <tr>
                    	<td width="1%"></td>
                        <td width="10%"></td>
                        <td width="10%"></td>
                        <td width="18"></td>
                        <td width="12%"></td>
                        <td width="18%"></td>
                        <td width="12%"></td>
                        <td width="18%"></td>
                        <td width="1%"></td>
                    </tr>
                    <tr>
                    	<td></td>
                        <td colspan="3"></td>
                        <td colspan="4" align="right">
                        	<table cellpadding="0" cellspacing="0" width="100%">
                            	<tr>
                                	<td width="30%"></td>
                                    <td align="right" width="5%"><gw:imgBtn img="popup" id="ibtnSearch"    alt="Popup"  onclick="OnSearch()"/></td>
                                    <td align="right" width="5%"><gw:imgBtn img="new" id="ibtnAdd"    alt="Add"  onclick="OnNew()"/></td>
                                    <td align="right" width="5%"><gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave()"/></td>
                                    <td align="right" width="5%"><gw:imgBtn img="delete" id="ibtnDelete"    alt="Delete"  onclick="OnDelete()"/></td>
                                    <td align="right" width="5%"><gw:imgBtn img="excel" id="ibtnExcel"    alt="Excel"  onclick="OnExcel()"/></td>
                                    <td align="center" width="25%"><gw:icon id="ibtnApprove" img="in" text="Approval Request" onclick="OnApprove()" /></td>
                                    <td align="right" width="10%"><gw:icon id="ibtnReplicate" img="in" text="Replicate" onclick="OnReplicate()" /></td>
                                </tr>
                            </table>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td align="right"><a title="Click here to show applicant" onClick="OnShowPopup(3)" href="#tips" >Application No &nbsp;</a></td>
                        <td><gw:textbox id="txtApplication_No"  text="" 	styles='width:90%;' csstype="mandatory"  onenterkey="OnEnterApp()" /></td>
                        <td></td>
                        <td align="right">Application Type &nbsp;</td>
                        <td><gw:textbox id="txtApp_Type_T"  text="" 	styles='width:100%;'  onenterkey="OnEnterApp()" /></td>
                        <td align="right">Application Status &nbsp;</td>
                        <td><gw:textbox id="txtApp_Status_T"  text="" 	styles='width:100%;'  onenterkey="OnEnterApp()" /></td>
                        <td></td>
                    </tr>
                    <tr>
                    	<td></td>
                        <td align="right"><a title="Click here to show applicant" onClick="OnShowPopup(1)" href="#tips" >Applicant &nbsp;</a></td>
                        <td><gw:textbox id="txtEmp_ID"  text="" 	styles='width:100%;' csstype="mandatory"  onenterkey="OnEnterEmp()" /></td>
                        <td><gw:textbox id="txtFull_Name"  text="" 	styles='width:100%;' csstype="mandatory"  onenterkey="OnEnterEmp()" /></td>
                        <td align="right">Department &nbsp;</td>
                        <td><gw:textbox id="txtDepartment" text="" styles='width:100%;' /></td>
                        <td align="right">Telephone &nbsp;</td>
                        <td><gw:textbox id="txtTelephone" text="" styles='width:100%;' /></td>
                        <td></td>
                    </tr>
                    <tr>
                    	<td></td>
                        <td align="right"><a title="Click here to show approver" onClick="OnShowPopup(2)" href="#tips" >Approver &nbsp;</a></td>
                        <td><gw:textbox id="txtApprover_ID"  text=""  styles='width:100%;' csstype="mandatory" /></td>
                        <td><gw:textbox id="txtApprover_Name"  text="" 	styles='width:100%;' csstype="mandatory"   /></td>
                        <td align="right">Object &nbsp;</td>
                        <td><gw:list  id="lstObject" value="" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0059' order by code_nm")%>
                            </data>
                            </gw:list ></td>
						<td align="right">Biz Type &nbsp;</td>
                        <td><gw:list  id="lstType" value="" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0060' order by code_nm")%>
                            </data>
                            </gw:list ></td>   
                        <td></td>                    
                    </tr>
                    <tr>
                    	<td></td>
                        <td align="right"><a title="Click here to cost account" onClick="OnShowPopup(5)" href="#tips" >Cost Account &nbsp;</a></td>
                        <td><gw:textbox id="txtCost_Acc_Code"  text="" styles='width:100%;'  /></td>
                        <td><gw:textbox id="txtCost_Acc_Name"  text="" styles='width:100%;'  /></td>
                        <td align="right">Cost Center &nbsp;</td>
                        <td><gw:textbox id="txtCost_Center"  text=""  styles='width:100%;' /></td>
                        <td align="right">Currency &nbsp;</td>
                        <td><gw:list  id="lstCurrency" value="01" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CHAR_1 from vhr_hr_code where id='HR0040' order by code_nm")%>
                            </data>
                            </gw:list ></td>
                        <td></td>
                    </tr>
                    <tr>
                    	<td></td>
                        <td align="right">Description &nbsp;</td>
                        <td colspan="3"><gw:textbox id="txtDescription"  text="" 	styles='width:100%;'  /></td>
                        <td align="right">Visiting Place &nbsp;</td>
                        <td colspan="2"><gw:textbox id="txtVisting_Place"  text="" styles='width:100%;'  /></td>
                        <td></td>
                    </tr>
                    <tr>
                    	<td></td>
                        <td align="right">Period &nbsp;</td>
                        <td colspan="2">
                        	<table cellpadding="0" cellspacing="0" width="100%">
                            	<tr>
                                	<td width="40%" align="left"><gw:datebox id="dtFrom"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept  /></td>
                                    <td width="20%" align="center"><b>-</b></td>
                                    <td width="40%" align="left"><gw:datebox id="dtTo"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
                                </tr>
                            </table>
                        </td>
                        <td align="right">Night/Day(s) &nbsp;</td>
                        <td><gw:textbox id="txtNight_Day"   text="" styles='width:100%;'  /></td>
                        <td align="right">Total Expenses &nbsp;</td>
                        <td><gw:textbox id="txtTotal_Expenses" format="#,###,###,###.##R" type="number"   text="" styles='width:100%;'  /></td>
                        <td></td>
                    </tr>
                </table>
             </fieldset>
        </td>
    </tr>
    <tr style="height:3%;" >
        <td>&nbsp;</td>
    </tr>
    <tr style="height:60%;" >
        <td>     
            <fieldset style="height:90%;" > 
            <legend><font color="#e9361d" size="2" >Other Information</font></legend>
            <br />
                <table width="100%" id="Table1" style="height:94%" border=0 cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                              <gw:tab id="idTab" >
	                            <table name="Companion" width=100% cellpadding=0 cellspacing=1 border=1 id="tblexp" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                            <table name="Companion" width=100% cellpadding=0 cellspacing=1 border=1 id="Table2" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="91%"  align="center" valign="center">
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="new" id="ibtnAdd_C"   alt="Add"  onclick="OnNewDetail(grdCompanion,12,-1)"/>
                                                    </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="save" id="ibtnSave_C"    alt="Save"  onclick="OnSaveDetail(datCompanion)"/>
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="delete" id="ibtnDelete_C"    alt="Delete"  onclick="OnDeleteDetail(grdCompanion)"/>
                                                    </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=4 style="width:100%" border=1> 
                                                         <gw:grid   
                                                            id="grdCompanion"  
                                                            header="Type|Organization|WGroup|Emp ID|Full Name|Position|Remark|_Emp_Pk|_PK|_Dep_PK|_Grp_PK|_Pos_Type|_App_PK"   
                                                            format="2|0|0|0|0|0|0|0|0|0|0|0|0"  
                                                            aligns="0|0|0|1|0|0|0|0|0|0|0|0|0"  
                                                            defaults="|||||||||||"  
                                                            editcol="1|0|0|0|0|0|1|0|0|0|0|0|0"  
                                                            widths="1700|2000|2000|1200|2500|1500|2000|0|0|0|0|0|0"  
                                                            styles="width:100%; height:100%"   
                                                            sorting="T"   
                                                            /> 
                                                    </td>

                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table> 
	                            <table name="Schedule" width=100% cellpadding=0 cellspacing=1 border=1 id="Table3" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                             <table  width=100% cellpadding=0 cellspacing=1 border=1 id="Table4" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="91%"  align="center" valign="center">
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="new" id="ibtnAdd_S"   alt="Add"  onclick="OnNewDetail(grdSchedule,8,-1)"/>
                                                    </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="save" id="ibtnSave_S"    alt="Save"  onclick="OnSaveDetail(datSchedule)"/>
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="delete" id="ibtnDelete_S"    alt="Delete"  onclick="OnDeleteDetail(grdSchedule)"/>
                                                    </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=4 style="width:100%" border=1> 
                                                         <gw:grid   
                                                                id="grdSchedule"  
                                                                header="From|To|Departure_Co|Departure_Ci|Arrival_Co|Arrival_Ci|Plan|_PK|_App_PK"
			                                                    format="4|4|0|0|0|0|0|0|0"
			                                                    aligns="1|1|0|0|0|0|0|0|0"
			                                                    defaults="|||||||||"
			                                                    editcol="1|1|1|1|1|1|1|0|0"
			                                                    widths="1500|1500|2000|2000|2000|2000|1500|0|0"
			                                                    styles="width:100%;height:100%"
			                                                    sorting="F"
			                                                    onafteredit="check_date()"
			                                                    oncellclick = ""
			                                                    acceptNullDate="T"
			                                                    oncelldblclick = ""/>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table> 
                                <table name="Transportation Expenses" width=100% cellpadding=0 cellspacing=1 border=1 id="Table5" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                             <table  width=100% cellpadding=0 cellspacing=1 border=1 id="Table6" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="41%" style="border:0;"  align="right" valign="center">Sum= &nbsp;
                                                    </td>
                                                    <td width="49%" style="border:0;"  align="left" valign="center"><gw:textbox format="#,###,###,###.##" type="number" id="txtTrans_Sum"  text="" 	styles='width:20%;'  />
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="new" id="ibtnAdd_T"   alt="Add"  onclick="OnNewDetail(grdTrans_Exp,7,4)"/>
                                                    </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="save" id="ibtnSave_T"    alt="Save"  onclick="OnSaveDetail(datTrans_Exp)"/>
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="delete" id="ibtnDelete_T"    alt="Delete"  onclick="OnDeleteDetail(grdTrans_Exp)"/>
                                                    </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=5 style="width:100%" border=1> 
                                                         <gw:grid   
                                                                id="grdTrans_Exp"  
                                                                header="Departure|Arrival|Transportation by|Amount|Currency|Remark|_PK|_App_PK"
		                                                        format="0|0|2|0|0|0|0|0"
			                                                    aligns="0|0|0|3|1|0|1|0"
			                                                    defaults="||||||||"
			                                                    editcol="1|1|1|1|0|1|0|0"
			                                                    widths="2000|2000|2000|1500|1000|1300|2500|0"
			                                                    styles="width:100%;height:100%"
			                                                    sorting="F"
			                                                    onafteredit="CheckCurrency(grdTrans_Exp,3)"
			                                                    oncellclick = ""
			                                                    onKeyPressEdit    = "on_edit_before(grdTrans_Exp)"
			                                                    acceptNullDate="T"
			                                                    oncelldblclick = ""/>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table> 
                                <table name="Other Expenses" width=100% cellpadding=0 cellspacing=1 border=1 id="Table7" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                             <table  width=100% cellpadding=0 cellspacing=1 border=1 id="Table8" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="32%" style="border:0;"  align="right" valign="center">Sum= &nbsp; 
                                                    </td>
                                                    <td width="59%" style="border:0;"  align="left" valign="center"><gw:textbox format="#,###,###,###.##" type="number" id="txtOther_Sum"  text="0"  styles='width:20%;'  />
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="new" id="ibtnAdd_O"   alt="Add"  onclick="OnNewDetail(grdOther_Exp,6,3)"/>
                                                    </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="save" id="ibtnSave_O"    alt="Save"  onclick="OnSaveDetail(datOther_Exp)"/>
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     <gw:imgBtn img="delete" id="ibtnDelete_O"    alt="Delete"  onclick="OnDeleteDetail(grdOther_Exp)"/>
                                                    </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=5 style="width:100%" border=1> 
                                                         <gw:grid   
                                                                id="grdOther_Exp"  
                                                                header="Type|Description|Amount|Currency|Remark|_PK|_App_PK"
		                                                        format="2|0|1|0|0|0|0"
			                                                    aligns="0|0|3|1|0|1|0"
			                                                    defaults="|||||||"
			                                                    editcol="1|1|1|0|1|0|0"
			                                                    widths="2000|2500|2000|1500|1000|2500|0"
			                                                    styles="width:100%;height:100%"
			                                                    sorting="F"
			                                                    onafteredit="CheckCurrency(grdOther_Exp,2)"
			                                                    oncellclick = ""
			                                                    onKeyPressEdit    = "on_edit_before(grdOther_Exp)"
			                                                    acceptNullDate="T"
			                                                    oncelldblclick = ""/>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table> 
	                        </gw:tab>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </td>
    </tr>
</table>
<gw:textbox id="txtApplicant_PK" styles="display:none"/>
<gw:textbox id="txtEmp_PK" styles="display:none"/>
<gw:textbox id="txtApprover_PK" styles="display:none"/>
<gw:textbox id="txtStatus" styles="display:none" />
<gw:textbox id="txtStatus_Times"  styles="display:none"/>
<gw:textbox id="txtCost_Center_PK"  styles="display:none"/>
<gw:textbox id="txtCost_Acc_PK"  styles="display:none"/>
<gw:textbox id="txtApp_Type"  styles="display:none"/>
<gw:textbox id="txtTmp"  styles="display:none"/>
<gw:textbox id="txtCompany"  styles="display:none"/>
<gw:textbox id="txtResult"  styles="display:none"/>
<gw:textbox id="txtMaker"  styles="display:none"/>

</body>



