<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";

var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
var  user_name = "<%=Session("USER_NAME")%>"  ;
var  user_id = "<%=Session("USER_ID")%>"  ; 
var  dept_pk = "<%=Session("DEPT_PK")%>"  ; 

function BodyInit()
{
    td_bottom.style.display="none";    
    td_Master.style.height="59%";    
    BindingDataList();  
    setButtonStatus();
    SetColumnFormat();
}
function SetColumnFormat(){   
    var ctrl1 = idGrid.GetGridControl();
    ctrl1.ColFormat(7) = "###,###R"; 
    var ctrl2=idGrid_Detail.GetGridControl();   
    ctrl2.ColFormat(5) = "###,###R"; 
}
function BindingDataList()
{    
     var l_today = dtSubmitDt_To.value;
     var l_pre_month ;
     l_pre_month=AddDate(l_today,-30)
     dtSubmitDt_From.value = l_pre_month;    
     txtReason.SetEnable(0);  
         
     txtUser_PK.text = user_pk ;
     txtManager_KIND.text = ''; 
     dso_approver_info.Call();  
}
function AddDate(strDate,intDay)
{
	if (v_language!="ENG")
        System.Translate(document);  
	var strYear;
	var strMonth;
	var strDay;
	var strFullDate;
	strYear=strDate.substr(0,4);
	strMonth=strDate.substr(4,2);
	strDay=strDate.substr(6,2);
	var oDate = new Date(strYear,strMonth-1, strDay);//20060203
	
	oDate.setDate(oDate.getDate()+intDay);	
	strYear=oDate.getYear();
	strMonth=oDate.getMonth()+1;
	strDay =oDate.getDate();
	
	strFullDate=strYear.toString()+String(strMonth<10?'0'+strMonth:strMonth) +String(strDay<10?'0'+strDay:strDay);
	return strFullDate;
	
}
function setButtonStatus()
{        
    var v_status =lstStatus.value;
    
    if (v_status=='30')
    {
        ibtnSearch.SetEnable(1);
        ibtnApprove.SetEnable(1);
        ibtnReject.SetEnable(1);
        ibtnRequest.SetEnable(1);
    }
    else    
    {
        //ibtnSearch.SetEnable(0);
        ibtnApprove.SetEnable(0);
        ibtnReject.SetEnable(0);
        ibtnRequest.SetEnable(0);
    }    
}
function onClickToGrid()
{
    txt_req_pk.text=idGrid.GetGridData(idGrid.row,13);    
    txtReason.SetDataText(idGrid.GetGridData(idGrid.row,14));
    dat_approve_training_detail.Call("SELECT");
    
    if (event.col==16)   
    {
        td_bottom.style.display="";         
        td_Master.style.height="55%";
        txtResponse.SetDataText(idGrid.GetGridData(idGrid.row,16));                  
        idGrid.SetGridText(idGrid.row,16,txtResponse.GetData()); 
    }
    else 
    {
        td_bottom.style.display="none";         
        td_Master.style.height="60%";
    }
}

function onChangeText()
{   
   idGrid.SetGridText(idGrid.row,16,txtResponse.GetData());      
}
function OnChangeDept()
{
    datGroupData.Call();
}
function OnSearch()
{
    dat_approve_training.Call("SELECT");   
}

/*function OnBeforUpdate(type)
{
    var cnt=0;
    var ctrl=idGrid.GetGridControl();
    
    if (idGrid.rows==1) 
    {
        alert("Not found data to update");
        return false;
    }    
    for (i=1;i<idGrid.rows;i++)
    {
        if (idGrid.GetGridData(i,0)=="-1")
        {
            cnt=cnt+1
        }          
    }    
    if (cnt==0){
        alert("Please select at least one row"); 
        return false;
    }
    
    for (i=1;i<idGrid.rows;i++)
    {       
        if (idGrid.GetGridData(i,0)=="-1")
        {
            switch (type)
            {               
                case 2:
                    if (idGrid.GetGridData(i,16)=="")
                        {
                            alert("Please input reject information");
                            td_bottom.style.display="";            
                            td_Master.style.height="59%";
                            return false;
                        }
                case 3: 
                    if (idGrid.GetGridData(i,16)=="")
                        {
                            alert("Please input request information");
                            td_bottom.style.display="";            
                            td_Master.style.height="59%";
                            return false;
                        }
            }
            idGrid.SetRowStatus(i,16);            
        }
        else
            {
                idGrid.SetRowStatus(i,0);
            }
    }
    return true;   
}*/

