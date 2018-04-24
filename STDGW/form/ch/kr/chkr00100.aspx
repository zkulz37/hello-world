<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

var col_pk              = 0,
    col_seq             = 1,
    col_dept            = 2,
    col_team            = 3,
    col_emp_id          = 4,
    col_emp_name        = 5,
    col_job_title       = 6,
    col_job_type        = 7,
    col_birth_dt        = 8,
    col_edu_type        = 9,
    col_sex             = 10,
    col_tel             = 11,
    col_present_addr    = 12,
    col_place_birth     = 13,
    col_join_date       = 14,
    col_working_period  = 15,
    col_left_date       = 16,
    col_type_010        = 17,
    col_type_020        = 18,
    col_type_030        = 19,
    col_type_040        = 20,
    col_type_050        = 21,
    col_type_060        = 22,
    col_type_070        = 23,
    col_type_250        = 24,
    col_type_260        = 25,
    col_type_080        = 26,
    col_type_090        = 27,
    col_type_100        = 28,
    col_type_110        = 29,
    col_type_120        = 30,
    col_type_130        = 31,
    col_type_140        = 32,
    col_type_150        = 33,
    col_type_160        = 34,
    col_type_170        = 35,
    col_type_180        = 36,
    col_type_190        = 37,
    col_type_200        = 38,
    col_type_210        = 39,
    col_type_220        = 40,
    col_type_230        = 41;

function BodyInit()
{ 
	System.Translate(document);
	
	var data = '';
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM")%> |ALL|Select All";
	lstCategory.SetDataText(data); 
    lstCategory.value = "ALL";

    data = "<%=ESysLib.SetListDataSQL("select a.pk, a.org_id || '-' || a.org_nm from tco_org a where a.del_if=0 and a.org_type='06' and nvl(a.end_date,to_char(sysdate,'yyyymmdd'))>=to_char(sysdate,'yyyymmdd') order by a.org_id")%>|ALL|Select All";
    lstDept.SetDataText(data);
    lstDept.value = "ALL";   
    
    lstGroup.SetDataText('|%|Seleect All');
    lstGroup.value = '%';

    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0168' ORDER BY to_number(CODE)")%> |ALL|Select All";
    lstTrainType.SetDataText(data); 
    lstTrainType.value= 'ALL';
        
    data = "<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All";    
    lstPosition.SetDataText(data);
    lstPosition.value = 'ALL';

    grdData2.GetGridControl().ColFormat(7) = "###,###,###,###,###"; 
    
	grdData.GetGridControl().ColFormat(3) = "###,###,###,###,###"; 
	grdData.GetGridControl().ColFormat(8) = "###,###,###,###,###"; 
	grdData.GetGridControl().ColFormat(9) = "###,###,###,###,###"; 
	grdData.GetGridControl().ColFormat(10) = "###,###,###,###,###"; 

    var obj = grdData1.GetGridControl();

    obj.FrozenCols = col_emp_name;
    obj.ColFormat(col_working_period) = "###,###,###,###,###"; 
    for(col = col_type_010; col <= col_type_230; col++)
    {
        obj.ColFormat(col) = "###,###,###,###,###";
    }
    
    var fg = grdData1.GetGridControl(); 
    fg.rows = fg.rows + 2;

	GetLastMonth();
    OnToggle();
    BuilGrid();
}

