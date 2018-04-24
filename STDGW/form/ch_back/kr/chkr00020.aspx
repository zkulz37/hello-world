<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

var user_pk   =  "<%=Session("EMPLOYEE_PK")%>"  ;
var user_id   =  "<%=Session("User_ID")%>"  ;

var col_select     = 0;
var col_train_result_pk = 1;
var col_trainee_pk = 2;
var col_dept       = 3;
var col_section    = 4;
var col_seq_no     = 5;
var col_emp_id     = 6;
var col_emp_name   = 7;
var col_course     = 8;
var col_course_pk  = 9;
var col_passed     = 10;
var col_score      = 11;
var col_actual     = 12;
var col_plan       = 13;
var col_currency   = 14;
var col_form       = 15;
var col_to         = 16;
var col_train      = 17;
var col_atten      = 18;
var col_rank       = 19;
var col_rate       = 20;
var col_des        = 21;
var col_reqd_pk    = 22;
var col_yn         = 23;
var col_status     = 24;
var col_crt_by_pk  = 25;

var col_em_pk        = 0;
var col_em_app_no    = 1;
var col_em_id        = 2;
var col_em_name      = 3;
var col_em_section   = 4;
var col_em_dept      = 5;
var col_em_course    = 6;
var col_em_course_pk = 7;
var col_em_plan      = 8;
var col_em_train     = 9;
var col_em_use       = 10;
var col_em_train_pk  = 11;

function BodyInit()
{
	System.Translate(document);
    txtEmpPK.text = user_pk;
    txtEmpID.text = user_id;

	GetLastMonth();
	
	<%=ESysLib.SetGridColumnComboFormat( "grdListCourse" , 9 , "SELECT T.PK, T.COURSE_NAME FROM THR_TRAIN_COURSE T WHERE T.DEL_IF = 0 ORDER BY PK") %>;
	<%=ESysLib.SetGridColumnComboFormat( "grdListCourse" , 14 , "SELECT V.CODE, V.CHAR_1 || ' - ' || CODE_NM FROM VHR_HR_CODE V WHERE  V.ID='HR0040' ORDER BY V.CODE_NM") %>;
	
	BindingData();
	
	grdListEmp.GetGridControl().ColFormat(col_em_plan)   = "###,###,###,###,###";
		
	grdListCourse.GetGridControl().ColFormat(col_score)  = "###,###,###,###,###"; 
	grdListCourse.GetGridControl().ColFormat(col_actual) = "###,###,###,###,###"; 
	grdListCourse.GetGridControl().ColFormat(col_plan)   = "###,###,###,###,###";
	grdListCourse.GetGridControl().ColFormat(col_train)  = "###,###,###,###,###"; 
	grdListCourse.GetGridControl().ColFormat(col_atten)  = "###,###,###,###,###";	
	grdListCourse.GetGridControl().ColFormat(col_rank)   = "###,###,###,###,###";
	
	ShowInfo();
	
	OnChangeDept();
}

function BindingData()
{
    var data = "";
    data = "<%=ESysLib.SetListDataSQL("select a.pk,org_id||'-'||a.org_nm from tco_org a where a.del_if=0 and org_type='06' order by 2")%>|ALL|Select All";
    lstDept.SetDataText(data);
    lstDept.value = "ALL";   
    
    data = "<%=ESysLib.SetListDataSQL("SELECT T.PK, T.COURSE_ID || '-'|| T.COURSE_NAME FROM THR_TRAIN_COURSE T WHERE T.DEL_IF = 0 ORDER BY COURSE_NAME")%>|ALL|Select All";
    lstCourseEmp.SetDataText(data);
    lstCourseEmp.value = "ALL";   
    
    lstCourse.SetDataText(data);
    lstCourse.value = "ALL";   
    
    data = "<%=ESysLib.SetListDataSQL("SELECT V.CODE, V.CHAR_1 || ' - ' || CODE_NM FROM VHR_HR_CODE V WHERE  V.ID='HR0040' ORDER BY V.CODE_NM")%>";
    lstSetCurrency.SetDataText(data);
    
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM")%>|ALL|Select All";
    lstCategory.SetDataText(data);
    lstCategory.value = 'ALL';
    
//    data = "<%=ESysLib.SetListDataSQL("SELECT T.PK, T.COURSE_NAME FROM THR_TRAIN_COURSE T WHERE T.DEL_IF = 0 ORDER BY PK")%>";
//    lstCourse.SetDataText(data);
}

