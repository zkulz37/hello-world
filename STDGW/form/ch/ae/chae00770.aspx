<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script type="text/javascript">

var strcodereturn; //return data of common code popup to check whether you change data of common code.
//var strdata; //data of common code popup
var bdelete=false;
//var binit=true;
var obj_list_code; //temp list of common code list
var v_language = "<%=Session("SESSION_LANG")%>";

var lang= "<%=Session("Lang")%>"; 
var iale_days=12;
//var flag_allowance=0;
//var list_sal_rate;
//var l_exp=0;
var check_init=0;

function BodyInit()
{          
    if (v_language!="ENG")
        System.Translate(document); 
    txtUser_PK.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    menu_id.text=System.Menu.GetMenuID();
    OnReset();                     
    iale_days="<%=ESysLib.SetDataSQL("select nvl(num_1,12) from vhr_hr_code where id='HR0006' and code='05'")%>";
    if (iale_days=="")
        iale_days=12;    
    txtAnnualLeave.text=  iale_days;  
    ChangeColorItem(lstOrg_Code.GetControl());
    datCheck_View.Call();            
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

//--------------------------------------------
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
    if (datRec.GetStatus()!=20)
            datRec.StatusInsert();
    SetEnablePro(true);
	dtRecruit.text="";		
	txtFullName.text="";
	txtBirthDT.text="";
	lstBirthPlace.value="";
	lstSEX.value=" ";
	txtLivingAdd.text="";
	lstPosition.value="";
	txtPersonalID.text="";
	dtIssueDT.text="";
	lstPlaceID.value=" ";
	dtJoinDT.text="";
	txtBasicSal.text="";
	txtAllow1AMT.text="";
	lstProKind.value=" ";
	dtSTProbate.text="";
    dtEDProbate.text="";
	lstEthnic.value="02"
	lstReligion.value="07"
	lstEducation.value=" "
	lstNation.value="01";
	lstSalaryType.value="01";
	lstMoneyKind.value="01";
	lstEmp_Type.value="";
	lstSal_period.value="01";
	txtAnnualLeave.text=iale_days;
    lstOrg_Code.value=" ";
    lstWork_Grp.value="1";
}