function OnUpdate(type)
{
    var cnt=0;
    var n=0;
    var ctrl=idGrid.GetGridControl();
    
    if (idGrid.rows==1) 
    {
        alert("Not found data to update");
        return;
    }    
    for (i=1;i<idGrid.rows;i++)
    {
        if (idGrid.GetGridData(i,0)=="-1")
        {
            cnt=cnt+1
        }          
    } 
   
    if (cnt==0){
        alert("Please select at least one row"); 
        return;
    }
    
    for (i=1;i<idGrid.rows;i++)
    {      
        if (idGrid.GetGridData(i,0)=="-1")
        {
            switch (type)
            {
                case 1: //Approve                                                  
                    idGrid.SetGridText(i,17,"40");                    
                    lstStatus.value="40"; 
                    break;               
                case 2:
                    if (idGrid.GetGridData(i,16)=="")
                        {
                            alert("Please input reject information");
                            td_bottom.style.display="";            
                            td_Master.style.height="59%";
                            return;
                        }                 
                    idGrid.SetGridText(i,17,'60');
                    lstStatus.value='60';
                    break;                    
                case 3: 
                    if (idGrid.GetGridData(i,16)=="")
                        {
                            alert("Please input request information");
                            td_bottom.style.display="";            
                            td_Master.style.height="59%";
                            return;
                        }
                    idGrid.SetGridText(i,17,'80');               
                    lstStatus.value='80'; 
                    break;
            }
            idGrid.SetRowStatus(i,16);  
            n+=1;          
        }
        else
            {
                idGrid.SetRowStatus(i,0);
            }
    }
    if (n>0) 
        dat_approve_training.Call();
}

