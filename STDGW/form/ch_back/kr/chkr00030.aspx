<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
var strcodereturn;
var obj_list_code;
var user_id= "<%=Session("User_ID")%>"; 

var col_emp_course_pk   = 0;
    col_emp_pk          = 1,
    col_emp_app_no      = 2,
    col_emp_dept        = 3,
    col_emp_grp         = 4,
    col_emp_id          = 5,
    col_emp_fullname    = 6,
    col_emp_join_date   = 7,
    col_emp_categpry    = 8,
    col_emp_course_name = 9,
    col_emp_from        = 10,
    col_emp_to          = 11,
    col_emp_comple_hour = 12,
    col_emp_cost        = 13,
    col_emp_insti       = 14,
    col_emp_score       = 15,
    col_emp_ranking     = 16,
    col_emp_rate        = 17,
    col_emp_left_dt     = 18;
    
var col_emp_list_result_pk   = 0,
    col_emp_list_course_pk   = 1,
    col_emp_list_pk          = 2,
    col_emp_list_app_no      = 3,
    col_emp_list_dept        = 4,
    col_emp_list_grp         = 5,
    col_emp_list_id          = 6,
    col_emp_list_fullname    = 7,
    col_emp_list_join_date   = 8,
    col_emp_list_left_date   = 9,
    col_emp_list_categpry    = 10,
    col_emp_list_train_type  = 11,
    col_emp_list_course_name = 12,
    col_emp_list_from        = 13,
    col_emp_list_to          = 14,
    col_emp_list_comple_hour = 15,
    col_emp_list_cost        = 16,
    col_emp_list_insti       = 17,
    col_emp_list_score       = 18,
    col_emp_list_ranking     = 19,
    col_emp_list_rate        = 20,
    col_emp_list_remark      = 21;

function BodyInit()
{ 
/*   
   if (user_id == 'truong' || user_id == 'hr.huy')
        document.getElementById("idSave").style.display="";
    else 
  
  document.getElementById("idSave").style.display="none";
*/        
    
	System.Translate(document);
	grdData.GetGridControl().FrozenCols = col_emp_list_join_date;
	var data = '';
	//data = "<%=ESysLib.SetListDataSQL("select a.pk , a.org_id ||'-'|| a.org_nm from tco_org a where a.del_if = 0 and a.org_type ='06' connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All";
    data = "<%=ESysLib.SetListDataSQL("select a.pk, a.org_id || '-' || a.org_nm from tco_org a where a.del_if=0 and a.org_type='06' and nvl(a.end_date,to_char(sysdate,'yyyymmdd'))>=to_char(sysdate,'yyyymmdd') order by a.org_id")%>|ALL|Select All";
	lstDept.SetDataText(data); 
	lstDept.value = "ALL";
	
	lstDept1.SetDataText(data); 
	lstDept1.value = "ALL";
	
	data = "<%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a where a.del_if=0 and a.org_type in('07','12')order by a.org_nm")%>|%|Select All";
	lstGroup.SetDataText('|%|Select All');  
    lstGroup.value = '%';
    
    data = "<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All";
    lstPosition.SetDataText(data);
    lstPosition.value = 'ALL';
    
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM")%> |ALL|Select All";
    lstCategory.SetDataText(data);
    lstCategory.value = 'ALL';

    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0168' ORDER BY to_number(CODE)")%> |ALL|Select All";
    lstTrainType.SetDataText(data);
    lstTrainType.value = 'ALL';
    
    data = "<%=ESysLib.SetListDataSQL("SELECT T.PK, T.COURSE_ID || '-'|| T.COURSE_NAME FROM THR_TRAIN_COURSE T WHERE T.DEL_IF = 0 ORDER BY COURSE_ID")%>|ALL|Select All";
    lstCourseName.SetDataText(data);
    lstCourseName.value = "ALL";    
    
	grdListCategory.GetGridControl().ColFormat(2) = "###,###,###,###,###.00"; 
	grdListCategory.GetGridControl().ColFormat(3) = "###,###,###,###,###.00"; 
	
	grdListEmp.GetGridControl().ColFormat(col_emp_comple_hour)= "###,###,###,###,###"; 
	grdListEmp.GetGridControl().ColFormat(col_emp_cost)       = "###,###,###,###,###"; 
	//grdListEmp.GetGridControl().ColFormat(col_emp_score)      = "###,###,###,###,###.00"; 
	//grdListEmp.GetGridControl().ColFormat(col_emp_ranking)    = "###,###,###,###,###.00"; 
	grdListEmp.GetGridControl().ColFormat(col_emp_rate)       = "###,###,###,###,###.00"; 
	
	grdData.GetGridControl().ColFormat(col_emp_list_comple_hour)= "###,###,###,###,###"; 
	grdData.GetGridControl().ColFormat(col_emp_list_cost)       = "###,###,###,###,###"; 
	//grdData.GetGridControl().ColFormat(col_emp_list_score)      = "###,###,###,###,###.00"; 
	//grdData.GetGridControl().ColFormat(col_emp_list_ranking)    = "###,###,###,###,###.00"; 
	grdData.GetGridControl().ColFormat(col_emp_list_rate)       = "###,###,###,###,###.00"; 
	
	ShowInfo();
	GetLastMonth();
	OnToggle('1');
}

