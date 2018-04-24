<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>
var _employee_pk =  "<%=Session("EMPLOYEE_PK") %>";
function BodyInit()
{ 
	System.Translate(document);
	// Set data to combobox
	  var ctrl1 = grdList.GetGridControl();    
	ctrl1.ColFormat(6) = "###,###,###,###,###"; 
	ctrl1.ColFormat(7) = "###,###,###,###,###";
	ctrl1.ColFormat(8) = "###,###,###,###,###";
	
	lstCategory_Data = "<%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM")%> |%|Select All";
	lstCategory.SetDataText(lstCategory_Data); lstCategory.value = "%";
	// Set Product type to grid combo
	//<%=ESysLib.SetGridColumnComboFormat( "grdList" , 2 , "SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0078' ORDER BY CODE_NM") %>;
	ShowInfo();
	dtTo.SetDataText(System.AddDate(dtTo.GetData(),30));
	OnSearchData();
	//dsoDataList.Call("SELECT");
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
    var mapctrl = grdList.GetGridControl();
    for(i=1; i<grdList.rows;i++)
    {
        if (mapctrl.IsSelected(i)) 
        {
            grdList.DeleteRowAt(i)
        }
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
    if(confirm('Are you sure Approve courses ?'))
    {
        SetApproverPK();
        dsoDataList.Call();
    }
}

function OnReject()
{
    if(confirm('Are you sure Reject courses ?'))
    {
        SetApproverPK();
        dsoRejectData.Call();
    }
}

function SetApproverPK()
{
 for(var i=0;i<grdList.rows;i++)
    {
     if(grdList.GetGridData(i,0) == -1)//checked
       {
            grdList.SetGridText(i,3,_employee_pk);
       }
    }
 }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Register Training Course</title>
</head>
<body>
    <gw:data id="dsoDataList" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
    <xml> 
        <dso type="grid" parameter="0,1,3" function="HR_CHKR10200002_sel_train_cour"  procedure="HR_CHKR10200002_upd_train_cour"  > 
            <input bind="grdList"  > 
				<input bind="lstCategory" /> 
				<input bind="txtFilterValue" /> 
				<input bind="dtFrom" /> 
				<input bind="dtTo" />
				<input bind="chkApprove" /> 	
            </input> 
            <output bind="grdList" /> 
        </dso> 
    </xml> 
</gw:data>

<body>
    <gw:data id="dsoRejectData" onreceive="OnDataReceive(this)" onerror="OnDataError(this)"> 
    <xml> 
        <dso type="grid" parameter="0,1,3" function="HR_CHKR10200002_sel_train_cour"  procedure="HR_CHKR10200002_upd_train2"  > 
            <input bind="grdList"  > 
				<input bind="lstCategory" /> 
				<input bind="txtFilterValue" /> 
				<input bind="dtFrom" /> 
				<input bind="dtTo" />
				<input bind="chkApprove" /> 	
            </input> 
            <output bind="grdList" /> 
        </dso> 
    </xml> 
</gw:data>

    <table width="100%" height="100%" border="1" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="7%">
                            Category</td>
                        <td width="12%">
                            <gw:list id="lstCategory" value="%" styles='width:100%' onchange="OnSearchData()">
                    </gw:list>
                        </td>
                        <td width="3%">
                        </td>
                        <td width="10%">
                            Course ID/Name</td>
                        <td width="15%">
                            <gw:textbox id="txtFilterValue" styles="width:100%" alt="Search by ID, Name" onenterkey="OnSearchData()" />
                        </td>
                        <td width="10%" align="center">
                            Start Date</td>
                        <td width="10%">
                            <gw:datebox id="dtFrom" lang="1" />
                            ~
                        </td>
                        <td width="10%">
                            <gw:datebox id="dtTo" lang="1" />
                        </td>
                        <td width="2%">
                        </td>
                        <td width="2%">
                            <gw:checkbox id="chkApprove" defaultvalue="Y|N" />
                            Approved</td>
                        <td width="8%">
                        </td>
                        <td width="5%">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search item" onclick="OnSearchData()" />
                        </td>
                        <td align="right" width="5%" nowrap>
                            <gw:icon id="ibtnApprove" alt="Approve" text="Approve" img="in" styles="width:100%" onclick="OnSaveChangedData()" />
                        </td>                        
                        <td align="right" width="5%" nowrap>
                            <gw:icon id="ibtnReject" alt="Reject" text="Reject" img="in" styles="width:100%" onclick="OnReject()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="15%">
                            &nbsp;</td>
                        <td width="60%" align="right">
                            <gw:label id="lblRecordCount" text="0 record(s)." maxlen="100" styles="color:blue;width:100%;font-weight: bold;font-size:12" />
                        </td>
                        <td width="15%">
                            &nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="90%">
            <td height="100%">
                <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <gw:grid id="grdList" header="Approved YN|_PK|Category|_Approver PK|Course ID|Course Name|Training(hour)|Min Trainee|Training budget|Start Date|End Date|Insitution|Location|Description|Approver|Approved Date"
                                format="3|0|0|0|0|0|0|0|0|4|4|0|0|0|0" aligns="0|0|0|0|0|0|3|3|3|0|0|0|0|0|0" defaults="||||||||||||||"
                                editcol="1|1|0|1|0|0|0|0|0|0|0|0|0|0|0" widths="1500|0|2200|0|1500|3000|2000|1200|1500|1500|3000|3000|2000|2000|2000"
                                styles="width:100%; height:100%" sorting="T" acceptnulldate="T" param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14" autosize="T"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txtMasterPK" styles="display:none" />
</body>
</html>
