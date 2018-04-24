<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script type="text/javascript">

var strcodereturn; //return data of common code popup to check whether you change data of common code.
var strdata; //data of common code popup
var bdelete=false;
var binit=true;
var obj_list_code; //temp list of common code list
var v_language = "<%=Session("SESSION_LANG")%>";

var lang= "<%=Session("Lang")%>"; 
var iale_days=12;
var flag_allowance=0;
var list_sal_rate;
var l_exp=0;
var check_init=0;

function BodyInit()
{          
    if (v_language!="ENG")
        System.Translate(document); 
    iale_days="<%=ESysLib.SetDataSQL("select nvl(num_1,12) from vhr_hr_code where id='HR0006' and code='05'")%>";
    if (iale_days=="")
        iale_day=12;     
    <%=ESysLib.SetGridColumnComboFormat("grdFamily",4,"select code,CODE_NM from vhr_hr_code where id='HR0024' order by code_nm") %>
    OnReset();
    lblLoginID.enabled=false;
    lblMaxID.enabled=false;
    //OnCollapse();
     txtUser_PK.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    menu_id.text=System.Menu.GetMenuID();
    ChangeColorItem(lstOrg_Code.GetControl());
   list_sal_rate="<%=ESysLib.SetListDataSQL("select s.pk,s.RATE from thr_table_salary s where del_if=0 order by s.rate")%>|0|Select...";
    	
	
    l_flag_load.text="ALL";
    datPro_load_form.Call();
}

//-----------------------------------------------

 function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }


//-------------------------------

 function OnToggle(obj)
{	
    if(txt_sal_security.text=='Y')
	{
		var imgtemp;
		if (obj==1)
		{
					
			var imgArrow = document.all("imgArrow");   

			if(imgArrow.status == "expand")
			{
				OnCollapse();
				imgArrow.status = "collapse";
				imgArrow.src = "../../../system/images/down.gif";
			}
			else
			{
						
					OnExpand();
					imgArrow.status = "expand";
					imgArrow.src = "../../../system/images/up.gif";
					if(flag_allowance==0)
					{
						flag_allowance=1;
						datAllowance.Call();
					}    
			}
		}
	}  
    
	if(obj==2)	
	{			
        var imgAddress = document.all("imgAddress");  		
		if(imgAddress.status == "show")
        {					
                imgAddress.status = "hide";
                imgAddress.src = "../../../system/images/close_popup.gif";
			    imgAddress.alt="Hide detail address";
			    var row_addr1= document.all("a1");
				var row_addr2= document.all("a2");
				var row_addr3= document.all("a3");
				row_addr1.style.display="";
				row_addr2.style.display="";
				row_addr3.style.display="";
				var maintab=document.all("main");
				var imgArrow = document.all("imgArrow"); 				
				if(imgArrow.status == "expand")
				{
					maintab.style.height="80%";					
				}
				else
				{
					maintab.style.height="80%";					
				}
				
        }
        else 
        {					
                imgAddress.status = "show";
                imgAddress.src = "../../../system/images/iconmaximize.gif";
			    imgAddress.alt="Show detail address";
			    var row_addr1= document.all("a1");
				var row_addr2= document.all("a2");
				var row_addr3= document.all("a3");
				row_addr1.style.display="none";
				row_addr2.style.display="none";
				row_addr3.style.display="none";
				var maintab=document.all("main");
				var imgArrow = document.all("imgArrow"); 				
				if(imgArrow.status == "expand")
				{
					maintab.style.height="80%";					
				}
				else
				{
					maintab.style.height="80%";					
				}				
        }
	}
}
//-----------------------------------------------

function OnCollapse()
{
    for (var i=1; i<=3;i++)
    {
        var temp;
        temp="h" + i;
        var coll= document.all(temp);
        coll.style.display="none"
        var maintab=document.all("main");
        maintab.style.height="80%";
    }
}
//-----------------------------------------------

function OnExpand()
{
    for (var i=1; i<=3;i++)
    {
        var temp;
        temp="h" + i;
        var coll= document.all(temp);
        coll.style.display=""
        var maintab=document.all("main");
        maintab.style.height="100%";
    }
    
    
}

