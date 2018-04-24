<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var binit=true;
var v_language = "<%=Session("SESSION_LANG")%>";
var emp_pk_list;
var rpt_no=0;
//column of manage tab
var   icmjoin_dt=4
var   icmcreate_contract=6
var   icmprob_type=7
var   icmoldcontract_type=8
var   icmnewcontract_type=9
var   icmbegin_probation=10
var   icmend_probation=11
var   icmbegin_contract=12
var   icmend_contract=13
var   icmget_salary=14
var   icmsalary_k1=16
var   icmsalary_k2=17
var   icmsalary_k3=18
var   icmallow_amt1=19
//column of report tab   
var icrcontract_type_text=8
var icrsalary_k1=14
var icrsalary_k2=15
var icrsalary_k3=16
var icrallow_amt1=17
var icremp_pk = 25
var icrcontract_type =28
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
    OnToggle();
    OnToggle_A();
    grdLabourContract.GetGridControl().FrozenCols =5;
    grdLBReport.GetGridControl().FrozenCols =5;
    grdLBPreparation.GetGridControl().FrozenCols =5;
    grdLabourContract.GetGridControl().ScrollTrack=true;
    grdLBReport.GetGridControl().ScrollTrack=true;
    grdLBPreparation.GetGridControl().ScrollTrack=true;
    grdAppendix.GetGridControl().FrozenCols =6;
    grdAppendix.GetGridControl().ScrollTrack=true;
    grdAppendix_His.GetGridControl().FrozenCols =6;
    grdAppendix_His.GetGridControl().ScrollTrack=true;
    BindingData();
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    //co phan loai luong can ban hay khong? 
    //CheckSeparateSal();
    datAllowance.Call();
}
//--------------------------------------
function CheckSeparateSal()
{
    lblDisplay1_sal.text="<%=ESysLib.SetDataSQL("select code_nm from hr.vhr_hr_code where id='HR0095' and code='A1' and nvl(num_1,0)=1")%>";
    lblDisplay2_sal.text="<%=ESysLib.SetDataSQL("select code_nm from hr.vhr_hr_code where id='HR0095' and code='A2' and nvl(num_1,0)=1")%>";
    lblDisplay3_sal.text="<%=ESysLib.SetDataSQL("select code_nm from hr.vhr_hr_code where id='HR0095' and code='A3' and nvl(num_1,0)=1")%>";
    if (lblDisplay1_sal.text!="") //co su dung
    {
        grdLabourContract.SetGridText(0,icmsalary_k1,lblDisplay1_sal.text);
        grdLabourContract.GetGridControl().ColHidden(icmsalary_k1)=0;
        grdLBReport.SetGridText(0,icrsalary_k1,lblDisplay1_sal.text);
        grdLBReport.GetGridControl().ColHidden(icrsalary_k1)=0;
        
    }
    if (lblDisplay2_sal.text!="") //co su dung
    {
        grdLabourContract.SetGridText(0,icmsalary_k2,lblDisplay2_sal.text);
        grdLabourContract.GetGridControl().ColHidden(icmsalary_k2)=0;
        grdLBReport.SetGridText(0,icrsalary_k2,lblDisplay2_sal.text);
        grdLBReport.GetGridControl().ColHidden(icrsalary_k2)=0;
    }
    if (lblDisplay3_sal.text!="") //co su dung
    {
        grdLabourContract.SetGridText(0,icmsalary_k3,lblDisplay3_sal.text);
        grdLabourContract.GetGridControl().ColHidden(icmsalary_k3)=0;
        grdLBReport.SetGridText(0,icrsalary_k3,lblDisplay3_sal.text);
        grdLBReport.GetGridControl().ColHidden(icrsalary_k3)=0;
    }    
}
//-------------------------------------------------------------------------
function BindingData()
{
    <%=ESysLib.SetGridColumnComboFormat( "grdLabourContract" , 7 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0002' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdLabourContract" , 8 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdLabourContract" ,9 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdAppendix" ,6 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq") %>; 
   
    <%=ESysLib.SetGridColumnComboFormat( "grdAppendix_His" ,7 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdAppendix_His" ,8 , "select a.code,a.code_nm from vhr_hr_code a where a.id='HR0002' ORDER BY A.seq") %>; 
}
//---------------------------------------------------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:260;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        datDeptData.Call();
    }
    
}
//-------------------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl();
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//-------------------------------------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {
        if(txtHr_level.text=="6")
            txtDeptData.text=txtDeptData.text+"|ALL|Select All";
        switch (tabMain.GetCurrentPageNo())
        {
            case 0:
                lstDept_Code_M.SetDataText(txtDeptData.text);
                txtDept.text=lstDept_Code_M.value;
                break;
            case 1:
                lstOrg_Code_R.SetDataText(txtDeptData.text);
                txtDept.text=lstOrg_Code_R.value;
                break;
            case 2:
                lstDept_Code_P.SetDataText(txtDeptData.text);
                txtDept.text=lstDept_Code_P.value;
                break;
        }  
        datTeamData.Call();
   }
   else if (obj.id=="datTeamData")
   {
        switch (tabMain.GetCurrentPageNo())
        {
            case 0:
                ChoseList_box(lstGrp_Code_M,txtGroupData.text);
                break;
            case 1:
                ChoseList_box(lstOrgType_R,txtGroupData.text);
                break;
            case 2:
                ChoseList_box(lstGrp_Code_P,txtGroupData.text);
                break;
        }  
        if (binit==true)
        {
            binit=false;
            ChoseList_box(lstGrp_Code_M,txtGroupData.text);
            ChoseList_box(lstOrgType_R,txtGroupData.text);
            ChoseList_box(lstGrp_Code_P,txtGroupData.text);
        }
        
   }
   else if (obj.id=="datAllowance")
   {
        
        BindingCol(grdLabourContract,icmallow_amt1);
        BindingCol(grdLBReport,icrallow_amt1);
        BindingCol(grdLBPreparation,14);
        BindingCol(grdAppendix,12);
        BindingCol(grdAppendix_His,10);
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
        
   }
   else if (obj.id=="datLabourContractManage")
   {
        lblRecord_M.text=grdLabourContract.rows -1 + " record(s).";
        chkCheckCreate.value='F';
        chkGetSalary.value='F';        
   }
   else if (obj.id=="datLabourContractReport")
   {
        lblRecord_R.text=grdLBReport.rows -1 + " record(s).";
        chkCheckReport.value='F';
   }
   else if (obj.id=="datAppendixContract")
   {
        lblRecord_A.text=grdAppendix.rows -1 + " record(s).";
   }
   else if (obj.id=="datLabourContractHis")
   {
        lblRecord_H.text=grdLBHist.rows -1 + " record(s).";
        
   }
   else if (obj.id=="datLabourContractPre")
   {
        lblRecord_P.text=grdLBPreparation.rows -1 + " record(s).";
        if (grdLBPreparation.rows==1)
            chkCheckPre.value='F';
        else
            chkCheckPre.value='T';
   }  
   else if (obj.id=="datUser_info")
   {
        lstDept_Code_M.SetDataText(txtDeptData.text);
        lstOrg_Code_R.SetDataText(txtDeptData.text);
        lstDept_Code_P.SetDataText(txtDeptData.text);
        txtDept.text=lstDept_Code_M.value;
        datTeamData.Call();
   }
   else if (obj.id=="datLBReport")
   {
        datFind_Report.Call();
   }
   else if (obj.id=="datFind_Report")
   {
        var url;
        switch(rpt_no)
        {
            case 1: //current report
                    //txtReport_tmp.text="rpt_labour_contract.aspx";
                    url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list;
                    break;
            case 2: //current labour contract list
                url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?p_tco_dept_pk=' + lstOrg_Code_R.value + '&p_thr_group_pk=' + lstWorkGroup_R.value  + '&p_chktemp=' + lstTemp_R.value + '&p_temp=' + txtTemp_R.text + '&p_probation_type=' + lstKindPB_R.value + '&p_from_begin_probation=' + dtFromBProbation_R.value;
                url=url + '&p_to_begin_probation=' + dtToBProbation_R.value + '&p_from_end_probation=' ;
				url=url + dtFromEProbation_R.value + '&p_to_end_probation=' + dtToEProbation_R.value + '&p_contract_type=' + lstKindLB_R.value +  '&p_from_begin_contract=';
				url=url + dtFromBContract_R.value +  '&p_to_begin_contract=' + dtToBContract_R.value + '&p_from_end_contract=' ;
				url=url + dtFromEContract_R.value + '&p_to_end_contract=' + dtToEContract_R.value  ;
				url=url + '&p_Nation=' + lstNation_R.value + '&p_OrgType=' + lstOrgType_R.value  ;
                break;
            case 3: //history report
                alert("Report here");
                break;
            case 4: //labour contract preparation
                if (FindSameType(grdLBPreparation,24)==false)
                {                    
                    alert("Have to print the same type of report!" + "\n"  + "Phải chọn cùng một kiểu của loại hợp đồng!");
                    break;
                }
                else                   
                    url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?&p_contract_type=' + lstKindLB_P.value + '&emp_pk=' + emp_pk_list;
                break;               
         }       
        window.open(url);    
   }
}

