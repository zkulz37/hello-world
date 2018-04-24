<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;
function BodyInit()
{
    grdEmployee.GetGridControl().FrozenCols =6;
    grdEmployee.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
    ibtnSave.SetEnable(false);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user="<%=session("USER_ID")%>";
    BindingDataList();
   // datAllowance.Call();
}
//----------------------------------
function OnShowPopup(obj)
{   if(obj==2)
    {   var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae0030_Emp_Kind.aspx";
        
        
	    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:100;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
	    if (obj!=null)
	    { lstEmpKind.value=obj;
	    }
	}
	    else if(obj==3)
	 {  var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx";    
	    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:100;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
	    if (obj!=null)
	    { lstNewOrg.value=obj;
	    }
	    
	 }
	 if(obj==1)
	 {var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx";    
	    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:100;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
	    if (obj!=null)
	    { lstDept_Code.value=obj;
	    }
	 }
}
function BindingDataList()
{   <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 2 ,  "select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 order by a.seq") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 8 ,  "select code,CODE_NM from vhr_hr_code where id='HR0021' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 12 , "select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 15 , "select code,CODE_NM from vhr_hr_code where id='HR0014' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 17 , "select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 18 , "select code,CODE_NM from vhr_hr_code where id='HR0015' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 19 , "select code,CODE_NM from vhr_hr_code where id='HR0016' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 20 , "select code,CODE_NM from vhr_hr_code where id='HR0011' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 21 , "select code,CODE_NM from vhr_hr_code where id='HR0010' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 22 , "select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 38 , "select code,CODE_NM from vhr_hr_code where id='HR0017' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 51 , "select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 52 , "select code,CODE_NM from vhr_hr_code where id='HR0020' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 64 , "select code,CODE_NM from vhr_hr_code where id='HR0115' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdEmployee" , 65 , "select a.pk,a.PL_CD from acnt.tac_abpl a  where a.del_if=0 and nvl(a.USE_YN,'N')='Y' ORDER BY a.PL_CD") %>; 
    <%=ESysLib.SetGridColumnComboFormatString2( "grdEmployee" , 61 , "Y|YES|N|NO") %>;  
    }