function OnToggle(obj)
{
    var left = document.all("left"); 
    var right = document.all("right"); 
    var imgArrow = document.all("imgArrow"); 
	var up = document.all("up"); 
    var imgArrowUp = document.all("imgArrowUp"); 
	if(obj == "x")
		if(imgArrow.status == "All"){
		right.style.display="";
		left.style.display="none";
		imgArrow.status = "right";
		right.style.width="100%";
		//imgArrow.src = "../../../system/images/next_orange.gif";
		}
		else if(imgArrow.status == "right"){
		right.style.display="none";
		left.style.display="";
		imgArrow.status = "left";
		left.style.width="100%";
		//imgArrow.src = "../../../system/images/next_orange.gif";
		}
		else{
		left.style.display="";
		right.style.display="";
		imgArrow.status = "All";
		left.style.width="35%";
		right.style.width="65%";
		//imgArrow.src = "../../../system/images/prev_orange.gif";
		}
	else if(obj == "y")
	{
		if(imgArrowUp.status == "All"){
		up.style.display="none";
		imgArrowUp.status = "down";
		up.style.height="0%";
		//imgArrow.src = "../../../system/images/next_orange.gif";
		}
		else if(imgArrow.status == "right"){
		up.style.display="";
		imgArrow.status = "left";
		up.style.height="100%";
		//imgArrow.src = "../../../system/images/next_orange.gif";
		}
	}
	else { return;}
}

//-------------------------------------------------
function OnShowDeptPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:270;edge:sunken;scroll:no;unadorned:yes;help:no');
        if (obj!=null)
        {
             lstDept.value=obj;
        }
}

function OnChangeDept(flag)
{
	if(flag == 'EMPLOYEE')
	{
		dsoGetCourseByCategoryEmp.Call("SELECT");
	}
	else
	{
		datGroupData.Call();
	}
}

function OnChangeCategory(flag)
{
	if(flag == "SEARCH")
		dsoGetCourseByCategory.Call();
	else if(flag == "SET_INFO")
		dsoGetCourseByCategory_SetInfo.Call();
	else
		return;
}

function OnSearchData(obj)
{
	if(obj == 'Employee')
	{
		dsoSearchEmp.Call("SELECT");
	}
	else if(obj == 'Course')
	{
		dsoSearchCourse.Call("SELECT");
	}
	else {return;}
}

function OnDeleteData()
{
    var mapctrl = grdListCourse.GetGridControl();
    for(i = 1; i < grdListCourse.rows; i++)
    {
        if (mapctrl.IsSelected(i)) 
        {
            grdListCourse.DeleteRowAt(i)
        }
    }
}

function OnSubmitData()
{   
    if (confirm('Are you sure Submit ?'))
    {
        for(i = 1; i < grdListCourse.rows; i++)
        {
//            if ( grdListCourse.GetGridData(i, col_crt_by_pk)== user_pk)
//            {        
                if(grdListCourse.GetGridData(i, col_train_result_pk) == '')
                {
                    alert("You haven't saved Emp ID : " + grdListCourse.GetGridData(i, col_emp_id));
                }
                else
                {
//                    if (grdListCourse.GetGridData(i, col_status) == '10')
//                    {
//                        txt_train_result_pk.text += grdListCourse.GetGridData(i, col_train_result_pk) + ',';
//                    }
                    txt_train_result_pk.text = grdListCourse.GetGridData(i, col_train_result_pk); 
                    dsoSubmitCourse.Call();
                }
//            }
//            else
//            {
//                alert('You might not have permission to Submit this.');
//                return;
//            }
        }
    }
}

function CheckAll()
{
    if( chkSelectAll.GetData()=='T')
    {
        for(row = 1; row < grdListCourse.rows; row++)
        {
            grdListCourse.SetGridText(row, col_select, -1);
        }
    }
	else
	{
        for(row = 1; row < grdListCourse.rows; row++)
        {
            grdListCourse.SetGridText(row, col_select, 0);
        }
    }
}