//-------------------------------------------------
function OnSetLBType(obj_grd,obj_col)
{
    var tmp;
    tmp=lstKindLB_Set.value;    
    var ctrl = obj_grd.GetGridControl();
	for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		{
			var row = ctrl.SelectedRow(i);
			if ( row > 0 )
			{		
				obj_grd.SetGridText(row,obj_col,tmp);
			}	
		}
}
//--------------------------------------------------
function BindingCol(obj,icol)
{
    obj.SetGridText(0,icol,lblA1.text);
    obj.SetGridText(0,icol+1,lblA2.text);
    obj.SetGridText(0,icol+2,lblA3.text);
    obj.SetGridText(0,icol+3,lblA4.text);
    obj.SetGridText(0,icol+4,lblA5.text);
    obj.SetGridText(0,icol+5,lblA6.text);
    obj.SetGridText(0,icol+6,lblA7.text);
    obj.SetGridText(0,icol+7,lblA8.text);
    obj.GetGridControl().ColHidden(icol)=!(Number(lblDisplay1.text));
    obj.GetGridControl().ColHidden(icol+1)=!(Number(lblDisplay2.text));
    obj.GetGridControl().ColHidden(icol+2)=!(Number(lblDisplay3.text));
    obj.GetGridControl().ColHidden(icol+3)=!(Number(lblDisplay4.text));
    obj.GetGridControl().ColHidden(icol+4)=!(Number(lblDisplay5.text));
    obj.GetGridControl().ColHidden(icol+5)=!(Number(lblDisplay6.text));
    obj.GetGridControl().ColHidden(icol+6)=!(Number(lblDisplay7.text));
    obj.GetGridControl().ColHidden(icol+7)=!(Number(lblDisplay8.text));
}
//--------------------------------------------------
function OnChangeDept(obj)
{
    
    switch (tabMain.GetCurrentPageNo())
    {
        case 0:
            txtDept.text=lstDept_Code_M.value ;
            break;
        case 1:
            txtDept.text=lstOrg_Code_R.value ;
            break;
        case 2:
            txtDept.text=lstDept_Code_P.value ;
            break;
    }    
    datTeamData.Call();
}
//------------------------------------------------
function OnToggle()
{
    
    if(imgArrow.status == "expand")
    {
        tblHist.style.display="none";
        imgArrow.status = "collapse";
        imgArrow.src = "../../../system/images/iconmaximize.gif";
        tblReport.style.height="100%";
        tblMainHist.style.height="83%";
        tblHist.style.height="0%";
        
    }
    else
    {
        tblHist.style.display="";
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/close_popup.gif";
        tblReport.style.height="100%";
        tblMainHist.style.height="53%";
        tblHist.style.height="30%";
        if (grdLBReport.row>0)
        {
            txtEmp_PK.text=grdLBReport.GetGridData(grdLBReport.row,22);
            datLabourContractHis.Call("SELECT");
        }
        
    }
    
}
//------------------------------------------------

function OnToggle_A()
{
    
    if(imgArrow_A.status == "expand")
    {
        idAppendix_His.style.display="none";
        imgArrow_A.status = "collapse";
        imgArrow_A.src = "../../../system/images/iconmaximize.gif";
        idAppendix.style.height="100%";
        idAppendix_Main.style.height="88%";
        idAppendix_His.style.height="0%";
        
    }
    else
    {
        idAppendix_His.style.display="";
        imgArrow_A.status = "expand";
        imgArrow_A.src = "../../../system/images/close_popup.gif";
        idAppendix.style.height="100%";
        idAppendix_Main.style.height="58%";
        idAppendix_His.style.height="30%";
        if (grdLBReport.row>0)
        {
            txtEmp_PK.text=grdLBReport.GetGridData(grdLBReport.row,22);
            datLabourContractHis.Call("SELECT");
        }
        
    }
    
}

