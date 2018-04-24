<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>

var strcodereturn; //return data of common code popup to check whether you change data of common code.
var strdata; //data of common code popup
var bdelete=false;
var binit=true;
var obj_list_code; //temp list of common code list
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>"; 
var iale_days=12;
var inewtype;
function BodyInit()
{          
    if (v_language!="ENG")
        System.Translate(document);  
    //check annual leave in the year
    iale_days="<%=ESysLib.SetDataSQL("select nvl(num_1,12) from vhr_hr_code where id='HR0006' and code='05'")%>";
    if (iale_days=="")
        iale_day=12;
    //check using combacked worker
    inewtype="<%=ESysLib.SetDataSQL("select 1 from vhr_hr_code where id='HR0097' and code='01' and nvl(char_1,'N')='Y'")%>";
    if (inewtype!="1")
        idcomback.style.display="none";
    <%=ESysLib.SetGridColumnComboFormat("grdFamily",4,"select code,CODE_NM from vhr_hr_code where id='HR0024' order by code_nm") %>
    OnReset();
    lblLoginID.enabled=false;
    lblMaxID.enabled=false;
    OnCollapse("h");
     txtUser_PK.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    datSal_security.Call();
    
}

function BindingDataList()
{   
 lstDept_Code.SetDataText("<%=ESysLib.SetListDataSQL("select pk,dept_nm from comm.tco_dept a where nvl(a.child_yn,'Y')='N' and del_if=0")%>");    
 lstGrp_Code.SetDataText("<%=ESysLib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y' order by seq, Group_NM")%>");
 
}
//-----------------------------------------------

 function OnToggle(obj,img,sid)
{
    if((txt_sal_security.text=='Y' && obj==1)|| obj==2)
    {
        var imgtemp= document.all(img);
        if(imgtemp.status == "expand")
        {
            OnCollapse(sid);
            imgtemp.status = "collapse";
            imgtemp.src = "../../../system/images/down.gif";
        }
        else
        {
            
            OnExpand(sid);
            imgtemp.status = "expand";
            imgtemp.src = "../../../system/images/up.gif";
        }
     }   
    
}
//-----------------------------------------------

function OnCollapse(sid)
{
    for (var i=1; i<=3;i++)
    {
        var temp;
        temp=sid + i;
        var coll= document.all(temp);
        coll.style.display="none"
        var maintab=document.all("main");
        maintab.style.height="70%";
        if (sid=="ins")
            imgArrow.style.top=400
    }
    
}
//-----------------------------------------------

function OnExpand(sid)
{
    for (var i=1; i<=3;i++)
    {
        var temp;
        temp=sid + i;
        var coll= document.all(temp);
        coll.style.display=""
        var maintab=document.all("main");
        maintab.style.height="90%";
        if (sid=="ins")
            imgArrow.style.top=475
    }
}