//----------------------------------
/*function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        datDeptData.Call();
    }
    
}*/
//----------------------------------------------------
function ChoseList_box(obj_list,value)
{/*
    
    obj_list.SetDataText(value);
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;*/
}
function OnSetGrid(obj)
{   if(obj=='1')
    if(lstNewOrg.value=="ALL")
    alert("Please select organization");
    else
    {
     for (var i=1;i<grdEmployee.rows;i++)
        grdEmployee.SetGridText(i,2,lstNewOrg.value);
    }
    if(obj=='2')
        if(lstNewProject.value=="ALL")
        alert("Please select new project");
        else
        {
         for (var i=1;i<grdEmployee.rows;i++)
            grdEmployee.SetGridText(i,65,lstNewProject.value);
        }
}
//----------------------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {
        if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstDept_Code.SetDataText(txtDeptData.text)    ;
            
              obj=lstDept_Code.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=0;
        datTeamData.Call();
   }
   else if (obj.id=="datTeamData")
   {
       // ChoseList_box(lstGrp_Code,txtGroupData.text)
        
   }
   else if (obj.id=="datSal_security")
   {
       if(txt_sal_security.text=='N') 
       {
            var icol=39; //value of probation salary
            for (var i=0;i<=7;i++)
                grdEmployee.GetGridControl().ColHidden(icol+i)=1;
       }
       if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
   }
   else if (obj.id=="datUser_info")
   {
        //lstDept_Code.SetDataText(txtDeptData.text);
        datTeamData.Call();
   }
   else if (obj.id=="datEmp_Management")
   {
        if (grdEmployee.rows>1)
        {
            ibtnSave.SetEnable(true);
            SetColRow();
        }
        else
        {
            ibtnSave.SetEnable(false);
            
        }
        lblRecord.text=grdEmployee.rows-1 + " record(s).";
        auto_resize_column(grdEmployee,0,grdEmployee.cols-1,9);    
   }
   /*else if (obj.id=="datFind_Report")
   {
        var url=System.RootURL;
        switch (rpt_no)
        {
        
            case 1:
            {
                
                url=url + '/reports/ch/ae/'+txtReport_tmp.text+'?p_1=' + lstGrp_Code.value + '&p_2=' + lstNation.value + '&p_3=' + lstTemp.value + '&p_4=' + txtTemp.text + '&p_5=' + dtFrom_JoinDate.value + '&p_6=' + dtTo_JoinDate.value ;
                url=url + '&p_7=' + lstSalaryYN.value + '&p_8=' +lstPosition.value + '&p_9=' + lstPay_Type.value + '&p_10=' + lstContract_Kind.value + '&p_11=' + dtFrom_BeginContract.value + '&p_12=' + dtTo_BeginContract.value;
                url=url + '&p_13=' + lstSex.value  +'&p_14=' + lstInsuranceYN.value  + '&p_15=' + lstStatus.value  +'&p_16=' + dtFrom_LeftDate.value + '&p_17=' + dtTo_LeftDate.value +  '&p_18=' + dtFrom_BirthDate.value  ;
                url=url + '&p_19=' + lstOTYN.value  + '&p_20=' + dtFrom_BirthDate.value  +'&p_21=' + lstDept_Code.value + '&p_22=' + txt_sal_security.text ;
                url=url + '&p_23=' + lstJob.value  + '&p_24=' + lstEducation.value  +'&p_25=' + lstEmpKind.value + '&p_26=' + lstProject.value+ '&p_27=' + lstWg.value ;
                
                break;
            }
            case 2:
            {
                
                url=url + '/reports/ch/ae/'+txtReport_tmp.text+'?p_thr_group_pk=' + lstGrp_Code.value + '&p_nation=' + lstNation.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text + '&p_from_joindate=' + dtFrom_JoinDate.value + '&p_to_joindate=' + dtTo_JoinDate.value ;
                url=url + '&p_salary_yn=' + lstSalaryYN.value + '&p_position=' +lstPosition.value + '&p_pay_type=' + lstPay_Type.value + '&p_contract_kind=' + lstContract_Kind.value + '&p_from_contract=' + dtFrom_BeginContract.value + '&p_to_contract=' + dtTo_BeginContract.value;
                url=url + '&p_sex=' + lstSex.value  +'&p_insurance_yn=' + lstInsuranceYN.value  + '&p_status=' + lstStatus.value  +'&p_from_leftdate=' + dtFrom_LeftDate.value + '&p_to_leftdate=' + dtTo_LeftDate.value +  '&p_from_birthdate=' + dtFrom_BirthDate.value  ;
                url=url + '&p_ot_yn=' + lstOTYN.value  + '&p_to_birthdate=' + dtFrom_BirthDate.value  +'&p_tco_dept_pk=' + lstDept_Code.value + '&p_user=' + user + '&p_sal_security=' + txt_sal_security.text;
                url=url + '&p_23=' + lstJob.value  + '&p_24=' + lstEducation.value  +'&p_25=' + lstEmpKind.value + '&p_26=' + lstProject.value+ '&p_27=' + lstWg.value ;
                break;
            }
            
        }
        window.open(url); 
   }*/
   /*else if (obj.id=="datBand_GradeData")
   {
        var obj=lstProject.GetControl();
        obj.options.selectedIndex=obj.options.length-1;
   }
   */
   
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//------------------------------------------------
function SetColRow()
{
    grdEmployee.SetCellBgColor(1,5,grdEmployee.rows -1 ,5,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,8,grdEmployee.rows -1 ,22,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,30,grdEmployee.rows -1 ,30,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,33,grdEmployee.rows -1 ,33,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,36,grdEmployee.rows -1 ,36,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,38,grdEmployee.rows -1 ,40,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,51,grdEmployee.rows -1 ,53,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,58,grdEmployee.rows -1 ,61,0xFFEEFF);
    grdEmployee.SetCellBgColor(1,58,grdEmployee.rows -1 ,62,0xFFEEFF);
   
    
}
//------------------------------------------------
function OnChangeDept()
{
    datTeamData.Call();
}
//----------------------------------------------------
function OnSearch()
{
        datEmp_Management.Call("SELECT");
}
//-------------------------------------------------------------
function SelectOption(obj)
{
    if (obj==1)
    {
        txtOption.text="1";
        lstTemp.SetEnable(false);
        txtTemp.SetEnable(false);
        txtEmpID.SetEnable(true);
        txtTemp.text="";
        txtEmpID.GetControl().select();
    }
    else
    {
        txtOption.text="2";
        lstTemp.SetEnable(true);
        txtTemp.SetEnable(true);
        txtEmpID.SetEnable(false);
        txtEmpID.text="";
        txtTemp.GetControl().select();
    }
}
//------------------------------------------------------------
function doSelectAll()
{	
	var tmp;
	if( idCheckAll.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
	for (var i=1; i<grdEmployee.rows; i++)
		grdEmployee.SetGridText( i , 0,tmp );
}

//-----------------------------------------------
function OnReport(obj)
{
   /* var url=System.RootURL;
    rpt_no=obj;
    switch (obj)
    {
    
        case 1:
        {
            txtReport_tmp.text="rpt_employee_list.aspx";
            break;
        }
        case 2:
        {
            txtReport_tmp.text="rpt_employee_detail_list.aspx";
            break;
        }
        
    }*/
    //datFind_Report.Call();
 var url=System.RootURL;
  url=url + '/reports/ch/ae/rpt_employee_list_change_project.aspx?p_picture='+lstImage.value + '&p_nation=' + lstNation.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text + '&p_from_joindate=' + dtFrom_JoinDate.value + '&p_to_joindate=' + dtTo_JoinDate.value ;
               url=url + '&p_salary_yn=' + lstSalaryYN.value + '&p_position=' +lstPosition.value + '&p_pay_type=' + lstPay_Type.value + '&p_contract_kind=' + lstContract_Kind.value + '&p_from_contract=' + dtFrom_BeginContract.value + '&p_to_contract=' + dtTo_BeginContract.value;
               url=url + '&p_sex=' + lstSex.value  +'&p_insurance_yn=' + lstInsuranceYN.value  + '&p_status=' + lstStatus.value   ;
                url=url + '&p_tco_dept_pk=' + lstDept_Code.value + '&p_user=' + user + '&p_sal_security=' + txt_sal_security.text;
               url=url + '&p_job=' + lstJob.value  +'&p_emp_kind=' + lstEmpKind.value + '&p_project=' + lstProject.value+ '&p_wplace=' + lstWorkPlace.value ;
    
    
    window.open(url);  
    
}
//-----------------------------------------------
function OnSave()
{
   // if (CheckUpdate())
        if (confirm("Do you want to save?"))
            datEmp_Management.Call();
}
//-----------------------------------------------
function CheckUpdate()
{

    var rowvalue;
    for (var i=1;i<grdEmployee.rows;i++)
    {
        if (grdEmployee.GetRowStatus(i)==16)
        {
            rowvalue=grdEmployee.GetGridData(i,9);
            if (isNaN(rowvalue) && rowvalue!="") //telephone
            {
                alert("Please input number in row " + i + " and column 8");
                return false;
            }
            rowvalue=grdEmployee.GetGridData(i,13); //person id
            
            if (isNaN(rowvalue)  && rowvalue!="")
            {
                alert("Please input number in row " + i + " and column 8");
                return false;
            }
        }
    }
    return true;
}
function OnChangeBand()
{
    //datBand_GradeData.Call();
}

</script>
<body style=" margin-bottom:0; margin-top:0; margin-right:0; margin-left:0" >
<!-------------------data control----------------------->

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
<!------------------------------------------------------>

<!------------------------------------->
<gw:data id="datTeamData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_team_data_all" > 
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
<gw:data id="datEmp_Management" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,2,3,5,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,30,33,36,38,39,40,51,52,53,58,59,60,61,62,65" function="HR.SP_SEL_EMP_Change_Proj" procedure="hr.sp_upd_emp_management_posli"> 
                <input bind="grdEmployee" >
                    <input bind="lstDept_Code" />
                   
                    <input bind="lstNation" />
                    <input bind="lstTemp" />
                    <input bind="txtTemp" />
                    <input bind="dtFrom_JoinDate" />
                    <input bind="dtTo_JoinDate" />
                    <input bind="lstSalaryYN" />
                    <input bind="lstPosition" />
                    <input bind="lstPay_Type" />
                    <input bind="lstContract_Kind" />
                    <input bind="dtFrom_BeginContract" />
                    <input bind="dtTo_BeginContract" />
                    <input bind="lstSex" />
                    <input bind="lstInsuranceYN" />
                    <input bind="lstStatus" />
                      
                    <input bind="lstJob" />
                   
                    <input bind="lstEmpKind" />
                    <input bind="lstProject" />
                    <input bind="lstWorkPlace" />
                    <input bind="lstImage" />
                    
                </input>
                <output  bind="grdEmployee" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstDept_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<!------------------------------------------>
<gw:data id="datSal_security" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="hr.sp_pro_sal_display"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txt_sal_security" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
   <table id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
                  <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:0%"  >
                   <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                   <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                   <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                   <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                   <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                   <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                   <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td
                   <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                   <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                   <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                   </tr>
                    <tr style="border:0;width:100%;height:5%"  >
                        <td  colspan ="8" style="border:0;" align="left" ><a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Organizaion</a></td>
                        <td colspan="19"  style="border:0;" align="left" >
                         <gw:list  id="lstDept_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeDept()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 order by a.seq")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="10"style="border:0;" align="left"><a title="Click here to show employee kind" onclick="OnShowPopup(2)" href="#tips" >Emp Kind</a></td>
                        <td style="border:0;" colspan="20" ><gw:list  id="lstEmpKind" value="ALL" styles='width:100%' OnChange="">
                           <data>
                                <%=ESysLib.SetListDataSQL("SELECT A.PK,A.KIND_NAME as code FROM THR_EMPLOYEE_KIND A  where  A.del_if=0  order by code ")%>|ALL|Select All
                            </data></gw:list></td>
                         <td colspan="4" style="border:0" align="right">Position </td>
                        <td  colspan="11" style="border:0;" align="left" >
                         <gw:list  id="lstPosition" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>                       
                         
                         <td  style="border:0;" align="right" colspan="8" >Join Date</td>
				        <td  style="border:0;" colspan="7" ><gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  style="border:0;" colspan="1" align="center">~</td>
				        <td  style="border:0;" colspan="7" ><gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                                           
                        <td colspan="1" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td colspan="2" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave()"/>
                        </td>
                        <td colspan="2" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnSumPrinter"    alt="Summmary Report"  onclick="OnReport(1)"/>
                        </td>
                                             
                    </tr>
                    <tr>                      
				        <td  colspan="4" style="border:0;" align="right" >Status</td>
                        <td  style="border:0;" align="left" colspan="10">
                         <gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>				        
				        <td style="border:0;" align="right" colspan="4" >Nation</td>
                        <td style="border:0;" align="left" colspan="16" >
                            <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
                                <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td   style="border:0;" align="right" colspan="3">Job </td>
                        <td  style="border:0" align="right" colspan="13"><gw:list  id="lstJob"  value="ALL" styles='width:100%' >
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0010' order by seq")%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                         <td  colspan="6" style="border:0;" align="center">Project</td>
				        <td style="border:0;" colspan="16"><gw:list  id="lstProject" value="ALL" styles='width:100%' OnChange="">
                           <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.PL_CD from acnt.tac_abpl a  where a.del_if=0 and nvl(a.USE_YN,'N')='Y' ORDER BY a.PL_CD")%>|ALL|Select All
                            </data></gw:list>
                         </td>
                        
                        <td   style="border:0;"colspan="2" align="right" >Sex</td>
                        <td colspan=8 style="border:0" align="right">
                         <gw:list  id="lstSex" value="ALL" styles='width:100%' onchange=""> 
							        <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                      
                         <td colspan=5 style="border:0;" align="right" >Search by</td>
                        <td  colspan=7 style="border:0;" align="left" >
                         <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							     <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					     </gw:list>
                        </td> 
                        <td colspan=7 style="border:0;" align="right"> <gw:textbox id="txtTemp"  text="" maxlen = "100" styles='width:100%'onenterkey="OnSearch()"/>
                        </td>
                                          
                    </tr>
                    <tr>                     
                     <td  style="border:0" align="left"  colspan="4">Salary</td>
					    <td  style="border:0" colspan="16">
					    <gw:list  id="lstSalaryYN" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>LIST|Y|Yes|N|No|ALL|Select All</data> </gw:list>
				     </td>
				       <td colspan=7 style="border:0;" align="left" >Pay type</td>
                        <td  style="border:0;"  colspan=15>
                         <gw:list  id="lstPay_Type" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  colspan=6 style="border:0;" align="right" >
                            Insurance</td>
                        <td colspan=14 style="border:0;" align="left" >
                         <gw:list  id="lstInsuranceYN" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>LIST|Y|Yes|N|No|ALL|Select All</data> 
                        </gw:list>
                        </td>
                       <td style="border:0" align="right" valign="middle" colspan=5>Contract</td>
				        <td  style="border:0" colspan=14> 
					        <gw:list  id="lstContract_Kind" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td style="border:0;" align="right" colspan=4>Begin CT</td>
				        <td style="border:0;" colspan=7><gw:datebox id="dtFrom_BeginContract" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  style="border:0;" align="center">~</td>
				        <td style="border:0;" colspan=7><gw:datebox id="dtTo_BeginContract" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                    </tr>
                    <tr>
                    <td style="border:0;" align="left" colspan=4>Photo</td>
                      <td  style="border:0" colspan=16> 
					        <gw:list  id="lstImage" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>List|1|Yes|2|No|ALL|All</data></gw:list>
                      </td>
                      <td style="border:0" align="left"  colspan=7>W place</td>
				       <td  style="border:0" colspan="15"> 
					       <gw:list  id="lstWorkPlace" maxlen = "100" value="ALL" styles='width:100%'> 			        
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0115' order by code_nm")%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                      <td  colspan ="16" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(3)" href="#tips" >New Organizaion</a></td>
                       <td colspan="15"  style="border:0;" align="left" >
                         <gw:list  id="lstNewOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeDept()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 order by a.seq")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="2"style="border:0;"><gw:imgBtn img="set" id="ibtnSet_O"   alt="Set Grid"  onclick="OnSetGrid(1)"/></td>
                        <td  colspan="10" style="border:0;" align="right">New Project</td>
				        <td style="border:0;" colspan="9"><gw:list  id="lstNewProject" value="ALL" styles='width:100%' OnChange="">
                           <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.PL_CD from acnt.tac_abpl a  where a.del_if=0 and nvl(a.USE_YN,'N')='Y' ORDER BY a.PL_CD")%>|ALL|Select All
                            </data></gw:list>
                         </td>                                                          
                         <td colspan="2"style="border:0;"><gw:imgBtn img="set" id="ibtnSet_P"   alt="Set Grid"  onclick="OnSetGrid(2)"/></td>
                    </tr>     
                    <tr>
                    <td colspan="100" align="center"><gw:label id="lblRecord"  text="0 recode(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" /></td>
                    </tr>           
                    <tr style="border:1;width:100%;height:75%" valign="top">
                        <td colspan=100 style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdEmployee"  
                                header="_PK|Department|Team/Section|Emp ID|Full Name|ID Num|Join Date|Birth Date|Place Birth|Telephone|Permanent Address|Present Address|Sex|Person ID|Issue Date|Place Per ID|Married|Nation|Ethenic|Religion|Education|Job|Position|Probation Type|Begin Probation|End  Probation|Contract Kind|Contract NO|Begin Contract|End Contract|Social Flag|Social Place|Social Date|Health Flag|Health Place|Health Date|Unemp Flag|Unemp Date|Employee Type|OT YN|Salary YN|Probation Salary|Basic Salary|Allow Amt1|Allow Amt2|Allow Amt3|Allow Amt4|Allow Amt5|Allow Amt6|Allow Amt7|Allow Amt8|Pay Type|Bank Type|Account|Status|Left Date|Resign Type|Cost Kind|Pass Port No|Pass Port Date|Remark|Union|Pit No|W-Group|Working Place|Project"   
                                format="0|0|0|0|0|0|4|0|0|0|0|0|0|0|4|0|3|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0|3|0|0|3|0|0|3|3|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|4|0|2|0|0|0|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"    
                                defaults="|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"    
                               editcol="0|0|0|1|0|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|1|0|0|1|0|0|1|0|1|1|0|0|0|0|0|0|0|0|0|0|0|1|1|1|0|0|0|0|1|1|1|1|1|0|1|1"  
                                widths="1500|1500|1500|1500|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|500|500|1500|1500|1500|1500|1500"  
                                styles="width:100%; height:100%"   
                                sorting="T"/> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
</body>

<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtOption" text="1" styles="display:none"/> 
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txt_sal_security" styles="display:none"/>

</html>