//-----------------------------------------------------
function OnSearch(obj_data)
{
    if (obj_data==datLabourContractPre && lstKindLB_P.value=="ALL")
    {
        alert("Have to select a type of labour contract Kind!" + "\n" + "Bạn phải chọn một loại hợp đồng!");
        
    }
    else if (obj_data==datLabourContractPre && (dtFromSign.value=="" || dtToSign.value==""))
    {
            alert("Have to input date of period of signing!" + "\n" + "Bạn phải nhập ngày ký hợp đồng!");
    }
    else    
        obj_data.Call("SELECT");
        
}
//-----------------------------------------------------
function OnSave()
{
    
    if(confirm("Do you want to save contract ?" + "\n" + "Bạn có muốn cập nhật hợp đồng không?") &&  CheckBeforeSave())
    {
        datLabourContractManage.Call();
    }
}
//-----------------------------------------------------
function OnSave_A()
{
    
    if(confirm("Do you want to save appendix contract ?" + "\n" + "Bạn có muốn cập nhật phụ lục hợp đồng không?") &&  CheckBeforeSave())
    {
        datAppendixContract.Call();
    }
}
//---------------------------------------------------------
function OnDelete()
{
    if(confirm("Do you want to delete this contract ?" + "\n" + "Bạn có muốn xóa hợp đồng này không?"))
    {
        grdLabourContract.DeleteRow();
    }
}
//---------------------------------------------------------
function OnDelete_A()
{
    if(confirm("Do you want to delete this appendix contract ?" + "\n" + "Bạn có muốn xóa phụ lục hợp đồng này không?"))
    {
        grdAppendix.DeleteRow();
    }
}
//--------------------------
function CheckBeforeSave()
{
    var p_create_new;
    var p_old_contract_type;
    var p_new_contract_type,p_begin_pro,p_end_pro,p_begin_con,p_end_con;
    for(var i=1;i<grdLabourContract.rows;i++)
    {
        if (grdLabourContract.GetRowStatus(i)==16)
        {
            p_join_dt=grdLabourContract.GetGridData(i,icmjoin_dt); //column create new
            p_join_dt=String(p_join_dt.substr(6,4)) + String(p_join_dt.substr(3,2)) + String(p_join_dt.substr(0,2));
            p_create_new=grdLabourContract.GetGridData(i,icmcreate_contract); //column create new
            p_old_contract_type=grdLabourContract.GetGridData(i,icmoldcontract_type); //column old_contract_type
            p_new_contract_type=grdLabourContract.GetGridData(i,icmnewcontract_type); //column new_contract_type
            p_begin_pro=grdLabourContract.GetGridData(i,icmbegin_probation); //column begin probation
            p_end_pro=grdLabourContract.GetGridData(i,icmend_probation); //column end probation
            p_begin_con=grdLabourContract.GetGridData(i,icmbegin_contract); //column begin contract
            p_end_con=grdLabourContract.GetGridData(i,icmend_contract); //column end contract
            if (Number(p_join_dt) > Number(p_begin_pro) || Number(p_join_dt) > Number(p_end_pro) || ( Number(p_join_dt) > Number(p_begin_con) && p_begin_con !='') || (Number(p_join_dt) > Number(p_end_con) && p_end_con !=''))
            {
                alert("Join Date can not larger than Contract signed date at row " + i + "\n" + "Ngày vào không thể lớn hơn ngày ký hợp đồng tại dòng " + i );
                return false;
            }
            if ( Number(p_begin_pro) > Number(p_end_pro)  || (Number(p_begin_con) > Number(p_end_con)  && p_end_con !='') )
            {
                alert("Start Date can not larger than End Date at row " + i + "\n" + "Ngày bắt đầu ký hợp đồng không thể nhỏ hơn ngày kết thúc tại dòng " + i );
                return false;
            }
            if ((p_create_new==-1) && (p_old_contract_type == p_new_contract_type ) && p_new_contract_type !='05')
            {
                alert("Have to choose another contract type if you want to create new contract at row " + i + "\n" + "Để tạo hợp đồng mới bạn phải chọn loại hợp đồng mới tại dòng " + i );
                return false;
            }
            else if ((p_create_new==0) && (p_old_contract_type == p_new_contract_type))
            {
                alert("Have to choose old contract type if you wan't to create new contract at row " + i + "\n" + "Phải chọn hợp đồng cũ nếu không tạo hợp đồng mới tại dòng " + i );
                return false;
            }
        }
    }
    return true;
}

//------------------------------------------------------------------------------------
function OnSetGrid(obj_checkbox,obj_grd,obj_col)
{	
    var tmp;
    if( obj_checkbox.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
    var ctrl = obj_grd.GetGridControl();
    
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    obj_grd.SetGridText(row,obj_col,tmp);
			    }
		    }
	}
	else
	{
	    for ( var i =  1 ; i < ctrl.rows ; i++ )
				    obj_grd.SetGridText(i,obj_col,tmp);
	}
}
//----------------------------------------------------------------------------------
function OnPrint(obj)
{
    rpt_no=obj;
        switch(rpt_no)
        {
            case 1: //current report
                if (FindSameType(grdLBReport,icrcontract_type)==false)
                {
                    alert("Have to print the same type of report!" + "\n"  + "Phải chọn cùng một kiểu của loại hợp đồng!");
                    return;
                }
                else
                {
                    emp_pk_list="";
                    
                    for (var i=1;i<=grdLBReport.rows-1;i++)
                    {
                        if (grdLBReport.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdLBReport.GetGridData(i,icremp_pk) + ",";
                            txtContract_Type.text=grdLBReport.GetGridData(i,icrcontract_type);
                        }   
                    }
                    if (emp_pk_list=="")
                        alert("Please choose employees to print");
                    else
                    {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                        datLBReport.Call();
                    }
                }    
                break;
            case 2: //current labour contract list
            {
                txtReport_tmp.text="rpt_list_lb.aspx";
                datFind_Report.Call();
                break;
            }
            case 3: //history report
                alert("Report here");
                break;
            case 4: //labour contract preparation
                if (FindSameType(grdLBPreparation,24)==false)
                {
                    alert("Have to print the same type of report!" + "\n"  + "Phải chọn cùng một kiểu của loại hợp đồng!");
                    break;
                }
                else 
                {
                    emp_pk_list="";
                    
                    for (var i=1;i<=grdLBPreparation.rows-1;i++)
                    {
                        if (grdLBPreparation.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdLBPreparation.GetGridData(i,22) + ",";                        
                        }   
                    }
                    if (emp_pk_list=="")
                        alert("Please choose employees to print");
                    else
                    {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                        txtReport_tmp.text="rpt_lb_signning.aspx";
                    }
                    datFind_Report.Call();
                 }
                break;
           case 5:  // appendix contract
                  emp_pk_list="";
                  appendix_times="";
                    
                    for (var i=1;i<=grdAppendix.rows-1;i++)
                    {
                        if (grdAppendix.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdAppendix.GetGridData(i,23) + ",";
                           
                        }   
                    }
                 if (emp_pk_list=="")
                        alert("Please choose employees to print");
                 else
                 {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                        url =System.RootURL + '/reports/ch/ae/rpt_appendix_contract.aspx?emp_pk=' + emp_pk_list;
                        window.open(url); 
                 }
                break;   
            case 6:  // appendix contract history
                  emp_pk_list="";
                  appendix_times="";
                    
                    for (var i=1;i<=grdAppendix_His.rows-1;i++)
                    {
                        if (grdAppendix_His.GetGridData(i,0)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdAppendix_His.GetGridData(i,20) + ",";
                           
                        }   
                    }
                 
                 if (emp_pk_list=="")
                        alert("Please choose employees to print");
                 else
                 {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                        url =System.RootURL + '/reports/ch/ae/rpt_appendix_contract.aspx?emp_pk=' + emp_pk_list;
                        window.open(url); 
                 }
                break;   
        }
    
    
}
//-------------------------------------------------------------------------------------
function FindSameType(obj_grid,col) //check report of grid just one labour contract type
{
    var irow;
    irow=0;
    for (var i=1;i<=obj_grid.rows-1;i++)
    {
        if (obj_grid.GetGridData(i,0)=="-1")
        {
            if (obj_grid.GetGridData(i,col) !=obj_grid.GetGridData(irow,col) && irow !=0)
                return false;
            irow=i;
            
        }
    }
    return true;
    
}
//-----------------------------------labour contract report -------------------------