function OnToggle(n)
{
    switch(n)
    {
        case '1':
        imgMaster.status = 'expand';
            if(imgMaster.status == "expand")
            {
                imgMaster.status = "collapse";
			    tblDetail.style.display="none";
			    tblMaster.style.display="";
			    tblDetail.style.height="0%";
			    tblMaster.style.height="100%";
                imgMaster.src = "../../../system/images/iconmaximize.gif";
			    //imgMaster.alt="Show old Training";    			
            }
            else
            {
                imgMaster.status = "expand";
			    tblDetail.style.display="";
			    tblMaster.style.display="none";
                tblDetail.style.height="100%";
                tblMaster.style.height="0%";
                imgMaster.src = "../../../system/images/close_popup.gif";
			    //imgMaster.alt="Close old Training";    			
            }
        break;
        case '2':            
            var left = document.all("left"); 
            var right = document.all("right"); 
            var imgArrow = document.all("imgArrow"); 
	        if(imgArrow.status == "left"){
		        left.style.display="none";
		        right.style.display="";
		        imgArrow.status = "right";
		        left.style.width="0%";
		        right.style.width="100%";
		        imgArrow.src = "../../../system/images/next_orange.gif";
	        }
	        else{
		        right.style.display="";
		        left.style.display="";
		        imgArrow.status = "left";
		        left.style.width="35%";
		        right.style.width="65%";
		        imgArrow.src = "../../../system/images/prev_orange.gif";
	        }
        break;
    }
}

function GetLastMonth()
{
    var l_today = idTermDateTo.value;
    idTermDateFr.value = AddDate(l_today, -30);
    idTermDateFr1.value = AddDate(l_today, -30);
}

function AddDate(strDate, intDay)
{
    var strYear;
	var strMonth;
	var strDay;
	var strFullDate;
	strYear = strDate.substr(0,4);
	strMonth= strDate.substr(4,2);
	strDay  = strDate.substr(6,2);
	var oDate = new Date(strYear,strMonth-1, strDay);//20060203
	
	oDate.setDate(oDate.getDate()+intDay);	
	strYear = oDate.getYear();
	strMonth= oDate.getMonth()+1;
	strDay  = oDate.getDate();
	
	strFullDate = strYear.toString()+String(strMonth<10?'0'+strMonth:strMonth) + String(strDay<10?'0'+strDay:strDay);
	return strFullDate;
}

function OnSave()
{
    dsoGrdData.Call();
}

function OnSearchData(obj)
{
	if(obj == 'Category')
	{
		dsoSearchCategorySum.Call("SELECT");
		txtCategoryPK.text = "";
	}
	else if(obj == 'Course')
	{
		if(grdListCategory.rows <= 1)
		{
			txtCategoryPK.text = "";
			return;
		}
		txtCategoryPK.text  = grdListCategory.GetGridData( grdListCategory.row, 0);
		txtTeamPK.text      = grdListCategory.GetGridData( grdListCategory.row, 6);
		txtPosition.text    = grdListCategory.GetGridData( grdListCategory.row, 7);
		dsoSearchCourseEmp.Call("SELECT");		
	}
}