function OnSaveChangedData()
{    
	if(CheckDataIsValid() == false)
	{
		return;
	}
	else
	{
	    for(var i = 1; i < grdListCourse.rows; i++)
	    {
	        if (grdListCourse.GetGridData(i, col_form) == '')
	        {
    	        alert('You must input From date.');
    	        return;
	        }
	        	        
	        if (grdListCourse.GetGridData(i, col_atten) == '')
	        {
    	        alert('You must input Attendence Hour.');
    	        return;
	        }

	    }
	    
		dsoSearchCourse.Call();
	}
}

function ShowInfo()
{
	lblRecCntMaster.text = grdListEmp.rows - 1 + " record(s) found.";
	lblRecCntDetail.text = grdListCourse.rows - 1 + " record(s) found.";
	return;
}

function OnDataReceive(obj)
{
    for(row = 1; row < grdListCourse.rows; row++)
    {
        if (grdListCourse.GetGridData(row, col_status) == '20')
        {
            grdListCourse.SetCellBgColor(row, 0, row, grdListCourse.cols - 1, 0x8B7B60);
        }
    }
	ShowInfo();

    switch (obj.id) 
    {
        case 'dsoSubmitCourse':
            OnSearchData('Course');
        break;
    }
}

function CheckDataIsValid()
{
	if(CheckValidValue(grdListCourse, col_emp_id, "", "Employee ID can not empty." ) == false
		|| CheckValidValue(grdListCourse, col_course_pk, "", "You must select one course." ) == false
		//|| CheckValidValue(grdList, 1, "", "Product type cannot empty. You must select one in list" ) == false 
		)	
	{
		return false;
	}
	return true;
}

function CheckValidValue(obj, col, values, msg )
{
    if(col < 0)
        return true; // Du lieu tai cot [col] trong [obj] khong trung voi [values]
    if(obj.Rows <= 1)
        return true; 
    var tmp = obj.GetGridControl();
    for(i=1; i<obj.rows; i++)
    {
        if(tmp.TextMatrix(i , col) == values)
		{
			alert(msg)
			return false; // Du lieu tai cot [col] trong [obj] trung voi [values]
		}
    }
    return true; // khong trung
}

function OnDataError(obj)
{
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

function GetLastMonth()
{
    var l_today = dtAppTo.value;
    dtAppForm.value = AddDate(l_today, -30);
    idPeriodDateFr.value = AddDate(l_today, -30);
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

function PassGrid(flag)
{
	/* flag == true : grdListEmp ==> grdListCourse*/
	/* flag == false : grdListCourse ==> grdListEmp*/
	if(flag == true)
	{
		var SourceGrid = grdListEmp.GetGridControl();
		var DestinationGrid = grdListCourse.GetGridControl();
		if(SourceGrid.SelectedRows <= 0)
        {
            alert("Employee not selected")
            return;
        }
        else
        {
            for(i=SourceGrid.Rows-1; i>=0; i--)
            {
                if (SourceGrid.IsSelected(i)) 
                {
                    if(!CheckExist(grdListEmp.GetGridData(i,col_em_id)))
                    {
					    grdListCourse.AddRow();
                    
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_reqd_pk)    = SourceGrid.TextMatrix(i, col_em_pk);        // Reqd_PK
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_emp_id)     = SourceGrid.TextMatrix(i, col_em_id);        // Emp ID		
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_emp_name)   = SourceGrid.TextMatrix(i, col_em_name);      // Emp Name
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_section)    = SourceGrid.TextMatrix(i, col_em_section);   // Emp Group
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_dept)       = SourceGrid.TextMatrix(i, col_em_dept);	  // Emp Dept
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_course)     = SourceGrid.TextMatrix(i, col_em_course);    // train course
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_course_pk)  = SourceGrid.TextMatrix(i, col_em_course_pk); // train course PK
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_plan)       = SourceGrid.TextMatrix(i, col_em_plan);	  // Plan Cost
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_train)      = SourceGrid.TextMatrix(i, col_em_train);	  // Train Time
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_actual)     = txtSetCost.text;
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_currency)   = lstSetCurrency.value;
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_form)       = idSetPeriodDateFr.text;
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_to)         = idSetPeriodDateTo.text;
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_yn)         = SourceGrid.TextMatrix(i, col_em_use);       // Use (Y:N)					
					    DestinationGrid.TextMatrix(DestinationGrid.Rows-1 , col_trainee_pk) = SourceGrid.TextMatrix(i, col_em_train_pk);  // Emp PK
					
					    grdListEmp.SetCellBgColor( i, 0, i, grdListEmp.cols-1, 0xFF6A73);
                    }
                    else
                    {
                        alert("Employee " + grdListEmp.GetGridData(grdListEmp.row, col_em_id) + " was selected.");
                    }
				}	
            }
        }
	}
	else
	{
		return;
	}
}