function OnHistLabourContract()
{
    if (imgArrow.status=="expand")
    {
        txtEmp_PK.text=grdLBReport.GetGridData(grdLBReport.row,icremp_pk);
        datLabourContractHis.Call("SELECT");
    }
}
//-------------------------check select column of grid labour contract history-------------------
function AfterSelectHist() 
{
    
        if (grdLBHist.col==0)
        {
            var i,icurrow;
            icurrow=grdLBHist.row;
            if ( grdLBHist.GetGridData(icurrow,0)==-1)
                for (i=1;i<=grdLBHist.rows-1;i++)
                    if (icurrow!=i) 
                        grdLBHist.SetGridText(i,0,"0");
        }
    
}
//------------Appendix Contract----------------
function OnHistAppendixContract()
{
    if (imgArrow_A.status=="expand")
    {
        txtEmp_PK_A.text=grdAppendix.GetGridData(grdAppendix.row,20);
        txtAppendix_Times_A.text=grdAppendix.GetGridData(grdAppendix.row,21); 
        txtContract_Type_A.text = grdAppendix.GetGridData(grdAppendix.row,22);
        datAppendixContractHis.Call("SELECT");
    }
}
//-------------------------------------------------------------------------------------
</script>

<body style=" margin-bottom:0; margin-top:0; margin-right:0" >
<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datTeamData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_team_data_all" > 
                <input>
                    <input bind="txtDept" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_allowance_lb" > 
                <input>
                    <input bind="txtAllowance" /> 
                </input> 
                <output>
                    <output bind="lblA1" />
                    <output bind="lblA2" />
                    <output bind="lblA3" />
                    <output bind="lblA4" />
                    <output bind="lblA5" />
                    <output bind="lblA6" />
                    <output bind="lblA7" />
                    <output bind="lblA8" />
                    <output bind="lblDisplay1" />
                    <output bind="lblDisplay2" />
                    <output bind="lblDisplay3" />
                    <output bind="lblDisplay4" />
                    <output bind="lblDisplay5" />
                    <output bind="lblDisplay6" />
                    <output bind="lblDisplay7" />
                    <output bind="lblDisplay8" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datLBReport" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_lb_report" > 
                <input>
                    <input bind="txtContract_Type" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-----------------------tab labour contract manage------------------------------->
<gw:data id="datLabourContractManage" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="2,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29" function="hr.sp_sel_lb_manage_v2 " procedure="HR.sp_upd_labour_contract_v2"> 
                <input bind="grdLabourContract">
                    <input bind="lstDept_Code_M" /> 
                    <input bind="lstGrp_Code_M" /> 
                    <input bind="lstTemp_M" /> 
                    <input bind="txtTemp_M" /> 
                    <input bind="lstKindPB_M" /> 
                    <input bind="dtFromBProbation_M" /> 
                    <input bind="dtToBProbation_M" /> 
                    <input bind="dtFromEProbation_M" /> 
                    <input bind="dtToEProbation_M" /> 
                    <input bind="lstKindLB_M" />
                    <input bind="dtFromBContract_M" /> 
                    <input bind="dtToBContract_M" /> 
                    <input bind="dtFromEContract_M" /> 
                    <input bind="dtToEContract_M" /> 
                    <input bind="lstStatus1" />
					<input bind="lstNation1" />
					<input bind="lstWorkGroup1" />
                </input> 
                <output bind="grdLabourContract"/>
            </dso> 
        </xml> 
</gw:data>
<!-----------------------tab labour contract report------------------------------->
<gw:data id="datLabourContractReport" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="hr.sp_sel_lb_report_v2" > 
                <input bind="grdLBReport">
                    <input bind="lstOrg_Code_R" /> 
                    <input bind="lstOrgType_R" /> 
                    <input bind="lstTemp_R" /> 
                    <input bind="txtTemp_R" /> 
                    <input bind="lstKindPB_R" /> 
                    <input bind="dtFromBProbation_R" /> 
                    <input bind="dtToBProbation_R" /> 
                    <input bind="dtFromEProbation_R" /> 
                    <input bind="dtToEProbation_R" /> 
                    <input bind="lstKindLB_R" />
                    <input bind="dtFromBContract_R" /> 
                    <input bind="dtToBContract_R" /> 
                    <input bind="dtFromEContract_R" /> 
                    <input bind="dtToEContract_R" /> 
                    <input bind="lstStatus2" />
					<input bind="lstNation_R" />
					<input bind="lstWorkGroup_R" />
                </input> 
                <output bind="grdLBReport"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<gw:data id="datLabourContractHis" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="hr.sp_sel_labour_contract_his" > 
                <input bind="grdLBHist">
                    <input bind="txtEmp_PK" /> 
                </input> 
                <output bind="grdLBHist"/>
            </dso> 
        </xml> 
</gw:data>
<!-----------------------tab labour contract preparation------------------------------->
<gw:data id="datLabourContractPre" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="hr.sp_sel_labour_contract_pre" > 
                <input bind="grdLBPreparation">
                    <input bind="lstDept_Code_P" /> 
                    <input bind="lstGrp_Code_P" /> 
                    <input bind="lstTemp_P" /> 
                    <input bind="txtTemp_P" /> 
                    <input bind="lstKindLB_P" />
                    <input bind="dtFromSign" /> 
                    <input bind="dtToSign" /> 
                    <input bind="lstStatus3" />
					<input bind="lstNation_Pre" />
					<input bind="lstWorkGroup_Pre" />
                </input> 
                <output bind="grdLBPreparation"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------Tab Appendix Contract----------------->
<gw:data id="datAppendixContract" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22" function="hr.sp_sel_appendix_contract" procedure="HR.sp_upd_appendix_contract"> 
                <input bind="grdAppendix">
                    <input bind="lstDept_Code_A" /> 
                    <input bind="lstGrp_Code_A" /> 
                    <input bind="lstTemp_A" /> 
                    <input bind="txtTemp_A" /> 
                    <input bind="lstKindLB_A" />
                    <input bind="lstStatus_A" /> 
                    <input bind="lstHaveAppendix_A" />
					<input bind="lstNation_Ap" />
					<input bind="lstWorkGroup_Ap" />
                </input> 
                <output bind="grdAppendix"/>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------------------------>
<gw:data id="datAppendixContractHis" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  function="hr.sp_sel_appendix_contract_his" > 
                <input bind="grdAppendix_His">
                    <input bind="txtEmp_PK_A" /> 
                    <input bind="txtAppendix_Times_A" />
                    <input bind="txtContract_Type_A" />
                </input> 
                <output bind="grdAppendix_His"/>
            </dso> 
        </xml> 
</gw:data>