/*function OnUpdate(kind)
{
    if (OnBeforUpdate(kind))
    {
        switch (kind)
        {
            case 1: //Approve
                idGrid.SetGridText(idGrid.row,17,'40');
                lstStatus.value='40';
                break;
            case 2: //Reject 
                idGrid.SetGridText(idGrid.row,17,'60'); 
                lstStatus.value='60';
                break;
            case 3: //Request   
                idGrid.SetGridText(idGrid.row,17,'80');             
                lstStatus.value='80'; 
                break;
        }
        dat_approve_training.Call();  
    }      
}*/
function OnDataReceive(obj)
{ 
    switch  (obj.id)
    {
        case 'dat_approve_training':
            setButtonStatus();  
            lblRecord.text= "Total rows: " + (idGrid.rows-1);
            break;  
        case 'datGroupData':   
            ChoseList_box(lstGroup,txtGroupData.text);
            break;    
        /*case 'dso_approver_info':                  
            if(Trim(txtManager_PK.text) == Trim(user_pk) ) // user login la manager
            {
                if(txtManager_KIND.text == '02') // GA Manager
                {               
                    txtResponse.SetEnable(true);                     
                    // Status    
                    var ls_data     = "<%=ESysLib.SetListDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0090' and A.code in ('30','40', '60', '80') ")%>";
                    lstStatus.SetDataText(ls_data);                 
                    lstStatus.value = '30'; // Approved GA Manager
                }
                else if(txtManager_KIND.text == '01')
                {
                    dtSubmitDt_From.SetEnable(false);
                    dtSubmitDt_To.SetEnable(false);
                    lstDept.SetEnable(false);
                    lstGroup.SetEnable(false);
                    lstStatus.SetEnable(false);  
                    idGrid.SetEnable(false);
                    idGrid_Detail.SetEnable(false);
                    td_bottom.style.display="none";    
                    ibtnApprove.SetEnable(false);
                    ibtnReject.SetEnable(false);
                    ibtnRequest.SetEnable(false); 
                    alert('Sorry, You have not authority to use this form!!!');                                
                }
            }            
            else // disable form
            {
                dtSubmitDt_From.SetEnable(false);
                dtSubmitDt_To.SetEnable(false);
                lstDept.SetEnable(false);
                lstGroup.SetEnable(false);
                lstStatus.SetEnable(false);  
                idGrid.SetEnable(false);
                idGrid_Detail.SetEnable(false);
                td_bottom.style.display="none";    
                ibtnApprove.SetEnable(false);
                ibtnReject.SetEnable(false);
                ibtnRequest.SetEnable(false); 
                alert('Sorry, You have not authority to use this form!!!');
            }
            break ; */ 
    }
}
function ChoseList_box(obj_list,value)
{
    
    obj_list.SetDataText(value);
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
<gw:data id="dso_approver_info" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_biz_empid" > 
                <input>
                 <input bind="txtUser_PK" />                                       
                </input> 
                <output>
                    <output bind="txtEmployee_ID" />                    
                    <output bind="txtEmployee_NM" />
                    <output bind="txtManager_ID" />
                    <output bind="txtManager_NM" />
                    <output bind="txtManager_KIND" />
                    <output bind="txtManager_DEPT" />
                    <output bind="txtApplication_LV" />
                    <output bind="txtManager_PK" />
                    <output bind="txtCompany_PK" />
                    <output bind="txtTacABPLCenter_PK" />
                    <output bind="txtPLNM" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                    <input bind="lstDept" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dat_approve_training" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="hr" parameter="13,16,17" function="hr.sp_sel_approve_training_ga" procedure="hr.sp_upd_approve_training_ga"> 
                <input> 
                    <input bind="dtSubmitDt_From" /> 
                    <input bind="dtSubmitDt_To" />                     
                    <input bind="lstDept" />                   
                    <input bind="lstGroup" />                      
                    <input bind="lstStatus" />                                                 
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
</gw:data> 
<gw:data id="dat_approve_training_detail" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="hr" function="hr.sp_sel_approve_training_detail"> 
                <input> 
                    <input bind="txt_req_pk" />                               
                </input> 
                <output bind="idGrid_Detail" /> 
            </dso> 
        </xml> 
</gw:data>  
    <form id="form1" runat="server">
    <div>
    <table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">
    <tr>
        <td style="width:100%;height:5%">  
           <table border=0 width=100% cellpadding=0 cellspacing=0>
           <tr>
            <td align= left width=10%> Submited date</td>
            <td width="10%">
                <gw:datebox id="dtSubmitDt_From"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/>&nbsp;&nbsp;
            </td>
            <td width=2% nowrap align=center>~</td>
            <td width="10%">
               &nbsp;&nbsp; <gw:datebox id="dtSubmitDt_To"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>"/>&nbsp;&nbsp;
            </td>
            <td width=3% align= left>Dept</td>
            <td width="20%">
                <gw:list  id="lstDept"  value="ALL" maxlen = "100" styles='width:100%' >
                    <data>
                         <%=ESysLib.SetListDataSQL("select pk,dept_nm from comm.tco_dept a where a.child_yn='N' and del_if=0 order by dept_id")%>|ALL|Select All
                     </data>
                </gw:list>
            </td>
            <td nowrap align=left width=5%>Team/Section</td>
            <td width="15%">
                <gw:list  id="lstGroup" value="ALL"  maxlen = "100" styles='width:100%' >
                    <data>
                         <%=ESysLib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM")%>|ALL|Select All
                     </data>
                </gw:list>
            </td>
            <td width=5%>&nbsp;</td>
            <td align=right width=5% nowrap><gw:icon id="ibtnSearch" alt="Search"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch()"/></td>            
            <td align=right width=5% nowrap><gw:icon id="ibtnApprove" alt="Approve"  text="Approve" img="in"  styles="width:100%" onclick="OnUpdate(1)" /></td>
            <td align=right width=5% nowrap><gw:icon id="ibtnReject" alt="Reject"  text="Reject"  img="in"  styles="width:100%" onclick="OnUpdate(2)"/></td>
            <td align=right width=5% nowrap><gw:icon id="ibtnRequest" alt="Request more info"  text="Request more info"  onclick="OnUpdate(3)" img="in"  styles="width:100%" /></td>                        
           </tr>
           <tr>
           <td nowrap align=left>Status</td>
           <td colspan=3>
                <gw:list  id="lstStatus" onchange="setButtonStatus(),OnSearch()" value="30"  maxlen = "100" styles='width:100%'>
                    <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0090' and code in ('30','40','60','80') order by code")%></data>
                </gw:list>
           </td>
           <td colspan=9 align=center valign=bottom>
                <gw:label id="lblRecord" style="font-family:Tahoma;color:Red;size:12" text="" />
           </td>
           </tr>
           </table>        
        </td>
    </tr>
    <tr>
        <td height="1%">&nbsp;</td>
    </tr>
    <tr>
        <td id="td_Master" style="width:100%;height:55%">  
            <gw:grid   
                    id="idGrid" 
                    header="Select|Application No|Summited date|Requester ID|Requester Name|Department|Team/Section|Plan cost|Currency|Course Name|Institution|Location|Required Date|_Req_PK|_Reason|M Response|Response|_Status"                                       
                    format="3|0|4|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0"  
                    aligns="0|0|1|0|0|0|0|3|0|0|0|0|1|0|0|0|0|0"     
                    defaults="|||||||||||||||||"                     
                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    widths="700|1500|1500|1500|2000|1500|1500|1500|1000|1500|1500|1500|1500|0|0|3000|3000|0"  
                    styles="width:100%; height:100%"   
                    acceptNullDate="T"
                    oncellclick="onClickToGrid()" 
                    sorting="T"/>                
        </td>
    </tr>    
    <tr>
    <td nowrap style="height:1%;font:12;color:Blue"><strong>Trainee List</strong></td>
    </tr> 
    <tr>
    <td id="td_Detail" style="width:100%;height:34%">
    <table border=0 cellpadding=0 cellspacing=0 style="width:100%;height:100%">
        <tr>
            <td style="width:70%">
                <gw:grid   
                id="idGrid_Detail" 
                header="No|Emp ID|Emp Name|Department|Team/Section|Plan Cost|Description"                                       
                format="0|0|0|0|0|0|0"  
                aligns="0|0|0|0|0|3|0"    
                defaults="||||||"                     
                editcol="0|0|0|0|0|0|0"  
                widths="1000|1000|2000|1500|1500|1500|2000"
                styles="width:100%; height:100%"   
                acceptNullDate="T"
                oncellclick="onClickToGrid()" 
                sorting="T"/>
            </td>
            <td style="width:30%;height:100%">
                <gw:textarea id="txtReason" rows=5 text="" onchange="onChangeText(0)" styles='width:100%;height:100%'/>
            </td>
        </tr>
    </table>
    </td>   
    </tr>   
    <tr>
        <td id='td_bottom' style="width:100%;height:5%">  
        <gw:textarea id="txtResponse" rows=5 text="" onchange="onChangeText()" styles='width:100%;'/>          
        </td>
    </tr>    
    </table>   
    </div>
    <gw:textbox id="txt_req_pk" styles="display:none"/> 
    <gw:textbox id="txtUser_PK" styles="display:none"/>     
    
    <gw:textbox id="txtEmployee_ID" styles="display:none"/>
    <gw:textbox id="txtEmployee_NM" styles="display:none"/>
    <gw:textbox id="txtManager_ID" styles="display:none"/>
    <gw:textbox id="txtManager_NM" styles="display:none"/>
    <gw:textbox id="txtManager_KIND" styles="display:none"/>
    <gw:textbox id="txtManager_DEPT" styles="display:none"/>    
    <gw:textbox id="txtApplication_LV" styles="display:none"/>
    <gw:textbox id="txtManager_PK" styles="display:none"/>
    <gw:textbox id="txtCompany_PK" styles="display:none"/>
    <gw:textbox id="txtTacABPLCenter_PK" styles="display:none"/>
    <gw:textbox id="txtPLNM" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    </form>
</body>
</html>