function BuilGrid()
{
    var stt;
    var fg = grdData1.GetGridControl(); 
    fg.AutoResize = true;
    fg.AutoSize(0, fg.Cols - 1);
    fg.FixedRows = 3;
    fg.MergeCells = 5 ;
    fg.MergeRow(0) = true;
    fg.MergeRow(1) = true;

    fg.ColWidth(col_type_010) = 2500;
    fg.ColWidth(col_type_020) = 1500;
    fg.ColWidth(col_type_030) = 1500;
    fg.ColWidth(col_type_040) = 2500;
    fg.ColWidth(col_type_050) = 2000;
    fg.ColWidth(col_type_060) = 1500;
    fg.ColWidth(col_type_070) = 1500;
    fg.ColWidth(col_type_250) = 1500;
    fg.ColWidth(col_type_260) = 1500;    
    fg.ColWidth(col_type_080) = 2500;
    fg.ColWidth(col_type_090) = 1500;
    fg.ColWidth(col_type_100) = 2500;
    fg.ColWidth(col_type_110) = 1500;
    fg.ColWidth(col_type_120) = 2000;
    fg.ColWidth(col_type_130) = 1500;
    fg.ColWidth(col_type_140) = 1500;
    fg.ColWidth(col_type_150) = 2000;
    fg.ColWidth(col_type_160) = 2000;
    fg.ColWidth(col_type_170) = 3500;
    fg.ColWidth(col_type_180) = 2000;
    fg.ColWidth(col_type_190) = 2500;
    fg.ColWidth(col_type_200) = 2500;
    fg.ColWidth(col_type_210) = 2000;
    fg.ColWidth(col_type_220) = 2000;
    fg.ColWidth(col_type_230) = 1000;

    fg.Cell(0, 0, col_pk,   2, col_pk) = "PK";
    fg.MergeCol(col_pk) = true ;
    fg.Cell(0, 0, col_seq,  2, col_seq) = "Seq"; 
    fg.MergeCol(col_seq) = true ;
    fg.Cell(0, 0, col_dept, 2, col_dept) = "Department"; 
    fg.MergeCol(col_dept) = true ;
    fg.Cell(0, 0, col_team, 2, col_team) = "Team/Section";
    fg.MergeCol(col_team) = true ;
    fg.Cell(0, 0, col_emp_id, 2, col_emp_id) = "Emp ID";
    fg.MergeCol(col_emp_id) = true ;
    fg.Cell(0, 0, col_emp_name, 2, col_emp_name) = "Emp Name";
    fg.MergeCol(col_emp_name) = true ;
    fg.Cell(0, 0, col_job_title, 2, col_job_title) = "Job Title";
    fg.MergeCol(col_job_title) = true ;
    fg.Cell(0, 0, col_job_type, 2, col_job_type) = "Job Class";
    fg.MergeCol(col_job_type) = true ;    
    fg.Cell(0, 0, col_birth_dt, 2, col_birth_dt) = "Birthday";
    fg.MergeCol(col_birth_dt) = true ;
    fg.Cell(0, 0, col_edu_type, 2, col_edu_type) = "Education";
    fg.MergeCol(col_edu_type) = true ;
    fg.Cell(0, 0, col_sex, 2, col_sex) = "Sex";
    fg.MergeCol(col_sex) = true ;
    fg.Cell(0, 0, col_tel, 2, col_tel) = "Telephone";
    fg.MergeCol(col_tel) = true ;
    fg.Cell(0, 0, col_present_addr, 2, col_present_addr) = "Present Address";
    fg.MergeCol(col_present_addr) = true ;
    fg.Cell(0, 0, col_place_birth, 2, col_place_birth) = "Place Birth";
    fg.MergeCol(col_place_birth) = true ;
    fg.Cell(0, 0, col_join_date, 2, col_join_date) = "Join Date";
    fg.MergeCol(col_join_date) = true ;
    fg.Cell(0, 0, col_working_period, 2, col_working_period) = "Working Period (Month)";
    fg.MergeCol(col_working_period) = true ;
    fg.Cell(0, 0, col_left_date, 2, col_left_date) = "Left Date";
    fg.MergeCol(col_left_date) = true ;
    
    fg.Cell(0, 0, col_type_010, 0, col_type_230) = "Training Type";

    fg.Cell(0, 1, col_type_010, 1, col_type_260) = "Domestic";
    fg.Cell(0, 2, col_type_010, 2, col_type_010) = "Intensive Management";
    fg.Cell(0, 2, col_type_020, 2, col_type_020) = "Jump-up";
    fg.Cell(0, 2, col_type_030, 2, col_type_030) = "Leadership";
    fg.Cell(0, 2, col_type_040, 2, col_type_040) = "New Employee Training";
    fg.Cell(0, 2, col_type_050, 2, col_type_050) = "Train the trainer";
    fg.Cell(0, 2, col_type_060, 2, col_type_060) = "Non Smoking";
    fg.Cell(0, 2, col_type_070, 2, col_type_070) = "OJT";
    fg.Cell(0, 2, col_type_250, 2, col_type_250) = "Computer";
    fg.Cell(0, 2, col_type_260, 2, col_type_260) = "Language";

    fg.Cell(0, 1, col_type_080, 1, col_type_140) = "Oversea";
    fg.Cell(0, 2, col_type_080, 2, col_type_080) = "Global Challenge";
    fg.Cell(0, 2, col_type_090, 2, col_type_090) = "Job Training";
    fg.Cell(0, 2, col_type_110, 2, col_type_100) = "POSCO Mind Level Up";
    fg.Cell(0, 2, col_type_110, 2, col_type_110) = "QSS";
    fg.Cell(0, 2, col_type_120, 2, col_type_120) = "System training";
    fg.Cell(0, 2, col_type_130, 2, col_type_130) = "Mini-MBA";
    fg.Cell(0, 2, col_type_140, 2, col_type_140) = "Change Agent";

    fg.Cell(0, 1, col_type_150, 1, col_type_230) = "e-Learning"; 
    fg.Cell(0, 2, col_type_150, 2, col_type_150) = "Quick Six Sigma";
    fg.Cell(0, 2, col_type_160, 2, col_type_160) = "Visual Planning";
    fg.Cell(0, 2, col_type_170, 2, col_type_170) = "POSCO and Global Business Ethics";
    fg.Cell(0, 2, col_type_180, 2, col_type_180) = "Global POSCO Way";
    fg.Cell(0, 2, col_type_190, 2, col_type_190) = "Information Security";
    fg.Cell(0, 2, col_type_200, 2, col_type_200) = "Easy Korean Language";
    fg.Cell(0, 2, col_type_210, 2, col_type_210) = "Trust Leadership";
    fg.Cell(0, 2, col_type_220, 2, col_type_220) = "How to set a goal";
    fg.Cell(0, 2, col_type_230, 2, col_type_230) = "PM and NS"; //Performance Management and Nurture a subordinate

    grdData1.SetCellBold(1, col_type_010, 1, col_type_230, true);
    grdData1.SetCellBold(2, col_type_010, 2, col_type_230, true);
}

