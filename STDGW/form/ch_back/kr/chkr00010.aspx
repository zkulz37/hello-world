<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
var col_approved_yn     = 0, 
    col_pk              = 1, 
    col_category        = 2, 
    col_train_type      = 3,
    col_course_id       = 4, 
    col_course_name     = 5, 
    col_training        = 6, 
    col_min_trainee     = 7, 
    col_training_budget = 8, 
    col_start_date      = 9, 
    col_end_date        = 10, 
    col_insitution      = 11, 
    col_location        = 12, 
    col_course_lname    = 13, 
    col_course_fname    = 14, 
    col_description     = 15, 
    col_approver        = 16, 
    col_approved_date   = 17;

function BodyInit()
{ 
	System.Translate(document);
	// Set data to combobox
    
	grdList.GetGridControl().ColFormat(col_min_trainee)     = "###,###,###,###,###"; 
	grdList.GetGridControl().ColFormat(col_training)        = "###,###,###,###,###";
	grdList.GetGridControl().ColFormat(col_training_budget) = "###,###,###,###,###";
    var data = '';
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM")%> |%|Select All";
	lstCategory.SetDataText(data); 
    lstCategory.value = "%";
    
    data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0168' ORDER BY to_number(CODE)")%> |%|Select All";
    lstTrainType.SetDataText(data); 
    lstTrainType.value= '%'

	<%=ESysLib.SetGridColumnComboFormat( "grdList" , 2, "SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM") %>;
    <%=ESysLib.SetGridColumnComboFormat( "grdList" , 3, "SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0168' ORDER BY to_number(CODE)") %>;

	ShowInfo();
	GetLastMonth() ;
	OnSearchData();
}

function GetLastMonth() {
    var l_today = dtTo.value;
    dtFrom.value = AddDate(l_today, -30);
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

function OnDataReceive(obj)
{
	if(obj.id == "dsoDataList")
    {
        ShowInfo();
		return;
    }
	return;
}

function ShowInfo()
{
	lblRecordCount.text = grdList.rows - 1 + " record(s) found."
	return;
}

function OnSearchData()
{
	dsoDataList.Call("SELECT");
	return;
}

function CheckValidData()
{
}

function OnAddnewData()
{
	for(i=1; i<grdList.rows;i++)
    {
        if (grdList.GetRowStatus(i) == 32 ) 
        {
            alert("An empty row existed ! Please input data");
			return;
        }
    }
	grdList.AddRow();
	//var mapCtrl = grdList.GetGridControl();
	//mapCtrl.TextMatrix(grdList.rows - 1 , 10) = lstCompany.GetData();
	return;
}

function OnDeleteData()
{
      if (confirm("Do you want to delete?"))
	{
		grdList.DeleteRow();		
	}
}

function OnUnDeleteData()
{
    var mapctrl = grdList.GetGridControl();
    for(i=1; i<grdList.rows;i++)
    {
        if (mapctrl.IsSelected(i)) 
        {
            grdList.UnDeleteRowAt(i)
        }
    }
}

function OnSaveChangedData()
{
	if(CheckDataIsValid())
	{
		dsoDataList.Call();
	}
}

function CheckDataIsValid() 
{
  for(i = 1; i < grdList.rows; i++)
  {
     if(grdList.GetGridData(i, col_course_name)=="")
     {
        alert("Please input course name at row " +i);
        return false;
     }
     if(grdList.GetGridData(i, col_training)=="")
     {
        alert("Please input training(hour) at row "+ i);
        return false;
     }
     if(grdList.GetGridData(i, col_min_trainee)=="")
     {
        alert("Please input min trainee at row "+ i);
        return false;
     }
     if(grdList.GetGridData(i, col_start_date)=="")
     {
        alert("Please input start date at row "+ i);
        return false;
     }
  }
  return true;
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Register Training Course</title>
</head>
<body>

<gw:data id="dsoDataList"  onreceive="OnDataReceive(this)"  > 
    <xml> 
        <dso type="grid" parameter="1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="HR_CHKR10200001_sel_train_cour"  procedure="HR_CHKR10200001_upd_train_cour"  > 
            <input bind="grdList"  > 
				<input bind="lstCategory" /> 
                <input bind="lstTrainType" /> 
				<input bind="txtFilterValue" /> 
				<input bind="dtFrom" /> 
				<input bind="dtTo" /> 	
            </input> 
            <output bind="grdList" /> 
        </dso> 
    </xml> 
</gw:data> 

    <table width="100%" height="100%" border="1" cellspacing="0" cellpadding="0">
		<tr >
			<td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
			      <tr>
				    <td width="7%" align="right">Category</td>
				    <td width="12%">
					    <gw:list  id="lstCategory" value = "%" styles='width:100%'onchange="OnSearchData()" >
                        </gw:list>
				    </td>
                    <td width="7%" align="right">Train Type</td>
				    <td width="17%">
					    <gw:list  id="lstTrainType" value = "%" styles='width:100%'onchange="OnSearchData()" >
                        </gw:list>
				    </td>
				    <td width="10%" align="right">Course ID/Name</td>
				    <td width="13%"><gw:textbox id="txtFilterValue" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData()"  /></td>
				    <td width="7%" align="right">Start Date</td>
				    <td width="10%">
                      <gw:datebox id="dtFrom" lang="1" /> ~                
                    </td>
                    <td  width="10%"><gw:datebox id="dtTo" lang="1" /></td>
				    <td width="3%"><gw:imgBtn id="btnSearch" img="search" alt="Search item" onclick="OnSearchData()" /></td>	
				    <td width="3%"><gw:imgBtn id="btnAddnew" img="new" alt="Add new item to list" onclick="OnAddnewData()" /></td>
				    <td width="3%"><gw:imgBtn id="btnDelete" img="delete" alt="Delete Selected item from list" onclick="OnDeleteData()" /></td>
				    <td width="3%"><gw:imgBtn id="btnSave" img="save" alt="Save all changed Information" onclick="OnSaveChangedData()" /></td>
				    <td width="3%">&nbsp;</td>
			      </tr>
			    </table>
            </td>
		</tr>
		<tr >
			<td >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="15%">&nbsp;</td>
						<td width="60%" align="right"><gw:label id="lblRecordCount" text="0 record(s)." maxlen = "100" styles="color:blue;width:100%;font-weight: bold;font-size:12" /></td>
						<td width="15%">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="90%">
			<td height="100%">
				<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<gw:grid   
								id="grdList"  
								header="_Approved YN|_PK|Category|Train Type|Course ID|Course Name|Training(hour)|Min Trainee|Training budget|Start Date|End Date|Insitution|Location|_course_lname|_course_fname|Description|Approver|Approved Date"
								format="3|0|0|0|0|0|1|1|1|4|4|0|0|0|0|0|0|0"
								aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
								defaults="|||||||||||||||||"
								editcol="0|0|1|0|0|1|1|1|1|1|1|1|1|1|1|1|0|0"
								widths="1600|0|1500|0|1000|2000|1500|1500|2000|1500|1500|2000|3000|0|0|2000|2000|2000"
								styles="width:100%; height:100%"   
								sorting="T"   
								acceptNullDate="T"
                                autosize="true"/>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
