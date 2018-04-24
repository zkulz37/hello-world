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
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user="<%=session("USER_ID")%>";
    BindingDataList();
    datAllowance.Call();
}
//----------------------------------
function BindingDataList()
{   
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
    <%=ESysLib.SetGridColumnComboFormatString2( "grdEmployee" , 61 , "Y|YES|N|NO") %>;  
    

}
//----------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:240;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        datDeptData.Call();
    }
    
}
//----------------------------------------------------
function ChoseList_box(obj_list,value)
{
    
    obj_list.SetDataText(value);
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
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
       // datGroupData.Call();
   }
   else if (obj.id=="datGroupData")
   {
        ChoseList_box(lstGrp_Code,txtGroupData.text)
        
   }
   else if (obj.id=="datAllowance")
   {
        var icol=43; //value of allowance col
        grdEmployee.SetGridText(0,icol,grdAllowance.GetGridData(1,0));
        grdEmployee.SetGridText(0,icol+1,grdAllowance.GetGridData(1,1));
        grdEmployee.SetGridText(0,icol+2,grdAllowance.GetGridData(1,2));
        grdEmployee.SetGridText(0,icol+3,grdAllowance.GetGridData(1,3));
        grdEmployee.SetGridText(0,icol+4,grdAllowance.GetGridData(1,4));
        grdEmployee.SetGridText(0,icol+5,grdAllowance.GetGridData(1,5));
        grdEmployee.SetGridText(0,icol+6,grdAllowance.GetGridData(1,6));
        grdEmployee.SetGridText(0,icol+7,grdAllowance.GetGridData(1,7));
        grdEmployee.GetGridControl().ColHidden(icol)=!(Number(grdAllowance.GetGridData(1,8)));
        grdEmployee.GetGridControl().ColHidden(icol+1)=!(Number(grdAllowance.GetGridData(1,9)));
        grdEmployee.GetGridControl().ColHidden(icol+2)=!(Number(grdAllowance.GetGridData(1,10)));
        grdEmployee.GetGridControl().ColHidden(icol+3)=!(Number(grdAllowance.GetGridData(1,11)));
        grdEmployee.GetGridControl().ColHidden(icol+4)=!(Number(grdAllowance.GetGridData(1,12)));
        grdEmployee.GetGridControl().ColHidden(icol+5)=!(Number(grdAllowance.GetGridData(1,13)));
        grdEmployee.GetGridControl().ColHidden(icol+6)=!(Number(grdAllowance.GetGridData(1,14)));
        grdEmployee.GetGridControl().ColHidden(icol+7)=!(Number(grdAllowance.GetGridData(1,15)));
        datSal_security.Call();
    
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
       // datGroupData.Call();
   }
   else if (obj.id=="datEmp_Management")
   {
        lblRecord.text=grdEmployee.rows-1 + " record(s).";
        auto_resize_column(grdEmployee,0,grdEmployee.cols-1,9);    
   }
   else if (obj.id=="datFind_Report")
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
                
                break;
            }
            case 2:
            {
                
                url=url + '/reports/ch/ae/'+txtReport_tmp.text+'?p_thr_group_pk=' + lstGrp_Code.value + '&p_nation=' + lstNation.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text + '&p_from_joindate=' + dtFrom_JoinDate.value + '&p_to_joindate=' + dtTo_JoinDate.value ;
                url=url + '&p_salary_yn=' + lstSalaryYN.value + '&p_position=' +lstPosition.value + '&p_pay_type=' + lstPay_Type.value + '&p_contract_kind=' + lstContract_Kind.value + '&p_from_contract=' + dtFrom_BeginContract.value + '&p_to_contract=' + dtTo_BeginContract.value;
                url=url + '&p_sex=' + lstSex.value  +'&p_insurance_yn=' + lstInsuranceYN.value  + '&p_status=' + lstStatus.value  +'&p_from_leftdate=' + dtFrom_LeftDate.value + '&p_to_leftdate=' + dtTo_LeftDate.value +  '&p_from_birthdate=' + dtFrom_BirthDate.value  ;
                url=url + '&p_ot_yn=' + lstOTYN.value  + '&p_to_birthdate=' + dtFrom_BirthDate.value  +'&p_tco_dept_pk=' + lstDept_Code.value + '&p_user=' + user + '&p_sal_security=' + txt_sal_security.text;
                break;
            }
            
        }
        window.open(url); 
   }
   
}
//---------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