function GetLastMonth() {
    var l_today = dtTo.value;
    dtFrom.value = AddDate(l_today, -30);
    dtFrom1.value = AddDate(l_today, -30);
}

function AddDate(strDate, intDay) {
    var strYear;
    var strMonth;
    var strDay;
    var strFullDate;
    strYear  = strDate.substr(0, 4);
    strMonth = strDate.substr(4, 2);
    strDay   = strDate.substr(6, 2);
    var oDate = new Date(strYear, strMonth - 1, strDay); //20060203

    oDate.setDate(oDate.getDate() + intDay);
    strYear  = oDate.getYear();
    strMonth = oDate.getMonth() + 1;
    strDay   = oDate.getDate();

    strFullDate = strYear.toString() + String(strMonth < 10 ? '0' + strMonth : strMonth) + String(strDay < 10 ? '0' + strDay : strDay);
    return strFullDate;
}

function OnSearchData(n)
{
    switch (n) 
    {
        case '1':
            dsoData.Call('SELECT');
        break;
        case '2':
            dsoData1.Call('SELECT');
        break;
        case '3':
            dsoData2.Call('SELECT');
        break;
    }
}

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'dsoData':        
            grdData.Subtotal(1, 2, -1, '4!9!10');
            
            if (grdData.rows > 1)
                lblRecord.text = grdData.rows - 2 + ' record(s)';
            else
                lblRecord.text = grdData.rows - 1 + ' record(s)';
        break;
        case 'dsoData1':
            BuilGrid();

            for(row = 3; row < grdData1.rows; row++)
            {
                if (grdData1.GetGridData(row, col_left_date) != '')
                {
                    grdData1.SetCellBgColor(row, 0, row, grdData1.cols - 1, 0x8B7B60);
                }
            }
            lblRecord1.text = grdData1.rows - 3 + ' record(s)';
        break;        
        case 'dsoData2':
            lblRecord2.text = grdData2.rows - 1 + ' record(s)';
            
            grdData2.Subtotal(1,2,0, '7','', true, 0x99FFFF, 'Total',0x000000,0x000000, true);
        break;
    }
}

function OnPrint(n)
{
    var url = '';
    switch (n) 
    {
        case '1':
            url = System.RootURL + '/reports/ch/kr/chkr00100.aspx?p_category=' + lstCategory.value 
            + "&p_train_type="  + lstTrainType.value
            + "&p_dt_from="     + dtFrom.value 
            + "&p_dt_to="       + dtTo.value;
            window.open(url);
        break;
        case '2':
            url = System.RootURL + '/reports/ch/kr/chkr00100_1.aspx?p_dept_pk=' + lstDept.value
            + "&p_group_pk="   + lstGroup.value
            + "&p_job_title="   + lstPosition.value
            + "&p_emp_id="      + txtEmpID.text
            + "&p_dt_from="     + dtFrom1.value 
            + "&p_dt_to="       + dtTo1.value
            + "&p_left_yn="     + chkLeftDT.value;
            window.open(url);
        break;
    }
}