//----------------------------------------------
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datCheck_View":
        {
            if(txtFlag_View.text == 'Y')
            {                
                ibtnUpdate.style.display = "none";
                ibtnDelete.style.display = "none";
                ibtnResetE.style.display = "none";
            }
        
            if((Trim(txtUser_PK.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	        {
                datUser_info.Call();     	    
	        }   
	        else 
                check_init=1;                 
        }
        break;

        case "datUser_info":
        {
            ChangeColorItem(lstOrg_Code.GetControl());
            check_init=1;                
        }
        break;

        case "datProbationDate":
        {
            if (lstProKind.value =="03") //have to input end probation
            dtEDProbate.SetEnable(true);
            else
                dtEDProbate.SetEnable(false);
            dtSTProbate.SetEnable(false);               
        }
        break;  
        case "datRec":
        {
            //alert(txtRec_pk.text);
            //alert("abc");
            if (bdelete==true ) // case delete
            {
                bdelete=false;
                OnReset();
            }
        }
        break;  
        case "datCheckDelete":
        {
            if (txtDelete_Flag.text==1)
                alert("You can't delete beause having data of employee \n Bạn không thể xóa vì lấy dữ liệu cho nhân viên");            
            else
            {     
                bdelete=true;           
                datRec.StatusDelete();
                datRec.Call();           
            }
        }
        break;  
        case "datCheckExist":
        {       
            //alert(txtEmpIDTemp.text);                 
            if (txtExistTemp.text==1 )
            {
                alert("Have already person id of employee id:" + txtEmpIDTemp.text + "\nĐã trùng số CMND với nhân viên : "+txtEmpIDTemp.text )                       
                txtPersonalID.GetControl().focus(); 
                return;                                                               
            }  
            if (txtExistTemp.text==2 )
            {
                if (confirm("Have already person id of recruitment Do you want to continue?" +"\nĐã trùng số CMND với recruitment khác Bạn có muốn tiếp tục?")) 
                {
                    if (datRec.GetStatus()==10 || datRec.GetStatus()==0)
                    {
                        if (confirm("Do you want to update? \n Bạn có muốn cập nhật?"))
                        {
                            datRec.StatusUpdate();
                            datRec.Call();
                        }
                    }
                    else if (datRec.GetStatus()==20)
                    {                                    
                        if (confirm("Do you want to add new recruitment? \n Bạn muốn thêm mới?"))
                        {
                            datRec.Call();
                        }
                    }           
                } 
                else
                {                                  
                    txtPersonalID.GetControl().focus();
                    return;  
                }    
            }
            else
            {
                if (datRec.GetStatus()==10 || datRec.GetStatus()==0)
                    {
                        if (confirm("Do you want to update? \n Bạn có muốn cập nhật?"))
                        {
                            datRec.StatusUpdate();
                            datRec.Call();
                        }
                    }
                    else if (datRec.GetStatus()==20)
                    {                                    
                        if (confirm("Do you want to add new recruitment? \n Bạn muốn thêm mới?"))
                        {
                            datRec.Call();
                        }
                    }     
            }                                                                                                                                               
       }
       break;
       case "datGetNewCode":
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
        break;          
    }  // end switch
    
}

//-----------------------------------------------
function OnUpdate()
{  
	if(check_init==1)
	{		
		OnCheckAdd();  
    
	}		    
}
//----------------------------------------------
function OnSearch()
{
	if(check_init==1)
	{
		var fpath = System.RootURL + "/form/ch/ae/chae00770_search_recruit.aspx" ;
		var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
		if (obj!=null)
		{
			txtRec_pk.text=obj[0];
            //alert(txtRec_pk.text);
		   
			datRec.Call("SELECT");
		}
	}	
}
//-------------------------------------------
function OnDelete()
{
	if(check_init==1)
	{
		if (confirm("Do you want to delete this recruitment?\Bạn muốn xóa?"))
		{
			datCheckDelete.Call();
		}
	}	
    
}
//---------------------------------------------------------
function OnCheckAdd()
{
    if (Trim(dtRecruit.value)=="")
    {
        alert("Please input recruitment date! \n Vui lòng nhập ngày tuyển dụng.");
        dtRecruit.GetControl().focus();
        return;
    }
    if (Trim(txtFullName.text)=="")
    {
        alert("Please input full name! \n Vui lòng nhập họ và tên");
        txtFullName.GetControl().focus();
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


    if (Trim(txtBirthDT.text)=="")
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

    if(Trim(lstBirthPlace.value)=="")
    {
	alert("Please input birth place! \n Vui lòng nhập nơi sinh");
        	return;
    }
    if(Trim(lstSEX.value)=="")
    {
	alert("Please input sex! \n Vui lòng nhập giới tính.");
        	return;
    }

    if(Trim(lstPosition.value)=="")
    {
	alert("Please input position! \n Vui lòng nhập vị trí.");
        	return;
    }


    if(Trim(txtPersonalID.text)=="")
    {
	    alert("Please input Personal ID! \n Vui lòng nhập số CMND.");
        	return;
    }
    if(Trim(dtIssueDT.value)=="")
    {
	alert("Please input Issue Date! \n Vui lòng nhập ngày cấp CMND.");
        	return;
    }
    if(Trim(lstPlaceID.value)=="")
    {
	alert("Please input Personal ID Place! \n Vui lòng nhập nơi cấp CMND.");
        	return;
    }

    if (Trim(dtJoinDT.value)=="")
    {
        alert("Please input join date!\nVui lòng nhập ngày vào làm .");
        return;
    }  
    
    if(Trim(dtRecruit.value)!="" && (Trim(dtJoinDT.value)!="") && dtRecruit.value > dtJoinDT.value)
    {
        alert("Join date have to larger than or equal to recruitment date");
        return;
    }  
      
    if (Trim(lstProKind.value)=="")
    {
        alert("Have to choose probation kind!\nVui lòng chọn loại thử việc");
        return;
    }

     if (Trim(dtSTProbate.value)=="")
    {
        alert("Please input end probation date!\nVui lòng nhập ngày hết thử .");
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
       
    if (Trim(lstSalaryType.value)=="")
    {
        alert("Salary Type cannot be NULL!\nVui lòng chọn phương thức tính lương.");
        return;
    }                           
	if (txtPersonalID.text!="")
	    CheckExistPersonID();    
}
//-----------------------------------------------

function checkKey() {
    var c = String.fromCharCode(event.keyCode);
    var x = c.toUpperCase().charCodeAt(0);
    event.keyCode = x;

}
//-------------------------------------------------
function OnShowPopup(strtemp,objlist)
{
    
	if (strtemp==3)
    {
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
			lstOrg_Code.value = obj;
			datGet_period.Call();
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
function CheckExistPersonID()
{
    //txtFlag.text=1;
    datCheckExist.Call();
}

<!------------------------------------>

</script>
<body bgcolor='#F5F8FF'>

<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR.sp_pro_check_view"  > 
                <input>
                    <input bind="txtUser_PK" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!----------------------------------->
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

<!------------------------------------->
<gw:data id="datCheckExist" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_check_exist_10077" > 
                <input>
                    <input bind="dtRecruit" />
                    <input bind="txtRec_pk" />  
                    <input bind="txtPersonalID" />                    
                </input> 
                <output>
                    <output bind="txtExistTemp" />
                    <output bind="txtEmpIDTemp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datRec" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27" function="hr_sel_10010077_recruitment" procedure="HR_upd_10010077_recruitment">            
                <inout>   
                    <inout bind="txtRec_pk"/>                
                    <inout bind="txtFullName"/>
                    <inout bind="lstOrg_Code"/>					
					<inout bind="lstWork_Grp"/>
                    <inout bind="txtBirthDT"/>
                    <inout bind="lstBirthPlace"/>
                    <inout bind="lstSEX"/>
                    <inout bind="txtLivingAdd"/>
                    <inout bind="lstPosition"/>
                    <inout bind="txtPersonalID"/>                    
                    <inout bind="dtIssueDT"/>
                    <inout bind="lstPlaceID"/>
                    <inout bind="dtJoinDT"/>
                    <inout bind="txtBasicSal"/>                    
                    <inout bind="txtAllow1AMT"/>
                    <inout bind="lstProKind"/>
                    <inout bind="dtSTProbate"/>
                    <inout bind="dtEDProbate"/>
                    <inout bind="lstEthnic"/>
                    <inout bind="lstReligion"/>
                    <inout bind="lstEducation"/>                    
                    <inout bind="lstNation"/>
                    <inout bind="lstSalaryType"/>
                    <inout bind="lstMoneyKind"/>
                    <inout bind="lstEmp_Type"/>
                    <inout bind="lstSal_period" />
                    <inout bind="txtAnnualLeave"/>
                    <inout bind="dtRecruit"/>

               </inout> 
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------>
<gw:data id="datCheckDelete" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_sel_10010077_check_delete" > 
                <input>
                    <input bind="txtRec_pk" /> 
                </input> 
                <output>
                    <output bind="txtDelete_Flag" />
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
<!----------------------------------->

 
     <table id="main"  cellpadding="20" cellspacing="0"  style="width:80%;height:60%;" align=center border=2>
        <tr >
            <td>
                <table  width="100%" style="width:100%;height:100%;" cellpadding="0" cellspacing="0" >
                    <tr style="height:10%" valign=top cellpadding="0" cellspacing="0">
                        <td colspan=11>
                            <table  width=100% cellpadding="0" cellspacing="0" >
                                <tr style="border:0">
                                    <td nowrap width=40%  style="border:0" align=right >Recruitment Date
                                        </td>
                                    <td nowrap width=10%  style="border:0" ><gw:datebox id="dtRecruit"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" />
                                     </td>
                                    <td nowrap width=5%  style="border:0" align=right></td>
                                    
                                    <td nowrap width=10%  style="border:0">  </td>
                                  
                                   <td nowrap width=5%  style="border:0"></td>
                                    <td nowrap width=5%  style="border:0">
                                        <gw:imgBtn id="ibtnResetE" alt="Reset" img="Reset" text="Reset" onclick="OnReset()" />
                                    </td>
                                    <td nowrap width=5%  style="border:0">
                                        <gw:imgBtn id="ibtnUpdate" alt="Save" img="save" text="Save" onclick="OnUpdate()" />
                                    </td>
                                    <td nowrap width=5%  style="border:0">
                                        <gw:imgBtn id="ibtnSearch"  alt="Popup"  img="popup" text="Search"  onclick="OnSearch()" />
                                    </td>
                                    <td nowrap width=5%  style="border:0">
                                        <gw:imgBtn id="ibtnDelete"  alt="Delete"  img="delete"  text="Delete"  onclick="OnDelete()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height:5%">
                    
                        <td nowrap width=10%>
                            Full Name(VN)(*)</td>
                        <td nowrap colspan=1 width=20%>
                            <gw:textbox id="txtFullName"  maxlen = "60" text="" styles='width:100%;' csstype="mandatory" onkeypress="checkKey()" />
                        </td>
                        <td width="5%"></td>
                       <td nowrap width=10%><a title="Click here to show Organization" onclick="OnShowPopup(3,'')" href="#tips" >
                            Organization(*)</a></td>
                        <td nowrap width=20%> <gw:list  id="lstOrg_Code" value=" " maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>| |Select ...
                            </data>
                        </gw:list></td>
                        <td nowrap width="5%">
                        </td>
                           <td nowrap width="10%">Work Group(*)</td>
                        <td nowrap  width="20%"><gw:list  id="lstWork_Grp" maxlen = "100" styles='width:100%'onchange="" >
								<data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  order by nvl(a.seq,99999999)")%>| |Select ...
                            </data>
							</gw:list></td>
                    </tr>
					
					<tr style="height:5%">
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
                        <td nowrap ></td>
                        <td nowrap ><a title="Click here to show sex code" onclick="OnShowPopup('HR0007',lstSEX)" href="#tips" >
                            Sex</a></td>
                        <td nowrap >
                            <gw:list  id="lstSEX" value=" " styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm")%>||
                            </data>
                            </gw:list>
                        </td>
					</tr>
					<tr style="height:5%">
					  <td nowrap >
                           Permanent Addr</td>
                        <td nowrap  colspan=4 >
                            <gw:textbox id="txtLivingAdd"  text="" maxlen = "100" styles='width:100%' />
                        </td> 
                        <td nowrap ></td>
                          <td nowrap ><a title="Click here to show position code" onclick="OnShowPopup('HR0008',lstPosition)" href="#tips" >
                            Position(*)</a></td>
                        <td nowrap > <gw:list  id="lstPosition" value=" " maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>||
                            </data>
                            </gw:list>
                            
                        </td> 
                    </tr>
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
                    </tr>
                    <tr style="height:5%">
					     <td nowrap>
                            Join Date(*)</td>
                        <td nowrap >
                            <gw:datebox id="dtJoinDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="ChangeProbType()" />
                        </td>
                         <td nowrap ></td>
                           <td nowrap  >
                            Basic Salary</td>
                        <td nowrap  >
                           <gw:textbox  id="txtBasicSal" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                        </td>
                        
                        <td nowrap ></td>
                          <td nowrap>Allowance</td>
                        <td nowrap >
                            <gw:textbox  id="txtAllow1AMT" type="number" format="#,###,###,###.##R" text="" styles='width:100%' /> 
                        </td >
                           
                        <td nowrap >
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
                      </tr>
                      <tr style="height:5%">
                       <td nowrap ><a title="Click here to show ethnic" onclick="OnShowPopup('HR0015',lstEthnic)" href="#tips" >
                            Ethnic</a></td>
                        <td nowrap >
                            <gw:list  id="lstEthnic" value="02" styles='width:100%'>
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
                            <gw:list  id="lstReligion"  value="07" styles='width:100%'> 
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0016' order by code_nm")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td>
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
					    <td nowrap ><a title="Click here to show nation code" onclick="OnShowPopup('HR0009',lstNation)" href="#tips" >
                            Nation(*)</a></td>
                        <td nowrap >
                            <gw:list  id="lstNation"  styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code")%>||
                            </data>
                            </gw:list> 
                        </td>
                        <td nowrap ></td>
                           <td nowrap ><a title="Click here to show Salary type" onclick="OnShowPopup('HR0056',lstSalaryType)" href="#tips" >
                            Salary Type</a></td>
                        <td nowrap id="h45" >
                            <gw:list  id="lstSalaryType" value="" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0056' order by num_1")%>||
                            </data>
                            </gw:list >
                        </td>
                         <td nowrap ></td>
                         <td nowrap ><a title="Click here to show pay type" onclick="OnShowPopup('HR0040',lstMoneyKind)" href="#tips" >
                            Money Kind</a>
                        </td>
                        <td nowrap  > <gw:list  id="lstMoneyKind" value="01" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0040' order by code_nm")%>
                            </data>
                            </gw:list ></td>
					</tr>
					<tr style="height:5%">
					    <td nowrap width=5%><a title="Click here to show employee type" onclick="OnShowPopup('HR0017',lstEmp_Type)" href="#tips" >
                            Emp Type(*)</a></td>
                        <td nowrap ><gw:list  id="lstEmp_Type" value=" " styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code_nm")%>||
                            </data>
                            </gw:list>
                        </td> 
                        <td>
                        </td>
                         <td nowrap  >Salary Period</td>
                        <td nowrap   ><gw:list  id="lstSal_period" value="" styles='width:100%' onChange="">
                             <data>
                                <%=ESysLib.SetListDataSQL("select v.CODE,v.CODE_NM||' '|| v.CHAR_1||'->'||v.CHAR_2 from vhr_hr_code v where v.id='HR0030' and v.num_1=1 and (v.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',v.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6') order by v.code")%>
                            </data>
                            </gw:list >
                        </td>
                         <td>
                        </td>
                         <td nowrap >Annual Leave</td>
                        <td nowrap >
                            <gw:textbox  id="txtAnnualLeave" type="number" format="#,###,###,###.##R" text="" styles='width:100%' />
                        </td>
					</tr>
                </table>
            </td>
        </tr>
    </table>
                  
    <gw:textbox id="txtUser_PK" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>    
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />
    <gw:textbox id="txtEmp_PK" styles="display:none"/>
    <gw:textbox id="txtFlag" styles="display:none"/>
    <gw:textbox id="txtExistTemp" styles="display:none"/>
    <gw:textbox id="txtRec_pk" styles="display:none"/>
    <gw:textbox id="txtDelete_Flag" styles="display:none"/>
    <gw:textbox id="txtEmpIDTemp" styles="display:none"/>
    <gw:textbox id="txtComCodeID" styles="display:none"/>
    <gw:textbox id="txtCodeTemp" styles="display:none" />	
</body>