function OnSearch()
{
    dsoGrdData.Call("SELECT");
}

function OnShowEmpPopup()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
    var obj = System.OpenModal( fpath , 900 ,600, 'resizable:yes;status:yes;');
    
    if (obj!=null)
    {
        txtEmp.text   = obj[1];
    }
}

function OnShowDeptPopup()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:270;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
         lstDept.value=obj;
    }
}

function OnShowPopup(strtemp,objlist)
{
    var strcom;
    obj_list_code = objlist;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_com_code.aspx?code=" +  strtemp ;
    var strid = strtemp;
    
    var obj  = System.OpenModal( fpath , 800 , 600 , 'resizable:yes;status:yes');
    if (obj!=null)
    {
        strcodereturn=obj[1];
        obj_list_code.value=strcodereturn;
//        
//        txtComCodeID.text= strtemp;
//        alert(obj[0]);
//        if (obj[0]==1 )  //modify common code
//            datGetNewCode.Call("SELECT");
//        else if (strcodereturn!=0)
//        {
//            obj_list_code.value=strcodereturn;
//        }
    }
}

function OnShowJobPopup()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:270;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
         lstDept.value=obj;
    }
}

function ShowInfo()
{
	lblRecCntMaster.text = grdListCategory.rows - 1 + " record(s) found.";
	
	if (grdListEmp.rows > 1)
	    lblRecCntDetail.text = grdListEmp.rows - 2 + " record(s) found.";
	else
	    lblRecCntDetail.text = grdListEmp.rows - 1 + " record(s) found.";
	    
    if (grdData.rows > 1)
	    lblRecord.text = grdData.rows - 2 + " record(s) found.";
	else
	    lblRecord.text = grdData.rows - 1 + " record(s) found.";
	
	return;
}

function OnDataReceive(obj)
{    
    var strTemp;

	if(obj.id == "dsoSearchCourseEmp")
    {
        if (grdListEmp.rows <= 1)
        {
            grdListEmp.ClearData();
        }
        else
        {
            for(var row = 1; row < grdListEmp.rows; row++)
            {
                if (grdListEmp.GetGridData(row, col_emp_left_dt) != '')
                {
                    grdListEmp.SetCellBgColor(row, 0, row, grdListEmp.cols - 1, 0x8B7B60);
                }
            }
        }
        
        strTemp = col_emp_comple_hour + '-' + col_emp_cost;
        grdListEmp.Subtotal(1, 2, -1, strTemp);
        grdListEmp.GetGridControl().AutoSize(0, grdListEmp.cols-1);
    }
    
    if (obj.id == "dsoGrdData")
    {
        for(var row = 1; row < grdData.rows; row++)
        {
            if (grdData.GetGridData(row, col_emp_list_left_date) != '')
            {
                grdData.SetCellBgColor(row, 0, row, grdData.cols - 1, 0x8B7B60);
            }
        }
        
        strTemp = col_emp_list_comple_hour + '-' + col_emp_list_cost;
        grdData.Subtotal(1, 2, -1, strTemp);
        grdData.GetGridControl().AutoSize(0, grdData.cols-1);
    }
    
	ShowInfo();
	return;
}

function OnDataError(obj)
{
return;
	if (obj.id=="dsoDataList")
    {
		AlertDBError(obj.errmsg)
		return;
	}
	else
	{
		AlertDBError(obj.errmsg)
		return;
	}
}

function AlertDBError(errmsg)
{
	var aTmp = new Array();
	aTmp = errmsg.split("ORA-");
	if(aTmp.length >= 2)
	{
		alert(aTmp[1]);
	}
	else 
	{
		alert(errmsg);
	}
}