function CheckExist(p_tranee_pk)
{
    for(var i=1;i<grdListCourse.rows;i++)
    {
        if(grdListCourse.GetGridData(i,col_emp_id) == p_tranee_pk)
        {
            return true;
        }
    }
    return false;
}

function SetInfo()
{
	var DestinationGrid = grdListCourse.GetGridControl();
	
	if(DestinationGrid.SelectedRows <= 0)
	{
		alert("No Data to set infomation")
		return;
	}
	else
	{
	    if (idSetPeriodDateFr.GetData() == "" )
	    {
	        alert('You must input Period Date');
	        return;
	    }
	    
		for(i=DestinationGrid.Rows-1; i>=0; i--)
		{
			if (DestinationGrid.IsSelected(i)) 
			{
				DestinationGrid.TextMatrix(i , col_actual)   = txtSetCost.text;
				DestinationGrid.TextMatrix(i , col_currency) = lstSetCurrency.value;
				DestinationGrid.TextMatrix(i , col_form)     = idSetPeriodDateFr.text;
				DestinationGrid.TextMatrix(i , col_to)       = idSetPeriodDateTo.text;
                DestinationGrid.TextMatrix(i , col_atten)    = txtAttHour.text;

                if (chkPassed.GetData() == 'T')
                    DestinationGrid.TextMatrix(i, col_passed)       = -1;
				else
                    DestinationGrid.TextMatrix(i, col_passed)       = 0;

				if(grdListCourse.GetRowStatus(i) != 32 && grdListCourse.GetRowStatus(i) != 48)
					grdListCourse.SetRowStatus(i, 16);
			}
		}
	}
}

function CheckDupplicateData(empPK, Course, StartDate, EndDate)
{
    var tmpGrid = grdListCourse.GetGridControl();
    for(i=1; i<tmpGrid.rows; i++)
    {
        if(	tmpGrid.TextMatrix(i , col_trainee_pk).toUpperCase() == empPK.toUpperCase()
				&& tmpGrid.TextMatrix(i , col_course).toUpperCase() == Course.toUpperCase()
				&&(tmpGrid.TextMatrix(i , col_currency) < StartDate || tmpGrid.TextMatrix(i , col_currency) > EndDate )
				&&(tmpGrid.TextMatrix(i , col_form) < StartDate || tmpGrid.TextMatrix(i , col_form) > StartDate )
				&& StartDate <= EndDate )
			{
				alert("Duplicate data !  Check for employee ID : " + tmpGrid.TextMatrix(i , col_emp_id) + ". This employee will not insert");
				return i; // bi trung
			}
    }
	alert(empPK + " - " + Course  + " - " + StartDate + " - " + EndDate)
	return 0; // khong trung
}

function OnCheck(n)
{
    switch(n)
    {
        case 1:
            if (dtAppForm.GetData() - dtAppTo.GetData() > 0)
                dtAppForm.SetDataText(dtAppTo.GetData());
                                
            break;
            
        case 2:
            if (idPeriodDateFr.GetData() - idPeriodDateTo.GetData() > 0)
                idPeriodDateFr.SetDataText(idPeriodDateTo.GetData());
                
            break;
            
        case 3:
            if (idSetPeriodDateFr.GetData() - idSetPeriodDateTo.GetData() > 0)
                idSetPeriodDateFr.SetDataText(idSetPeriodDateTo.GetData());
                
            break;
    }
}

