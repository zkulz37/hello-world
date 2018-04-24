<!-- #include file="../../../system/lib/form.inc"  -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head id="Head1" runat="server">
    <title>Domitory Charge for GA</title>
</head>

<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var lang= "<%=Session("Lang")%>";
//---------------
 var  user_pk   = "<%=Session("EMPLOYEE_PK")%>"  ;
 var  user_name = "<%=Session("USER_NAME")%>"  ;
 var  user_id = "<%=Session("USER_ID")%>"  ;

//--------------------------------------------------------------
 function OnToggle() {
//    var left  = document.all("left");    
//    var right = document.all("right");   
//    var imgArrow = document.all("imgArrow");   
//    
//    if(imgArrow.status == "expand")
//    {
//        left.style.display="none";       
//        imgArrow.status = "collapse";
//        right.style.width="100%";
//        imgArrow.src = "../../../system/images/next_orange.gif";
//    }
//    else
//    {
//        left.style.display="";
//        imgArrow.status = "expand";
//        right.style.width="80%";
//        imgArrow.src = "../../../system/images/prev_orange.gif";
//    }
 }
 		
//------------------------------------------------------------------------	        
function BodyInit()
{  
    if (v_language!="ENG")
        System.Translate(document);  
    BindingData(); 
    SetColumnFormat();
    OnShowPeriod('2')
}
function SetColumnFormat(){    
    var ctrl = idGrid.GetGridControl();
    ctrl.ColFormat(11) = "###,###R";
    ctrl.ColFormat(12) = "###,###R"; 
}
//---------------------------------------------------------------------
function BindingData()
{
    var ls_data ;
//department    
    ls_data     = "<%=ESysLib.SetListDataSQL("select pk, org_nm from comm.tco_org where del_if = 0 ")%>|ALL|Select All";
    lstDept.SetDataText(ls_data);
    lstDept.value = 'ALL';
    lstGroup.value = 'ALL';
//dormitory code
    
    //combobox of grid
    ls_data = "<%=ESysLib.SetGridColumnDataSQL("SELECT A.code, A.code_nm FROM THR_CODE_detail A, THR_CODE_MASTER B WHERE A.DEL_IF=0 AND B.DEL_IF=0 AND B.PK = A.thr_code_master_pk AND B.ID = 'HR0073'" ) %> ";       
   // idGrid.SetComboFormat(6, ls_data);
}
//---------------------------------------------------------------
//function OnChangeStatus()
//{
//    if(event.col == '10')
//    {
//        alert('Staff cannot change status of the request, only view...');
//        return ;
//    }
//}
//---------------------------------------------------------------
function OnDataReceive(iObj)
{
    switch(iObj.id)
    {
        case 'datGroupData':
            lstGroup.SetDataText(txtGroupData.text + '|ALL|Select All');
        break ;   
        case 'thr_dormitory_list':
            idRecord.text=idGrid.rows-1 +" records are found!";
        break ;  
        case 'datGroupData':   
            ChoseList_box(lstGroup,txtGroupData.text);
            break;         
    }
}
//---------------------------------------------------------------
function OnShowGroup()
{
    datGroupData.Call();
}
//---------------------------------------------------------------
function OnSearch()
{   
    thr_dormitory_list.Call('SELECT');
}
//---------------------------------------------------------------
function OnShowPeriod(iCase)
{
    var ls_month = new Array("31", "28", "31", "30", "31", "30", "31", "31", "30", "31", "30", "31");    
    var i ;
    if(iCase == '1')
    {
        dtFrom.value = dtYear.value + '0101';
        dtTo.value = dtYear.value + '1231';
    }
    else if(iCase == '2')
    {                        
        if(dtMonth.value.substring(4, 6) == '02' )
        {                        
            if(CheckLeapYear(dtMonth.value.substring(0, 4)))            
                ls_month[1] = "29";            
        }        
        i = Number(dtMonth.value.substring(4, 6)) - 1;
        dtFrom.value = dtMonth.value + '01';
        dtTo.value = dtMonth.value + ls_month[i];
    }
}
//------------------------------------------------------------------
function CheckLeapYear(iYear)
{
    if( (Number(iYear) % 400 == 0) || (Number(iYear) % 100 != 0 && Number(iYear) % 4 ==0 ) )    
        return 1;
    else
        return 0;
}
//------------------------------------------------------------------
function OnSave()
{
    if(confirm('Are you sure you want to update the dormitory list?'))
    {
        thr_dormitory_list.Call();
    }        
}
//------------------------------------------------------------------