function OnPrint(n) 
{
    switch(n)
    {
        case 1:            
            if (txtCategoryPK.text != '' )
            {
        //        var url = System.RootURL + "/system/ReportEngine.aspx?file=ch/kr/chkr00030.rpt&procedure=HR.SP_SEL_EMP_COURSE"
        //        + "&parameter=" + txtCategoryPK.text + "," + lstDept.value + "," + txtEmpPK.text+ "," + txtTeamPK.text;
        //        window.open(url);
           
                var url = System.RootURL + '/reports/ch/kr/chkr00030.aspx?p_category_pk=' + txtCategoryPK.text;
                window.open(url);
            }   
        break;
        case 2:
            var url = System.RootURL + '/reports/ch/kr/chkr00030_1.aspx?p_dept_pk=' + lstDept1.value 
                + "&p_team_pk="     + lstGroup.value 
                + "&p_pos_pk="      + lstPosition.value 
                + "&p_emp_pk="      + txtEmp.text
                + "&p_dt_from="     + idTermDateFr1.value
                + "&p_dt_to="       + idTermDateTo1.value
                + "&p_category="    + lstCategory.value
                + "&p_train_type="  + lstTrainType.value
                + "&p_course_pk="   + lstCourseName.value
                + "&p_type="   + rbType.value;
                window.open(url);
        break;
    }
}

