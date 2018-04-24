<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";

var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
var  user_name = "<%=Session("USER_NAME")%>"  ;
var  user_id = "<%=Session("USER_ID")%>"  ; 
var  dept_pk = "<%=Session("ORG_PK")%>"  ; 

function BodyInit()
{
    td_bottom.style.display="none";    
    td_Master.style.height="59%";    
    BindingDataList();  
    setButtonStatus();
    SetColumnFormat();
    OnChangeDept();
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
     //dso_approver_info.Call();  
      lstStatus.value = '20'; // submit
}
function OnChangeDept()
{
    datGroupData.Call();
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
    
    if (v_status=='20')
    {
        ibtnSearch.SetEnable(1);
        ibtnApprove.SetEnable(1);
        ibtnReject.SetEnable(1);
        ibtnRequest.SetEnable(1);
    }
    if ((v_status=='30')|| (v_status=='50')||(v_status=='90'))
    {
        //ibtnSearch.SetEnable(0);
        ibtnApprove.SetEnable(0);
        ibtnReject.SetEnable(0);
        ibtnRequest.SetEnable(0);
    }
    if (v_status=='70')
    {
        //ibtnSearch.SetEnable(0);
        ibtnApprove.SetEnable(1);
        ibtnReject.SetEnable(1);
        ibtnRequest.SetEnable(1);
    }   
     
}
function onClickToGrid()
{
    txt_req_pk.text=idGrid.GetGridData(idGrid.row,13);
    txtReason.SetDataText(idGrid.GetGridData(idGrid.row,14));
    dat_approve_training_detail.Call("SELECT");
    
    if (event.col==15)   
    {
        td_bottom.style.display="";         
        td_Master.style.height="55%";
        txtResponse.SetDataText(idGrid.GetGridData(idGrid.row,15));                  
        idGrid.SetGridText(idGrid.row,15,txtResponse.GetData()); 
    }
    else 
    {
        td_bottom.style.display="none";         
        td_Master.style.height="60%";
    }
}

function onChangeText(obj)
{   
   idGrid.SetGridText(idGrid.row,15,txtResponse.GetData());      
}

function OnSearch()
{
    dat_approve_training.Call("SELECT");   
}

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
                    idGrid.SetGridText(i,17,"30");                    
                    lstStatus.value="30"; 
                    break;               
                case 2:
                    if (idGrid.GetGridData(i,15)=="")
                        {
                            alert("Please input reject information");
                            td_bottom.style.display="";            
                            td_Master.style.height="59%";
                            return;
                        }                 
                    idGrid.SetGridText(i,17,'50');
                    lstStatus.value='50';
                    break;                    
                case 3: 
                    if (idGrid.GetGridData(i,15)=="")
                        {
                            alert("Please input request information");
                            td_bottom.style.display="";            
                            td_Master.style.height="59%";
                            return;
                        }
                    idGrid.SetGridText(i,17,'70');               
                    lstStatus.value='70'; 
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
function OnDataReceive(obj)
{ 
    switch  (obj.id)
    {
        case 'dat_approve_training':  
            setButtonStatus();
            lblRecord.text= "Total rows: " + (idGrid.rows-1);           
            break; 
    }
}

</script>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
<gw:data id="dso_approver_info" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="HR_CHKR10200004_get_biz_empid" > 
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
            <dso  type="list" procedure="HR_CHKR10200002_group_by_dept" > 
                <input>
                    <input bind="lstDept" /> 
                </input> 
                <output>
                    <output bind="lstGroup" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dat_approve_training" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="hr" parameter="13,15,17" function="HR_CHKR10200004_sel_approve" procedure="HR_CHKR10200004_upd_approve"> 
                <input> 
                    <input bind="dtSubmitDt_From" /> 
                    <input bind="dtSubmitDt_To" />                     
                    <input bind="lstDept" />                   
                    <input bind="lstGroup" />                      
                    <input bind="lstStatus" /> 
                    <input bind="txtUser_PK" />               
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
</gw:data> 
<gw:data id="dat_approve_training_detail" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="grid" user="hr" function="HR_CHKR10200004_sel_app_detail"> 
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
                <gw:list  id="lstDept" onchange="OnChangeDept()" value="ALL"  styles='width:100%' >
                    <data>
                         <%=ESysLib.SetListDataSQL("select pk,org_id||'-'||org_nm from tco_org a where a.org_type='06' and del_if=0 order by org_nm")%>|ALL|Select All
                     </data>
                </gw:list>
            </td>
            <td nowrap align=left width=5% >Team/Section</td>
            <td width="15%" >
                <gw:list  id="lstGroup" value="ALL"  maxlen = "100" styles='width:100%;' >
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
                <gw:list  id="lstStatus" onchange="setButtonStatus(),OnSearch()" value="20"  maxlen = "100" styles='width:100%'>
                    <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0090' and code in ('20','30','50','70') order by code")%></data>
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
                    header="Select|Application No|Summited date|Requester ID|Requester Name|Department|Team/Section|Plan cost|Currency|Course Name|Institution|Location|Required Date|_Req_PK|_Reason|Response|_GA Response|_Status"                                       
                    format="3|0|4|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0"  
                    aligns="0|0|1|0|0|0|0|3|0|0|0|0|1|0|0|0|0|0"     
                    defaults="|||||||||||||||||"                     
                    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                    widths="700|1500|1500|1500|2000|1500|1500|1500|1000|1500|1500|1500|1500|0|0|0|0|0"  
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
