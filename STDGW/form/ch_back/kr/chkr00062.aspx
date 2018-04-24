<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>POP UP GET TRAINNING REQUEST</title>
</head>

<script>
//--------------------------------------------------------------------------------------

function BodyInit()
{ 
    data = "<%=ESysLib.SetListDataSQL("select pk,org_id ||'-'|| org_nm from tco_org a where a.leaf_yn='N' and del_if=0 order by 2") %>"; 
    lstDept.SetDataText(data + "|ALL|Select All");
    lstDept.value ='ALL';
     
    data = "<%=ESysLib.SetGridColumnDataSQL("select pk,org_id ||'-'|| org_nm from tco_org a where a.leaf_yn='N' and del_if=0 order by 2") %> ";       
    grdMaster.SetComboFormat(10,data);
        
    data = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0090' order by code_nm " ) %> ";       
    grdMaster.SetComboFormat(12,data);   
     
    var  user_id  = "<%=Session("USER_ID")%>" ;
    txtUser_ID.text = user_id;
    GetLastMonth();
}
//--------------------------------------------------------------------------------------

function GetLastMonth()
{
    var l_today = dtReqToDT.value;
    var l_pre_month ;
    l_pre_month=AddDate(l_today,-30)
    dtReqFromDT.value = l_pre_month; 
}

function AddDate(strDate,intDay)
{
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
function OnDataReceive(obj)
{
	if(obj.id == "chkr00062")
    {
        data_chkr00062_1.Call("SELECT");
    }
	return;
}
//--------------------------------------------------------------------------------------
function OnSelect()
{
    if ( grdMaster.row > 0 )
    {
	    var aValue = new Array();
		aValue[0] = grdMaster.GetGridData(  grdMaster.row, 0);
		
	    window.returnValue = aValue; 
	    window.close();
	}    
}

//--------------------------------------------------------------------------------------

function OnClick()
{
    if (grdMaster.row > 0)
    {
        txtMasterPK.text = grdMaster.GetGridData(grdMaster.row,0);
        data_chkr00062_1.Call('SELECT');
    }
}
//--------------------------------------------------------------------------------------

</script>

<body>
    <!-------------------------------------------------------------------------------------->
    <gw:data id="data_chkr00062" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod"  function="hr.sp_sel_chkr00062" > 
                <input bind="grdDetail">
                    <input bind="dtReqFromDT" />  
                    <input bind="dtReqToDT" /> 
                    <input bind="lstDept" /> 
                    <input bind="lstSearchBy" /> 
                    <input bind="txtEmp" /> 
                    <input bind="txtUser_ID" />          
                </input> 
                <output bind="grdMaster" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------------------------->
    <gw:data id="data_chkr00062_1" onreceive="OnDataReceive(this)"> 
        <xml> 
           <dso id="4" type="grid" user="prod" parameter="0,1,2,3,4,5,6,7,8,9,10,11" function="hr.sp_sel_chkr00062_1" procedure="hr.sp_upd_chkr00062_1"> 
                <input bind="grdDetail">
                    <input bind="txtMasterPK" />               
                </input> 
                <output bind="grdDetail" /> 
            </dso> 
        </xml> 
    </gw:data>
    <!-------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" border="1">
        <tr style="height: 1%">
            <td>
                <table style="width: 100%; height: 100%">
                    <tr>
                        <td style="width: 5%">
                            Date
                        </td>
                        <td style="width: 25%">
                            <gw:datebox id="dtReqFromDT" lang="<%=Application("Lang")%>" mode="01" />
                            ~
                            <gw:datebox id="dtReqToDT" lang="<%=Application("Lang")%>" mode="01" />
                        </td>
                        <td style="width: 5%">
                            Dept</td>
                        <td style="width: 25%">
                            <gw:list id="lstDept" styles="width:100%" onchange="data_chkr00062.Call('SELECT');" />
                        </td>
                        <td style="width: 5%">
                            Emp</td>
                        <td style="width: 10%">
                            <gw:list id="lstSearchBy" text="" styles="width:100%" value="1">
                                <data>
                                    DATA|1|Full Name|2|Emp ID|3|Card ID|4|Person ID
                                </data>
                            </gw:list>
                        </td>
                        <td style="width: 14%">
                            <gw:textbox id="txtEmp" styles="width: 100%" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn id="idSearch" img="search" text="Search" styles='width:100%' onclick="data_chkr00062.Call('SELECT');" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 49%">
            <td>
                <gw:grid id='grdMaster' header='_PK|Req No|Date|_THR_TRAIN_COURSE_PK|Course Name|Institution|Location|_REQ_EMP_PK|Emp ID|Full Name|Department|Team/Section|Status|Mandantory|_APPROVER_PK|Approver ID|Approver Name|Training budget|Reason'
                    format='0|0|4|0|0|0|0|0|0|0|0|0|0|3|0|0|0|1|0' aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    defaults='||||||||||||||||||' editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                    widths='0|1500|1200|0|1500|2000|1500|0|1500|1500|1500|1500|1500|1500|0|1500|1500|1500|0'
                    sorting='T' styles='width:100%; height:100%' onclick="OnClick()" 
                    oncelldblclick="OnSelect()" />
            </td>
        </tr>
        <tr style="height: 50%">
            <td>
                <gw:grid id='grdDetail' header='_PK|_THR_TRAIN_REQ_PK|No|_TRAINEE_PK|EMP ID| EMP NAME|_TCO_DEPT_PK|DEPT NM|_THR_GROUP_PK|TEAM/SECTION|PLAN COST|DESCRIPTION'
                    format='0|0|0|0|0|0|0|0|0|0|0|0' aligns='0|0|0|0|0|0|0|0|0|0|3|0' defaults='|||||||||||'
                    editcol='0|0|1|0|0|0|0|0|0|0|1|1' widths='1000|1000|1000|1000|1500|3000|1000|2000|1000|2000|1500|1000'
                    sorting='T' onafteredit="TotalAmount()" oncelldblclick="OnGridCellDoubleClick(this)"
                    styles='width:100%; height:100%' />
            </td>
        </tr>
    </table>
    <!--------------------------------------------------------------------------->
    <gw:textbox id="txtMasterPK" styles="width: 100%;display: none" />
    <gw:textbox id="txtUser_ID" styles="width: 100%;display: none1" />
    <!--------------------------------------------------------------------------->
</body>
</html>