function OnPopUp(obj, n)
{
    switch (obj) 
    {
        case 'Course':
            var path = System.RootURL + '/form/ch/kr/chkr00061.aspx?';
            var obj = System.OpenModal( path ,900 , 600 ,  'resizable:yes;status:yes');

            if ( obj != null )      
            {
                if (n == 1)
                    lstCourseEmp.value =obj[0];

                if (n == 2)
                    lstCourse.value =obj[0];
            }
        break;    
    }
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Register Training Result</title>
</head>
<body>

<gw:data id="dsoGetCourseByCategory" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_CHKR10200002_GET_COURSE" > 
                <input>
                    <input bind="lstCategory" /> 
                </input> 
                <output>
                    <output bind="lstCourse" />
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
<gw:data id="dsoSearchEmp"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="0,1,2,3,4,5" function="HR_CHKR10200002_train_course"> 
            <input bind="grdListEmp"  > 
                <input bind="dtAppForm" /> 
                <input bind="dtAppTo" /> 
				<input bind="lstDept" /> 
				<input bind="lstGroup" /> 
				<input bind="lstCourseEmp" /> 
				<input bind="txtSearchEmp" /> 	
            </input> 
            <output bind="grdListEmp" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoSearchCourse"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="grid" parameter="1,2,10,11,12,14,15,16,18,19,20,21,22,24" function="HR_CHKR10200002_sel_train" procedure="HR_CHKR10200002_upd_train" > 
            <input bind="grdListCourse"  > 
				<input bind="lstCourse" /> 
				<input bind="idPeriodDateFr" /> 
				<input bind="idPeriodDateTo" /> 
				<input bind="txtEmpCourse" />
                <input bind="txtEmpID" />
            </input> 
            <output bind="grdListCourse" />
        </dso> 
    </xml> 
</gw:data> 
<gw:data id="dsoSubmitCourse" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="process" procedure="HR_CHKR10200002_pro_train" >
            <input>
                <input bind="txt_train_result_pk" />
                <input bind="txtEmpPK" />
            </input> 
            <output>
                <output bind="txtRtnValue" />
            </output>
        </dso> 
    </xml> 
</gw:data>

	<img status="All" id="imgArrow" alt="Show/Hide List" src="../../../system/images/iconmaximize.gif" style="cursor:hand;position:absolute;" onclick="OnToggle('x')"  />
	<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
		
		<tr height="100%">
			<td>
				<table width="100%" height="100%" border="1" cellspacing="0" cellpadding="0">
					<tr>
						<td id="left" height="100%" width="35%">
							<table  width="100%" height="100%" border="0" >
								<tr>
									<td><fieldset style="padding: 5"><legend>Search infomation</legend>
										<table>
										    <tr>
												<td align = "right" width="20%">Approve date</td>
												<td align = "left" width="60%">
												    <table width="100%" border="0">
												        <tr width="100%">
												            <td width="10%"><gw:datebox id="dtAppForm" lang="<%=Session("Lang")%>" styles="width:10%" onchange="OnCheck(1)" ></gw:datebox></td></td>
												            <td width="5%">~</td>
												            <td width="10%"><gw:datebox id="dtAppTo" lang="<%=Session("Lang")%>" styles="width:10%" onchange="OnCheck(1)"></gw:datebox></td>
												            <td width="75%" align="right"><gw:imgBtn id="btnSearchEmp" img="search" alt="Search item" onclick="OnSearchData('Employee')" /></td>
												        </tr>
												    </table>
												<td align = "left" width="10%"></td>
											</tr>
											<tr>
												<td align = "right" width="20%"><a title="Click here to show department" onclick="OnShowDeptPopup()" href="#tips" >Department</a></span></td>
												<td align = "left" width="60%"><gw:list  id="lstDept" value = "ALL" styles='width:100%'onchange="OnChangeDept('COURSE')" ></gw:list></td>
												<td align = "left" width="10%"></td>
											</tr>
											<tr>
												<td align = "right" width="20%" >Team/Section</td>
												<td align = "left" width="60%" ><gw:list  id="lstGroup" value = "%"  styles='width:100%' onchange="OnSearchData('Employee')" ></gw:list></td>
												<td align = "left" width="10%"></td>
											</tr>
											
											<tr>
												<td align = "right" width="20%">
                                                    <a title="Click here to select Course" onclick="OnPopUp('Course', 1)" href="#tips"
                                style="text-decoration: none; color: #0000ff"><b>Course Name</b></a></td>
												<td align = "left" width="60%"><gw:list  id="lstCourseEmp" value = "ALL"  styles='width:100%' onchange="OnSearchData('Employee')" ></gw:list></td>
												<td align = "left" width="10%"></td>
											</tr>
											<tr>
												<td align = "right" width="20%">Emp ID/Name</td>
												<td align = "left" width="60%"><gw:textbox id="txtSearchEmp" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData('Employee')"  /></td>
												<td align = "left" width="10%"></td>
											</tr>
										</table>
									</fieldset></td>
								</tr>
								<tr>
								    <td width="100%">
								        <table width="100%" border="0">
								            <tr>
								                <td width="97%" align = "right"><gw:label id="lblRecCntMaster" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>            
								                <td width="3%"><gw:icon id="BtnPassGrid" img="in" text = "Pass" alt="Pass selected employee to Course result" onclick="PassGrid(true)" /></td>
								            </tr>
								        </table>
								    </td>
								</tr>
								<tr width="100%" height="100%">
									<td>
										<gw:grid   
										id="grdListEmp"  
										header="_PK|App No|Emp ID|Emp Name|Team/Section|Department|Course Name|_COURSE_PK|Plan Cost|_Train Time|_Use|_TRAINEE_PK"
										format="0|0|0|0|0|0|0|0|2|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|0|0"  
										defaults="0|0|0|0|0|0|0|0|0|0|0|0"  
										editcol="0|0|0|0|0|0|0|0|0|0|0|0"  
										widths="0|0|1500|2500|2500|2500|3000|0|800|0|0|0"
										styles="width:100%; height:100%"   
										sorting="T"   
										acceptNullDate
                                        debug="false"
										param="0,1,2,3,4,5,6,7,8,9,10,11" oncelldblclick="PassGrid(true)"  />
									</td>
								</tr>
							</table>
						</td>
						<td id="right" height="100%" width="65%">
							<table  width="100%" height="100%" border="0" >
								<tr>
									<td><fieldset style="padding: 5"><legend>Search infomation</legend>
										<table border="0">
											<tr>
												<td align = "right" width="20%">Category&nbsp;&nbsp;</td>
												<td align = "left" width="30%"><gw:list  id="lstCategory" value = "%" styles='width:100%'onchange="OnChangeCategory('SEARCH')" ></gw:list></td>
												<td align = "right" width="15%">
                                                    <a title="Click here to select Course" onclick="OnPopUp('Course', 2)" href="#tips"
                                style="text-decoration: none; color: #0000ff"><b>Course Name</b></a></td>
												<td align = "left" width="40%" colspan = "5"><gw:list  id="lstCourse"  styles='width:100%' onchange="OnSearchData('Course')" ></gw:list></td>
											</tr>
											<tr>
												<td align = "right" width="15%">Emp(ID/Name)&nbsp;</td>
												<td align = "left" width="30%">
													<gw:textbox id="txtEmpCourse" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData('Course')"  />
												</td>
												<td align = "right" width="15%">Period&nbsp;&nbsp;</td>
												<td align = "left" width="10%">
													<gw:datebox id="idPeriodDateFr" lang="<%=Session("Lang")%>" styles="width:90%" onchange="OnCheck(2)"></gw:datebox>
												</td>
												<td align = "center" width="3%">~</td>
												<td align = "left" width="10%">
													<gw:datebox id="idPeriodDateTo" lang="<%=Session("Lang")%>" styles="width:90%" onchange="OnCheck(2)"></gw:datebox>
												</td>
												<td align = "center" width="7%"></td>
												<td align = "center" width="10%">
												</td>
											</tr>
										</table>
									</fieldset></td>
								</tr>
								<tr id="up" >
									<td><fieldset style="padding: 5"><legend>Set infomation</legend>
										<table width="100%" border="0">
											<tr>
												<td align = "right" width="10%">Period&nbsp;&nbsp; </td>
												<td width="22%">
												    <gw:datebox id="idSetPeriodDateFr" lang="<%=Session("Lang")%>" styles="width:90%" onchange="OnCheck(3)" nullaccept></gw:datebox>&nbsp;~&nbsp;
												    <gw:datebox id="idSetPeriodDateTo" lang="<%=Session("Lang")%>" styles="width:90%" onchange="OnCheck(3)"></gw:datebox>
												</td>
												<td align="right" width="10%">Actual Cost&nbsp;</td>
												<td width="15%"><gw:textbox id="txtSetCost" type="number" format="###,###"  styles="width:100%" onenterkey=""  /></td>
												<td align="right" width="10%">Atten Hour</td>
												<td width="20%"><gw:textbox id="txtAttHour" type="number" format="###,###"  styles="width:100%" onenterkey=""  /></td>
												<td width="3%"></td>
												<td width="10%"><gw:icon id="idBtnSetInfo" img="in" text="Set Info" onclick="SetInfo()" /></td>
											</tr>
                                            <tr>
                                                <td>Currency</td>
                                                <td><gw:list  id="lstSetCurrency" styles='width:100%'onchange="" ></gw:list></td>
                                                <td>Passed</td>
                                                <td width="22%">
                                                    <gw:checkbox id="chkPassed" value="F" text="" onclick="CheckAll()" ></gw:checkbox >
												</td>

                                                <td colspan="2"></td>
                                            </tr> 
										</table>
									</fieldset></td>
								</tr>
								<tr>
									<td>
										<fieldset style="padding:0">
											<table>
												<tr>
													<td width="5%"></td>
													<td width="30%"><gw:label id="lblRecCntDetail" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
													<td></td>
													<td width="3%"></td>
													<td width="3%">
                                                        <gw:icon id="btnSearchCourse" text="Search"   img="in" alt="Search item" onclick="OnSearchData('Course')" />
                                                    </td>
													<td width="3%">
														<gw:icon id="ibtnDelete" text="Delete"  img="in" onclick="OnDeleteData()" />
													</td>
													<td width="3%">
														<gw:icon id="ibtnSave" text="Save"  img="in" onclick="OnSaveChangedData()" />
													</td>
													<td width="3%">
                                                        <gw:icon id="ibtnSubmit" text="Submit"  img="in" onclick="OnSubmitData()" />
                                                    </td>
												</tr>
											</table>
										</fieldset>
									</td>
								</tr>
                                <tr>
                                    <td>
                                        <gw:checkbox id="chkSelectAll" value="F" text="" onclick="CheckAll()" >Select All</gw:checkbox >
                                    </td>
                                </tr>
								<tr width="100%" height="100%">
									<td>
										<gw:grid   
										id="grdListCourse"
										header="Select|_THR_TRAIN_RESULT_PK|_TRAINEE_PK|Deparment|Team/Section|_SEQ|Emp ID|Emp Name|Course Name|_Course PK|Passed|Score|Actual Cost|Plan Cost|Currency|From|To|Traning Time|Attendence Hour|Rank|Rate|Description|_THR_TRAIN_REQD_PK|_Use|_status_course|_crt_by_pk"
										format="3|0|0|0|0|1|0|0|0|0|3|1|1|1|0|4|4|0|0|1|1|0|0|0|0|0"
										aligns="0|0|0|0|0|0|0|0|0|0|3|0|0|0|0|0|0|3|3|3|3|0|0|0|0|0" 
										defaults="||||||||||0|||||||||||||||"  
									    editcol="0|0|0|0|0|0|0|0|0|0|1|1|1|0|1|1|1|1|1|1|1|1|1|0|0|0"
										widths="0|0|0|2000|2000|500|1000|2500|2000|0|1000|1000|1500|1500|2000|1500|1500|1500|1900|1000|1000|2000|0|0|0|0"
										styles="width:100%; height:100%"
										sorting="T"   
                                        autosize="true"
										acceptNullDate
                                        debug="false"
                                        onSelChange=""  oncelldblclick="PassGrid(false)" />
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
<gw:textbox id="txt_train_result_pk" style="display:none" />  
<gw:textbox id="txtRtnValue" style="display:none" />
<gw:textbox id="txtEmpPK" style="display:none" />
<gw:textbox id="txtEmpID" style="display:none" />