function OnToggle()
{
    if(imgMaster.status == "expand")
    {
        imgMaster.status = "collapse";
	    tblDetail.style.display="none";
	    tblMaster.style.display="";
	    tblDetail.style.height="0%";
	    tblMaster.style.height="100%";
        //imgMaster.src = "../../../system/images/iconmaximize.gif";
	    //imgMaster.alt="Show old Training";    			
    }
    else
    {
        imgMaster.status = "expand";
	    tblDetail.style.display="";
	    tblMaster.style.display="none";
        tblDetail.style.height="100%";
        tblMaster.style.height="0%";
        //imgMaster.src = "../../../system/images/close_popup.gif";
	    //imgMaster.alt="Close old Training";    			
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
    }
}

function OnChangeDept()
{
	datGroupData.Call();
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Training Summary</title>
</head>
<body>

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
<gw:data id="dsoData"  onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso type="grid" function="HR_CHKR10200009_sel_Training"> 
            <input bind="grdData"  >
                <input bind="lstCategory" /> 
                <input bind="lstTrainType" /> 
				<input bind="dtFrom" /> 
				<input bind="dtTo" /> 	
            </input> 
            <output bind="grdData" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoData1"  onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso type="grid" function="HR_CHKR10200009_sel_Training_1"> 
            <input bind="grdData1"  >
                <input bind="lstDept" />
                <input bind="lstGroup" />
                <input bind="lstPosition" />
                <input bind="txtEmpID" /> 
				<input bind="dtFrom1" /> 
				<input bind="dtTo1" /> 	
                <input bind="chkLeftDT" />
            </input> 
            <output bind="grdData1" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoData2"  onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso type="grid" function="HR_CHKR10200009_sel_Training_2"> 
            <input bind="grdData2"  >
                <input bind="dtMonth" />
            </input> 
            <output bind="grdData2" /> 
        </dso> 
    </xml> 
</gw:data> 

<table width="100%" height="100%" border="1" cellspacing="0" cellpadding="0">
    <tr height="1%">
        <td width="100%" height="1%">
            <img status="expand" id="imgMaster" alt="" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle()"  />
        </td>
    </tr>
    <tr id="tblMaster" height="100%">
        <td width="100%" height="100%" >
            <gw:tab id="tabMain" style="width:100%;height:100%" border="1">
            <table name="Training History" width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">             
	            <tr height="2%">
		            <td>
		                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="7%" align="right">Category</td>
				                <td width="16%">
					                <gw:list  id="lstCategory" value = "%" styles='width:100%'onchange="OnSearchData('1')" >
                                    </gw:list>
				                </td>
                                <td width="10%" align="right">Train Type</td>
				                <td width="17%">
					                <gw:list  id="lstTrainType" value = "%" styles='width:100%'onchange="OnSearchData('1')" >
                                    </gw:list>
				                </td>
                                <td width="10%" align="right">Period</td>
                                <td width="10%">
                                    <gw:datebox id="dtFrom" lang="1" />      ~               
                                </td>
                                <td width="10%"><gw:datebox id="dtTo" lang="1" /></td>
                                <td width="10%" align="right"><gw:label id="lblRecord" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                                <td width="3%"><gw:imgBtn id="btnSearch" img="search" alt="Search" onclick="OnSearchData('1')" /></td>	
                                <td width="3%"><gw:imgBtn img="excel" alt="Print" onclick ="OnPrint('1')"/></td>
                            </tr>
		                </table>
		            </td>
	            </tr>
	            <tr height="98%">
		            <td height="100%">
			            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				            <tr>
					            <td>
						            <gw:grid   
							            id="grdData"  
							            header="Seq|Category|Train Tye|Course Name|Number of Trainee|From|To|Institution|Location|Complete Hour|Cost"
							            format="0|0|0|0|0|0|0|0|0|0|0"
							            aligns="1|0|0|0|3|1|1|0|0|3|3"
							            defaults="||||||||||"
							            editcol="0|0|0|0|0|0|0|0|0|0|0"
							            widths="0|0|0|0|0|0|0|0|0|0|0"
							            styles="width:100%; height:100%"   
							            autosize="true"
							            sorting="T"/>
					            </td>
				            </tr>
			            </table>
		            </td>
	            </tr>       
            </table>
            <table name="Training Summary" width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" valign="top">             
                <tr style="width:100%;height:2%">
                    <td align="center" width="1%">
                        <gw:datebox id="dtMonth" lang="1" type="year" onchange="OnSearchData('3')"/>
                    </td>
                    <td align="right"><gw:label id="lblRecord2" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                    <td align="right" width="1%">
                        <gw:imgBtn id="btnSearch2" img="search" alt="Search" onclick="OnSearchData('3')" />
                    </td>
                </tr>
                <tr style="width:100%;height:98%">
		            <td colspan='3'>
			            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				            <tr>
					            <td>
						            <gw:grid   
							            id="grdData2"  
							            header="Seq|Department|Team/Section|Emp ID|Full Name|Join DT|Left DT|Complete Hour"
							            format="0|0|0|0|0|0|0|0"
							            aligns="0|0|0|0|0|0|0|1"
							            defaults="|||||||"
							            editcol="0|0|0|0|0|0|0|0"
							            widths="0|0|0|0|0|0|0|0"
							            styles="width:100%; height:100%"   
							            autosize="true"
							            sorting="T"/>
					            </td>
				            </tr>
			            </table>
		            </td>
                </tr>
            </table>
            </gw:tab>
        </td>
    </tr>
    <tr id="tblDetail" height="100%">
        <td width="100%" height="100%" >
             <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">             
	            <tr height="2%">
		            <td>
		                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td width="10%" align="right"><a title="Click here to show department" onclick="OnShowDeptPopup()" href="#tips" >Department</a>&nbsp</td>
				                <td width="12%">
					                <gw:list  id="lstDept" value = "%" styles='width:100%'onchange="OnChangeDept()" >
                                    </gw:list>
				                </td>
                                <td width="7%" align="right">Team/Section&nbsp</td>
				                <td width="18%">
                                    <gw:list  id="lstGroup" value = "%" styles='width:100%'onchange="OnSearchData('2')" >
                                    </gw:list>
				                </td>
                                <td width="6%" align="right">
                                    Period&nbsp</td>
                                <td width="10%">
                                    <gw:datebox id="dtFrom1" lang="1" />      ~               
                                </td>
                                <td width="10%"><gw:datebox id="dtTo1" lang="1" /></td> 
                                <td width="11%" colspan="3" align="right"><gw:label id="lblRecord1" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
                                <td width="1%"><gw:imgBtn id="btnSearch1" img="search" alt="Search" onclick="OnSearchData('2')" /></td>	
                                <td width="1%"><gw:imgBtn id="btnPrint1" img="excel" alt="Print" onclick ="OnPrint('2')"/></td>
                            </tr>
                            <tr>
                                <td width="7%" align="right">
                                    <a title="Click here to show Job" onclick="OnShowPopup('HR0008',lstPosition)" href="#tips" >Job Title&nbsp</a>&nbsp
                                </td>
				                <td width="18%">
				                    <gw:list  id="lstPosition" styles='width:100%' onchange="OnSearchData('2')" />
				                </td>
                                <td width="10%" style="" align="right">
			                        Emp ID&nbsp
			                    </td>
			                    <td width="20%" style="" >
                                    <gw:textbox id="txtEmpID" onenterkey="OnSearchData('2')"/>
			                    </td>
                                <td align="right">
                                    <gw:checkbox id="chkLeftDT" value="F" text="" onclick="" ></gw:checkbox >
                                </td>
                                <td colspan="2">Left Date
                                </td>
                            </tr>
		                </table>
		            </td>
	            </tr>
	            <tr height="98%">
		            <td height="100%">
			            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
				            <tr>
					            <td>
						            <gw:grid   
							            id="grdData1"  
							            header="_0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|_16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41"
							            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							            aligns="0||0|0|0|0|0|0|00|0|0|0|0|0|0|3|0|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3"
							            defaults="||||||||||||||||||||||||||||||||||||||||||"
							            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							            widths="0|20|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
							            styles="width:100%; height:100%"
							            autosize="true"
                                        debug="false"
							            sorting="T"/>
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