//-----------------------------------------------
function OnShowPopup(strtemp,objlist)
{
    if (strtemp==1 )
    {
        
        var strcom
        var fpath = System.RootURL + "/form/ch/ae/chae00010_emp_id_code.aspx?idcode=Emp";
        var obj  = System.OpenModal(  fpath , 900 , 450 , 'resizable:yes;status:yes');
    
    }
    else if (strtemp==2)
    {
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            txtUpperDept.text=obj;
            datDeptData.Call();
            
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
    if (obj.id=="datAllowance1")       
    {
        
        if(grdAllowance.GetGridData(1,8)=="0")
        {
            txtAllow1AMT.style.display="none";
            lblA1.style.display="none";
        }
        if(grdAllowance.GetGridData(1,9)=="0")
        {
            txtAllow2AMT.style.display="none";
            lblA2.style.display="none";
        }
        if(grdAllowance.GetGridData(1,10)=="0")
        {
            txtAllow3AMT.style.display="none";
            lblA3.style.display="none";
        }
        if(grdAllowance.GetGridData(1,11)=="0")
        {
            txtAllow4AMT.style.display="none";
            lblA4.style.display="none";
        }
        if(grdAllowance.GetGridData(1,12)=="0")
        {
            txtAllow5AMT.style.display="none";
            lblA5.style.display="none";
        }
        if(grdAllowance.GetGridData(1,13)=="0")
        {
            txtAllow6AMT.style.display="none";
            lblA6.style.display="none";
        }
        if(grdAllowance.GetGridData(1,14)=="0")
        {
            txtAllow7AMT.style.display="none";
            lblA7.style.display="none";
        }
        if(grdAllowance.GetGridData(1,15)=="0")
        {
            txtAllow8AMT.style.display="none";
            lblA8.style.display="none";
        }
        OnChangeDept();                               
    }
    if (obj.id=="datSal_security")
       if((Trim(txtUser_PK.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
	    else
	        datMaxEmpID.Call();
	    
   if (obj.id=="datMaxEmpID" && binit==true)
   {    
        binit=false;
        datAllowance.Call(); 
   }
   
   if (obj.id=="datAllowance")
   {
        
        datAllowance1.Call(); 
   }        
   if (obj.id=="datDeptData")
   {
        lstDept_Code.SetDataText(txtDeptData.text)    ;
        
          obj=lstDept_Code.GetControl()
		if (obj.options.length ==2)
			obj.options.selectedIndex=0;
		else
			obj.options.selectedIndex=obj.options.length-1;
        txtDept.text=lstDept_Code.value;
        datGroupData.Call();
   }
   else if (obj.id=="datGroupData")
   {
        lstGrp_Code.SetDataText(txtGroupData.text);
        var obj=lstGrp_Code.GetControl()
		if (obj.options.length ==2)
			obj.options.selectedIndex=0;
		else
			obj.options.selectedIndex=obj.options.length-1;
   }
   else if (obj.id=="datEmployee")
   {
        ibtnResetE.SetEnable(true);
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
        datMaxEmpID.Call();
   }
   else if (obj.id=="datCheckExist")
   {
        if (txtFlag.text==1)
        {    
            if (txtExistTemp.text!="" )
            {
                if(!confirm("Have already person id of employee id:" + txtExistTemp.text+"\nĐã trùng số cmnd với nhân viên có mã : "+txtExistTemp.text))
                {
                    txtPersonalID.GetControl().focus();
                    return;
                }    
                
            }
               
            txtFlag.text="2";
            datCheckExist.Call();
                
            
        }
        else
        {    
            if (txtExistTemp.text!="" )
            {
                alert("Have already card id of employee id:" + txtExistTemp.text+"\nĐã trùng số card với nhân viên có mã : "+txtExistTemp.text);
                txtIDCard.GetControl().focus();
            }
            else
            {
                txtFull_FName.text=CutAccent(txtFullName.text);
                txtPhoto_PK.text=imgFile.GetData();
                //continue save info
                if (datEmployee.GetStatus()==10 || datEmployee.GetStatus()==0)
                {
                    if (confirm("Do you want to update? \n Bạn có muốn save?"))
                    {
                        datEmployee.StatusUpdate();
                        datEmployee.Call();
                    }
                }
                else if (datEmployee.GetStatus()==20)
                {
                    if (confirm("Do you want to add new employee? \n Bạn muốn thêm mới?"))
                        datEmployee.Call();
                }
                
            }
        }
   }
   else if (obj.id=="datCheckDelete")
   {
       
        if (txtDelete_Flag.text==1)
            alert("You can't delete beause having time machine \n Bạn không thể xóa vì nhân viên này đã có trong ds công");
        else if (txtDelete_Flag.text==2)
            alert("You can't delete beause having absent time \n Bạn không thể xóa vì nhân viên này đã có trong ds vắng.");
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
            BindingDataList();
            txtEmp_PK.text=txtEmp_PK_NB.text;
            datEmployee.Call("SELECT");
        }    
   }
   else if (obj.id=="datRateData")
   {
        lstRate.SetDataText(txtRateData.text);
        datSalRate.Call();
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
   else if (obj.id=="datUser_info")
       {
            datMaxEmpID.Call();
       }
   
}
//----------------------------------------------
function OnSearch()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
    var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	if (obj!=null)
	{
	    txtEmp_PK.text=obj[0];
	    BindingDataList();
	    datEmployee.Call("SELECT");
	}
}
//-------------------------------------------
function OnDelete()
{
    if (confirm("Do you want to delete this employee?\Bạn muốn xóa?"))
    {
        datCheckDelete.Call();
    }
    
}
//-----------------------------------------
function OnChangeDept()
{
    datGroupData.Call();
}
//------------------------------------------
function OnUpdate()
{   
    OnCheckAdd();
}
//----------------------------------------------
function OnCheckAdd()
{
    if (txtEMPID.text=="" && lstNewType.value=='02')
    {
        alert("Please input emp id! \n Vui lòng nhập mã số");
        txtEmp_ID.GetControl().focus();
        return;
    }
    if (txtFullName.text=="")
    {
        alert("Please input full name! \n Vui lòng nhập họ và tên");
        txtFullName.GetControl().focus();
        return;
    }
    if (lstDept_Code.value=="")
    {
        alert("Please choose department! \n Vui lòng chọn phòng ban");
        return;
    }
    if (lstGrp_Code.value=="")    
    {
        alert("Please choose Group! \n Vui lòng chọn group.");
        return;
    }
    if (dtJoinDT.value=="")
    {
        alert("Have to input join date! \n Vui lòng nhập ngày vào.");
        dtJoinDT.GetControl().focus();
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
		if (!confirm("Employee under 18!Do you want to continue? \n Nhân viên này chưa đủ 18 tuổi,bạn muốn tiếp tục không?"))
		    return;
	}
	else if(t==2)
	{	
		alert("Year must be 4 character num, ex 1980,pls input again. \n Năm phải là 4 ký tự, ví dụ 1980, vui lòng nhập lại.");
		return;
	}
	else if(t==3)
	{	
		alert("Incorrect type, ex dd/mm/yyyy, pls input again \n Nhập kiểu ngày,tháng,năm không hợp lệ.");
		return;
	}
	else if(t==4)
	{	
		alert("Incorrect month, month >=1 and month <= 12, pls input again \n Kiểu tháng nhập không hợp lệ.");
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
        alert("Begin probation date have to larger than or equal to join date!\nNgày thử việc phải lớn hay bằng ngày vào.");
        dtSTProbate.GetControl().focus();
        return;
    }
    if (dtJoinDT.value!="" && dtEDProbate.value!="" && dtEDProbate.value < dtJoinDT.value)
    {
        alert("End probation date have to larger than or equal to join date!\nNgày kết thúc thử việc phải lớn hay bằng ngày vào.");
        dtEDProbate.GetControl().focus();
        return;
    }
    if (dtSTProbate.value!="" && dtEDProbate.value!="" && dtEDProbate.value < dtSTProbate.value)
    {
        alert("End probation date have to larger than start probation date!\nNgày kết thúc thử việc phải lớn hay bằng ngày bắt đầu thử việc.");
        dtEDProbate.GetControl().focus();
        return;
    }
    if (Trim(dtEDProbate.value)=="")
    {
        alert("Please input end probation date!\nVui lòng nhập ngày kết thúc thử việc.");
        return;
    }    
    
    if (Trim(lstStatus.value)=="")
    {
        alert("Have to choose status!\nVui lòng chọn status.");
        return;
    }    
    if (Trim(lstSalaryType.value)=="")
    {
        alert("Salary Type cannot be NULL!\nVui lòng chọn phương thức tính lương.");
        return;
    }
    if (lstStatus.value!="A" && dtLeaveDT.value=="")
    {  
        alert("Have to input leave date with resign status!\nBạn phải nhập ngày nghỉ việc khi cho nghỉ việc");
        
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
        alert("Leave date have to larger than or equal to join date!\nNgày nghỉ việc phải lớn hơn hay bằng ngày vào làm.");
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
    lstNewType.value="01";
    dtOldJoinDT.value="";
    dtOldLeftDT.value="";
    dtOldJoinDT.SetEnable(false);
    dtOldLeftDT.SetEnable(false);
    lstContractKind.SetEnable(false);
    lstProKind.value=" ";
    dtSTContract.SetEnable(false);
    dtEDContract.SetEnable(false);
    SetEnablePro(true);
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
    dtLeaveDT.text="";
    lstBirthPlace.value="";
    lstCostKind.value="";
    
    lstJob.value="";
    lstPosition.value="";
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
    txtAnnualLeave.text=iale_days;
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
    txtPassportNo.text="";
    dtPassportDT.text=""; 
    lstPlaceID.value="";
    lstCostGroup.value="";
    lstCostGroupKind.value="";
    lstNativeCountry.value="";
    lstMoneyKind.value="01";
    lstUnion.value="N";    
    ibtnResetE.SetEnable(false);
    datGroupData.Call();
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
    
    if (obj==1)
        txtBackNext.text=1;
    else
        txtBackNext.text=2;
    datEmpIDBackNext.Call();
}
//---------------------------------------------------
function checkKey() 
{ 
	var c = String.fromCharCode (event.keyCode); 
	var x = c.toUpperCase().charCodeAt(0) ; 
	event.keyCode = x; 
	
}
//--------------------------------------------------
function OnChangeSalScale()
{
    datRateData.Call();
}
//-------------------------------------------------
function OnChangeRate()
{
    //alert(lstRate.value);
    //return;
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
    BindingDataList();    
    datEmpPK_Base_EmpID.Call();
}
//------------------------continued with expand employee----------------
function OnChangeTab()
{   
    var icurpage=tabMain.GetCurrentPageNo();
    if (icurpage==1) //expand employee
    {
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
    
    if (obj==1)
    {
        grdExperience.AddRow();
        grdExperience.SetGridText(grdExperience.rows - 1,1,txtEmp_PK.text);
    }
    else if (obj==2)
    {
        grdFamily.AddRow();
        grdFamily.SetGridText(grdFamily.rows-1,1,txtEmp_PK.text);
    }
    else
    {
        grdOther.AddRow();
        grdOther.SetGridText(grdOther.rows-1,1,txtEmp_PK.text);
    }
}
//------------------------------------------------
function OnSave_E(obj)
{
    if (confirm("Do you want to save information?\nBạn có muốn save?"))
    {
        if (obj==1)
        {
            datExperience.Call();    
        }
        else if (obj==2)
        {
            datFamily.Call();
        }
        else
        {
            datOther.Call();
        }
    }
}
//------------------------------------------------
function OnDelete_E(obj)
{
    if (confirm("Do you want to delete information?\nBạn có muốn delete."))
    {
        if (obj==1)
        {   
            grdExperience.DeleteRow();
            datExperience.Call();    
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
        }
    }
}
//------------------------------------------------------------------
function OnDataReceive_E(obj)
{   
   
    if (obj.id=="datExperience")
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
//OnComeback
function OnComeback()
{
    if (lstNewType.value=="01" && txtEmp_PK.text!="")
    {
        alert("Can not change from comebacked worker to new worker");
        lstNewType.value="02"
        return;
    }    
    if (lstNewType.value=="02" && txtEmp_PK.text!="")
    {
        if (lstStatus.value!="R")
        {
            alert("Please select worker comeback is resigned! \n Vui lòng chọn người đã nghỉ việc quay trở lại làm!")
            lstNewType.value="01"
            return;
        }
        else
        {
            dtOldJoinDT.value=dtJoinDT.value;
            dtOldLeftDT.value=dtLeaveDT.value;
            dtJoinDT.value="";
            dtLeaveDT.value="";
            lstStatus.value="A";
            lstResignType.value="";
            lstContractKind.SetEnable(false);
            lstProKind.value=" ";
            dtSTContract.SetEnable(false);
            dtEDContract.SetEnable(false);
            lstProKind.value=" ";
            dtSTContract.text="";
            dtEDContract.text="";
            dtSTProbate.text="";
            dtEDProbate.text="";
            lstContractKind.value="01";
            SetEnablePro(true);
            txtContractNo.text="";
            lstSocialYN.value="N";
            lstUnempYN.value="N";
            lstHealthYN.value="N";
        }
        
    }    
}

</script>
<body bgcolor='#F5F8FF'>
<!---------------------main employee tab data control------------------>
<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_allowance" > 
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
<gw:data id="datAllowance1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_allowance_salary" > 
                <input bind="grdAllowance" >
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------->

<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data" > 
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
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data" > 
                <input>
                    <input bind="lstDept_Code" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role1"  > 
                <input>
                    <input bind="txtUser_PK" />
                </input> 
                <output>
                    <output bind="lstDept_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datSal_security" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="hr.sp_pro_sal_display"  > 
                <input>
                    <input bind="txtUser_PK" />
                </input> 
                <output>
                    <output bind="txt_sal_security" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datCheckExist" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_check_exist" > 
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
            <dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79" function="hr.sp_sel_main_employee" procedure="hr.sp_upd_main_employee"> 
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
                    <inout bind="lstGrp_Code"/>
                    <inout bind="lstDept_Code"/>
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
                    <inout bind="lstCostKind"/>
                    <inout bind="lstSalYN"/>
                    <inout bind="lstSalaryType"/>
                    <inout bind="txtPassportNo"/>
                    <inout bind="dtPassportDT"/>
                    <inout bind="lstRate"/>
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
                    <inout bind="lstNewType"/>
                    <inout bind="dtOldJoinDT"/>
                    <inout bind="dtOldLeftDT"/>
               </inout> 
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------>
<gw:data id="datCheckDelete" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_check_delete" > 
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
<gw:data id="datMaxEmpID" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_max_emp_id" > 
                <input>
                    <input bind="lblMaxID" />
                </input>
                <output>
                    <output bind="lblMaxID" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datEmpPK_Base_EmpID" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_emppk_base_emp_id" > 
                <input>
                    <input bind="txtEMPID" />
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
            <dso  type="process" procedure="hr.sp_pro_empid_back_next" > 
                <input>
                    <input bind="txtBackNext" />
                    <input bind="txtEMPID" />
                </input>
                <output>
                    <output bind="txtEmp_PK_NB" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datRateData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_rate_data" > 
                <input>
                    <input bind="lstSal_Scale" />
                </input>
                <output>
                    <output bind="lstRate" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datSalRate" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_sal_rate" > 
                <input>
                    <input bind="lstRate" />
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
            <dso  type="process" procedure="hr.sp_pro_probation_date" > 
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
        <dso type="list" procedure="hr.sp_list_new_code" > 
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
            <dso  type="grid"  parameter="0,1,3,4,5,6,7,8,9" function="hr.sp_sel_experience" procedure="hr.sp_upd_experience"> 
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
            <dso  type="grid" function="hr.sp_sel_family" procedure="hr.sp_upd_family" parameter="0,1,3,4,5,6,7,8,9,10,11"> 
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
            <dso  type="grid" function="hr.sp_sel_other" procedure="hr.sp_upd_other" parameter="0,1,3,4,5,6,7"> 
                <input>
                    <input bind="txtEmp_PK" />
                </input>
                <output  bind="grdOther" />
            </dso> 
        </xml> 
</gw:data>

<!---------------------expand employee tab data control------------------>

<!----------------------------------->
 
<gw:tab id="tabMain"  border=1 style="width:100%;height:99%" onpageactivate="" onclick ="OnChangeTab()"> 	
<form name="Main E" id="form1" >
     <table id="main"  cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
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
                                    <td width=23%  style="border:0">
                                    </td>
                                    
                                    <td width=3% style="border:0">
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
                    <tr style="height:5%" id="idcomback">
                        <td nowrap width=10% style="color:Red">Newcommer Type
                            </td>
                        <td nowrap width=20%>
                            <gw:list  id="lstNewType" value=" " styles='width:100%' onchange="OnComeback()">
                            <data>|01|New|02|Comback
                            </data>
                            </gw:list>
                        </td>
                        <td nowrap width=4%>
                        </td>
                        <td nowrap width="5%" style="color:Red">
                            Old Join Dt</td>
                        <td nowrap width="15%">
                            <gw:datebox id="dtOldJoinDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept  />
                        </td>
                        <td nowrap width="4%">
                        </td>
                        <td nowrap width="5%" style="color:Red">
                            Old Left Dt</td>
                        <td nowrap width="10%">
                            <gw:datebox id="dtOldLeftDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept  />
                        </td>
                        <td nowrap width="4%">
                        </td>
                        <td nowrap  width=23% colspan=2   >
                        </td>
                    </tr>
                    <tr style="height:5%">
                        <td nowrap width=10%><a title="Click here to show employee id code" onclick="OnShowPopup(1,'')" href="#tips" >Employee ID</a>
                            </td>
                        <td nowrap width=20%>
                            <gw:textbox id="txtEMPID"  text="" 	maxlen = "10" styles='width:100%;' csstype="mandatory"  onenterkey="OnEnterEmp()" />
                        </td>
                        <td nowrap width=4%>
                        </td>
                        <td nowrap width="5%">
                            Old Code</td>
                        <td nowrap width="15%">
                            <gw:textbox id="txtOldCode" text="" maxlen = "10" styles='width:100%;' />
                        </td>
                        <td nowrap width="4%">
                        </td>
                        <td nowrap width="5%">
                            ID No</td>
                        <td nowrap width="10%">
                            <gw:textbox id="txtIDCard"  text="" maxlen = "20" styles='width:100%;' csstype="mandatory" />
                        </td>
                        <td nowrap width="4%">
                        </td>
                        <td nowrap  width="23%" colspan=2  rowspan=5 ><gw:image id="imgFile"   view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:130;height:130"  />
                        </td>
                    </tr>
                    <tr style="height:5%">
                        <td nowrap >
                            Full Name(VN)</td>
                        <td nowrap colspan=1 >
                            <gw:textbox id="txtFullName"  maxlen = "60" text="" styles='width:100%;' csstype="mandatory" onkeypress="checkKey()" />
                        </td>
                        <td></td>
                        <td nowrap >
                            Join Date</td>
                        <td nowrap >
                            <gw:datebox id="dtJoinDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="ChangeProbType()" />
                        </td>
                        <td nowrap >
                        </td>
                        <td nowrap width=5%><a title="Click here to show employee type" onclick="OnShowPopup('HR0017',lstEmp_Type)" href="#tips" >
                            Emp Type</a></td>
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
                        <td nowrap ><a title="Click here to show department" onclick="OnShowPopup(2,'')" href="#tips" >
                            Department</a></td>
                        <td nowrap > <gw:list  id="lstDept_Code"  maxlen = "100" styles='width:100%'onchange="OnChangeDept()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk,dept_nm from comm.tco_dept a where a.child_yn='N' and del_if=0 order by dept_id")%>
                            </data>
                        </gw:list>
                        </td>
                        <td nowrap > 
                        </td>
                        <td nowrap >Group</td>
                        <td nowrap ><gw:list  id="lstGrp_Code"  maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM")%></data></gw:list>
                                            </td>
                        <td nowrap >
                        </td>
                        <td nowrap >Annual Leave</td>
                        <td nowrap width=15%>
                            <gw:textbox  id="txtAnnualLeave" type="number" format="#,###,###,###.##R" text="12" styles='width:100%' /> 
                        </td>
                        <td nowrap >
                        </td>
                    </tr>
                    <tr style="height:5%">
                        <td nowrap >
                            Current Addr</td>
                        <td nowrap  colspan=4 >
                            <gw:textbox id="txtLivingAdd"  text="" maxlen = "100" styles='width:100%' />
                        </td>  
                        <td>
                        </td>             
                        <td nowrap >
                            Tel</td>
                        <td nowrap >
                            <gw:textbox id="txtTel"  text="" maxlen = "15" styles='width:100%' tabindex="35"  onkeypress="return Numbers(event)"  onlostfocus="check_number(0)"  onBlur="" />
                        </td>
                        <td nowrap >
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
                     <tr style="height:5%">
                        <td nowrap >
                            Personal ID</td>
                        <td nowrap >
                            <gw:textbox id="txtPersonalID"  maxlen = "10" text="" styles='width:100%;' onkeypress="return Numbers(event)"  onlostfocus="check_number(0)" onenterkey="" />
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
                        <td nowrap ><a title="Click here to show birth place" onclick="OnShowPopup('HR0021',lstNativeCountry)" href="#tips" >
                            Native Country</a></td>
                       
                        <td nowrap ><gw:list  id="lstNativeCountry" value=" "  maxlen = "100" styles='width:100%'> 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0021' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        
                    </tr>
                    <tr style="height:5%" >
                        <td nowrap style="height:5%">
                            Birth Date</td>
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
                            <gw:list  id="lstJob"  value=" " styles='width:100%' >
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0010' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap width=4%>
                        </td>
                        <td nowrap width=5%><a title="Click here to show position code" onclick="OnShowPopup('HR0008',lstPosition)" href="#tips" >
                            Position</a></td>
                        <td nowrap width=12%>
                            <gw:list  id="lstPosition" value=" "  maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>||
                            </data>
                            </gw:list>
                        </td>
                        
                    </tr>
                    
                    <tr style="height:5%">
                        <td nowrap ><a title="Click here to show nation code" onclick="OnShowPopup('HR0009',lstNation)" href="#tips" >
                            Nation</a></td>
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
                            Probation Kind</a></td>
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
                            Begin Probation</td>
                        <td nowrap  >
                            <gw:datebox id="dtSTProbate"  maxlen = "10" text="" styles='width:90%' lang="<%=Session("Lang")%>" nullaccept onchange=""/>
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >
                            End Probation</td>
                        <td nowrap  >
                            <gw:datebox id="dtEDProbate"  maxlen = "10" text="" styles='width:90%' lang="<%=Session("Lang")%>" nullaccept onchange=""/>
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >
                            Marital Status</td>
                        <td nowrap  ><gw:list  id="lstMarial" value=" " styles="width:100%" > 
		                        <data> LIST|N|Single|Y|Married</data> 
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
                        <td nowrap  ><a title="Click here to show contract kind" onclick="OnShowPopup('HR0001',lstContractKind)" href="#tips" >
                            Contract Kind</a></td>
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
                         <td nowrap  >
                            </td>
                        <td nowrap  >
                            
                        </td>
                        
                    </tr>
                    <tr id="ins1" style="display:none">
                        <td nowrap  >
                            Health From</td>
                        <td nowrap   >
                            <gw:datebox id="dtHealthDT"  text="" maxlen = "10" styles='width:65%' lang="<%=Session("Lang")%>" type="month" nullaccept/> 
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
                    <tr id="ins2"  style="display:none">
                        <td nowrap  >Social From</td>
                        <td nowrap>
                            <gw:datebox id="dtSocialDT"  text="" maxlen = "10" styles='width:65%' lang="<%=Session("Lang")%>" type="month" nullaccept />                  
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
                    <tr id="ins3"  style="display:none">
                        <td nowrap  >Passport No</td>
                        <td nowrap  >
                            <gw:textbox id="txtPassportNo"  text="" maxlen = "20" styles='width:100%' />
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >Passport Date</td>
                        <td nowrap  >
                            <gw:datebox id="dtPassportDT"  text="" maxlen = "10" styles='width:90%' lang="<%=Session("Lang")%>" nullaccept /> 
                        </td>
                         <td nowrap  >
                        </td>
                        <td nowrap  >Unemp From</td>
                        <td nowrap>
                            <gw:datebox id="dtUnempDT"  text="" maxlen = "10" styles='width:65%' lang="<%=Session("Lang")%>" type="month" nullaccept />                  
                        </td>
                        <td nowrap  ></td>
                        <td nowrap  >Unemp Flag</td>
                        <td nowrap ><gw:list  id="lstUnempYN" value="N"  maxlen = "100" styles='width:100%'> 
                                <data>|Y|Y|N|N</data> 
                            </gw:list>
                         </td>
                       
                    </tr>
                    <tr >
                        <td nowrap  >PIT No</td>
                        <td nowrap  >
                            <gw:textbox id="txtPit_No"  text="" maxlen = "30" styles='width:100%' />
                        </td>
                        <td nowrap  ></td>
                        <td nowrap  ><a title="Click here to show bank" onclick="OnShowPopup('HR0020',lstBank)" href="#tips" >Bank</a> </td>
                        <td nowrap  ><gw:list  id="lstBank" value=" " styles='width:100%' onChange="">
                             <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0020' order by code_nm")%>||
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
                        
                        <td nowrap ><a title="Click here to show pay type" onclick="OnShowPopup('HR0092',lstCostGroup)" href="#tips" >
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
                        <td nowrap  ><a title="Click here to show pay type" onclick="OnShowPopup('HR0093',lstCostGroupKind)" href="#tips" >
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
                        <td nowrap  >Cost Center
                            </td>
                        <td nowrap colspan=4 >
                            <gw:list  id="lstCostKind" value="" styles='width:100%' onChange="">
                              <data>
                                <%=ESysLib.SetListDataSQL("select PK,pl_nm from ACNT.TAC_ABPL where del_if=0 and nvl(leaf_yn,'Y')='Y' and (TCO_COMPANY_PK='" & Session("COMPANY_PK") & "' or '" & Session("COMPANY_PK") & "'='')  order by pl_nm")%>||
                            </data></gw:list >
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
                        <td nowrap  ><gw:datebox id="dtLabor"  text="" maxlen = "10" styles='width:65%' lang="<%=Session("Lang")%>" type="month" nullaccept /></td>
                       
                    </tr>
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
                    <tr style="display:none" id="h3">
                        <td nowrap  >Salary Scale
                           </td>
                        <td nowrap  >
                           <gw:list  id="lstSal_Scale" value="0" styles='width:100%' OnChange="OnChangeSalScale()">
                           <data>
                                <%=ESysLib.SetListDataSQL("SELECT P.PK, P.POS_GRP_NAME FROM THR_POSITION_GRP P WHERE P.DEL_IF=0 AND LEVEL<>1 CONNECT BY PRIOR P.PK=P.UPPER_PK START WITH NVL(P.UPPER_PK,0)=0")%>|0|
                            </data></gw:list>
                        </td>
                        <td nowrap  >
                        </td>
                        <td nowrap  >Rate
                            </td>
                        <td nowrap  > <gw:list  id="lstRate" value="0" styles='width:100%' OnChange="OnChangeRate()">
                           <data>
                                <%=ESysLib.SetListDataSQL("SELECT pk, rate FROM thr_table_salary WHERE DEL_IF = 0 and use_yn='Y'")%>|0|
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
                         <td nowrap  >Prob Sal
                            </td>
                        <td nowrap  ><gw:textbox  id="txtProbSal" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                       </td>               
                       
                                 
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</form>
<form name="Expand E" id="form2">
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
                    <tr style="width:100%;height:30%">
                        <td colspan=2 style="border:1;width:100%;height:30%">
                            <fieldset style="height:100%;  "> 
                            <legend style="border:1"><font color="fuchsia" size="3"  >EMPLOYEE EXPERIENCE</font></legend>
                               <table width=100% cellpadding=0 cellspacing=1 border=0 id="tblexp" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td width="88%"  align="center" valign="center">
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="new" id="ibtnAdd_E"   alt="Add"  onclick="OnAddNew_E(1)"/>
                                        </td>
                                         <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="save" id="ibtnSave_E"    alt="Save"  onclick="OnSave_E(1)"/>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="delete" id="ibtnDelete_E"    alt="Delete"  onclick="OnDelete_E(1)"/>
                                        </td>
                                        <td width="3%" style="border:0" align="right">
                                         <gw:imgBtn img="printer" id="ibtnPrinter_E"    alt="Report"  onclick="OnReport_E(1)"/>
                                        </td>
                                    </tr>
                                    
                                    <tr style=";width:100%;height:25%" valign="top">
                                        <td colspan=5 style="width:100%" border=1> 
                                             <gw:grid   
                                                        id="grdExperience"  
                                                        header="_PK|_EMP_PK|NO|COMPANY'S NAME|START DATE|END DATE|POSITION|DUTIES|SALARY|RESIGNED REASON"   
                                                        format="0|0|0|0|0|0|0|0|1|0"  
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
                    
                    <tr style="width:100%;height:30%">
                        <td colspan=2 style="border:1;width:100%;height:30%">
                            <fieldset style="height:100%"> 
                            <legend><font color="fuchsia" size="3" >EMPLOYEE'S FAMILY</font></legend>
                               <table width="100%" id="tblfam" style="height:100%" border=0 cellpadding="0" cellspacing="0">
                                  <tr style="width:100%;height:5%" valign="top" >
                                        <td width="88%"  align="center" valign="center">
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="new" id="ibtnAdd_F"   alt="Add"  onclick="OnAddNew_E(2)"/>
                                        </td>
                                         <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="save" id="ibtnSave_F"    alt="Save"  onclick="OnSave_E(2)"/>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="delete" id="ibtnDelete_F"    alt="Delete"  onclick="OnDelete_E(2)"/>
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
                                                        format="0|0|0|0|0|0|0|1|0|3|4|4"  
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
                    <tr style="width:100%;height:30%">
                        <td colspan=2 style="border:0;width:100%;height:100%">
                            <fieldset style="height:100%;" > 
                            <legend><font color="fuchsia" size="3" >EMPLOYEE'S OTHER INFORMATION</font></legend>
                               <table width="100%" id="tbloth" style="height:100%" border=0 cellpadding="0" cellspacing="1">
                                    <tr style="width:100%;height:5%" valign="top" >
                                        <td width="88%"  align="center" valign="center">
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="new" id="ibtnAdd_O"   alt="Add"  onclick="OnAddNew_E(3)"/>
                                        </td>
                                         <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="save" id="ibtnSave_O"    alt="Save"  onclick="OnSave_E(3)"/>
                                        </td>
                                        <td width="3%" style="border:0;" align="right" >
                                         <gw:imgBtn img="delete" id="ibtnDelete_O"    alt="Delete"  onclick="OnDelete_E(3)"/>
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
  <img status="collapse" id="imgArrow" src="../../../system/images/down.gif" style="cursor:hand;position:absolute;left:3;top:405;" onclick="OnToggle(1,'imgArrow','h')"  /> 
  <img status="collapse" id="imgIns" src="../../../system/images/down.gif" style="cursor:hand;position:absolute;left:3;top:315;" onclick="OnToggle(2,'imgIns','ins')"  /> 
  
     <gw:textbox id="txtComCodeID" styles="display:none"/>	
     <gw:textbox id="txtDept" styles="display:none"/>	
     <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtEmp_PK" styles="display:none"/>
    <gw:textbox id="txtPhoto_PK" styles="display:none"/>
    <gw:textbox id="txtFull_FName" styles="display:none"/>
    <gw:textbox id="txtExistTemp" styles="display:none"/>
    <gw:textbox id="txtFlag" styles="display:none"/>
    <gw:textbox id="txtRateData" styles="display:none"/>
    <gw:textbox id="txtCodeTemp" styles="display:none" />

    <gw:textbox id="txtDelete_Flag" styles="display:none"/>
    <gw:textbox id="txtAllowance" text="HR0019" styles="display:none"/>
    <gw:textbox id="txtBackNext" styles="display:none"/>
    <gw:textbox id="txtEmp_PK_E" styles="display:none" />
    <gw:textbox id="txtEmp_PK_NB" styles="display:none" />
    <gw:textbox id="txtUser_PK" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txt_sal_security" styles="display:none"/>
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