</script>

<body style=" margin-bottom:0; margin-top:0; margin-right:0; margin-left:0">
    <!------------------------------------------------------------------------>
    <gw:data id="datGroupData" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data" > 
                <input>
                    <input bind="lstDept" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
    <!------------------------------------------------------------------------>
    <gw:data id="thr_dormitory_list" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="grid" function="hr.sp_sel_dormitory_charge_ga" parameter="0,3,7,8,9,10,11,12,13" procedure="hr.sp_upd_dormitory_charge_ga" > 
            <input bind="idGrid" >                  
                 <input bind="dtFrom" />
                 <input bind="dtTo" />
                 <input bind="lstDept" /> 
                 <input bind="lstGroup" />
                 <input bind="lstSearchBy" />
                 <input bind="txtEmpValue" />
             </input> 
            <output bind="idGrid" /> 
        </dso> 
    </xml> 
</gw:data>
    <!------------------------------------------------------------------------>
    <table style="width: 100%; height: 100%" border="0" cellpadding="0" cellspacing="0">
        <tr style="height: 1%">
            <td><fieldset style="padding: 5">
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 12%">
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 10%">
                        </td>
                        <td style="width: 12%">
                        </td>
                        <td style="width: 3%">
                        </td>
                        <td style="width: 3%">
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Charge Period&nbsp</td>
                        <td align="right">
                            Year&nbsp</td>
                        <td align="left">
                            <gw:datebox id="dtYear" mode="01" type="year" styles="width:100%" onchange="OnShowPeriod('1')" />
                        </td>
                        <td align="right">
                            Month&nbsp</td>
                        <td align="left">
                            <gw:datebox id="dtMonth" type="month" lang="1" onchange="OnShowPeriod('2')" />
                        </td>
                        <td align="right">
                            From Date&nbsp</td>
                        <td align="left">
                            <gw:datebox id="dtFrom" lang="1" styles="width:100%" />
                        </td>                        
                        <td align="right">
                            ~&nbsp;&nbsp;<gw:datebox id="dtTo" lang="1" styles="width:100%" />
                        </td>
                        <td align="right">
                            </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Department&nbsp</td>
                        <td align="left">
                            <gw:list id="lstDept" styles="width:100%" maxlen="100" onchange="" />
                        </td>
                        <td align="right">
                           <!-- Group&nbsp--></td>
                        <td align="left">
                            <gw:list id="lstGroup" styles="width:100%;display:none">                           
                           </gw:list>
                        </td>
                        <td align="right">
                            Employee&nbsp</td>
                        <td align="left">
                            <gw:list id="lstSearchBy" styles="width:100%">
                        <data>
                            DATA|1|Full Name|2|Emp ID|3|Card ID|4|Person ID
                        </data>
                        </gw:list>
                        </td>
                        <td align="left" colspan="2">
                            <gw:textbox id="txtEmpValue" styles="width:100%" onenterkey="OnSearch()" />
                        </td>
                        <td width=3% align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                        <td width=3% align="right">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave()" />
                        </td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>
        <tr style="height: 9%">
            <td style="border-bottom: none; border-left: none; border-right: none;">
            <fieldset style="padding: 5">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align=center>
                            <gw:label id="idRecord" text="" style="font-family:Tahoma;color:red;size:12"/>
                        </td>
                    </tr>                    
                </table>
                </fieldset>
            </td>
        </tr>
        <tr style="height: 90%">
            <td>
                <gw:grid id="idGrid" header="_thr_dormitory_app_pk|Dept|Group|_thr_employee_pk|EMP Name|EMP ID|Dormitory Type|Allocated Date|Move-in Date|Move-out Date|Inhabited Days|Unit Cost|Total Amount|Remark (GA)"
                    format="0|0|0|0|0|0|0|4|4|4|0|0|0|0" aligns="0|0|0|0|0|1|0|1|1|1|3|3|3|0" defaults="|||||||||||||"
                    editcol="0|0|0|0|0|0|0|1|1|1|0|0|0|1" widths="0|1500|1500|1500|2000|1000|1500|1500|1500|1500|1500|1500|1500|2000"
                    acceptNullDate="T"  
                    sorting="T" styles="width:100%; height:100%" />
            </td>
        </tr>
    </table>
    <gw:textbox id="txtThr_dormitory_app_pk" styles="display:none " />
    <gw:textbox id="txtGroupData" styles="display:none " />
</body>
</html>