//------------------------------------------------
function OnChangeDept()
{
   // datGroupData.Call();
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
    var url=System.RootURL;
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
        
    }
    datFind_Report.Call();
    
    
    
    
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
<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_allowance_salary" > 
                <input bind="grdAllowance" >
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
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
            <dso  type="grid"  parameter="0,3,5,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,30,33,36,38,39,40,51,52,53,58,59,60,61,62" function="hr.sp_sel_emp_management" procedure="hr.sp_upd_emp_management"> 
                <input bind="grdEmployee" >
                    <input bind="lstDept_Code" />
                    <input bind="lstGrp_Code" />
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
                    <input bind="dtFrom_LeftDate" />
                    <input bind="dtTo_LeftDate" />
                    <input bind="dtFrom_BirthDate" />
                    <input bind="dtTo_BirthDate" />
                    <input bind="lstOTYN" />
                    <input bind="lstUnion" />
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
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="9%" style="border:0;" align="right" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" >
                            Department </a>                  
                        </td>
                        <td width="13%" style="border:0;" align="left" >
                         <gw:list  id="lstDept_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeDept()" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.dept_nm from comm.tco_dept a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="7%" style="border:0;" align="right" >Group</td>
                        <td width="11%" style="border:0;" align="left" >
                         <gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM" )%>|ALL|Select All</data></gw:list>
                        </td>
                         <td width="10%" style="border:0;" align="right" >Nation</td>
                        <td width="10%" style="border:0;" align="left" >
                         <gw:list  id="lstNation" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td width="10%" style="border:0;" align="right">Birth Date</td>
				        <td  width="7%" style="border:0;"><gw:datebox id="dtFrom_BirthDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  width="1%" style="border:0;" align="center">~</td>
				        <td width="7%" style="border:0;"><gw:datebox id="dtTo_BirthDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                         
                        
                        <td width="4%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnSumPrinter"    alt="Summmary Report"  onclick="OnReport(1)"/>
                        </td>
                        <td width="9%" style="border:0" align="left">
                         <gw:imgBtn img="excel" id="ibtnDetPrinter"    alt="Detail Report"  onclick="OnReport(2)"/>
                        </td>
                       
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td  style="border:0" align="right" valign="middle">Search by</td>
					    <td  style="border:0">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list>
				        </td>
                        <td colspan=2 align=right style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles="width:95%"/>
				        </td>
                        
                         <td style="border:0;" align="right" >Pay type</td>
                        <td  style="border:0;" align="left" >
                         <gw:list  id="lstPay_Type" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  style="border:0;" align="right">Join Date</td>
				        <td  style="border:0;"><gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  style="border:0;" align="center">~</td>
				        <td  style="border:0;"><gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td   style="border:0;" align="right" >Sex</td>
                        <td colspan=3 style="border:0" align="right">
                         <gw:list  id="lstSex" value="ALL" styles='width:100%' onchange=""> 
							        <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                    </tr>
                    <tr>
                        <td  style="border:0;" align="right" >Position</td>
                        <td  style="border:0;" align="left" >
                         <gw:list  id="lstPosition" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
				        <td  style="border:0;" align="right" >
                            Insurance</td>
                        <td  style="border:0;" align="left" >
                         <gw:list  id="lstInsuranceYN" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>LIST|Y|Yes|N|No|ALL|Select All</data> 
                        </gw:list>
                        </td>
                        <td style="border:0" align="right" valign="middle">Contract Type</td>
				        <td  style="border:0"> 
					        <gw:list  id="lstContract_Kind" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0001' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
                        <td style="border:0;" align="right">Begin Contract</td>
				        <td style="border:0;" ><gw:datebox id="dtFrom_BeginContract" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  style="border:0;" align="center">~</td>
				        <td style="border:0;"><gw:datebox id="dtTo_BeginContract" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td   style="border:0;" align="right" >Union</td>
                        <td colspan=3 style="border:0" align="right">
                         <gw:list  id="lstUnion" value="ALL" styles='width:100%' onchange=""> 
							        <data>|Y|Yes|N|No|ALL|Select All</data></gw:list>
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        
                        <td  style="border:0;" align="right" >Salary</td>
                        <td  style="border:0;" align="left" >
                         <gw:list  id="lstSalaryYN" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>LIST|Y|Yes|N|No|ALL|Select All</data> </gw:list>
                        </td>
                        <td   style="border:0;" align="right" >OT</td>
                        <td  style="border:0" align="right">
                         <gw:list  id="lstOTYN" value="ALL" styles='width:100%' onchange=""> 
							        <data>LIST|Y|Yes|N|No|ALL|Select All</data> 
					        </gw:list>
                        </td>
                        <td  style="border:0;" align="right" >Status</td>
                        <td  style="border:0;" align="left" >
                         <gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                       
                        <td  style="border:0" align="right" valign="middle">Left Date</td>
                        <td style="border:0;"><gw:datebox id="dtFrom_LeftDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  width="3%" style="border:0;" align="center">~</td>
				        <td style="border:0;"><gw:datebox id="dtTo_LeftDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        
                        
                        <td colspan=4 style="border:0;" align="center" ><gw:label id="lblRecord"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" />
                        </td>
                    </tr>
                   
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=14 style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdEmployee"  
                                header="_PK|Department|Group|Emp ID|Full Name|ID Num|Join Date|Birth Date|Place Birth|Telephone|Permanent Address|Present Address|Sex|Person ID|Issue Date|Place Per ID|Married|Nation|Ethenic|Religion|Education|Job|Position|Probation Type|Begin Probation|End  Probation|Contract Kind|Contract NO|Begin Contract|End Contract|Social Flag|Social Place|Social Date|Health Flag|Health Place|Health Date|Unemp Flag|Unemp Date|Employee Type|OT YN|Salary YN|Probation Salary|Basic Salary|Allow Amt1|Allow Amt2|Allow Amt3|Allow Amt4|Allow Amt5|Allow Amt6|Allow Amt7|Allow Amt8|Pay Type|Bank Type|Account|Status|Left Date|Resign Type|Cost Kind|Pass Port No|Pass Port Date|Remark|Union|Pit No"   
                                format="0|0|0|0|0|0|4|0|0|0|0|0|0|0|4|0|3|0|0|0|0|0|0|0|0|0|0|0|0|0|3|0|0|3|0|0|3|0|0|3|3|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|0|4|0|2|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"    
                                defaults="||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"    
                               editcol="0|0|0|1|0|1|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0|1|0|0|1|0|0|1|0|1|1|0|0|0|0|0|0|0|0|0|0|0|1|1|1|0|0|0|0|1|1|1|1|1"  
                                widths="1500|1500|1500|1500|2500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|500|500|1500|1500"  
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
<gw:grid   
    id="grdAllowance"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 7"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1|2|1|0|0|0|0|0|0"  
    defaults="||||||||||||||"  
    editcol="0|0|0|0|0|1|1|1|1|1|0|0|0|0|0|0"  
    widths="0|1500|1600|1000|2500|1500|1700|1500|1700|1500|1500|1200|1200|1200|1200|1200"  
    styles="display:none" 
    sorting="T"    
/> 
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
  <gw:textbox id="txt_sal_security" styles="display:none"/>

</html>