<!--------------------main table----------------------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate=""  > 

    <table name="Manage" id="management" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%">
        <tr  style="width:100%;height:100%" valign="top">
            <td  style="width:100%;height:100%">
                <table width="100%" id="tblexp" style="height:23%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%" valign="middle"  >
                        <td width="14%"  align="right" ></td>
                        <td width="15%"  align="left" >
                        </td>
                        <td width="10%"  align="right" ></td>
                        <td width="21%" colspan=3 align="left" ></td>
                       
                        <td width="9%" style="border:0" align="right" valign="middle"></td>
				       <td width="10%" style="border:0"></td>
			            <td  width="8%"  colspan=2 style="border:0"> </td>
			            <td width="4%"  align="right" ></td>
                        <td width="3%" style="border:0" align="right"></td>
                        <td width="3%"  align="right" ></td>
                        <td width="3%"  align="right" ></td>
                    </tr>
					<tr style="border:0;width:100%" valign="middle"  >
                        <td width="14%"  align="right" >Department              
                        </td>
                        <td width="15%"  align="left" ><gw:list  id="lstDept_Code_M" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeDept()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type='06' order by a.seq")%>|ALL|Select All
                            </data>
                        </gw:list></td>
                        <td width="10%"  align="right" >Team/Section</td>
                        <td width="21%" colspan=3 align="left" >
                         <gw:list  id="lstGrp_Code_M" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type in('07','12') order by a.seq")%>|ALL|Select All</data>
							</gw:list>
                        </td>
                       
                        <td width="9%" style="border:0" align="right" valign="middle">Work Group</td>
				       <td width="10%" style="border:0" colspan = "3"><gw:list  id="lstWorkGroup1" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
									<%=ESysLib.SetListDataSQL("SELECT PK, WORKGROUP_NM FROM THR_WORK_GROUP WHERE DEL_IF = 0")%>|ALL|Select All
							</data>
                        </gw:list></td>
			            <td width="4%"  align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch_M"   alt="Search"  onclick="OnSearch(datLabourContractManage)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave()"/>
                        </td>
                        <td width="3%"  align="right" >
                         <gw:imgBtn img="delete" id="ibtnDelete"   alt="Delete"  onclick="OnDelete()"/>
                        </td>
                        <td width="3%"  align="right" ></td>
                    </tr>
					<tr align=top cellpadding="0" cellspacing="0" >
						<td align="right"  ><font color="black">Probation Type</td>
						
						<td  >
							<gw:list id="lstKindPB_M"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0002' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td    align=right><font color="black">Begin Probation</td>
		    	        <td  width="10%"> <gw:datebox id="dtFromBProbation_M" nullaccept styles='width:80%'   lang="<%=Session("Lang")%>"/></td>
			            <td  width="1%" align=center>~</td>
			            <td  width="10%"> <gw:datebox id="dtToBProbation_M" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
			
						<td  align=right><font color="black">End Probation</td>
						<td  ><gw:datebox id="dtFromEProbation_M"  styles='width:80%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
			            <td  width="1%" align=center>~</td>
			            <td  width="10%"> <gw:datebox id="dtToEProbation_M" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
			            <td  align=right><font color="black"></td>
			            <td colspan=3  align=right><font color="black"></td>
					</tr>
					<tr align=top >
						<td align="right" ><font color="black">Contract Type</font></td>
						<td >
							<gw:list id="lstKindLB_M"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td align=right  ><font color="black">Begin Contract</td>
			            <td  > <gw:datebox id="dtFromBContract_M" nullaccept styles='width:80%'   lang="<%=Session("Lang")%>"/></td>
			            <td   align=center>~</td>
			            <td  > <gw:datebox id="dtToBContract_M" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
						</td>
						
						<td    align=right><font color="black">End Contract</td>
						<td   ><gw:datebox id="dtFromEContract_M"  styles='width:80%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
			            <td   align=center>~</td>
			            <td  > <gw:datebox id="dtToEContract_M" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
						<td colspan=3 align=right></td>
					</tr>
					<tr style="border:0;width:100%" valign="middle"  >
                        <td width="14%"  align="right" >Nation</td>
                        <td width="15%"  align="left" ><gw:list  id="lstNation1" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list></td>
                        <td width="10%"  align="right" >Search by</td>
                        <td width="10%" align="left" >
				            <gw:list  id="lstTemp_M" value="2" styles='width:100%' onchange=""> 
						            <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
				            </gw:list>
			            </td>
                       
                        <td width="11%" colspan="2" style="border:0" align="right" valign="middle"> 
				            <gw:textbox id="txtTemp_M" onenterkey   ="OnSearch(datLabourContractManage)" styles='width:100%'/>
			            </td>
				       <td width="10%" align="right" style="border:0">Status</td>
			            <td  width="8%" style="border:0"><gw:list id="lstStatus1"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > </td>
			            <td width="4%"  align="right" ></td>
                        <td width="3%" style="border:0" align="right"></td>
                        <td width="3%"  align="right" ></td>
                        <td width="3%"  align="right" ></td>
                    </tr>
				    <tr align=top >
					    <td align=right style="color:RED"><font color="black" >SET GRID COLUMN</font></td>
						<td align=right><font color="black" >Create LB</font><gw:checkbox id="chkCheckCreate" value="F" onclick="OnSetGrid(chkCheckCreate,grdLabourContract,icmcreate_contract)" ></gw:checkbox ></td>
						<td colspan=2 align="right" >Change Contract Type</td>
						<td   colspan=2 align=right colspan=3><gw:list id="lstKindLB_Set"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%></data>
							</gw:list > 	</td>
					    <td  align="center" >
                         <gw:imgBtn img="set" id="ibtnSet_M"   alt="Set Grid"  onclick="OnSetLBType(grdLabourContract,icmnewcontract_type)"/>
                        </td>
                        <td colspan=1 ><font color="black" >Get Salary</font><gw:checkbox id="chkGetSalary" value="F" onclick="OnSetGrid(chkGetSalary,grdLabourContract,icmget_salary)" ></gw:checkbox ></td>
						<td colspan=2><gw:label id="lblRecord_M"  text="0 record(s)." maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
					</tr>
			     </table>
                 <table cellspacing=0 cellpadding=0 style="height:77%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                            <gw:grid   
						        id="grdLabourContract"  
						        header="_Department|Team/Section|Emp ID|Full Name|D.O.J|Contract No|Create New|Probation Kind|_Old Kind of LC|Contrac Kind|Start Probation|End Probation|Start Contract|End Contract|Get Salary|Total Salary|Basic Salary|Addition Sal|Crane Sal|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_PK"   
						        format="0|0|0|0|4|0|3|2|2|2|4|4|4|4|3|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0"  
						        aligns="2|0|1|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1"  
						        defaults="|||||||||||||||||||||||||||||"  
						        editcol="0|0|0|0|0|1|1|1|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0"  
						        widths="1500|1500|1200|2500|1200|1500|1200|1500|2500|1200|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0|0|0"  
						        styles="width:100%; height:100%"   
						        sorting="T"   
						        acceptNullDate
						        /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>


    <table name="Report" id="tblReport"  width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:98%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table2" style="height:17%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:0%" valign="center"  >
						<td width="14%"  align="right" ></td>
						<td width="15%"  align="left" ></td>
						<td width="10%"  align="right" ></td>
						<td width="21%"  colspan=3 align="left" ></td>
						<td width="9%" style="border:0" align="right" valign="middle"></td>
						<td width="8%" style="border:0"></td>
						<td width="11%" colspan=2 style="border:0"></td>
						<td width="4%"  align="right" ></td>
						<td width="3%" style="border:0" align="right"></td>
						<td width="3%" style="border:0" align="right"></td>
                        <td width="3%" style="border:0" align="right"></td>
                    </tr>
					<tr style="border:0;width:100%;height:5%" valign="center"  >
                        <td width="14%"  align="right" >Department</td>
                        <td width="15%"  align="left" >
                         <gw:list  id="lstOrg_Code_R" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeDept()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type='06' order by a.seq")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="10%"  align="right" >Team/Section</td>
                        <td width="21%"  colspan=3 align="left" >
                         <gw:list  id="lstOrgType_R" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type in('07','12') order by a.seq")%>|ALL|Select All</data>
							</gw:list>
                        </td>
                       
                        <td width="9%" style="border:0" align="right" valign="middle">Work Group</td>
					   <td width="8%" colspan="3" style="border:0"><gw:list  id="lstWorkGroup_R" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
							<data>
									<%=ESysLib.SetListDataSQL("SELECT PK, WORKGROUP_NM FROM THR_WORK_GROUP WHERE DEL_IF = 0")%>|ALL|Select All
							</data>
						</gw:list></td>
                        <td width="4%"  align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch_R"   alt="Search"  onclick="OnSearch(datLabourContractReport)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn id="ibtnPrint_R1" alt="Print Current Labour" img="excel" text="Print Labour" onclick="OnPrint(1)"/>	
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn id="ibtnPrint_R2" alt="Print Current Labour List " img="excel" text="Print Labour" onclick="OnPrint(2)"/>
                        </td>
                        <td width="3%" style="border:0" align="right"></td>
                    </tr>
					<tr style="border:0;width:100%;height:5%" valign="center"  >
						<td width="14%"  align="right" >Nation</td>
						<td width="15%"  align="left" >
							<gw:list  id="lstNation_R" value='01' maxlen = "100" styles='width:100%' >
								<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data>
							</gw:list></td>
						<td width="10%"  align="right" >Search by</td>
						<td width="10%" align="left" ><gw:list  id="lstTemp_R" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
					        </gw:list></td>
						<td width="11%" colspan=2  style="border:0" align="right" valign="middle">
							<gw:textbox id="txtTemp_R" onenterkey   ="OnSearch(datLabourContractReport)" styles='width:100%'/></td>
						<td width="8%" style="border:0" align="right" >Status</td>
						<td width="10%" style="border:0"><gw:list id="lstStatus2"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > </td>
						<td width="4%" colspan="4" align="right" ><gw:label id="lblRecord_R"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
						
                    </tr>
					<tr  style="border:0;width:100%;height:5%" align=top cellpadding="0" cellspacing="0" >
						<td align="right" ><font color="black">Probation Type</td>
						<td  >
							<gw:list id="lstKindPB_R"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0002' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td    align=right><font color="black">Begin Probation</td>
			            <td width="10%"> <gw:datebox id="dtFromBProbation_R" nullaccept styles='width:80%'   lang="<%=Session("Lang")%>"/></td>
			            <td width="1%" align=center>~</td>
			            <td width="10%"> <gw:datebox id="dtToBProbation_R" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
						<td  align=right><font color="black">End Probation</td>
						<td ><gw:datebox id="dtFromEProbation_R"  styles='width:80%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
		                <td  width="1%" align=center>~</td>
		                <td   width="8%"> <gw:datebox id="dtToEProbation_R" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
		                <td  align=right><font color="black"></td>
			            <td colspan=3  align=right><font color="black"></td>
					</tr>
					<tr  style="border:0;width:100%;height:5%" align=top >
					    <td>
					        <table width="100%" style="height:100%">
					            <tr>
					                <td  align="center"><gw:checkbox id="chkCheckReport" value="F" onclick="OnSetGrid(chkCheckReport,grdLBReport,0)" ></gw:checkbox ></td>
						            <td align="right" ><font color="black">Contract Type</font></td>
					            </tr>
					        </table>
					    </td>
						<td width="15%" >
							<gw:list id="lstKindLB_R"  value="ALL" styles='width:100%'>	
								<data><%=Esyslib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td align=right  ><font color="black">Begin Contract</td>
		                <td  width="10%"> <gw:datebox id="dtFromBContract_R" nullaccept styles='width:80%'   lang="<%=Session("Lang")%>"/></td>
		                <td   width="1%" align=center>~</td>
		                <td  width="10%"> <gw:datebox id="dtToBContract_R" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>
						<td    align=right><font color="black">End Contract</td>
						<td   ><gw:datebox id="dtFromEContract_R"  styles='width:80%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
			            <td  width="1%" align=center>~</td>
			            <td width="10%" > <gw:datebox id="dtToEContract_R" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
			            <td  colspan=3 align="right"></td>
						<td align="right" valign="bottom" ><img status="expand" id="imgArrow" src="../../../system/images/iconmaximize.gif" alt="Show history"  style="cursor:hand" onclick="OnToggle()"  /> </td>
					</tr>
			        
				</table>
                <table id="tblMainHist" cellspacing=0 cellpadding=0 style="height:53%" width=100% border=1>
                    <tr valign="top">
                        <td  style="width:100%;height:100%;"> 
                            <gw:grid   
	                            id="grdLBReport"  
	                            header="Select|Department|Team/Section|Emp ID|Full Name|D.O.J|Contract No|Probation Kind|Contract Kind|Start Probation|End Probation|Start Contract|End Contract|Total Salary|Basic Salary|Addition Sal|Crane Sal|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_PK|_Contract Type"   
	                            format="3|0|0|0|0|4|0|0|0|0|0|0|1|1|1|11|1|1|1|1|1|1|1|0|0|0|0|0"  
	                            aligns="1|2|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="|||||||||||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            widths="800|1700|1700|1200|2500|1200|2000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500|0"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            oncellclick = "OnHistLabourContract()" /> 

                        </td>
                    </tr>
               </table> 
               <table id="tblHist" cellspacing=0 align = top cellpadding=0 style="width:100%;height:30%" border=1 >				
		            <tr style="width:100%;height:20%">		
			            <td width="95%" align="right" style="border:0"><gw:label id="lblRecord_H" text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12"></gw:label></td>													
			            <td width="5%"  style="border:0" align="right">		
			                <gw:imgBtn id="ibtnPrint_H" alt="Print History Labour" img="excel" text="Print History Labour" onclick="OnPrint(3)"/>				
			            </td>			
			        </tr>
			       
	                <tr style="width:100%;height:80%">
	                    <td colspan=4 >		
		                   <gw:grid   
	                            id="grdLBHist"  
	                            header="Select|_Department|Team/Section|Emp ID|Full Name|_Job|D.O.J|Contract No|Probation Kind|Contract Kind|Start Probation|End Probation|Start Contract|End Contract|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_Contract Type"   
	                            format="3|0|0|0|0|0|4|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|0|0|0|0"  
	                            aligns="1|2|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="||||||||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            widths="800|1700|1700|1200|2500|2000|1200|2000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            oncellclick="AfterSelectHist()"/> 
		                </td>
	                </tr>	
                </table>
            </td>
        </tr>
    </table>
    <table name="Preparation" id="Table3"  width="100%" cellpadding="0"  cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table1" style="height:12%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:0%" valign="center"  >
						<td width="10%" align="right" ></td>
						<td width="15%"  align="left" ></td>
						<td width="10%"  align="right" ></td>
						<td width="15%" colspan=3  align="left" ></td>
						<td width="7%"  align="right" ></td>
						<td width="10%" align=right></td>
						<td width="12%"  colspan=2 style="border:0" align="right" valign="middle"></td>
						<td width="7%" style="border:0"></td>
						<td colspan=2 width="6%"  style="border:0"></td>
						<td width="6%"  align="right" ></td>
						<td width="3%" style="border:0" align="right"></td>
						<td width="3%" style="border:0" align="right"></td>
                    </tr>
					<tr style="border:0;width:100%;height:5%" valign="center"  >
						<td width="10%" align="right" >Department</td>
						<td width="25%" colspan="2" align="left" ><gw:list  id="lstDept_Code_P" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeDept()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type='06' order by a.seq")%>|ALL|Select All
                            </data>
                        </gw:list></td>
						<td width="7%"  align="right" >Team/Section</td>
						<td width="20%" colspan="2" align="right" ><gw:list  id="lstGrp_Code_P" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type in('07','12') order by a.seq")%>|ALL|Select All</data>
							</gw:list></td>
						<td width="22%"  colspan="2" style="border:0" align="right" valign="middle">Work Group</td>
						<td colspan="3" width="6%"  style="border:0"><gw:list  id="lstWorkGroup_Pre" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
							<data>
									<%=ESysLib.SetListDataSQL("SELECT PK, WORKGROUP_NM FROM THR_WORK_GROUP WHERE DEL_IF = 0")%>|ALL|Select All
							</data>
						</gw:list></td>
						<td width="6%"  align="right" ></td>
						<td width="3%" style="border:0" align="right"></td>
						<td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="search" id="ibtnSearch_P"   alt="Search"  onclick="OnSearch(datLabourContractPre)"/>
                        </td>
						<td width="3%" style="border:0" align="right">
                         <gw:imgBtn id="idBtnPrint_P" alt="Print Current Labour" img="excel" text="Print Labour" onclick="OnPrint(4)"/>	
                        </td>
                    </tr>
					<tr style="border:0;width:100%;height:5%" valign="center"  >
                        <td width="10%" align="right" >Search by</td>
                        <td width="15%"  align="left" ><gw:list  id="lstTemp_P" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
					        </gw:list></td>
                        <td width="10%"  align="right" ><gw:textbox id="txtTemp_P" onenterkey   ="OnSearch(datLabourContractPre)" styles='width:100%'/>
				        </td>
						<td width="15%"  align="right" >Status</td>
                       <td width="10%" colspan="2" align=right><font color="black"><gw:list id="lstStatus3"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > </td>
						<td></td>
                       <td width="7%"  align="right" style="border:0">Nation</td>
				        <td colspan=2 width="6%"  style="border:0"><gw:list  id="lstNation_Pre" value='01' maxlen = "100" styles='width:100%' >
							<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list></td>
                        <td width="6%" colspan="3" align="right" ><gw:label id="lblRecord_P"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                    </tr>
					<tr style="border:0;width:100%;height:5%" align=top cellpadding="0" cellspacing="0" >
					    <td width="5%" align="center"  style="border:0"><gw:checkbox id="chkCheckPre" value="F" onclick="OnSetGrid(chkCheckPre,grdLBPreparation,0)"></gw:checkbox ></td>		 
						<td align="right" width="15%" >Current Contract Type</td>
						<td  >
							<gw:list id="lstKindLB_P"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td  colspan=4 align=right style="color:Blue; font-size:13"><font color="black" >PERIOD OF SIGNING LABOUR CONTRACT</font></td>
						<td width="8%" align=right style="color:Blue; font-size:13"><font color="black" >From</font></td>
						<td  width="7%"><gw:datebox id="dtFromSign"  styles='width:80%' nullaccept  lang="<%=Session("Lang")%>"/>  </td>						
						<td  width="3%" align=center>To</td>
						<td  width="7%"> <gw:datebox id="dtToSign" nullaccept styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
						<td colspan=3 align=right></td>
					</tr>
				</table>
                <table cellspacing=0 cellpadding=0 style="height:88%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                            <gw:grid   
	                            id="grdLBPreparation"  
	                            header="Select|Department|Team/Section|Emp ID|Full Name|D.O.J|Contract No|Probation Kind|Contract Kind|Start Probation|End Probation|Start Contract|End Contract|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_Contract Type"   
	                            format="3|0|0|0|0|4|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|0|0|0|0"  
	                            aligns="1|2|2|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="|||||||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            widths="800|1700|1700|1200|2500|1200|2000|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    
    
    <table name="Appendix" id="idAppendix"  width="100%" height="100%" cellpadding="0"  cellspacing="0" >
		<tr width="100%">
			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
			<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
		</tr>
		<tr>
			<td colspan="5" align="right" >Department </a>                  
            </td>
			<td colspan="10" align="left" >
                         <gw:list  id="lstDept_Code_A" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeDept()" >
                           <data>
								<%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type='06' order by a.seq")%>|ALL|Select All
							</data>
                        </gw:list>
			</td>
			<td colspan="5"  align="right" >Team/Section</td>
			<td colspan="10" colspan=3 align="left" >
			 <gw:list  id="lstGrp_Code_A" value='ALL' maxlen = "100" styles='width:100%' >
				<data><%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type in('07','12') order by a.seq")%>|ALL|Select All</data>
				</gw:list>
			</td>
			<td colspan="5"  align="right" >Work Group</td>
			<td colspan="10" colspan=3 align="left" ><gw:list  id="lstWorkGroup_Ap" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
					<data>
							<%=ESysLib.SetListDataSQL("SELECT PK, WORKGROUP_NM FROM THR_WORK_GROUP WHERE DEL_IF = 0")%>|ALL|Select All
					</data>
				</gw:list>
			</td>
			<td colspan="1" align="right" ></td>
			<td colspan="1" align="right" >
			 <gw:imgBtn img="search" id="ibtnSearch_A"   alt="Search"  onclick="OnSearch(datAppendixContract)"/>
			</td>
			<td colspan="1" style="border:0" align="right">
			 <gw:imgBtn img="save" id="ibtnSave_A"    alt="Save"  onclick="OnSave_A()"/>
			</td>
			<td colspan="1" align="right" >
			 <gw:imgBtn img="delete" id="ibtnDelete_A"   alt="Delete"  onclick="OnDelete_A()"/>
			</td>
			<td colspan="1" style="border:0" align="right">		
				<gw:imgBtn id="ibtnPrint_A" alt="Print Appendix Contract" img="excel" text="Print Appendix Contract" onclick="OnPrint(5)"/>				
			</td>	
			
		</tr>
		<tr>
			<td colspan="5" align="right" >Search by</td>
			<td colspan="5" align="left" >
                        <gw:list  id="lstTemp_A" value="2" styles='width:100%' onchange=""> 
						            <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
				            </gw:list>
			</td>
			<td colspan="5"  align="right" >
				<gw:textbox id="txtTemp_A" onenterkey   ="OnSearch(datAppendixContract)" styles='width:100%'/>
			</td>
			<td colspan="5" align="right" >Nation</td>
			<td colspan="10" align="right" ><gw:list  id="lstNation_Ap" value='01' maxlen = "100" styles='width:100%' >
	<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list></td>
			<td colspan="5" align="right" >Status</td>
			<td colspan="5" align="right" ><gw:list id="lstStatus_A"  value="ALL" styles='width:100%'>	
					<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0022' ORDER BY A.seq")%>|ALL|Select All</data>
				</gw:list > </td>
			<td  colspan="10" align=right><gw:label id="lblRecord_A"  text="0 record(s)." maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
		</tr>
		<tr>
			<td colspan="2" align="center"><gw:checkbox id="chkCheckReport_A" value="F" onclick="OnSetGrid(chkCheckReport_A,grdAppendix,0)" ></gw:checkbox ></td>
			<td colspan="8" align="right" ><font color="black">Current Contract Type</font></td>
			<td colspan="5" >
				<gw:list id="lstKindLB_A"  value="ALL" styles='width:100%'>	
					<data><%=ESysLib.SetListDataSQL("select a.code,a.code_nm from vhr_hr_code a where a.id='HR0001' ORDER BY A.seq")%>|ALL|Select All</data>
				</gw:list > 										
			</td>
			<td  colspan="5" style="border:0" align="right" valign="middle">Have Appendix</td>
			<td  colspan="5" style="border:0">
				<gw:list  id="lstHaveAppendix_A" value="2" styles='width:100%' onchange=""> 
						<data>LIST|Y|Yes|N|No|ALL|Select All</data> 
				</gw:list>
			</td>
			<td  colspan="10" align="right" ><font color="black" >Create Appendix</font></td>
			<td  colspan="1"  align="right" ><gw:checkbox id="chkAppendix" value="F" onclick="OnSetGrid(chkAppendix,grdAppendix,8)" ></gw:checkbox ></td>
			<td  colspan="4"  align="right" ></td>
			<td  colspan="8" align="center" ><font color="black" >Get Salary</font><gw:checkbox id="chkGetSalary_A" value="F" onclick="OnSetGrid(chkGetSalary_A,grdAppendix,10)" ></gw:checkbox ></td>
			<td  colspan="1" align=right></td>
			
			<td colspan="1" align="right" valign="bottom" ><img status="expand" id="imgArrow_A" src="../../../system/images/iconmaximize.gif" alt="Show Appendix"  style="cursor:hand" onclick="OnToggle_A()"  /> </td>
		</tr>
        <tr height="100%">
            <td colspan="50" height="100%">
                
                <table id="idAppendix_Main" cellspacing=0 cellpadding=0 style="height:100s%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;">
                           <gw:grid   
	                            id="grdAppendix"  
	                            header="Select|_Department|Team/Section|Emp ID|Full Name|Contract No|Contract Kind|Appendix No|Create New|Singature Date|Get Salary|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_CONTRACT_PK|APPENDIX_PK"   
	                            format="3|0|0|0|0|0|0|0|3|4|3|1|1|1|1|1|1|1|1|1|1|1|1|1"  
	                            aligns="1|0|0|0|0|0|0|0|1|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="||||||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0"  
	                            widths="800|1700|1700|1700|2500|2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500|1500"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            oncellclick = "OnHistAppendixContract()" 
	                            /> 
		                </td>
                    </tr>    
                </table>
                <table id="idAppendix_His" cellspacing=0 cellpadding=0 style="height:30%" width=100% border=1>
                    <tr style="width:80%;height:20%">		
			            <td width="75%" align="right" style="border:0"><gw:label id="lblRecord_His_A" text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12"></gw:label></td>													
			            <td width="5%"  style="border:0" align="right">		
			                <gw:imgBtn id="ibtnPrint_A" alt="Print Appendix History" img="excel" text="Print Appendix History" onclick="OnPrint(6)"/>				
			            </td>			
			        </tr>
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td  style="width:100%;height:100%;">
                           <gw:grid   
	                            id="grdAppendix_His"  
	                            header="Select|Department|Team/Section|Emp ID|Full Name|Appendix No|Contract No|Contract Kind|Singature Date|Salary|ALLOW1|ALLOW2|ALLOW3|ALLOW4|ALLOW5|ALLOW6|ALLOW7|ALLOW8|_EMP_PK|TIMES|_APPENDIX_PK"   
	                            format="3|0|0|0|0|0|0|0|4|1|1|1|1|1|1|1|1|1|1|1|1"  
	                            aligns="1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
	                            acceptNullDate
	                            defaults="|||||||||||||||||||||"  
	                            editcol="1|0|0|0|0|0|0|0|1|0|1|0|0|0|0|0|0|0|0|0|0"  
	                            widths="800|1700|1700|1700|2500|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|2000|1500|1500|1500|1500"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            /> 
		                    </td>
                    </tr>    
                </table>
            </td>
        </tr>
    </table>