function OnChangeDept()
{
	datGroupData.Call();
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Training Statistics</title>
</head>
<body>

<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso  type="list" procedure="HR_CHKR10200002_group_by_dept" > 
            <input>
                <input bind="lstDept1" /> 
            </input> 
            <output>
                <output bind="lstGroup" />
            </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="datGetNewCode" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="HR_CHKR10200007_list_new_code" > 
            <input> 
                <input bind="txtComCodeID" />
            </input>
	       <output>
	            <output bind="txtCodeTemp" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="dsoSearchCategorySum"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="" function="HR_CHKR10200007_sel_category"> 
            <input bind="grdListCategory"  > 
				<input bind="lstDept" /> 
				<input bind="idTermDateFr" /> 	
				<input bind="idTermDateTo" /> 
            </input> 
            <output bind="grdListCategory" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoSearchCourseEmp"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="" function="HR_CHKR10200007_sel_emp_course"> 
            <input bind="grdListEmp"  > 
				<input bind="txtCategoryPK" />
            </input> 
            <output bind="grdListEmp" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoGrdData"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,13,14,15,16,18,19,21" function="HR_CHKR10200007_sel_course_1" procedure="HR_CHKR10200007_UPD_COURSE_1">  
            <input bind="grdData"  > 
                <input bind="lstDept1" />
				<input bind="lstGroup" />
				<input bind="lstPosition" />
				<input bind="txtEmp" /> 
				<input bind="idTermDateFr1" /> 	
				<input bind="idTermDateTo1" /> 
                <input bind="lstCategory" /> 
                <input bind="lstTrainType" /> 
                <input bind="lstCourseName" /> 
                <input bind="rbType" />
            </input> 
            <output bind="grdData" /> 
        </dso> 
    </xml> 
    
</gw:data> 
<table width="100%" height="100%" border="0">
    <tr>
        <td colspan="2" align="right" style="border:0" valign="bottom"><img status="collapse" id="imgMaster" alt="" src="../../../system/images/close_popup.gif" style="cursor:hand;display: none" onclick="OnToggle('1')"  /></td>
    </tr>        
	<tr id="tblDetail">
		<td id="left" height="100%" width="35%">				
			<table width="100%" height="100%" border="1">
				<tr height="15%">
					<td>
					    <fieldset style="padding: 5">
						    <legend>Training Course</legend>
						    <table width="100%" border="0">
							    <tr>
								    <td width="10%"><a title="Click here to show Department" onclick="OnShowDeptPopup()" href="#tips" >Department</a></td>
								    <td width="25%" colspan = "3">
									    <gw:list  id="lstDept" value = "ALL" styles='width:100%'onchange="" >
									    </gw:list>
								    </td>
							    </tr>
							    <tr>
								    <td width="10%">Period</td>
								    <td width="90%">
								        <table width="100%">
								            <tr>
								                <td width="10%">
									                <gw:datebox id="idTermDateFr" lang="<%=Session("Lang")%>" styles="width:90%" onchange=""></gw:datebox>
								                </td>
								                <td align = "center" width="1%">~</td>
								                <td width="10%" align = "right" >
									                <gw:datebox id="idTermDateTo" lang="<%=Session("Lang")%>" styles="width:90%" onchange=""></gw:datebox>
								                </td>
								                <td width="19%" ></td>   
								            </tr>
								        </table>
								    </td>
							    </tr>
							    <tr>
								    
								    <%--<td width="10%">Cost between</td>
								    <td width="25%" colspan = "3">
									    <table>
										    <tr>
											    <td width="30%"><gw:textbox id="txtCostBot" type="number" format="###,###.##"  styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData('Category')"  /></td>
											    <td  align = "center" width="10%">~</td>
											    <td width="30%"><gw:textbox id="txtCostUp" type="number" format="###,###.##"  styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData('Category')"  /></td>
											    <td align = "center" width="10%">
												    <gw:imgBtn id="btnSearch" img="search" alt="Search item" onclick="OnSearchData('Category')" />
											    </td>
										    </tr>
									    </table>
								    </td>--%>
							    </tr>									
						    </table>
						</fieldset>
					</td>
				</tr>					
				<tr height="100%">
					<td  width="100%" >
						<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="97%" align = "right"><gw:label id="lblRecCntMaster" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                                <td width="3%" align = "center" width="10%">
	                                <gw:imgBtn id="btnSearch" img="search" alt="Search item" onclick="OnSearchData('Category')" />
                                </td>
                            </tr>
                            <tr  height="100%">
                                <td colspan="2">
	                                <gw:grid   
		                                id="grdListCategory"  
		                                header="_PK|Category|Train Type|Course Name|Complete Hours|Cost|_emp_pk|_team_pk|_pos_type"
		                                format="0|0|0|0|1|1|0|0|0"
		                                aligns="0|0|0|0|3|3|0|0|0"
		                                defaults="||||||||"
		                                editcol="0|0|0|0|0|0|0|0|0"
		                                widths="0|3000|3000|0|1500|1500|0|0|0"
		                                styles="width:100%; height:100%"   
		                                sorting="F"   
		                                debug="false"
		                                autosize="true"
		                                onSelChange="" OnClick="OnSearchData('Course')"  />
                                </td>
                            </tr>
						</table>
					</td>
			</table>
		</td>	
		<td id="right" height="100%" width="65%" valign="top">
			<table height="100%" width="100%" border="1">
				<tr>
					<td width="97%" align = "right"><gw:label id="lblRecCntDetail" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
					<td width="3%"><gw:imgBtn img="excel" alt="Print" onclick ="OnPrint(1)"/></td>
				</tr>
				<tr height="100%" width="100%">
					<td  height="100%" width="100%" colspan="2" >
						<gw:grid   
							id="grdListEmp"  
							header="_Course_PK|_Emp_PK|App No|Department|Group|Emp ID|Full Name|Join Date|Category|Course Name|From|To|Complete Hour|Cost|Institution|Score|Ranking|_Rate|_left_dt"
							format="0|0|0|0|0|0|0|0|0|0|0|0
									|0|0|0|0|0|0|0"
							aligns="0|0|0|0|0|0|0|0|0|0|0|0
									|3|3|0|3|3|3|0"
							defaults="|||||||||||||||||"
							editcol="0|0|0|0|0|0|0|0|0|0|0|0
									|0|0|0|0|0|0|0"
							widths="0|0|0|2000|2000|1000|2500|3000|1500|1500
									|1500|1500|1500|1000|1000|1000|0|0|0"
							styles="width:100%; height:100%"   
							sorting="F"   
							debug="false"
							autosize="true"
							param="0,1,2,3" onSelChange="" OnClick=""/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr id="tblMaster">
	    <td colspan="2" width="100%" >	        
			<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
			    <tr>
			        <td width="10%" align="right">
			            <a title="Click here to show Department" onclick="OnShowDeptPopup()" href="#tips" >Department</a>
			        </td>
				    <td width="20%" >
					    <gw:list  id="lstDept1" value = "ALL" styles='width:100%'onchange="OnChangeDept()" >
					    </gw:list>
				    </td>
				    <td width="7%" align="right">Category
			        </td>
			        <td width="15%">
			            <gw:list  id="lstCategory" value = "ALL" styles='width:100%'onchange="" ></gw:list>
			        </td>
			        <td width="7%" style="" align="right">
			            Period
			        </td>
			        <td width="30%" style="" colspan="3">  
				        <table width="100%">
				            <tr>
				                <td width="10%">
					                <gw:datebox id="idTermDateFr1" lang="<%=Session("Lang")%>" styles="width:90%" onchange=""></gw:datebox>
				                </td>
				                <td align = "center" width="1%">~</td>
				                <td width="10%" align = "right" >
					                <gw:datebox id="idTermDateTo1" lang="<%=Session("Lang")%>" styles="width:90%" onchange=""></gw:datebox>
				                </td>
				                <td width="19%" ></td>   
				            </tr>
				        </table>
			        </td>
			        <td width="1%" style="">
			            <gw:imgBtn id="btnSearch1" img="search" alt="Search" onclick="OnSearch()" />
			        </td>
			        <td width="1%" style="">
			            <gw:imgBtn id="btnPrint1" img="excel" alt="Print" onclick="OnPrint(2)" />
			        </td>
			        <td id='idSave'width="1%" style="">
			            <gw:imgBtn id="btnSave" img="Save" alt="Save" onclick="OnSave()" />
			        </td>
			    </tr>
		        <tr height="1%">
			        <td width="10%" style="" align="right">
			            Team/Section
			        </td>
			        <td width="20%" style="" >
				        <gw:list  id="lstGroup"  styles='width:100%' onchange="" ></gw:list>
			        </td>			        
			        <td nowrap align="right">Training Type</td>
			        <td>	            
                        <gw:list  id="lstTrainType" value = "ALL" styles='width:100%'onchange="" ></gw:list>
			        </td>
			        <td width="5%" style="" align="right">Emp ID
			        </td>
			        <td width="7%">
					    <gw:textbox id="txtEmp" onenterkey="" styles='width:100%'/>
			        </td>
			        <td width="22%" style="" colspan="5" align="center"> Sort by
                        <gw:radio id="rbType" value="1">
                            <span value="1">Emp ID</span>
                            <span value="2">From Date</span>
                        </gw:radio> 
			        </td>
		        </tr>
                <tr  height="1%">
                    <td width="7%" align="right">
                        <a title="Click here to show Job" onclick="OnShowPopup('HR0008',lstPosition)" href="#tips" >Job Title</a>
			        </td>
			        <td width="15%">
				        <gw:list  id="lstPosition"  styles='width:100%' onchange="" />
			        </td>
			        <td nowrap align="right">Course Name</td>
			        <td colspan="4">					            
                        <gw:list  id="lstCourseName" value = "ALL" styles='width:100%'onchange="OnSearch()" ></gw:list>
			        </td>
                    <td colspan="7" align="right">
			            <gw:label id="lblRecord" text="0 record(s) found." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" />                        
                    </td>
                </tr>
                <tr  height="97%">
                    <td colspan="12">
                        <gw:grid   
                            id="grdData"  
							header="_Result_pk|_Course_PK|_Emp_PK|App No|Department|Group|Emp ID|Full Name|Join Date|_Left Date|Category|Train Type|Course Name|From|To|Complete Hour|Cost|Institution|Score|Ranking|_Rate|Remark"
							format="0|0|0|0|0|0|0|0|0|0|0|0|0
									|4|4|0|0|0|0|0|0|0"
							aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0
									|3|3|0|1|1|3|0"
							defaults="||||||||||||||||||||"
							editcol="0|0|0|0|0|0|0|0|0|0|0|0|0
									|1|1|1|1|0|1|1|0|1"
							widths="0|0|0|0|2000|2000|1000|2500|3000|1500|1500
									|1500|1500|1500|1000|1000|1000|0|0|0|0|0"
							styles="width:100%; height:100%"   
							sorting="F"   
							debug="false"
							autosize="true"
                            onSelChange="" OnClick=""/>
                    </td>
                </tr>
			</table>
	    </td>
	</tr>
</table>
	<!--------------------------------------------------------------------------->
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0; display: none" onclick="OnToggle('2')" />
	<gw:textbox id="txtCategoryPK" styles="display:none"/>
	<gw:textbox id="txtTeamPK" styles="display:none"/>
	<gw:textbox id="txtComCodeID" styles="display:none"/>
	<gw:textbox id="txtCodeTemp" styles="display:none"/>
	<gw:textbox id="txtPosition" styles="display:none"/>
</body>
</html>