//-----------------------------------------------
function OnShowPopup(strtemp,objlist)
{
    if (strtemp==1 )
    {
               
        if(txt_First_use.text=="0")
        {
            var strcom
            var fpath = System.RootURL + "/form/ch/ae/chae00010_emp_id_code.aspx?idcode=Emp";
            var obj  = System.OpenModal(  fpath , 900 , 450 , 'resizable:yes;status:yes');
        }
        if(txt_First_use.text=="1")
        {   
            var strcom
            var fpath = System.RootURL + "/form/ch/ae/chae00010_emp_id_code_Auto.aspx?byhand="+txt_Employee_ByHand.text;
              var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:16;dialogHeight:10;dialogLeft:10;dialogTop:330;edge:sunken;scroll:no;unadorned:yes;help:no');
            if (obj!=null)
            {
                if(obj=="1")
                txt_Employee_ByHand.text="N";
                else
                txt_Employee_ByHand.text="Y";
                
            }
            
        }
    
    }
	else if (strtemp==3)
    {
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
			lstOrg_Code.value = obj;
			OnGetCostCenter();
            //txtUpperOrg.text=obj;
            //datOrgData.Call();
            
        }
    }
    else if (strtemp==4)
    {
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_group_salary.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {lstSalarGroup.value=obj;
			//lstOrg_Code.value = obj;
            //txtUpperOrg.text=obj;
            //datOrgData.Call();
            
        }
    }
    else if (strtemp==5) //cost center popup 
    {
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_cost_center.aspx?id="+txtCost_Center_pk.text+"&company_pk=" +  "<%=Session("COMPANY_PK")%>";
        var obj  = System.OpenModal(  fpath , 900 , 600 , 'resizable:yes;status:yes');
       // var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            //alert(obj[0]);
			txtCost_Center_pk.text=obj[0]
			objlist.text=obj[1];
            
        }
    }
    else
    {        
        var strcom;
        obj_list_code=objlist;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_com_code.aspx?code=" +  strtemp ;
        var strid = strtemp;
        
	    var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	    if (obj!=null)
	    {
	        strcodereturn=obj[1];           
	        txtComCodeID.text= strtemp;
	        if (obj[0]==1 )  //modify common code
	            datGetNewCode.Call("SELECT");
	        
	        else if (strcodereturn!=0)
	        {	            
                obj_list_code.value=strcodereturn; 				
	        }
	        
	    }
    }
    
}
//--------------------------------------------------
function OnDataReceive(obj)
{   

    if(obj.id == "datPro_load_form")
    {
        if(l_flag_load.text=="ALL")//load all
        {
            //gan lai cac gia tri
            txtFlag_View.text=l_txtFlag_View.text;
            lblMaxID.text=l_lblMaxID.text;
            txt_sal_security.text=l_txt_sal_security.text;
            txt_First_use.text=l_txt_First_use.text;
            txt_Employee_ByHand.text=l_txt_Employee_ByHand.text;

            if(txtFlag_View.text == 'Y')
            {
                ibtnAdd.style.display = "none";
                ibtnUpdate.style.display = "none";
                ibtnDelete.style.display = "none";
                ibtnResetE.style.display = "none";

                ibtnSave_O.style.display = "none";
                ibtnSave_F.style.display = "none";
                ibtnSave_E.style.display = "none";
                ibtnSave_E4.style.display = "none";

                ibtnAdd_O.style.display = "none";
                ibtnAdd_F.style.display = "none";
                ibtnAdd_E.style.display = "none";
                ibtnAdd_E4.style.display = "none";

                ibtnDelete_O.style.display = "none";
                ibtnDelete_F.style.display = "none";
                ibtnDelete_E.style.display = "none";
                ibtnDelete_E4.style.display = "none";
            }
            if((Trim(txtUser_PK.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	             datUser_info.Call();
            else //ket thuc load form
                check_init=1;
                     	    
        }  
        else if(l_flag_load.text=="MAX_ID")//load only max id
        {
            lblMaxID.text=l_lblMaxID.text;
        }
    }

   
   if(obj.id=="datCheckID")
        {   
            if(txt_Employee_ByHand.text=="Y")
                {
                    OnCheckAdd();
                }             
        }
    
   
   if (obj.id=="datUser_info")
   {
        ChangeColorItem(lstOrg_Code.GetControl());
        check_init=1;
   }
   
   if (obj.id=="datAllowance")
   {    
        
      if(lblA1.text=="0")
        {
            txtAllow1AMT.style.display="none";
            lblA1.style.display="none";
           
        }
        if(lblA2.text=="0")
        {
            txtAllow2AMT.style.display="none";
            lblA2.style.display="none";
           
        }
        if(lblA3.text=="0")
        {
            txtAllow3AMT.style.display="none";
            lblA3.style.display="none";
           
        }
        if(lblA4.text=="0")
        {
            txtAllow4AMT.style.display="none";
            lblA4.style.display="none";
           
        }
        if(lblA5.text=="0")
        {
            txtAllow5AMT.style.display="none";
            lblA5.style.display="none";
           
        }
        if(lblA6.text=="0")
        {
            txtAllow6AMT.style.display="none";
            lblA6.style.display="none";
           
        }
        if(lblA7.text=="0")
        {
            txtAllow7AMT.style.display="none";
            lblA7.style.display="none";
           
        }
        if(lblA8.text=="0")
        {
            txtAllow8AMT.style.display="none";
            lblA8.style.display="none";
           
        } 
   }        
   else if (obj.id=="datEmployee")
   {		
        l_exp=0;
        ibtnResetE.SetEnable(true);
		txt_Employee_ByHand.text=txt_Employee_ByHand_YN.text;
        if (bdelete==true ) //delete information
        {
            bdelete=false;
            OnReset();
        }
        else //select and update information
        {
            imgFile.SetDataText(txtPhoto_PK.text);
            if (dtSTContract.value=="") //if employee have probation contract then you can modify probation type, but else can't
            {
                SetEnablePro(true);
                if (lstProKind.value =="03") //other probation
                    dtEDProbate.SetEnable(true);
                else
                    dtEDProbate.SetEnable(false);
            }
            else
                SetEnablePro(false);
        }
		
        l_flag_load.text="MAX_ID";
        datPro_load_form.Call();
   }
   else if (obj.id=="datCheckExist")
   {
        if (txtFlag.text==1)
        {    
            if (txtExistTemp.text!="" )
            {
                if (confirm("Have already person id of employee id:" + txtExistTemp.text + ", Do you want to continue?" +"\nĐã trùng số CMND với nhân viên : "+txtExistTemp.text + ", Bạn có muốn tiếp tục?"))
                {      
                    txtFlag.text="2";                
                    datCheckExist.Call();
                }
                else
                    txtPersonalID.GetControl().focus();
            }
            else
            {      
                txtFlag.text="2";             
                datCheckExist.Call();
            }
        }
        else
        {    
            if (txtExistTemp.text!="" )
            {
                alert("Have already card id of employee id:" + txtExistTemp.text+"\nĐã trùng card với nhân viên: "+txtExistTemp.text);
                txtIDCard.GetControl().focus();
            }
            else
            {
                txtFull_FName.text=CutAccent(txtFullName.text);
                txtPhoto_PK.text=imgFile.GetData();
                //continue save info
                if (datEmployee.GetStatus()==10 || datEmployee.GetStatus()==0)
                {
                    if (confirm("Do you want to update? \n Bạn có muốn cập nhật?"))
                    {
                        datEmployee.StatusUpdate();
                        datEmployee.Call();
                    }
                }
                else if (datEmployee.GetStatus()==20)
                {
                    if(txtEMPID.text==""&& txt_Employee_ByHand.text=="Y")
                        {
                            alert("Please insert employee by hand!");
                            return;
                        }
                    if(txt_Exist_Emp_ID.text=="1" && txt_Employee_ByHand.text=="Y")
                        {
                            alert("You can't add new employee .\nEmployee id "+txtEMPID.text+ " exists !");
                            return; 
                        }
                    
                    if (confirm("Do you want to add new employee? \n Bạn muốn thêm mới?"))
                        {
                            txt_Employee_ByHand_YN.text = txt_Employee_ByHand.text;// luu gia tri byhand y/n
                            //alert(txtPhoto_PK.text);
                            datEmployee.Call();
                        }
                }
                
            }
        }
   }
   else if (obj.id=="datCheckDelete")
   {
       
        if (txtDelete_Flag.text==1)
            alert("You can't delete beause having time machine \n Bạn không thể xóa vì nhân viên đã có công");
        else if (txtDelete_Flag.text==2)
            alert("You can't delete beause having absent time \n Bạn không thể xóa vì nhân viên đã có trong danh sách vắng .");
        else
        { 
            bdelete=true;
            datEmployee.StatusDelete();
            datEmployee.Call();
           
        }
   }
   else if (obj.id=="datEmpPK_Base_EmpID")
   {
        if (txtEmp_PK_NB.text=="-1")
            alert("Can't find this employee with emp id like " + txtEMPID.text+"\n Không tìm thấy nhân viên này.");
        else
        {
            txtEmp_PK.text=txtEmp_PK_NB.text;
            datEmployee.Call("SELECT");
        }
        
   }
   else if (obj.id=="datEmpIDBackNext")
   {
        if (txtEmp_PK_NB.text=="-1")
            alert("Can't find employee\nKhông tìm thấy nhân viên này.");
        else
        {
            txtEmp_PK.text=txtEmp_PK_NB.text;
            datEmployee.Call("SELECT");
        }    
   }
   else if (obj.id=="datProbationDate")
   {
        if (lstProKind.value =="03") //have to input end probation
            dtEDProbate.SetEnable(true);
        else
            dtEDProbate.SetEnable(false);
        dtSTProbate.SetEnable(false);
            
   }
   else if (obj.id=="datGetNewCode")
   {
         var strcom;
         var ctllist;
        if (obj_list_code.value!="")
            strcom=obj_list_code.value;
        obj_list_code.SetDataText(txtCodeTemp.text);
        if (strcodereturn!=0)
            obj_list_code.value=strcodereturn;
        else
            obj_list_code.value=strcom;
        
        
   }
   else if (obj.id==="datSalaryGroupData")
   {
		datSalRate.Call();
   }    
}
//----------------------------------------------
function OnSearch()
{
	if(check_init==1)
	{
		var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
		var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
		if (obj!=null)
		{
			txtEmp_PK.text=obj[0];
		   
			datEmployee.Call("SELECT");
		}
	}	
}
//----------------------------------------------
function OnAdd()
{
    //OnReset();
	if(check_init==1)
	{
		var fpath = System.RootURL + "/form/ch/ae/chae00010_rec_emp.aspx?p_status=ALL&p_request=ALL" ;
		var adata = new Array();
		adata  = System.OpenModal(  fpath , 950 ,600, 'resizable:yes;status:yes;');
		if (adata!=null)
		{
			txtClose_YN.text = adata[51];      //close_yn
			 if(txtClose_YN.text == "Y")
			 {
				alert("Recruitment has closed, you can't get information this person!\nĐợt tuyển dụng đã đóng, bạn không thể lấy thông tin cho người này!")
				return;
			 }
			 else
			 {
				 txtFullName.text = adata[2];   //full Name
				 dtJoinDT.value = adata[47];    //joint_dt  
				 lstEmp_Type.value = adata[48]; //emp_type
				 lstOrg_Code.value = adata[27];   // Org
				 txtLivingAdd.text = adata[10];  //Current Address
				 txtHomePhone.text = adata[13];  //Home phone
				 txtTel.text = adata[12];       //Hand phone          
				 txtEmail.text = adata[15];     // Email
				 txtPerAdd.text = adata[11];      //per address
				 lstSEX.value = adata[3];    //sex
				 txtPersonalID.text = adata[6];     // personal id
				 dtIssueDT.value = adata[7];     //issue date   
				 lstPlaceID.value = adata[8];    //place id
				 txtBirthDT.text = adata[4];    // birth date
				 lstBirthPlace.value = adata[5]; // birth place
				 lstJob.value = adata[29];        // Job
				 lstPosition.value = adata[28];       // Position
				 lstNation.value = adata[49];         // Nation
				 lstEthnic.value = adata[9];           //Ethnic
				 lstEducation.value = adata[16];      //Education

				 txtRec_PK.text = adata[50];        //rec pk
				 //imgFile.setData("3570");
			 }
		}
	}	
}
//-------------------------------------------
function OnDelete()
{
	if(check_init==1)
	{
		if (confirm("Do you want to delete this employee?\Bạn muốn xóa?"))
		{
			datCheckDelete.Call();
		}
	}	
    
}
//--Kiem tra EmpID da ton tai hay chua khi su dung Byhand
function CheckEmpID()
{
    if(txt_Employee_ByHand.text=="Y" && txtEMPID.text!="" )
        {
            datCheckID.Call();   
        }

}
//------------------------------------------
function OnUpdate()
{  
	if(check_init==1)
	{
		if(txt_Employee_ByHand.text=="")
			txt_Employee_ByHand.text="N";
		 // Byhand
		if(txt_Employee_ByHand.text=="Y")
		{   
            if(txtEMPID.text=="")
			{
				alert("Please insert employee Id");
				return;
			}
			 if (datEmployee.GetStatus()==20) //chi khi add new moi check 
             {
                    //alert(datEmployee.GetStatus())
				    CheckEmpID();
             }
             else
			    OnCheckAdd(); 
		}
		else
			OnCheckAdd();  
	}		
    
}
//----------------------------------------------
function OnCheckAdd()
{
    if (txtFullName.text=="")
    {
        alert("Please input full name! \n Vui lòng nhập họ và tên");
        txtFullName.GetControl().focus();
        return;
    }
	if (dtJoinDT.value=="")
    {
        alert("Have to input join date! \n Vui lòng nhập ngày vào.");
        dtJoinDT.GetControl().focus();
        return;
    }
    if (Trim(lstOrg_Code.value)=="")
    {
        alert("Please choose Organization! \n Vui lòng chọn phòng ban");
        return;
    }
    
	if (Trim(lstWork_Grp.value)=="")
    {
        alert("Please choose Work Group ! \n");
        return;
    }
    if (txtBirthDT.text=="")
    {
        alert("Please input birth date! \n Vui lòng nhập ngày sinh");
        txtBirthDT.GetControl().focus();
        return;
    }
    
    var t= CheckBirthDate();
    if (t==1)
	{
		if (!confirm("Employee under 18!Do you want to continue? \n Nhân viên này chưa đủ 18tuổi, bạn muốn tiếp tục?"))
		    return;
	}
	else if(t==2)
	{	
		alert("Year must be 4 character num, ex 1980,pls input again. \n Năm phải là 4 kí tự, ví dụ 1980, vui lòng nhập lại.");
		return;
	}
	else if(t==3)
	{	
		alert("Incorrect type, ex dd/mm/yyyy, pls input again \n Nhập ngày tháng năm không hợp lệ.");
		return;
	}
	else if(t==4)
	{	
		alert("Incorrect month, month >=1 and month <= 12, pls input again \n Kiểu tháng không hợp lệ.");
		return;
	}
	else if(t==5)
	{	
		alert("Incorrect day, day <= the last day of the month, pls input again\nSố ngày tối đa trong tháng không đúng.");
		return;
	}
    if (Trim(lstProKind.value)=="")
    {
        alert("Have to choose probation kind!\nVui lòng chọn loại thử việc");
        return;
    }
    if (dtJoinDT.value!="" && dtSTProbate.value!="" && dtSTProbate.value < dtJoinDT.value)
    {
        alert("Begin probation date have to larger than or equal to join date!\nNgày thử việc phải lớn hoặc bằng ngày ngày vào.");
        dtSTProbate.GetControl().focus();
        return;
    }
    if (dtJoinDT.value!="" && dtEDProbate.value!="" && dtEDProbate.value < dtJoinDT.value)
    {
        alert("End probation date have to larger than or equal to join date!\nNgày hết thử việc phải lớn hoặc bằng ngày vào.");
        dtEDProbate.GetControl().focus();
        return;
    }
    if (dtSTProbate.value!="" && dtEDProbate.value!="" && dtEDProbate.value < dtSTProbate.value)
    {
        alert("End probation date have to larger than start probation date!\nNgày hết thử việc phải lớn hoặc bằng ngày thử việc.");
        dtEDProbate.GetControl().focus();
        return;
    }
    if (Trim(dtEDProbate.value)=="")
    {
        alert("Please input end probation date!\nVui lòng nhập ngày hết thử .");
        return;
    }    
    
    if (Trim(lstStatus.value)=="")
    {
        alert("Have to choose status!\nVui lòng chọnn status.");
        return;
    }    
    if (Trim(lstSalaryType.value)=="")
    {
        alert("Salary Type cannot be NULL!\nVui lòng chọn phương thức tính lương.");
        return;
    }
    if (lstStatus.value!="A" && dtLeaveDT.value=="")
    {  
        alert("Have to input leave date with resign status!\nBạn phải nhập ngày nghỉ việc");
        
        return; 
    }
    if (lstStatus.value=="A" && Trim(lstResignType.value)!="")
    {  
        alert("Active status haven't got resign reason!\nĐang còn làm việc thì không thể có lý do nghỉ việc.");
        
        return; 
    }
    if ((lstStatus.value=="A" || lstStatus.value=="") && dtLeaveDT.value!="")
    {
        alert("Have to clear leave date with active status!\nĐang còn làm việc thì không thể có ngày nghỉ việc.");
        
        return;
    }
    if (lstStatus.value=="")
    {
        alert("Have to input status!\Vui lòng chọn status");
        return;
    }
    if (dtJoinDT.value!="" && dtLeaveDT.value!="" && dtJoinDT.value > dtLeaveDT.value)
    {
        alert("Leave date have to larger than or equal to join date!\nNgày nghỉ việc phải lớn hay bằng ngày vào làm.");
        dtEDProbate.GetControl().focus();
        return;
    }
    
	if (txtPersonalID.text!="")
	    CheckExistPersonID();
    else
    {
        txtFlag.text="2";
        datCheckExist.Call();    
    }
}
//-----------------------------------------------
function CheckExistPersonID()
{
    txtFlag.text=1;
    datCheckExist.Call();
}
//-----------------------------------------------
function CheckBirthDate()
{
    var i,dt,yyyy,mm,dd,dem
	var MyDate =new Date();
	
	var SDay=MyDate.getDate();
	var SMonth=MyDate.getMonth();
	var SYear=MyDate.getFullYear();
	dt=Trim(txtBirthDT.text)
	//dt="-1/2/1978"
	dem=0
	
	mm=""
	dd=""
	yyyy=dt.substr(dt.length-4,4);
	if(dt=="")
		return 0; //khong xet
	if(isNaN(yyyy))
		return 2;
	else
		yyyy=Number(yyyy)
		
	if(dt.length>4)
	{
		for(var j=0;j<dt.length;j++)
			if(dt.charAt(j)=='/')
				dem+=1;
		if(dem!=2)
			return 3;
	}
	i=0;
	while(i<dt.length-4)
	{
		if(i<2)
		{
			if(dt.charAt(i)!='/')
				dd+=""+dt.charAt(i);
		}
		else
			if(dt.charAt(i)!='/')
					mm+=""+dt.charAt(i);
		i+=1;
	}

	if((dd=="")||(mm==""))
	{ //ngay hoac thang khong co -> chi lay nam
		txtBirthDT.text=yyyy
		if((yyyy>=SYear)||(SYear-yyyy)<18)
			return 1;
	}
	else //day du ngay thang
	{
		if ((SYear-yyyy)<18)
			return 1;
		else
		{
			if ((Number(SYear)-Number(yyyy))==18)//xet toi thang, ko can xet ngay
			{
				if(Number(mm)>Number(SMonth)+1)
					return 1;
			}
		//kiem tra ngay hop le
		var lday =getDaysInMonth(String(yyyy)+String(mm));
			if (Number(mm) < 1 || Number(mm) > 12 ) 
				return 4;
			else if ((Number(dd) > lday)||(Number(dd)<0))
				return 5;
		}
		
	}
	
	return 0;
}
//-----------------------------------------------
function getDaysInMonth(yyyymm) //xac dinh thang do co bao nhieu ngay
{
   // returns the last day of a given month
    var m,y,tmpDate,checkMonth,lastDay
	
	m = parseInt(yyyymm.substr(4,2))-1;
	y = parseInt(yyyymm.substr(0,4));
	tmpDate = new Date(y, m, 28);
	checkMonth = tmpDate.getMonth();
	lastDay = 27;

    while(lastDay <= 31)
    {
        temp = tmpDate.setDate(lastDay + 1);
        if(checkMonth != tmpDate.getMonth())
            break;
        lastDay++
    }
    return lastDay;
}
//--------------------------------------------------
function SetEnablePro(obj)
{
    dtJoinDT.SetEnable(obj);
    dtSTProbate.SetEnable(false);
    dtEDProbate.SetEnable(false);
    lstProKind.SetEnable(obj);
}
//--------------------------------------------------
function OnReset()
{
    lstContractKind.SetEnable(false);
    lstProKind.value=" ";
    dtSTContract.SetEnable(false);
    dtEDContract.SetEnable(false);
    SetEnablePro(true);
    txtManager.SetEnable(false);
    if (datEmployee.GetStatus()!=20)
            datEmployee.StatusInsert();
    txtPhoto_PK.text="";
    imgFile.SetDataText("");
    txtEmp_PK.text="";
    txtEMPID.text="";
    txtFullName.text="";
    txtFull_FName.text="";
    txtPhoto_PK.text="";
    lstStatus.value="A";
    lstNation.value="01";
    dtLeaveDT.text=" ";
    lstBirthPlace.value="";
    txtCostCenter.value="";
	lstBankBranch.value="";
    //alert(iale_days);
    txtAnnualLeave.text=iale_days;
    lstManager_fix.value="N";
    
    //lstJob.value="";
    //lstPosition.value="";
    lstEducation.value="";
    lstEthnic.value="02";
    lstReligion.value="";
    dtSTContract.text="";
    dtEDContract.text="";
    dtSTProbate.text="";
    dtEDProbate.text="";
    lstContractKind.value="01";
    lstBank.value="";
    txtContractNo.text="";
    //txtAnnualLeave.text="12";
    lstOTYN.value="Y";
    txtBasicSal.text="";
    txtProbSal.text="";
    txtAllow1AMT.text="";
    txtAllow2AMT.text="";
    txtAllow3AMT.text="";
    txtAllow4AMT.text="";
    txtAllow5AMT.text="";
    txtAllow6AMT.text="";
    txtAllow7AMT.text="";
    txtAllow8AMT.text="";
    lstSocialYN.value="N";
    lstUnempYN.value="N";
    dtUnempDT.text="";
    txtSocialNo.text="";
    lstSocialPlace.value="";
    dtHealthDT.text="";
    dtSocialDT.text="";
    lstHealthYN.value="N";
    txtHealthNo.text="";
    lstHealthPlace.value="";
    dtHealthDT.text="";
    lstResignType.value="";
    txtAccount.text="";
    lstSalYN.value="Y";
    lstSalaryType.value="01";
    lstPayType.value="01";


    lstPlaceID.value="";
    lstCostGroup.value="";
    lstCostGroupKind.value="";
    lstNativeCountry.value="";
    lstMoneyKind.value="01";
    lstUnion.value="N";    
    ibtnResetE.SetEnable(false);
    txtCostCenter.SetEnable(false);

    txtBACity.text="";
    txtBADistrict.text="";
    txtBAWard.text="";
    txtBANo.text="";

    txtCACity.text="";
    txtCADistrict.text="";
    txtCAWard.text="";
    txtCANo.text="";

    txtPACity.text="";
    txtPADistrict.text="";
    txtPAWard.text="";
    txtPANo.text="";
	
	txtBACity_code.text="";
    txtBADistrict_code.text="";
    txtBAWard_code.text="";
    
    txtCACity_code.text="";
    txtCADistrict_code.text="";
    txtCAWard_code.text="";
    
    txtPACity_code.text="";
    txtPADistrict_code.text="";
    txtPAWard_code.text="";
   
    
}
//-----------------------------------------------
function OnDataError(oData)
{
  //alert(eval(oData).errmsg);
    if (eval(oData).errno == 20001)
    {
		alert("Database problem 1: "+ eval(oData).errmsg);
    }
    else if (eval(oData).errno == 20002)
    {
		alert("Database problem 2: "+ eval(oData).errmsg);
    }
	else if (eval(oData).errno > 0)
	{
		alert("Unexpected error: "+ eval(oData).errmsg);
	}	
	
}
//-----------------------------------------------

function CutAccent(str)
{
    var aaccent=new Array("Á","À","Ả","Ã","Ạ","Â","Ậ","Ấ","Ầ","Ẩ","Ẫ","Ậ","Ă","Ắ","Ằ","Ẳ","Ẵ","Ặ","Ê","Ế","Ề","Ể","Ễ","Ệ","Í","Ì","Ỉ","Ĩ","Ị","Ó","Ò","Ỏ","Õ","Ọ","Ô","Ố","Ồ","Ổ","Ỗ","Ộ","Ơ","Ớ","Ờ","Ở","Ỡ","Ợ","Ư","Ứ","Ừ","Ử","Ữ","Ự","Ú","Ù","Ủ","Ũ","Ụ","Ý","Ỳ","Ỷ","Ỹ","Ỵ","Đ");
	var araccent=new Array("A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","E","E","E","E","E","E","I","I","I","I","I","O","O","O","O","O","O","O","O","O","O","O","O","O","O","O","O","O","U","U","U","U","U","U","U","U","U","U","U","Y","Y","Y","Y","Y","D");
    
    for (var i=0;i<aaccent.length ;i++)
        str=ReplaceString(str,aaccent[i],araccent[i]);
    return str;
}
//-----------------------------------------------

function ReplaceString(s1,s2,s3)
{
    while (s1.search(s2)!=-1)
        s1=s1.replace(s2,s3)
    return s1;
}
//--------------------------------------------------
function OnBackNext(obj)
{

	if(check_init==1)
	{	
		if (obj==1)
			txtBackNext.text=1;
		else
			txtBackNext.text=2;
		datEmpIDBackNext.Call();
	}	
}
//---------------------------------------------------
function checkKey() 
{ 
	var c = String.fromCharCode (event.keyCode); 
	var x = c.toUpperCase().charCodeAt(0) ; 
	event.keyCode = x; 
	
}
//--------------------------------------------------
function OnChangeSalaryGroup()
{
    if(lstSalarGroup.value=='0')
    {
        
        lstSalaryRate.SetDataText(list_sal_rate);
        lstSalaryRate.value='0';
		
    }
    else
    {
		
        datSalaryGroupData.Call();
    }    
}
//-------------------------------------------------
function OnChangeRate()
{
    //alert(lstSalaryRate.value);
    
    datSalRate.Call();
}
//-----------------------------------------------
function Numbers(e) 
{ 
  //  var ctrl=idTEL.GetControl(); 
    var keynum; 
    var keychar; 
    var numcheck; 
    keynum =event.keyCode; 
        
    if(window.event) // IE 
    { 
      keynum = e.keyCode; 
    } 
    else if(e.which) // Netscape/Firefox/Opera 
    { 
      keynum = e.which; 
    } 
    keychar = String.fromCharCode(keynum); 
    numcheck = /\d/; 
    return numcheck.test(keychar); 
}
//----------------------------------------------------------------------
function ChangeProbType()
{
    if (dtJoinDT.text!="" )
    {
        if (lstProKind.value!=" ") 
            datProbationDate.Call();
    }
    else
    {
        alert("Please input join date at first!\NVui lòng nhập ngày vào.");
        lstProKind.value=" ";
    }
}
//--------------------------------------------
function OnEnterEmp()
{
    
    datEmpPK_Base_EmpID.Call();
}
//------------------------continued with expand employee----------------
function OnChangeTab()
{   
    var icurpage=tabMain.GetCurrentPageNo();
    if (icurpage==1) //expand employee
    {
        l_exp=1;
        imgArrow.style.display="none";
        
        if (txtEmp_PK.text!="" && txtEmp_PK.text!=-1)
        {
            
            lblEmployee.text="EMPLOYEE:  " + txtEMPID.text + " - " + txtFullName.text;
            ibtnAdd_E.SetEnable(true);
            ibtnDelete_E.SetEnable(true);
            ibtnSave_E.SetEnable(true);
            ibtnPrinter_E.SetEnable(true);
            ibtnAdd_F.SetEnable(true);
            ibtnDelete_F.SetEnable(true);
            ibtnSave_F.SetEnable(true);
            ibtnPrinter_F.SetEnable(true);
            ibtnAdd_O.SetEnable(true);
            ibtnDelete_O.SetEnable(true);
            ibtnSave_O.SetEnable(true);
            ibtnPrinter_O.SetEnable(true);
            ibtnMainReport.SetEnable(true);
            if (txtEmp_PK.text != txtEmp_PK_E.text)
                datExperience.Call("SELECT");
        }
        else
        {
            ibtnAdd_E.SetEnable(false);
            ibtnDelete_E.SetEnable(false);
            ibtnSave_E.SetEnable(false);
            ibtnPrinter_E.SetEnable(false);
            ibtnAdd_F.SetEnable(false);
            ibtnDelete_F.SetEnable(false);
            ibtnSave_F.SetEnable(false);
            ibtnPrinter_F.SetEnable(false);
            ibtnAdd_O.SetEnable(false);
            ibtnDelete_O.SetEnable(false);
            ibtnSave_O.SetEnable(false);
            ibtnPrinter_O.SetEnable(false);
            ibtnMainReport.SetEnable(false);
        }
    }
    else
    {
        imgArrow.style.display="" ;
        
    }
        
    
}
//------------------------------------------------
function OnAddNew_E(obj)
{
    
        obj.AddRow();
        obj.SetGridText(obj.rows-1,1,txtEmp_PK.text);
        
        obj.GetGridControl().TopRow=obj.rows-1;
         
   /* if (obj==1)
    {
        grdExperience.AddRow();
        grdExperience.SetGridText(grdExperience.rows - 1,1,txtEmp_PK.text);
    }
    else if (obj==2)
    {
        grdFamily.AddRow();
        grdFamily.SetGridText(grdFamily.rows-1,1,txtEmp_PK.text);
    }
    else if (obj==3)
    {
        grdOther.AddRow();
        grdOther.SetGridText(grdOther.rows-1,1,txtEmp_PK.text);
    }
    else if (obj==4)
    {
        grdEDU.AddRow();
        grdEDU.SetGridText(grdEDU.rows-1,1,txtEmp_PK.text);
        
        grdEDU.GetGridControl().TopRow=grdEDU.rows-1;
    }*/
}
//------------------------------------------------
function OnSave_E(obj)
{
    if (confirm("Do you want to save information?\nBạn có muốn lưu?"))
    {
            l_exp=0;
            obj.Call();    
    }
}
//------------------------------------------------
function OnDelete_E(obj)
{
    if (confirm("Do you want to delete information?\nBạn muốn delete."))
    {
        obj.DeleteRow();
     /*   
        if (obj==1)
        {   
            grdExperience.DeleteRow();
           // datExperience.Call();    
        }
        else if (obj==2)
        {
            grdFamily.DeleteRow();
            datFamily.Call();
        }
        else
        {
            grdOther.DeleteRow();
            datOther.Call();
        }*/
    }
}
//------------------------------------------------------------------
function OnDataReceive_E(obj)
{   
   if(l_exp==1)
   {
        if (obj.id=="datExperience")
        {
            if (txtEmp_PK.text!=txtEmp_PK_E.text)
               datEdu.Call("SELECT");
               
        }
        else if (obj.id=="datEdu")
        {
            if (txtEmp_PK.text!=txtEmp_PK_E.text)
               datFamily.Call("SELECT");
               
        }
        else if (obj.id=="datFamily")
        {
            if (txtEmp_PK.text!=txtEmp_PK_E.text)
               datOther.Call("SELECT");
        }
        else
            if (txtEmp_PK.text!=txtEmp_PK_E.text)
                txtEmp_PK_E.text=txtEmp_PK.text;
   }         
    
}
//------------------------end  with expand employee----------------
function OnAllReport()
{
    var url =System.RootURL + '/reports/ch/ae/rpt_employee_information.aspx?emp_pk=' + txtEmp_PK.text  ;
    window.open(url); 
}
//-----------------------------------------------------------------
function OnReport_E(obj)
{
    var url=System.RootURL;
    switch (obj)
    {
        case 1:
        {
            url=url + '/reports/ch/ae/rpt_employee_experience.aspx?emp_pk=' + txtEmp_PK.text  ;
            break;
        }
        case 2:
        {
            url=url + '/reports/ch/ae/rpt_employee_family.aspx?emp_pk=' + txtEmp_PK.text  ;
            break;
        }
        case 3:
        {
            url=url + '/reports/ch/ae/rpt_employee_note.aspx?emp_pk=' + txtEmp_PK.text  ;
            break;
        }
    }
    window.open(url); 
}
function OnShowManager()
{
    var strcom
    
            var fpath = System.RootURL + "/form/ch/fd/chfd00020_search_emp.aspx";
            var obj  = System.OpenModal(  fpath , 800 , 500 , 'resizable:yes;status:yes');
            if (obj!=null)
	        {
                txtManager_id.text=obj[1];
                txtManager.text=obj[1]+"-"+obj[2];
	        }
	        
}

function OnAdd_Old()
{

    OnReset();

    var fpath = System.RootURL + "/form/ch/ae/chae00010_add_old.aspx" ;
    var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	if (obj!=null)
	{
               
              
               txtFullName.text=obj[3];
               txtFull_FName.text=obj[4];
               if(obj[5]!="")
                    imgFile.SetDataText(obj[5]);
               //txtPhoto_PK.text=obj[5];
               lstStatus.value='A';//6
               lstSEX.value=obj[6];

               txtBirthDT.text=obj[7];
               lstBirthPlace.value=obj[8];
               lstNation.value=obj[9];

               txtTel.text=obj[10];
               txtPerAdd.text=obj[11];
               txtLivingAdd.text=obj[12];
               lstEducation.value=obj[13];
               txtPersonalID.text=obj[14];

               dtIssueDT.value=obj[15];
               lstPlaceID.value=obj[16];
               lstMarial.value=obj[17];

               lstEthnic.value=obj[18];
               lstReligion.value=obj[19];

               txtAnnualLeave.text=obj[20];
               lstEmp_Type.value=obj[21];
               lstOTYN.value=obj[22];
               lstJob.value=obj[23];
               lstPosition.value=obj[24];

               lstSalaryType.value=obj[25];
               lstPayType.value=obj[26];
               txtAccount.text=obj[27];
               lstNetSal_YN.value=obj[28];
               lstMoneyKind.text=obj[29];
               txtLabor_No.text=obj[30];
               dtLabor.value=obj[31];
               txtPit_No.text=obj[32];
               lstCostGroup.value=obj[33];
               lstCostGroupKind.value=obj[34];
               lstNativeCountry.value=obj[35];
               lstSal_period.value=obj[36];
               lstNativeCountry.value=obj[37];
               lstBankBranch.value=obj[38];
              
	}
}


function OnShowPopupAddr(strtemp,objtxt,char5,objtxt_code) 
{	
    var strcom;
    var obj_txt=objtxt;
	var obj_txt_code=objtxt_code;
    if(char5=="HR0203")
    {
        tmp_char5.text="ALL";       
    }
    else
    {
        if(char5.text=="")
        {
            tmp_char5.text="ALL";
        }
        else
        {
            tmp_char5.text=char5.text;
        }       
    }
	
    var fpath = System.RootURL + "/form/ch/ae/chae00010_addr_com_code_view.aspx?code=" +  strtemp +"&char5=" + tmp_char5.text;
	//alert(fpath);
    var strid = strtemp;    
	var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');    
	if (obj!=null)
	{			
	    if (obj[1]!=0)
	    {	     
			objtxt_code.text=obj[1];
            obj_txt.text=obj[2];			
	    }			
	}	
}

function onChangeText(objtxt, objtxt_code)
{
	objtxt.text = "";
	objtxt_code.text = "";
}
function OnGetCostCenter()
{
    datGetCostCenter.Call();
}
</script>
<body bgcolor='#F5F8FF'>
<!---------------------main employee tab data control------------------>
<!--
    HR.sp_pro_check_view
    HR_SP_PRO_MAX_EMP_ID

--> 
<!------------------------------------------>
<gw:data id="datPro_load_form" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="hr_sp_pro_load_form"  > 
                <input>
                     <input bind="txtUser_PK" /> 
                    <input bind="menu_id" />    
                    <input bind="txtHr_level" />
                    <input bind="l_flag_load" />
                </input> 
                <output>
                    <output bind="l_txtFlag_View" />
                    <output bind="l_lblMaxID" />
                    <output bind="l_txt_sal_security" />
                    <output bind="l_txt_First_use" />
                    <output bind="l_txt_Employee_ByHand" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<!------------------------------------------>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="txtUser_PK" />
                </input> 
                <output>
                    <output bind="lstOrg_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_SEL_WG_ROLE_2"  > 
                <input>
                    <input bind="lstOrg_Code" />
                    <input bind="txtUser_PK" />
                </input> 
                <output>
                    <output bind="lstWork_Grp" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_display_allowance" > 
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
                    
                </output>
            </dso> 
        </xml> 
</gw:data>





<!------------------------------------->
<gw:data id="datCheckExist" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_check_exist" > 
                <input>
                    <input bind="txtEmp_PK" />
                    <input bind="txtFlag" />  
                    <input bind="txtPersonalID" />
                    <input bind="txtIDCard" />  
                </input> 
                <output>
                    <output bind="txtExistTemp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------>
<gw:data id="datEmployee" onreceive="OnDataReceive(this)" onerror="OnDataError(this)" > 
        <xml> 
            <dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99" function="hr_sel_10010001_main_employee" procedure="HR_upd_10010001_main_employee"> 
                <inout>
                    <inout bind="txtEmp_PK" /> 
                    <inout bind="txtEMPID"/>
                    <inout bind="txtOldCode"/>
                    <inout bind="txtIDCard"/>
                    <inout bind="txtFullName"/>
                    
                    <inout bind="txtFull_FName"/>
                    <inout bind="txtPhoto_PK"/>
                    <inout bind="lstStatus"/>
                    <inout bind="dtJoinDT"/>
                    <inout bind="dtLeaveDT"/>
                    
                    <inout bind="lstProKind"/>
                    <inout bind="lstSEX"/>
                    <inout bind="txtBirthDT"/>
                    <inout bind="lstBirthPlace"/>
                    <inout bind="lstNation"/>
                    
                    <inout bind="txtTel"/>
                    <inout bind="txtPerAdd"/>
                    <inout bind="txtLivingAdd"/>
                    <inout bind="lstEducation"/>
                    <inout bind="txtPersonalID"/>
                    
                    <inout bind="dtIssueDT"/>
                    <inout bind="lstPlaceID"/>
                    <inout bind="lstMarial"/>
                    <inout bind="lstEthnic"/>
                    <inout bind="lstReligion"/>
                    
                    <inout bind="dtSTContract"/>
                    <inout bind="dtEDContract"/>
                    <inout bind="dtSTProbate"/>
                    <inout bind="dtEDProbate"/>
                    <inout bind="lstContractKind"/>
                    
                    <inout bind="txtContractNo"/>
                    <inout bind="txtAnnualLeave"/>
                    <inout bind="lstEmp_Type"/>
                    <inout bind="lstOTYN"/>
                    <inout bind="lstBank"/>
                    
                    <inout bind="lstJob"/>
                    <inout bind="lstPosition"/>
                    <inout bind="txtBasicSal"/>
                    <inout bind="txtProbSal"/>
                    <inout bind="txtAllow1AMT"/>
                    
                    <inout bind="txtAllow2AMT"/>
                    <inout bind="txtAllow3AMT"/>
                    <inout bind="txtAllow4AMT"/>
                    <inout bind="txtAllow5AMT"/>
                    <inout bind="txtAllow6AMT"/>
                    
                    <inout bind="txtAllow7AMT"/>
                    <inout bind="txtAllow8AMT"/>
                    <inout bind="lstSocialYN"/>
                    <inout bind="txtSocialNo"/>
                    <inout bind="lstSocialPlace"/>
                    
                    <inout bind="dtSocialDT"/>
                    <inout bind="lstHealthYN"/>
                    <inout bind="txtHealthNo"/>
                    <inout bind="lstHealthPlace"/>
                    <inout bind="dtHealthDT"/>
                    
                    <inout bind="lstResignType"/>
                    <inout bind="lstPayType"/>
                    <inout bind="txtAccount"/>
                    <inout bind="txtCostCenter"/>
                    <inout bind="lstSalYN"/>
                    
                    <inout bind="lstSalaryType"/>
                    <inout bind="lstSalaryRate"/>
                    <inout bind="lstNetSal_YN"/>                    
                    <inout bind="lstMoneyKind"/>
                    <inout bind="lstUnion"/>

                    <inout bind="txtLabor_No"/>
                    <inout bind="dtLabor"/>
                    <inout bind="txtPit_No"/>                      
                    <inout bind="dtUnempDT"/>             
                    <inout bind="lstUnempYN"/> 

                    <inout bind="lstCostGroup"/>
                    <inout bind="lstCostGroupKind"/>
                    <inout bind="lstNativeCountry"/>                                                            
                    <inout bind="txtHomePhone"/>
                    <inout bind="txtOffPhone"/>

                    <inout bind="txtNContry2"/>
                    <inout bind="txtEmail"/>
					<inout bind="lstOrg_Code"/>					
					<inout bind="lstWork_Grp"/>
					<inout bind="lstSalarGroup"/>

					<inout bind="txt_Employee_ByHand_YN" />
					<inout bind="txtCost_Center_pk" />
					<inout bind="lstBankBranch" />					
					<inout bind="txtManager"/>
					<inout bind="txtManager_id"/>

					<inout bind="lstManager_fix"/>
					<inout bind="txtRec_PK" />
					<inout bind="lstSal_period" /> <%--87--%>
					
					<inout bind="txtBACity_code"/>
					<inout bind="txtBADistrict_code" />
					<inout bind="txtBAWard_code" />
					<inout bind="txtBANo" />
                    <inout bind="txtCACity_code"/>
					<inout bind="txtCADistrict_code" />
					<inout bind="txtCAWard_code" />
					<inout bind="txtCANo"/>
                    <inout bind="txtPACity_code"/>
					<inout bind="txtPADistrict_code" />
					<inout bind="txtPAWard_code" />
					<inout bind="txtPANo" />
					
                    <inout bind="txtBACity"/>
					<inout bind="txtBADistrict"/>
					<inout bind="txtBAWard"/>
										
					<inout bind="txtCACity" />
                    <inout bind="txtCADistrict"/>
					<inout bind="txtCAWard"/>
										
					<inout bind="txtPACity" />
					<inout bind="txtPADistrict" />
                    <inout bind="txtPAWard" />															
               </inout> 
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------>
<gw:data id="datCheckDelete" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_CHECK_DELETE" > 
                <input>
                    <input bind="txtEmp_PK" /> 
                </input> 
                <output>
                    <output bind="txtDelete_Flag" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datEmpPK_Base_EmpID" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_EMPPK_BASE_EMP_ID" > 
                <input>
                    <input bind="txtEMPID" />
					<input bind="txtUser_PK" />
                </input>
                <output>
                    <output bind="txtEmp_PK_NB" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datEmpIDBackNext" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_EMPID_BACK_NEXT" > 
                <input>
                    <input bind="txtBackNext" />
                    <input bind="txtEMPID" />
					<input bind="txtUser_PK" />
                </input>
                <output>
                    <output bind="txtEmp_PK_NB" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<!--gw:data id="datSalaryGroupData1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_rate_data" > 
                <input>
                    <input bind="lstSalarGroup" />
                </input>
                <output>
                    <output bind="txtBand_GradeData" />
                </output>
            </dso> 
        </xml> 
</gw:data-->

<gw:data id="datSalaryGroupData" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="HR_SP_PRO_GROUP_SALARY" > 
            <input> 
                <input bind="lstSalarGroup" />
            </input>
	       <output>
	            <output bind="lstSalaryRate" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datSalRate" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_SAL_RATE" > 
                <input>
                    <input bind="lstSalaryRate" />
                </input>
                <output>
                
                    <output bind="txtBasicSal" />
                    <output bind="txtAllow1AMT" />
                    <output bind="txtAllow2AMT" />
                    <output bind="txtAllow3AMT" />
                    <output bind="txtAllow4AMT" />
                    <output bind="txtAllow5AMT" />
                    <output bind="txtAllow6AMT" />
                    <output bind="txtAllow7AMT" />
                    <output bind="txtAllow8AMT" />                                                                                
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datProbationDate" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_PROBATION_DATE" > 
                <input>
                    <input bind="lstProKind" />
                    <input bind="dtJoinDT" />
                </input>
                <output>
                    <output bind="dtSTProbate" />
                    <output bind="dtEDProbate" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------------------------------->
<gw:data id="datGetNewCode" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="HR_SP_LIST_NEW_CODE" > 
            <input> 
                <input bind="txtComCodeID" />
            </input>
	       <output>
	            <output bind="txtCodeTemp" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>

<!---------------------expand employee tab data control------------------>
<gw:data id="datExperience" onreceive="OnDataReceive_E(this)"  > 
        <xml> 
            <dso  type="grid"  parameter="0,1,3,4,5,6,7,8,9" function="HR_SEL_10010001_EXPERIENCE" procedure="HR_UPD_10010001_EXPERIENCE"> 
                <input bind="grdExperience" >
                    <input bind="txtEmp_PK" />
                </input>
                <output  bind="grdExperience" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datFamily" onreceive="OnDataReceive_E(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10010001_FAMILY" procedure="HR_UPD_10010001_FAMILY" parameter="0,1,3,4,5,6,7,8,9,10,11"> 
                <input>
                    <input bind="txtEmp_PK" />
                </input>
                <output  bind="grdFamily" />
            </dso> 
        </xml> 
</gw:data>

<!----------------------------------->
<gw:data id="datOther" onreceive="OnDataReceive_E(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10010001_OTHER" procedure="HR_UPD_10010001_OTHER" parameter="0,1,3,4,5,6,7"> 
                <input>
                    <input bind="txtEmp_PK" />
                </input>
                <output  bind="grdOther" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datEdu" onreceive="OnDataReceive_E(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10010001_EDU" procedure="HR_UPD_10010001_EDU" parameter="0,1,3,4,5,6,7,8"> 
                <input>
                    <input bind="txtEmp_PK" />
                </input>
                <output  bind="grdEDU" />
            </dso> 
        </xml> 
</gw:data>




<%--------Check EmpID exist---------%>
<gw:data id="datCheckID" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10010001_CHECK_EMP_ID" > 
                <input>
                    <input bind="txtEMPID"/>
                </input> 
                <output>
                    <input bind="txt_Exist_Emp_ID"/>                    
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datGetCostCenter" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="hr_pro_00010_costcenter"  > 
                <input>
                     <input bind="lstOrg_Code" /> 
                     <input bind="lstCostGroup" />
                    <input bind="lstCostGroupKind" />
                    <input bind="txtCost_Center_pk" />
                    <input bind="txtCostCenter" />
                </input> 
                <output>
                    <output bind="lstCostGroup" />
                    <output bind="lstCostGroupKind" />
                    <output bind="txtCost_Center_pk" />
                    <output bind="txtCostCenter" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!---------------------expand employee tab data control------------------>

<!----------------------------------->
 
<gw:tab id="tabMain"  border=1 style="width:100%;height:120%" onpageactivate="" onclick ="OnChangeTab()"> 	
<form name="Main E" id="form1" >
     <table id="main"  cellpadding="0" cellspacing="0" border=1 style="width:100%;height:80%;">
        <tr >
            <td>
                <table  width="100%" style="width:100%;height:100%;" cellpadding="0" cellspacing="0">
                    <tr style="height:5%">
                        <td colspan=11>
                            <table border=1 width=100% cellpadding="0" cellspacing="0">
                                <tr style="border:0">
                                    <td nowrap width=10%  style="border:0" >
                                        Login ID</td>
                                    <td nowrap width=18%  style="border:0">
                                        <gw:label id="lblLoginID"  text="<%=session("USER_ID")%>" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:15" />
                                    </td>
                                    <td nowrap width=8%  style="border:0">
                                        
                                    </td>
                                    
                                    <td nowrap width=8%  style="border:0">
                                        Max EMP ID</td>
                                    <td nowrap width=4%  style="border:0">
                                        <gw:imgBtn img="back" id="ibtnPrev"   styles='width:10%' alt="back" img="in"  text="<<"  onclick="OnBackNext(1)"/>
                                    </td>
                                    <td nowrap width=10% align="center"  style="border:0">
                                        <gw:label id="lblMaxID"  text="" maxlen = "100" styles='color:red;width:100%;font-weight: bold;font-size:13' />
                                    </td>
                                    <td nowrap width=4% align="right"  style="border:0">
                                        <gw:imgBtn img="next"  id="ibtnNext"   styles='width:10%' img="in"  alt="next" text=">>"  onclick="OnBackNext(2)"/>
                                    </td>
                                    <td width=18%  style="border:0">
                                    </td>

                                    <td nowrap width=3%  style="border:0">
                                        <gw:icon id="ibtnAddOld" img="in" text="Add Old" onclick="OnAdd_Old()" />
                                    </td>
                                    <td width=1%  style="border:0">
                                    </td>
                                    <td nowrap width=3%  style="border:0">
                                        <gw:icon id="ibtnAddRec" img="in" text="Add Rec" onclick="OnAdd()" />
                                    </td>
                                    <td width=1%  style="border:0">
                                    </td>
                                    <td nowrap width=3%  style="border:0">
                                        <gw:imgBtn id="ibtnResetE" alt="Reset" img="Reset" text="Reset" onclick="OnReset()" />
                                    </td>
                                    <td nowrap width=3%  style="border:0">
                                        <gw:imgBtn id="ibtnUpdate" alt="Save" img="save" text="Save" onclick="OnUpdate()" />
                                    </td>
                                    <td nowrap width=3%  style="border:0">
                                        <gw:imgBtn id="ibtnSearch"  alt="Popup"  img="popup" text="Search"  onclick="OnSearch()" />
                                    </td>
                                    <td nowrap width=3%  style="border:0">
                                        <gw:imgBtn id="ibtnDelete"  alt="Delete"  img="delete"  text="Delete"  onclick="OnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    <tr style="height:5%">
                        <td nowrap width=10%><a title="Click here to show employee id code" onclick="OnShowPopup(1,'')" href="#tips" >Employee ID(*)</a>
                            </td>
                        <td nowrap width=13%>
                            <gw:textbox id="txtEMPID"  text="" 	maxlen = "10" styles='width:100%;' csstype="mandatory"  onenterkey="OnEnterEmp()" />
                        </td>
                        <td nowrap width=3%>
                        </td>
                        <td nowrap width="9%">
                            Old Code</td>
                        <td nowrap width="12%">
                            <gw:textbox id="txtOldCode" text="" maxlen = "10" styles='width:100%;' />
                        </td>
                        <td nowrap width="3%"></td>
                        <td nowrap width="10%">ID No</td>
                        <td nowrap width="8%">
                            <gw:textbox id="txtIDCard"  text="" maxlen = "20" styles='width:100%;' csstype="mandatory" />
                        </td>
                        <td nowrap width="1%"></td>
                        <td nowrap  width=19% colspan=2  rowspan=5 ><gw:image id="imgFile"   view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:130;height:130"  />
                        </td>
                    </tr>
                    <tr style="height:5%">
                        <td nowrap >
                            Full Name(VN)(*)</td>
                        <td nowrap colspan=1 >
                            <gw:textbox id="txtFullName"  maxlen = "60" text="" styles='width:100%;' csstype="mandatory" onkeypress="checkKey()" />
                        </td>
                        <td></td>
                        <td nowrap >
                            Join Date(*)</td>
                        <td nowrap >
                            <gw:datebox id="dtJoinDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="ChangeProbType()" />
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap width=5%><a title="Click here to show employee type" onclick="OnShowPopup('HR0017',lstEmp_Type)" href="#tips" >
                            Emp Type(*)</a></td>
                        <td nowrap ><gw:list  id="lstEmp_Type" value=" " styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code_nm")%>||
                            </data>
                            </gw:list>
                        </td> 
                        <td nowrap >
                        </td>              
                    </tr>
					<tr style="height:5%">
                        <td nowrap ><a title="Click here to show Organization" onclick="OnShowPopup(3,'')" href="#tips" >
                            Organization(*)</a></td>
                        <td nowrap colspan = "4"> <gw:list  id="lstOrg_Code" value=" " maxlen = "100" styles='width:100%' onchange="OnGetCostCenter()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>| |Select ...
                            </data>
                        </gw:list>
                        <td nowrap ></td>
                        <td nowrap ><a title="Click here to change manager" onclick="OnShowManager()" href="#tips" >
                            Manager</a></td>
                        <td nowrap width=12%><gw:textbox id="txtManager" text="" maxlen = "10" styles='width:100%;' /></td>
						<td nowrap ></td>
                    </tr>
					<tr style="height:5%">
                        <td nowrap >Work Group(*)</td>
                        <td nowrap colspan = "4" ><gw:list  id="lstWork_Grp" value=" " maxlen = "100" styles='width:100%'onchange="" >
								<data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  order by nvl(a.seq,99999999)")%>| |Select ...
                            </data>
							</gw:list></td>
						<td nowrap > </td>
                        <td nowrap >Manager Fix</td>
                        <td nowrap width=12%><gw:list  id="lstManager_fix" value=" " maxlen = "100" styles='width:100%'onchange="" >
                            <data>|Y|Yes|N|No</data>
                            </gw:list>
                        </td>
						<td nowrap ></td>
                    </tr>
                    <tr style="height:5%">
                        <td nowrap >
                            Current Addr</td>
                        <td nowrap  colspan=4 >
                            <gw:textbox id="txtLivingAdd"  text="" maxlen = "100" styles='width:100%' />
                        </td>  
                        <td>
                        </td>             
                        <td nowrap >Annual Leave</td>
                        <td nowrap >
                            <gw:textbox  id="txtAnnualLeave" type="number" format="#,###,###,###.##R" text="12" styles='width:100%' />
                        </td>
                        <td nowrap >
                        </td>
                             
                    </tr>
                    <tr style="height:5%">
                        <td nowrap >Home Phone</td>
                        <td nowrap >
                            <gw:textbox id="txtHomePhone"  text="" maxlen = "100" styles='width:100%' />
                        </td> 
                        <td nowrap ></td> 
                        <td nowrap >Office Phone</td>
                        <td nowrap >
                            <gw:textbox id="txtOffPhone"  text=""  styles='width:100%' tabindex="35" />
                        </td>
                        <td></td>             
                        <td nowrap >Hand Phone</td>
                        <td nowrap ><gw:textbox id="txtTel"  text="" maxlen = "15" styles='width:100%' tabindex="35"  /></td>
                        <td nowrap >
                        </td>
                    </tr>
                    <tr style="height:5%">
                        <td nowrap >Email</td>
                        <td nowrap colspan=4>
                            <gw:textbox id="txtEmail"  text="" maxlen = "100" styles='width:100%' />
                        </td> 
                        <td nowrap >
                        </td>
                         <td nowrap >N Country(2)</td>
                        <td nowrap colspan=4>
							<gw:textbox id="txtNContry2"  text="" maxlen = "100" styles='width:100%'/>
                           
                        </td>
                        
                    </tr>                   
                    <tr style="height:5%">
                        <td nowrap  >
                            Permanent Addr</td>
                        <td nowrap colspan=4>
                            <gw:textbox id="txtPerAdd"  text="" maxlen = "100" styles='width:100%'/>
                        </td>    
                        <td>
                        </td>         
                        <td nowrap ><a title="Click here to show sex code" onclick="OnShowPopup('HR0007',lstSEX)" href="#tips" >
                            Sex</a></td>
                        <td nowrap >
                            <gw:list  id="lstSEX" value=" " styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm")%>||
                            </data>
                            </gw:list>
                        </td>
                        <td nowrap >
                        </td>
						                                              
                    </tr>
					
					
					
					
					
					
					<!--code support imput city, district, ward for insurrance-->
					
					
					<tr style="height:1%">
                        <td nowrap colspan=9 >
                           <img status="show" id="imgAddress" alt="Show detail Address" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle(2)"  />Show/Hide Address Detail
                        </td>                                               
                    </tr>
												
					<tr style="display:none;height:5%;background-color:DarkOrange" id="a1">
                        <td nowrap  ><a title="Click here to show City/Province code" onclick="OnShowPopupAddr('HR0203',txtBACity,'HR0203',txtBACity_code)" href="#tips" >
                            Birth City</a></td>
                        <td nowrap >
                           <gw:textbox id="txtBACity"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange;color:black' onchange="onChangeText(txtBACity,txtBACity_code)"/>
                        </td> 
                        <td nowrap >
                        </td>
						<td nowrap ><a title="Click here to show District code" onclick="OnShowPopupAddr('HR0204',txtBADistrict,txtBACity_code,txtBADistrict_code)" href="#tips" >Birth District</a></td>
                        <td nowrap colspan=1>
                            <gw:textbox id="txtBADistrict"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange' onchange="onChangeText(txtBADistrict,txtBADistrict_code)"/>
                        </td>  
						<td nowrap >
                        </td>
						<td nowrap ><a title="Click here to show Ward code" onclick="OnShowPopupAddr('HR0205',txtBAWard,txtBADistrict_code,txtBAWard_code)" href="#tips" >Birth Ward</a></td>						
                        <td nowrap >
                            <gw:textbox id="txtBAWard"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange' onchange="onChangeText(txtBAWard,txtBAWard_code)"/>						
						</td>
						 <td nowrap >
                        </td>
                        <td nowrap >Birth No.</td>
                        <td nowrap >
							<gw:textbox id="txtBANo"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange'/>
                        </td>
                        <td nowrap >
                        </td>
                    </tr>
					<tr style="display:none;height:5%;background-color:DarkOrange" id="a2">
                        <td nowrap  ><a title="Click here to show City/Province code" onclick="OnShowPopupAddr('HR0203',txtCACity,'HR0203',txtCACity_code)" href="#tips" >
                            Current City</a></td>
                        <td nowrap >
                            <gw:textbox id="txtCACity"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange' onchange="onChangeText(txtCACity,txtCACity_code)"/>
                        </td> 
                        <td nowrap >
                        </td>
						<td nowrap ><a title="Click here to show District code" onclick="OnShowPopupAddr('HR0204',txtCADistrict,txtCACity_code,txtCADistrict_code)" href="#tips" >Current District</a></td>
                        <td nowrap colspan=1>
                            <gw:textbox id="txtCADistrict"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange' onchange="onChangeText(txtCADistrict,txtCADistrict_code)"/>
                        </td>  
						<td nowrap >
                        </td>
						<td nowrap ><a title="Click here to show Ward code" onclick="OnShowPopupAddr('HR0205',txtCAWard,txtCADistrict_code,txtCAWard_code)" href="#tips" >Current Ward</a></td>						
                        <td nowrap >
                            <gw:textbox id="txtCAWard"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange' onchange="onChangeText(txtCAWard,txtCAWard_code)"/>					
						</td>
						 <td nowrap >
                        </td>
                        <td nowrap >Current No.</td>
                        <td nowrap >
							<gw:textbox id="txtCANo"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange'/>
                        </td>
                        <td nowrap >
                        </td>
                    </tr>
					<tr style="display:none;height:5%;background-color:DarkOrange" id="a3">
                        <td nowrap  ><a title="Click here to show City/Province code" onclick="OnShowPopupAddr('HR0203',txtPACity,'HR0203',txtPACity_code)" href="#tips" >
                            Permanent City</a></td>
                        <td nowrap >
                            <gw:textbox id="txtPACity"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange' onchange="onChangeText(txtPACity,txtPACity_code)"/>
                        </td> 
                        <td nowrap >
                        </td>
						<td nowrap ><a title="Click here to show District code" onclick="OnShowPopupAddr('HR0204',txtPADistrict,txtPACity_code,txtPADistrict_code)" href="#tips" >Permanent District</a></td>
                        <td nowrap colspan=1>
                            <gw:textbox id="txtPADistrict"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange' onchange="onChangeText(txtPADistrict,txtPADistrict_code)"/>
                        </td>  
						<td nowrap >
                        </td>
						<td nowrap ><a title="Click here to show Ward code" onclick="OnShowPopupAddr('HR0205',txtPAWard,txtPADistrict_code,txtPAWard_code)" href="#tips" >Permanent Ward</a></td>						
                        <td nowrap >
                            <gw:textbox id="txtPAWard"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange' onchange="onChangeText(txtPAWard,txtPAWard_code)"/>								
						</td>
						 <td nowrap >
                        </td>
                        <td nowrap >Permanent No.</td>
                        <td nowrap >
							<gw:textbox id="txtPANo"  text="" maxlen = "100" styles='width:100%;background-color:DarkOrange'/>
                        </td>
                        <td nowrap >
                        </td>
                    </tr>
					<!--end code support imput city, district, ward for insurrance-->
					
					
					
					
					
					
					
                     <tr style="height:5%">
                        <td nowrap >
                            Personal ID</td>
                        <td nowrap >
                            <gw:textbox id="txtPersonalID"  maxlen = "20" text="" styles='width:100%;'  onenterkey="" />
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap >
                            Issue Date</td>
                        <td nowrap >
                            <gw:datebox id="dtIssueDT" text="" maxlen = "10" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept/>
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show place id" onclick="OnShowPopup('HR0014',lstPlaceID)" href="#tips" >
                            Place ID</a></td>
                        <td nowrap >
                            <gw:list  id="lstPlaceID" value=" " maxlen = "10" styles='width:100%' > 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0014' order by code_nm")%>||
                            </data>
                            </gw:list>
                        </td>
                        <td nowrap >
                            </td>
                        <td nowrap width="8%"><a title="Click here to show birth place" onclick="OnShowPopup('HR0021',lstNativeCountry)" href="#tips" >
                            N Country</a></td>
                       
                        <td nowrap  width="11%"><gw:list  id="lstNativeCountry" value=" "  maxlen = "100" styles='width:100%'> 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0021' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        
                    </tr>
                    <tr style="height:5%" >
                        <td nowrap style="height:5%">
                            Birth Date(*)</td>
                        <td nowrap >
                            <gw:textbox id="txtBirthDT"  text="" maxlen = "10" styles='width:100%' /> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show birth place" onclick="OnShowPopup('HR0021',lstBirthPlace)" href="#tips" >
                            Birth Place</a></td>
                        <td nowrap >
                            <gw:list  id="lstBirthPlace" value=" "  maxlen = "100" styles='width:100%'> 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0021' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show job code" onclick="OnShowPopup('HR0010',lstJob)" href="#tips" >
                            Job</a></td>
                        <td nowrap >
                            <gw:list  id="lstJob" value="" styles='width:100%' >
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0010' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap width=4%>
                        </td>
                        <td nowrap width=5%><a title="Click here to show position code" onclick="OnShowPopup('HR0008',lstPosition)" href="#tips" >
                            Position(*)</a></td>
                        <td nowrap width=12%>
                            <gw:list  id="lstPosition" value="" maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>||
                            </data>
                            </gw:list>
                        </td>
                        
                    </tr>
                    
                    <tr style="height:5%">
                        <td nowrap ><a title="Click here to show nation code" onclick="OnShowPopup('HR0009',lstNation)" href="#tips" >
                            Nation(*)</a></td>
                        <td nowrap >
                            <gw:list  id="lstNation"  styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show ethnic" onclick="OnShowPopup('HR0015',lstEthnic)" href="#tips" >
                            Ethnic</a></td>
                        <td nowrap >
                            <gw:list  id="lstEthnic"  styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0015' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show religion" onclick="OnShowPopup('HR0016',lstReligion)" href="#tips" >
                            Religion</a></td>
                        <td nowrap >
                            <gw:list  id="lstReligion"  styles='width:100%'> 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0016' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show education" onclick="OnShowPopup('HR0011',lstEducation)" href="#tips" >Education</a></td>
                       
                        <td nowrap >
                            <gw:list  id="lstEducation" value=" " maxlen = "10" styles='width:100%' > 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0011' order by code_nm")%>||
                            </data>
                            </gw:list>
                        </td>
                        
                    </tr>
                    
                   
                    <tr style="height:5%">
                        <td nowrap  ><a title="Click here to show probation kind" onclick="OnShowPopup('HR0002',lstProKind)" href="#tips" >
                            Probation Kind(*)</a></td>
                        <td nowrap  >
                            <gw:list  id="lstProKind" value=" " styles='width:100%' onchange="ChangeProbType()">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0002' order by code_nm")%>| |Choose...
                            </data>
                            </gw:list >
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >
                            Begin Probation(*)</td>
                        <td nowrap  >
                            <gw:datebox id="dtSTProbate"  maxlen = "10" text="" styles='width:90%' lang="<%=Session("Lang")%>" nullaccept onchange=""/>
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >
                            End Probation(*)</td>
                        <td nowrap  >
                            <gw:datebox id="dtEDProbate"  maxlen = "10" text="" styles='width:90%' lang="<%=Session("Lang")%>" nullaccept onchange=""/>
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >
                            Marital Status</td>
                        <td nowrap  ><gw:list  id="lstMarial" value=" " styles="width:100%" > 
		                        <data> LIST|N|Single|Y|Married|D|Divorce</data> 
                            </gw:list>
                            
                        </td>
                        
                    </tr>
                    <tr >
                        <td nowrap style="height:5%">Contract No</td>
                        <td nowrap  >
                             <gw:textbox  id="txtContractNo" text="" styles='width:100%' />
                            </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >Status</td>
                        <td nowrap  ><gw:list  id="lstStatus"   maxlen = "100" styles='width:100%' value="551">       
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>
                            </data>
                             </gw:list>   </td>
                        <td nowrap  ></td>
                        <td nowrap  >Leave Date</td>
                        <td nowrap  >
                            <gw:datebox id="dtLeaveDT"  text="" maxlen = "10" styles='width:90%' lang="<%=Session("Lang")%>" nullaccept /> 
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  ><a title="Click here to show resign type" onclick="OnShowPopup('HR0004',lstResignType)" href="#tips" >
                            Resign Type</a></td>
                        <td nowrap  >
                            <gw:list  id="lstResignType" maxlen = "100" value=" " styles='width:100%'> 			        
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0004' order by code_nm")%>||
                            </data>
                             </gw:list>
                        </td>
                        
                    </tr>
                    <tr >
                        <td nowrap  >Contract Kind</td>
                        <td nowrap  >
                            <gw:list  id="lstContractKind" value="01" styles='width:100%;' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code_nm")%>||
                            </data>
                            </gw:list >
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >
                            Begin Contract</td>
                        <td nowrap  >
                            <gw:datebox id="dtSTContract"  maxlen = "10" text="" styles='width:90%' lang="<%=Session("Lang")%>" nullaccept onchange=""/>
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >
                            End Contract</td>
                        <td nowrap  >
                            <gw:datebox id="dtEDContract"  maxlen = "10" text="" styles='width:90%' lang="<%=Session("Lang")%>" nullaccept onchange=""/>
                        </td>
                        <td nowrap  >
                        </td>
                         <td nowrap  >PIT No</td>
                        <td nowrap  >
                            <gw:textbox id="txtPit_No"  text="" maxlen = "30" styles='width:100%' />
                        </td>
                        
                        
                    </tr>
                    <tr >
                        <td nowrap  >
                            Health From</td>
                        <td nowrap   >
                            <gw:datebox id="dtHealthDT"  text="" maxlen = "10" styles='width:70%' lang="<%=Session("Lang")%>" type="month" nullaccept/> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap  >
                            Health No</td>
                        <td nowrap  >
                            <gw:textbox id="txtHealthNo"  text="" maxlen = "60" styles='width:100%' />
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  ><a title="Click here to show health place" onclick="OnShowPopup('HR0012',lstHealthPlace)" href="#tips" >
                            Health Place</a></td>
                        <td nowrap  >
                            <gw:list  id="lstHealthPlace" value=" " styles='width:100%' >
                            <data>
                                 <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0012' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap >Health YN</td>
                        <td nowrap  >
                            <gw:list  id="lstHealthYN" value="N"  maxlen = "100" styles='width:100%'> 
                                <data>|Y|Y|N|N</data> 
                            </gw:list>
                        </td>
                        
                    </tr>
                    <tr >
                        <td nowrap  >Social From</td>
                        <td nowrap>
                            <gw:datebox id="dtSocialDT"  text="" maxlen = "10" styles='width:70%' lang="<%=Session("Lang")%>" type="month" nullaccept />                  
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap >Social No</td>
                        <td nowrap >
                            <gw:textbox id="txtSocialNo"  text="" maxlen = "20" styles='width:100%' />
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap ><a title="Click here to show social place" onclick="OnShowPopup('HR0013',lstSocialPlace)" href="#tips" >
                            Social Place</a></td>
                        <td nowrap >
                            <gw:list  id="lstSocialPlace" value=" " styles='width:100%' > 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0013' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap   >Social YN</td>
                        <td nowrap >
                            <gw:list  id="lstSocialYN" value="N"  maxlen = "100" styles='width:100%'> 
                                <data>|Y|Y|N|N</data> 
                            </gw:list>
                        </td>
                       
                    </tr>  
                    <tr >
                        <td nowrap  >Salary Period</td>
                        <td nowrap colspan=4  ><gw:list  id="lstSal_period" value="" styles='width:100%' onChange="">
                             <data>
                                <%=ESysLib.SetListDataSQL("select v.CODE,v.CODE_NM||' '|| v.CHAR_1||'->'||v.CHAR_2 from vhr_hr_code v where v.id='HR0030' and v.num_1=1 and (v.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',v.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6') order by v.code")%>
                            </data>
                            </gw:list >
                        </td>
                         <td nowrap  >
                        </td>
                        <td nowrap  >Unemp From</td>
                        <td nowrap>
                            <gw:datebox id="dtUnempDT"  text="" maxlen = "10" styles='width:50%' lang="<%=Session("Lang")%>" type="month" nullaccept />                  
                        </td>
                        <td nowrap  ></td>
                        <td nowrap  >Unemp Flag</td>
                        <td nowrap ><gw:list  id="lstUnempYN" value="N"  maxlen = "100" styles='width:100%'> 
                                <data>|Y|Y|N|N</data> 
                            </gw:list>
                         </td>
                       
                    </tr>
                    <tr >
                        <td nowrap  ><a title="Click here to show bank" onclick="OnShowPopup('HR0020',lstBank)" href="#tips" >Bank</a> </td>
                        <td nowrap  ><gw:list  id="lstBank" value=" " styles='width:100%' onChange="">
                             <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0020' order by code_nm")%>||
                            </data>
                            </gw:list >
                        </td>
                         <td nowrap  >
                        </td>
						<td nowrap  ><a title="Click here to show bank branch" onclick="OnShowPopup('HR0116',lstBankBranch)" href="#tips" >Bank Branch</a> </td>
                        <td nowrap  ><gw:list  id="lstBankBranch" value=" " styles='width:100%' onChange="">
                             <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0116' order by code_nm")%>||
                            </data>
                            </gw:list >
                        </td>
                         <td nowrap  >
                        </td>
                        
                        <td nowrap  ><a title="Click here to show pay type" onclick="OnShowPopup('HR0023',lstPayType)" href="#tips" >
                            Pay Type</a></td>
                        <td nowrap><gw:list  id="lstPayType" value="" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm")%>||
                            </data>
                            </gw:list >
                        </td>
                        <td nowrap  ></td>
                        <td nowrap  >Account</td>
                        <td nowrap ><gw:textbox  id="txtAccount" value="" styles='width:100%' />
                            
                         </td>
                       
                    </tr>
                    <tr >
                        
                        <td nowrap ><a title="Click here to show Salary type" onclick="OnShowPopup('HR0056',lstSalaryType)" href="#tips" >
                            Salary Type</a></td>
                        <td nowrap id="h45" >
                            <gw:list  id="lstSalaryType" value="" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0056' order by num_1")%>||
                            </data>
                            </gw:list >
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap  >Recieve Net</td>
                        <td nowrap  >
                            <gw:list  id="lstNetSal_YN" value="N"  maxlen = "100" styles='width:100%'> 
                                <data>|Y|Y|N|N</data> 
                            </gw:list>
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >OT_YN
                            </td>
                        <td nowrap >
                            <gw:list  id="lstOTYN" value="Y"  maxlen = "100" styles='width:100%'> 
		                        <data>|Y|Y|N|N</data> 
                            </gw:list>
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >Salary YN
                            </td>
                        <td nowrap >
                            <gw:list  id="lstSalYN" value="Y"  maxlen = "100" styles='width:100%'> 
		                        <data>|Y|Y|N|N</data> 
                            </gw:list>
                        </td>
                    </tr>
                    <tr >
                        
                        <td nowrap ><a title="Click here to show cost group" onclick="OnShowPopup('HR0092',lstCostGroup)" href="#tips" >
                            Cost Group</a></td>
                        <td nowrap id="Td2" >
                            <gw:list  id="lstCostGroup" value="" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0092' order by code_nm")%>||
                            </data>
                            </gw:list >
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap  ><a title="Click here to show cost type" onclick="OnShowPopup('HR0093',lstCostGroupKind)" href="#tips" >
                            Cost Group Kind</a></td>
                        <td nowrap  >
                           <gw:list  id="lstCostGroupKind" value="" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0093' order by code_nm")%>||
                            </data>
                            </gw:list >
                            
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  ><a title="Click here to show cost center" onclick="OnShowPopup(5,txtCostCenter)" href="#tips" >Cost Center</td>
                        <td nowrap colspan=4 >
                            <gw:textbox  id="txtCostCenter" text="" styles='width:100%' /> 
                        </td>
                    </tr>
                    <tr >
                        <td nowrap ><a title="Click here to show pay type" onclick="OnShowPopup('HR0040',lstMoneyKind)" href="#tips" >
                            Money Kind</a></td>
                        <td nowrap id="Td1" >
                            <gw:list  id="lstMoneyKind" value="01" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0040' order by code_nm")%>
                            </data>
                            </gw:list >
                        </td>
                        <td nowrap  ></td>
                        <td nowrap >Union Y/N</td>
                        <td nowrap  ><gw:list  id="lstUnion" value="N" styles='width:100%' onChange="">
                              <data>|Y|Yes|N|No</data></gw:list ></td>
                        <td nowrap  ></td>
                        <td nowrap  >Labor No</td>
                        <td nowrap  ><gw:textbox id="txtLabor_No"  text="" maxlen = "20" styles='width:100%' /></td>
                        <td nowrap  ></td>
                        <td nowrap  >Labor Date</td>
                        <td nowrap  ><gw:datebox id="dtLabor"  text="" maxlen = "10" styles='width:90%' lang="<%=Session("Lang")%>" type="month" nullaccept /></td>
                       
                    </tr>
                    <tr style="display:none" id="h3">
                        <td nowrap  ><a title="Click here to show salary table" onclick="OnShowPopup(4,lstSalarGroup)" href="#tips" >Salary Group</a>
                           </td>
                        <td nowrap  >
                           <gw:list  id="lstSalarGroup" value="0" styles='width:100%' OnChange="OnChangeSalaryGroup()">
                           <data>
                                <%=ESysLib.SetListDataSQL("select a.PK,a.POS_GRP_NAME from thr_position_grp a where a.UPPER_PK is not null and del_if=0 order by a.POS_GRP_NAME")%>|0|Select...
                            </data></gw:list>
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >Salary Level
                            </td>
                        <td nowrap  > <gw:list  id="lstSalaryRate" value="0" styles='width:100%' OnChange="OnChangeRate()">
                           <data>
                                <%=ESysLib.SetListDataSQL("select s.pk,s.RATE from thr_table_salary s where del_if=0 order by s.rate")%>|0|Select...
                            </data></gw:list>
                       </td>
                       
                        <td nowrap  >
                        </td> 
                        <td nowrap  >
                            Basic Salary</td>
                        <td nowrap  >
                           <gw:textbox  id="txtBasicSal" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                        </td>
                         <td nowrap >
                        </td> 
                         <td nowrap  >Probation Salary
                            </td>
                        <td nowrap  ><gw:textbox  id="txtProbSal" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                       </td>               
                   
                    <tr width=100% style="display:none" id="h1">
                        
                        <td nowrap>
                            <gw:label  id="lblA1"   text="Allow1 AMT" styles='width:100%;font-weight: bold' /></td>
                        <td nowrap >
                            <gw:textbox  id="txtAllow1AMT" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                        </td >
                        <td nowrap>
                        </td>
                        <td nowrap >
                            <gw:label  id="lblA2"  text="Allow2 AMT" styles='width:100%;font-weight: bold' /></td>
                        <td nowrap >
                            <gw:textbox  id="txtAllow2AMT" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap >
                            <gw:label  id="lblA3" text="Allow3 AMT" styles='width:100%;font-weight: bold' /></td>
                        <td nowrap  >
                            <gw:textbox  id="txtAllow3AMT" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap >
                            <gw:label  id="lblA4" text="Allow4 AMT" styles='width:100%;font-weight: bold' /></td>
                        <td nowrap  >
                            <gw:textbox  id="txtAllow4AMT" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                        </td>
                                    
                    </tr>
                    <tr style="display:none" id="h2">
                        <td nowrap >
                        
                            <gw:label  id="lblA5" text="Allow5 AMT" styles='width:100%;font-weight: bold;' /></td>
                        
                        <td nowrap  align="right">
                        
                            <gw:textbox   id="txtAllow5AMT" type="number" format="#,###,###,###.##R" text="" styles='width:100%;' /> 
                            
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap >
                            <gw:label  id="lblA6" text="Allow6 AMT" styles='width:100%;font-weight: bold' /></td>
                        <td nowrap >
                            <gw:textbox  id="txtAllow6AMT" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                        </td>
                        <td nowrap>
                        </td>
                        <td nowrap  >
                            <gw:label  id="lblA7" text="Allow7 AMT" styles='width:100%;font-weight: bold' /></td>
                        <td nowrap >
                            <gw:textbox  id="txtAllow7AMT" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                        </td>
                        <td nowrap>
                        </td>
                        <td nowrap>
                            <gw:label  id="lblA8" text="Allow8 AMT" styles='width:100%;font-weight: bold' /></td>
                        <td nowrap>
                            <gw:textbox  id="txtAllow8AMT" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                        </td>
                        
                    </tr>
                    
                    
                </table>
            </td>
        </tr>
    </table>
</form>
<form name="Expand" id="form2">
    <table id="expand" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:5%" valign="top" >
                        <td style="border:1;width:97%" align="center" valign="center">
                            <gw:label id="lblEmployee"  maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:15" />
                        </td>
                        <td style="border:1;width:3%" align="right" valign="center"> <gw:imgBtn id="ibtnMainReport" alt="All information" img="printer" onclick="OnAllReport()" />
                        </td>
                    </tr>
                    <tr style="width:100%;height:25%">
                        <td colspan=2 style="border:1;width:100%;height:25%">
                            <fieldset style="height:100%;  "> 
                               <table width=100% cellpadding=0 cellspacing=1 border=1 id="tblexp" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td width="88%"  style="border:0" align="left" valign="center"><font color="#990066" size="2"  >EMPLOYEE EXPERIENCE</font>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="new" id="ibtnAdd_E"   alt="Add"  onclick="OnAddNew_E(grdExperience)"/>
                                        </td>
                                         <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="save" id="ibtnSave_E"    alt="Save"  onclick="OnSave_E(datExperience)"/>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="delete" id="ibtnDelete_E"    alt="Delete"  onclick="OnDelete_E(grdExperience)"/>
                                        </td>
                                        <td width="3%" style="border:0" align="right">
                                         <gw:imgBtn img="printer" id="ibtnPrinter_E"    alt="Report"  onclick="OnReport_E(1)"/>
                                        </td>
                                    </tr>
                                    
                                    <tr style="width:100%;height:100%;border:1" valign="top">
                                        <td colspan=5 style="width:100%;border:1" > 
                                             <gw:grid   
                                                        id="grdExperience"  
                                                        header="_PK|_EMP_PK|NO|COMPANY'S NAME|START DATE|END DATE|POSITION|DUTIES|SALARY|RESIGNED REASON"   
                                                        format="0|0|0|0|4|4|0|0|1|0"  
                                                        aligns="1|0|1|0|0|0|0|0|0|0"  
                                                        defaults="||||||||"  
                                                        editcol="0|0|0|1|1|1|1|1|1|1"  
                                                        widths="1000|2500|1000|1500|1500|1500|2000|2000|1500|1500"  
                                                        styles="width:100%; height:100%"   
                                                        sorting="T"   
                                                        /> 
                                        </td>
                                    </tr>
                               </table> 
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="width:100%;height:20%">
                        <td colspan=2 style="border:1;width:100%;height:25%">
                            <fieldset style="height:100%;  "> 
                               <table width=100% cellpadding=0 cellspacing=1 border=1 id="Table1" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td width="88%"  style="border:0" align="left" valign="center"><font color="#990066" size="2"  >EMPLOYEE EDUCATION</font>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="new" id="ibtnAdd_E4"   alt="Add"  onclick="OnAddNew_E(grdEDU)"/>
                                        </td>
                                         <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="save" id="ibtnSave_E4"    alt="Save"  onclick="OnSave_E(datEdu)"/>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="delete" id="ibtnDelete_E4"    alt="Delete"  onclick="OnDelete_E(grdEDU)"/>
                                        </td>
                                        <td width="3%" style="border:0" align="right">
                                         <gw:imgBtn img="printer" id="ibtnPrinter_E4"    alt="Report"  onclick="OnReport_E(4)"/>
                                        </td>
                                    </tr>
                                    
                                    <tr style="width:100%;height:25%;border:1" valign="top">
                                        <td colspan=5 style="width:100%;border:1" > 
                                             <gw:grid   
                                                        id="grdEDU"  
                                                        header="_PK|_EMP_PK|NO|SCHOOL NAME/MAJOR|START DATE|END DATE|MAJOR|RESULT|REMARK"   
                                                        format="0|0|0|0|4|4|0|0|0"  
                                                        aligns="1|0|1|0|0|0|0|0|0"  
                                                        defaults="|||||||"  
                                                        editcol="0|0|0|1|1|1|1|1|1"  
                                                        widths="1000|500|500|3000|1500|1500|2000|2000|1500"  
                                                        styles="width:100%; height:100%"   
                                                        sorting="T"   
                                                        /> 
                                        </td>
                                    </tr>
                               </table> 
                            </fieldset>
                        </td>
                    </tr>
                    
                    <tr style="width:100%;height:20%">
                        <td colspan=2 style="border:1;width:100%;height:25%">
                            <fieldset style="height:100%"> 
                               <table width="100%" id="tblfam" style="height:100%" border=0 cellpadding="0" cellspacing="0">
                                  <tr style="width:100%;height:5%" valign="top" >
                                        <td width="88%"  align="left" valign="center"><font color="#990066" size="2" >EMPLOYEE'S FAMILY</font>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="new" id="ibtnAdd_F"   alt="Add"  onclick="OnAddNew_E(grdFamily)"/>
                                        </td>
                                         <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="save" id="ibtnSave_F"    alt="Save"  onclick="OnSave_E(datFamily)"/>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="delete" id="ibtnDelete_F"    alt="Delete"  onclick="OnDelete_E(grdFamily)"/>
                                        </td>
                                        <td width="3%" style="border:0" align="right">
                                         <gw:imgBtn img="printer" id="ibtnPrinter_F"    alt="Report"  onclick="OnReport_E(2)"/>
                                        </td>
                                    </tr>
                                    
                                    <tr style="border:1;width:100%;height:25%" valign="top">
                                        <td colspan=5 style="width:100%;height:100%"> 
                                             <gw:grid   
                                                        id="grdFamily"  
                                                        header="_PK|_EMP_PK|NO|NAME|RELATION|BIRTH DATE|JOB|SALARY|REMARK|DEPEND FLAG|START DATE|END DATE"   
                                                        format="0|0|0|0|0|4|0|0|0|3|4|4"  
                                                        aligns="1|0|1|0|0|0|0|0|0|0|0|0"  
                                                        defaults="||||||||||"  
                                                        editcol="0|0|0|1|1|1|1|1|1|1|1|1"  
                                                        widths="1000|2500|1000|2500|2500|2500|2500|2000|2000|1300|1300|1300"  
                                                        styles="width:100%; height:100%"   
                                                        sorting="T"   
                                                        acceptNullDate
                                                       /> 
                                        </td>
                                    </tr>
                               </table> 
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="width:100%;height:20%">
                        <td colspan=2 style="border:0;width:100%;height:20%">
                            <fieldset style="height:100%;" > 
                               <table width="100%" id="tbloth" style="height:100%" border=0 cellpadding="0" cellspacing="1">
                                    <tr style="width:100%;height:5%" valign="top" >
                                        <td width="88%"  align="left" valign="center"><font color="#990066" size="2" >EMPLOYEE'S OTHER INFORMATION</font>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="new" id="ibtnAdd_O"   alt="Add"  onclick="OnAddNew_E(grdOther)"/>
                                        </td>
                                         <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="save" id="ibtnSave_O"    alt="Save"  onclick="OnSave_E(datOther)"/>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="delete" id="ibtnDelete_O"    alt="Delete"  onclick="OnDelete_E(grdOther)"/>
                                        </td>
                                        <td width="3%" style="border:0" align="right">
                                         <gw:imgBtn img="printer" id="ibtnPrinter_O"    alt="Report"  onclick="OnReport_E(3)"/>
                                        </td>
                                    </tr>
                                    
                                    <tr style="border:1;width:100%;height:85%" valign="top">
                                        <td colspan=5 style="width:100%;height:100%"> 
                                             <gw:grid   
                                                       id="grdOther"  
                                                        header="_PK|_EMP_PK|NO|NOTE 1|NOTE 2|NOTE 3|NOTE 4|NOTE 5"   
                                                        format="0|0|0|0|0|0|0|0"  
                                                        aligns="1|0|1|0|0|0|0|0"  
                                                        defaults="||||||"  
                                                        editcol="0|0|0|1|1|1|1|1"  
                                                        widths="1000|2500|1000|2500|2500|2500|2500|2500"  
                                                        styles="width:100%; height:100%"   
                                                        sorting="T"   
                                                        param="0,1,2,3,4,5,6,7" /> 
                                        </td>
                                    </tr>
                               </table> 
                            </fieldset>
                        </td>
                    </tr>
               </table> 
               
               
            </td>
        </tr>
    </table>
</form> 
</gw:tab>
  <img status="collapse" id="imgArrow" src="../../../system/images/down.gif" style="cursor:hand;position:absolute;left:3;top:470;" onclick="OnToggle(1)"  /> 
  
     <gw:textbox id="txtComCodeID" styles="display:none"/>	
     
    
    <gw:textbox id="txtEmp_PK" styles="display:none"/>
    <gw:textbox id="txtPhoto_PK" styles="display:none"/>
    <gw:textbox id="txtFull_FName" styles="display:none"/>
    <gw:textbox id="txtExistTemp" styles="display:none"/>
    <gw:textbox id="txtFlag" styles="display:none"/>
    
    <gw:textbox id="txtCodeTemp" styles="display:none" />

    <gw:textbox id="txtDelete_Flag" styles="display:none"/>
    <gw:textbox id="txtAllowance" text="HR0019" styles="display:none"/>
    <gw:textbox id="txtBackNext" styles="display:none"/>
    <gw:textbox id="txtEmp_PK_E" styles="display:none" />
    <gw:textbox id="txtEmp_PK_NB" styles="display:none" />
    <gw:textbox id="txtUser_PK" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txt_sal_security" styles="display:none"/>
    <gw:textbox id="txt_First_use" text="" styles="display:none"/>
    <gw:textbox id="txt_Employee_ByHand"  styles="display:none"/>
    <gw:textbox id="txt_Employee_ByHand_YN"  styles="display:none"/>
    
    <gw:textbox id="txt_Exist_Emp_ID" text="" styles="display:none"/>
    <gw:textbox id="txtCost_Center_pk" text="" styles="display:none"/>
    
    <gw:textbox id="txtManager_id"  text="0" styles="display:none"  />
     <gw:textbox id="txtRec_PK" text="" styles="display:none"  />
     <gw:textbox id="txtClose_YN" text="" styles="display:none"  />
	 

    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />
    <gw:textbox id="l_flag_load" text="" styles="display:none"  />

    <gw:textbox id="l_txtFlag_View" text="" styles="display:none"  />
    <gw:textbox id="l_lblMaxID" text="" styles="display:none"  />
    <gw:textbox id="l_txt_sal_security" text="" styles="display:none"  />
    <gw:textbox id="l_txt_First_use" text="" styles="display:none"  />
    <gw:textbox id="l_txt_Employee_ByHand" text="" styles="display:none"  />
           
    <gw:textbox id="tmp_char5" text="" styles="display:none"  />	
	<gw:textbox id="txtBACity_code" text="" styles="display:none"  />
    <gw:textbox id="txtBADistrict_code" text="" styles="display:none"  />    
    <gw:textbox id="txtBAWard_code" text="" styles="display:none"  />
    <gw:textbox id="txtCACity_code" text="" styles="display:none"  />
    <gw:textbox id="txtCADistrict_code" text="" styles="display:none"  />    
    <gw:textbox id="txtCAWard_code" text="" styles="display:none"  />
    <gw:textbox id="txtPACity_code" text="" styles="display:none"  />
    <gw:textbox id="txtPADistrict_code" text="" styles="display:none"  />    
    <gw:textbox id="txtPAWard_code" text="" styles="display:none"  />
    
         
    <gw:grid   
    id="grdAllowance"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 7"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1|2|1|0|0|0|0|0|0"  
    defaults="||||||||||||||"  
    editcol="0|0|0|0|0|1|1|1|1|1|0|0|0|0|0|0"  
    widths="0|1500|1600|1000|2500|1500|1700|1500|1700|1500|1500|1200|1200|1200|1200|1200"  
    styles="display:none;width:100%; height:15%" 
    sorting="T"    

   
/>  
</body>