</gw:tab>
 
</body>
 
  
<gw:textbox id="txtDept" styles="display:none"/>	
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="lblA1" text="" styles="display:none"/> 
<gw:textbox id="lblA2" text="" styles="display:none"/> 
<gw:textbox id="lblA3" text="" styles="display:none"/> 
<gw:textbox id="lblA4" text="" styles="display:none"/> 
<gw:textbox id="lblA5" text="" styles="display:none"/> 
<gw:textbox id="lblA6" text="" styles="display:none"/> 
<gw:textbox id="lblA7" text="" styles="display:none"/> 
<gw:textbox id="lblA8" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay1" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay2" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay3" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay4" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay5" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay6" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay7" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay8" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay1_sal" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay2_sal" text="" styles="display:none"/> 
<gw:textbox id="lblDisplay3_sal" text="" styles="display:none"/> 
<gw:textbox id="txtAllowance" text="HR0019" styles="display:none"/>
<gw:textbox id="txtEmp_PK" text="" styles="display:none"/> 
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtContract_Type" styles="display:none"/>
<gw:textbox id="txtEmp_PK_A" text="" styles="display:none"/> 
<gw:textbox id="txtContract_Type_A" styles="display:none"/>
<gw:textbox id="txtAppendix_Times_A" styles="display:none"/>

</html>
