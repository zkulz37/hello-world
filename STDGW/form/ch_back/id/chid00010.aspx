<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Dormitory Application Entry </title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";
var flag_page_load=0;
var flag_add_new=0;
var v_dor_pk;
var l_SysDate = new Date();
var flag_btn = false;

function BodyInit()
{  
    dd   = l_SysDate.getDate();
    mm   = l_SysDate.getMonth() + 1;
    yyyy = l_SysDate.getFullYear();    
    l_SysDate = yyyy + "" + mm + "" + dd ;
    
    lblReturn.style.display = "none"; 
    txtReturn.style.display = "none"; 
    txtReturn.SetEnable(0);
    
    dtToRequireDT.SetDataText(System.AddDate(dtToRequireDT.GetData(),5));
    v_dor_pk ="<%=Request("thr_dor_pk") %>";
    grd_Dormitory.StatusInsert();
    
   if (v_language!="ENG")
        System.Translate(document);          
  SetStatusControl();
   txtUser_PK.text = "<%=session("EMPLOYEE_PK")%>";
   onChangeDormitoryKind()
   var l_today = dtToRequireDT.value;
   var l_month = l_today.substring(0, 6);
   dtFromRequireDT.value = l_month + '01';
   var data1 = "<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0126' and code <> '0' order by code_nm")%>";    
   lstDifficult.SetDataText(data1);  
   OnToggle();
    if (v_dor_pk!="")
    {
        ibtnUpdate.SetEnable(1);
        ibtnSubmit.SetEnable(1);
        flag_page_load=1;
        txt_dor_PK.text=v_dor_pk;
        grd_Dormitory.Call("SELECT"); 
        
    }
    else
    {
        txtEmp_PK.text="<%=session("EMPLOYEE_PK")%>";            
        datDor_Emp_Infor.Call();            
    }
}
function OnToggle()
 {
    var left  = document.all("left");    
    var right = document.all("right");   
    var imgArrow = document.all("imgArrow");   
    
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="75%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
 function OnSetControl()
 {
    if (lstDormitoryStatus.GetData() == '70' || lstDormitoryStatus.GetData() == '80' || lstDormitoryStatus.GetData() == '100')
    {    
        lblReturn.style.display = ""; 
        txtReturn.style.display = ""; 
        lblReturn.text = lstDormitoryStatus.GetText();
    }
    else
    {
        lblReturn.style.display = "none"; 
        txtReturn.style.display = "none"; 
    }
 }
 
 function OnSearch(pos)
 {  
    switch (pos) 
    { 
        case 1:        
            txtUserID.text="<%=Session("USER_ID")%>";     
            dat_Dormitory_Search.Call("SELECT");           
            break;
            
        case 2:
            txt_dor_PK.text = grdSearch.GetGridData(grdSearch.row,0); 
            grd_Dormitory.Call("SELECT"); 
                //dtBirthday.SetEnable(0);                 
            break;
     }            
 }
 
 function OnShowPopup(iObj)
 { 
    switch (iObj)
    {
        case "Emp":        
            var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
            var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
            
            if (obj!=null)
            {
                lstDormitoryStatus.value = '10';
                OnNew();
                txtEmp_PK.text         = obj[0];            
                txtEmpID.text          = obj[1];
                txtName.text           = obj[2];            
                txtDept.text           = obj[4]; 
                dtBirthday.text        = obj[25];
                dtJoinDt.text          = obj[3];
                txtPerID.text          = obj[20];
                txtPos.text            = obj[10];
                txtEducation.text      = obj[18];
                txtMobile.text         = obj[7];
                lstMaritalStatus.value = obj[19];
                txtAddress.text        = obj[21];
                //ibtnUpdate.SetEnable(1);
            }   
            break;
                  
         case "AppNo":           
            var fpath = System.RootURL + "/form/ch/id/chid00010_AppNo_code.aspx?idcode=Dormitory";
            var obj  = System.OpenModal(  fpath , 900 , 450 , 'resizable:yes;status:yes');
            break; 
     }
}
function SetStatusControl()
{
    //txtAppNo.SetDataText("**New Application No**");
    txtAppNo.SetEnable(0);
    txtEmpID.SetEnable(0);
    txtName.SetEnable(0);
    txtPerID.SetEnable(0);
    dtJoinDt.SetEnable(0);
    txtDept.SetEnable(0);
    txtEducation.SetEnable(0);
    lstMaritalStatus.SetEnable(0);
    txtAddress.SetEnable(0);
    txtPos.SetEnable(0);
    txtMobile.SetEnable(0);
    dtSubmitDt.SetEnable(0);
    
    //--------------------------------
    lstDormitoryStatus.SetEnable(0);
    lstDormitoryType.value = "";    
    txtUnitCost.text = "";
    dtAppointedDt.text = "";
    dtRequireDt.text = "";
    txtUnitCost.SetEnable(0);
    
    
    if (lstDormitoryStatus.value == '10')
    {
        ibtnUpdate.SetEnable(1);
        ibtnSubmit.SetEnable(1);
        ibtnAddNew.SetEnable(1);
    }
    else if(lstDormitoryStatus.value == '20')
    {
        ibtnUpdate.SetEnable(0);
        ibtnSubmit.SetEnable(0);
        ibtnAddNew.SetEnable(1);
    }
    else if(lstDormitoryStatus.value == '70')
    {
        ibtnUpdate.SetEnable(1);
        ibtnSubmit.SetEnable(0);
        ibtnAddNew.SetEnable(1);
    }
    else if(lstDormitoryStatus.value == '80')
    {
        ibtnUpdate.SetEnable(1);
        ibtnSubmit.SetEnable(0);
        ibtnAddNew.SetEnable(1);
    }
    else if(lstDormitoryStatus.value == '100')
    {
        ibtnUpdate.SetEnable(1);
        ibtnSubmit.SetEnable(0);
        ibtnAddNew.SetEnable(1);
    }
    else
    {
        ibtnUpdate.SetEnable(0);
        ibtnSubmit.SetEnable(0);
        ibtnAddNew.SetEnable(1);
    }
}
function OnNew()
{       
    SetStatusControl()  
    dtSubmitDt.text="";
    txtEmpID.text="";
    txtName.text="";
    txtPerID.text="";
    dtJoinDt.text="";
    txtDept.text="";
    txtEducation.text="";
    txtPos.text="";    
    lstServiceType.text=" ";
    lstMaritalStatus.value=" ";
    txtAddress.text="";
    txtEmail.text="";
    txtVehicleNumber.text="";
    lstDormitory.text="";
    dtRequireDt.text="";
    dtAppointedDt.text="";
    lstDormitoryStatus.value=" ";    
    txtMobile.text="";  
    txtReason.text=""
    lstDormitoryType.value=" ";
    txtUnitCost.text="";
    ibtnUpdate.SetEnable(1);
    ibtnSubmit.SetEnable(1);
    ibtnAddNew.SetEnable(0);
    flag_add_new=1;
    dtBirthday.SetEnable(1);
    grd_Dormitory.StatusInsert();
}
function onCheckInvalid()
{
    if (txtEmpID.text=="")
    {
        alert("Please input employee info request");
        return false;
    }
    if (dtRequireDt.GetData()=="")
    {
        alert("Please input require date ");
        return false;
    }
    if (lstDormitoryType.GetData()=="")
    {
        alert("Please input dormitory status");
        return false;
    }
    if (txtFrequency.GetData()=="")
    {
        alert("Please input Frequency.");
        return false;
    }
    
    if (isNaN(txtFrequency.GetData()))
    {
        alert('Please input type number.');
        txtFrequency.text = 0;
        return false;
    }
    else
    {
        if (txtFrequency.GetData() > 7)
            txtFrequency.text = '7';
    }
    
    return true;
}
function OnUpdate(type)
{    
    if (onCheckInvalid())
    {
        switch (type)
        {
            case 1:                
                ibtnUpdate.SetEnable(0);
                ibtnSubmit.SetEnable(1);
                ibtnAddNew.SetEnable(0);                
                lstDormitoryStatus.value='10';
                break;
            case 2:
                if(confirm('Do you want to submit this request?'))
                {
                    ibtnUpdate.SetEnable(0);
                    ibtnSubmit.SetEnable(1);
                    ibtnAddNew.SetEnable(0);
                    lstDormitoryStatus.value='20';                    
                }
                break;
        }
        flag_btn = true;
        txtUser_PK.text = "<%=session("USER_PK")%>";   
        grd_Dormitory.Call();      
     }  
}
function OnDataReceive(iObj)
{
    switch(iObj.id)
    {      
        case 'grd_Dormitory':        
            OnSetControl();
            if (flag_btn == true)
            {
                SetStatusControl(); 
                dtBirthday.SetEnable(0);
                lstStatus.value = '10';
                dat_Dormitory_Search.Call('SELECT');     
            }
            break ; 
        case 'dat_Dormitory_Search':     
            flag_btn = false;       
            if (grdSearch.rows - 1 > 0);
                OnNew();
            //SetStatusControl(); 
            
            break ;  
        
        case 'datDor_Emp_Infor': 
            ibtnUpdate.SetEnable(1);
            ibtnSubmit.SetEnable(0);
            ibtnAddNew.SetEnable(0);
            break;           
    }
}
function onChangeDormitoryKind()
{
    var v_unit_cost;    
    lstUnitCost.value=lstDormitoryType.value;
    v_unit_cost=lstUnitCost.GetText();
    txtUnitCost.SetDataText(v_unit_cost);
}
function OnChangeDate()
{
    var l_CurDate;
    l_CurDate = dtRequireDt.value ;
    
    if(l_CurDate < l_SysDate)
    {
        alert("Please input require date larger system date");
        dtRequireDt.value="";
    }
    
}
</script>
<body>    
    <gw:data id="datDor_Emp_Infor" onreceive="OnDataReceive(this)"  > 
            <xml> 
                <dso  type="process" procedure="hr.sp_pro_get_chid0010" > 
                    <input>
                        <input bind="txtEmp_PK" />
                    </input> 
                    <output>
                        <output bind="txtEmpID"/>
                        <output bind="txtName"/>
                        <output bind="txtPerID" />          
                        <output bind="dtJoinDt" />
                        <output bind="txtDept" /> 
                        <output bind="txtGroup" /> 
                        <output bind="txtEducation" /> 
                        <output bind="txtPos"/> 
                        <output bind="txtMobile" /> 
                        <output bind="lstMaritalStatus" />                        
                        <output bind="txtAddress" /> 
                        <output bind="txtEmail" />                         
                    </output>
                </dso> 
            </xml> 
    </gw:data>
    <gw:data id="dat_Dormitory_Search" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="hr"   parameter="0,1,2,3,4" function="HR.sp_sel_chid00010_search" > 
                <input> 
                    <input bind="dtFromRequireDT" /> 
                    <input bind="dtToRequireDT" /> 
                    <input bind="txtApp" />  
                    <input bind="txtEmpID_S" />
                    <input bind="lstStatus" />    
                    <input bind="txtUserID" />                                   
                </input> 
                <output bind="grdSearch" /> 
            </dso> 
        </xml> 
    </gw:data>   
    <gw:data id="grd_Dormitory" onreceive="OnDataReceive(this)"> 
            <xml> 
                <dso type="control" parameter="0,1,2,3,4,13,15,18,19,20,21,22,23,25,26,27,28,29,30" function="HR.sp_sel_chid00010" procedure="HR.sp_upd_chid00010"> 
                    <inout>
                        <inout bind="txt_dor_PK" /> 
                        <inout bind="txtUser_PK"/> 
                        <inout bind="txtEmp_PK"/>  
                        <inout bind="txtAppNo" /> 
                        <inout bind="dtSubmitDt"/>
                        <inout bind="txtEmpID"/>
                        <inout bind="txtName"/>
                        <inout bind="txtPerID" />          
                        <inout bind="dtJoinDt" />
                        <inout bind="txtDept" /> 
                        <inout bind="txtGroup" /> 
                        <inout bind="txtEducation" /> 
                        <inout bind="txtPos"/> 
                        <inout bind="lstServiceType" /> 
                        <inout bind="txtMobile" /> 
                        <inout bind="lstMaritalStatus" />                        
                        <inout bind="txtAddress" /> 
                        <inout bind="txtEmail" /> 
                        <inout bind="txtVehicleNumber" /> 
                        <inout bind="lstDormitory" /> 
                        <inout bind="dtRequireDt" /> 
                        <inout bind="dtAppointedDt" /> 
                        <inout bind="lstDormitoryStatus" /> 
                        <inout bind="txtReason"/>
                        <inout bind="txtReturn"/>
                        <inout bind="lstDormitoryType"/>
                        <inout bind="txtUnitCost"/>
                        <inout bind="lstDifficult"/> 
                        <inout bind="txtFrequency"/>
                        <inout bind="txtPerResident"/> 
                        <inout bind="dtBirthday"/>                                                                                           
                    </inout>
                </dso> 
            </xml> 
    </gw:data>
    <form id="form1" name="Dormitory">
    <div>
    <table cellpadding="0" cellspacing="0" border="1" style="width:100%;height:100%">
        <tr>
            <td id='left' style="height: 100%; width:25%" valign="top">
                <table cellpadding=0 cellspacing=0 style="width:100%; height:100%" border="0" >
                    <tr style="height: 5%">
                        <td align="right">
                            <b> &nbsp; Require Date</b>
                        </td>
                        <td>
                            <gw:datebox id="dtFromRequireDT" lang="1" styles="width:100%" lang="<%=Session("Lang")%>" />
                            ~<gw:datebox id="dtToRequireDT" lang="1" styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td style="width: 1%" align='right'>
                            <gw:imgbtn id="btnAppSearch" img="search" onclick='OnSearch(1)' />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td align="right" style="width: 20%">Application No&nbsp;</td>
                        <td colspan="2">
                            <gw:textbox id="txtApp" csstype="mandatory" styles="width:100%" onenterkey="OnSearch(1)" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td align="right" style="width: 20%">&nbsp; 
                            <b>Emp ID</b></td>
                        <td colspan="2">
                            <gw:textbox id="txtEmpID_S" csstype="mandatory" styles="width:100%" onenterkey="OnSearch(1)" />
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td align="right" style="width: 30%">&nbsp;
                            Status
                        </td>
                        <td colspan="2">                        
                            <gw:list  id="lstStatus" value="ALL"  maxlen = "100" styles='width:100%' onchange="OnSearch(1)" >
                                <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0072' order by code_nm")%>|ALL|Select All</data>
                            </gw:list>
                        </td>
                    </tr>
                    <tr style="height: 80%">
                        <td colspan="3">
                            <gw:grid id="grdSearch" header="_PK|App No|Emp ID|Name|Require DT" format="0|0|0|0|4" aligns="0|0|0|0|0"
                                defaults="||||" editcol="0|0|0|0|0" widths="0|1200|1000|1500|1500" styles="width:100%; height:100%"
                                sorting="T" acceptnulldate="true" param="0,1,2,3,4" oncellclick="OnSearch(2)" />
                        </td>
                    </tr>
                </table>        
            </td>
            <td id="right" style="height: 100%; width:75%" valign="top">
                <table cellpadding=0 cellspacing=0 style="width:100%; height:100%" border="0" >
                    <tr style="height: 5%">
                        <td colspan=4 width=50%>&nbsp;</td>
                        <td colspan=4 width=50% valign=top>
                            <table width=100% cellpadding=0 cellspacing=0>
                                <tr>
                                    <td width=91%>&nbsp;</td>
                                    <td nowrap width=3%  style="border:0">
                                        <gw:icon id="ibtnAddNew" alt="Add New"  text="Add New"  img="in"  styles="width:100%" onclick="OnNew()"/>
                                        <!--<gw:imgBtn id="ibtnNew" alt="New" img="New" text="New" onclick="OnNew()" />-->
                                    </td>  
                                    <td nowrap width=3%  style="border:0">
                                        <gw:icon id="ibtnUpdate" alt="Save"  text="Save"  img="in"  styles="width:100%" onclick="OnUpdate(1)"/>
                                        <!--<gw:imgBtn id="ibtnUpdate" alt="Save" img="save" text="Save" onclick="OnUpdate()" />-->                                
                                    </td> 
                                    <td nowrap width=3%  style="border:0">
                                        <gw:icon id="ibtnSubmit" alt="Submit"  img="in"  styles="width:100%" text="Submit"  onclick="OnUpdate(2)" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td colspan=8 style="width:100%">            
                            <fieldset style="padding: 5"><legend>Employee information</legend>
                            <table style="width:100%" cellpadding=0 cellspacing=0 >
                                <tr valign=top >
                                    <td nowrap width="10%" align=left><a title="Click here to select application no" onclick="OnShowPopup('AppNo')" href="#tips" >Application No</a>&nbsp;</td>
                                    <td nowrap width=15% align=right>
                                    <gw:textbox id="txtAppNo"  text="" 	maxlen = "20" styles='width:100%;' csstype="mandatory"/>
                                    </td>
                                    <td nowrap width="10%" align=left> Submit Date</td>
                                    <td width="15%" align=left>
                                        <gw:datebox id="dtSubmitDt"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/>
                                    </td>
                                    <td  with="5%" >Difficulty</td>    
                                    <td  with="20%" > <gw:list  id="lstDifficult"  styles='width:100%' /></td>
                                    <td  with="5%" >Frequency</td>
                                    <td  with="20%" ><gw:textbox id="txtFrequency"  styles='width:100%;'csstype="mandatory" /></td>                        
                                </tr>   
                                <tr>
                                    <td nowrap width="10%" align=left><a title="Click here to show applicant" onclick="OnShowPopup('Emp')" href="#tips" >EMP ID</a> </td>
                                    <td nowrap width=15% align=left>
                                        <gw:textbox id="txtEmpID"  text="" 	maxlen = "20" styles='width:100%;' csstype="mandatory"/>
                                    </td>
                                    <td nowrap width="5%" align=left>Name</td>
                                    <td nowrap width=20% align=left>
                                        <gw:textbox id="txtName"  text="" maxlen = "60" styles='width:100%'/>
                                    </td>
                                    <td nowrap width="10%" align=left>Personal ID</td>
                                    <td nowrap width=15% align=left><gw:textbox id="txtPerID"  text="" maxlen = "10" styles='width:100%'/></td>
                                    <td nowrap width="10%" align=left>Join Date</td>
                                    <td nowrap width=15% align=left>
                                        <gw:datebox id="dtJoinDt"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/>
                                    </td>
                                </tr>  
                                <tr>
                                    <td nowrap width="10%" align=left>Department</td>
                                    <td nowrap width=15% align=left>
                                        <gw:textbox id="txtDept"  text="" 	maxlen = "20" styles='width:100%;'/>
                                    </td>
                                    <td nowrap width="5%" align=left></td>
                                    <td nowrap width=20% align=left>
                                         <gw:textbox id="txtGroup"  text="" maxlen = "60" styles="display:none"/>
                                    </td>
                                    <td nowrap width="10%" align=left>Education</td>
                                    <td nowrap width=15% align=left><gw:textbox id="txtEducation"  text="" maxlen = "10" styles='width:100%'/></td>
                                    <td nowrap width="10%" align=left>Birthday</td>
                                    <td nowrap width=15% align=left>
                                        <gw:datebox id="dtBirthday"  maxlen = "10" text="" lang="<%=Session("Lang")%>" nullaccept/>
                                    </td>
                                </tr>  
                                <tr>
                                    <td nowrap width="10%" align=left>Position</td>
                                    <td nowrap width=15% align=left>
                                        <gw:textbox id="txtPos"  text="" 	maxlen = "20" styles='width:100%;'/>
                                    </td>
                                    <td nowrap width="5%" align=left>Service Type</td>
                                    <td nowrap width=20% align=left>
                                        <gw:list  id="lstServiceType" value=" "  maxlen = "100" styles='width:100%' >
                                                <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0083' order by code_nm")%>||</data>
                                        </gw:list>
                                    </td>
                                    <td nowrap width="10%" align=left>Mobile</td>
                                    <td nowrap width=15% align=left>
                                    <gw:textbox id="txtMobile"  text="" maxlen = "10" styles='width:100%'/>
                                    </td>
                                    <td nowrap width="10%" align=left>Marital Status</td>
                                    <td nowrap width=15% align=left>
                                        <gw:list  id="lstMaritalStatus" value=" "  maxlen = "100" styles='width:100%' >
                                                <data> LIST|N|Single|Y|Married|||</data> 
                                        </gw:list>
                                    </td>
                                </tr>  
                                <tr>
                                    <td nowrap width="10%" align=left>Current Address</td>
                                    <td nowrap width=40% colspan=3 align=left>
                                        <gw:textbox id="txtAddress"  text="" maxlen = "100" styles='width:100%'/>
                                    </td>                
                                    <td nowrap width="10%" align=left>Email</td>
                                    <td nowrap width=15% align=left>
                                        <gw:textbox id="txtEmail"  text="" maxlen = "100" styles='width:100%'/>
                                    </td>
                                    <td nowrap width="10%" align=left>Vehicle Number</td>
                                    <td nowrap width=15% align=left>
                                    <gw:textbox id="txtVehicleNumber"  text="" maxlen = "10" styles='width:100%'/>   
                                    </td>            
                                </tr> 
                                <tr>
                                    <td>Permanent Resident</td>
                                    <td colspan="7"><gw:textbox id="txtPerResident"  text="" maxlen = "200" styles='width:100%'/></td>
                                </tr>
                            </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 5%">
                        <td colspan=8 style="width:100%"><fieldset style="padding: 5"><legend>Request information</legend>
                            <table border=0 cellpadding=0 cellspacing=0>
                            <tr>
                                <td nowrap width="10%" align=left>Dormitory</td>
                                <td nowrap width=15% align=left>
                                    <gw:list  id="lstDormitory" value=" "  maxlen = "100" styles='width:100%' >
                                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0073' order by code_nm")%>||</data>
                                    </gw:list>
                                </td>
                                <td nowrap width="5%" align=left>Require date</td>
                                <td nowrap width=20% align=left>
                                    <gw:datebox id="dtRequireDt" onchange="OnChangeDate()" csstype="mandatory" maxlen = "10" text="" lang="<%=Session("Lang")%>" nullaccept/>
                                </td>
                                <td nowrap width="10%" align=left>Appointed Date</td>
                                <td nowrap width=15% align=left>
                                    <gw:datebox id="dtAppointedDt"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept/>
                                </td>
                                <td nowrap width="10%" align=left>Status</td>
                                <td nowrap width=15% align=left>
                                    <gw:list csstype="mandatory"  id="lstDormitoryStatus" maxlen = "100" >
                                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0072'  order by code_nm")%>||</data>
                                    </gw:list>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap width="10%" align=left>Dormitory Type</td>
                                <td nowrap width=15% align=left>
                                    <gw:list  id="lstDormitoryType"  value=" " maxlen = "100" styles='width:100%' onchange="onChangeDormitoryKind()" >
                                            <data><%=ESysLib.SetListDataSQL("select pk, type_name from thr_unit_cost where CATEGORY_CODE='40' order by type_name")%>||</data>
                                    </gw:list>
                                </td>
                                <td nowrap width="5%" align=left>Unit Cost</td>
                                <td nowrap width=20% align=left>
                                    <gw:textbox id="txtUnitCost" type="number" format="###,###C" maxlen = "10" text="" styles='width:100%'/>
                                </td>
                                <td nowrap colspan=4 align=left></td>                
                            </tr> 
                            </table>
                            </fieldset>
                        </td>
                    </tr>            
                    <tr style="height: 5%">
                        <td colspan="8" nowrap>Reason</td>
                    </tr>  
                    <tr style="height: 5%">
                        <td colspan="8" nowrap>
                            <gw:textarea id="txtReason" rows=10 text=""  styles='width:100%; height:90'/>
                        </td>
                    </tr>  
                    <tr style="height: 5%">
                        <td colspan="8" nowrap><gw:label id="lblReturn" style="font-family:Tahoma;color:Red;size:12" text="" /></td>
                    </tr>  
                    <tr style="height: 5%">
                        <td colspan="8" nowrap>
                            <gw:textarea id="txtReturn" rows=10 text=""  styles='width:100%;height:90'/>
                        </td>
                    </tr>  
                    
                    <tr style="height: 65%">
                        <td colspan=8 style="width:100%">&nbsp;</td>
                    </tr>             
                </table>
            </td>
        </tr>   
    </table>
    
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />
    </div>
    <gw:textbox id="txtUserID" styles="display:none"/>
    <gw:textbox id="txtEmp_PK" styles="display:none"/>
    <gw:textbox id="txtUser_PK" styles="display:none"/>    
    <gw:textbox id="txt_dor_PK" styles="display:none"/>    
    <gw:list  id="lstUnitCost"  value="" maxlen = "100" styles='width:100%;display:none' >
            <data><%=ESysLib.SetListDataSQL("select pk, AMOUNT from thr_unit_cost where CATEGORY_CODE='40' order by type_name")%>||</data>
    </gw:list>
    </form>    
</body>
</html>
