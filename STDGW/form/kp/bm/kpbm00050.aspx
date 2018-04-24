<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Page</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<script language="JavaScript" src="../../../system/lib/md5.js"></script>

<script>
<%=ESysLib.RenderControlHTML("dat_60010060","col_index") %>
function BodyInit()
{
    System.Translate(document); 
    BindingDataList();
    txtUser_Pk.text = "<%=Session("USER_PK")%>";
 
    datGetAllCompany.Call();
    
}
function OnReset()
{
    txtFName.text="";
    txtLName.text="";
    txtPLPK1.text ="";
}
function OnReset1()
{
    txtSearchName.text="";
    /*txtSearchName1.text="";
    txtEmpID.text="";
    textGetDepartment.text= "ALL";*/
}
function BindingDataList()
{   
 var data;
 data = "<%=ESysLib.SetListDataSQL("select pk,org_nm from tco_org a where  del_if=0")%>"; 
 lstDept.SetDataText(data + "||Select All");
 lstDept.value = "";
 data = "<%=ESysLib.SetListDataFUNC("SELECT ac_get_COMMONCODE('ACBG0130') FROM DUAL")%>||Select All";
 lstAdvType.SetDataText(data);
 lstAdvType.value = "";
 data = "<%=ESysLib.SetListDataSQL("SELECT pk, PARTNER_NAME FROM TCO_company  where del_if=0")%>";   
 lstCompany.SetDataText(data);
 lstCompany.value = "<%=Session("COMPANY_PK") %>";
 //-----------
 <%=ESysLib.RenderControlHTML("dat_60010060","grid_list") %>
}

function searchUser()
{
    dat_60010060.Call("SELECT");
}

function openEmpLookup()
{
     var path = System.RootURL + '/form/60/01/60010060_search_emp.aspx';
            var obj = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
           
            if ( obj[0] != null )
            {
                txtSearchName.text    = obj[29];
            }
}
function openEmpLookup2()
{
     var path = System.RootURL + '/form/60/01/60010010_search_emp.aspx?company_pk='+lstCompany.value;
            var aValue = System.OpenModal( path ,800 , 600 ,  'resizable:yes;status:yes');
            //alert(aValue);
            if (aValue != null) 
            {
            if (aValue.length > 0)
            {
                for (i = 0; i < 1; i++)
                {
                    var tmp = aValue[i];
                    if (tmp[1] != 0)
                    {
					
							grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Company,  lstCompany.GetData());
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Advance_type,  lstAdvType.GetData());
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Emp_ID,  tmp[4]); 
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Employee_Name,  tmp[6]);
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Employee_LName,  tmp[6]);
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Emp_PK, tmp[1]);
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Organization,  tmp[18]);
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Active,  "-1");

                    }
                }
                for(i=1; i<aValue.length; i++)
                {
                    var tmp = aValue[i];
                    if (tmp[0] != 0)
                    {
                            grdUserList.AddRow();
	                        grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Company,  lstCompany.GetData());
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Advance_type,  lstAdvType.GetData());
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Emp_ID,  tmp[4]); 
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Employee_Name,  tmp[6]);
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Employee_LName,  tmp[6]);
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Emp_PK, tmp[1]);
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Organization,  tmp[18]);
                            grdUserList.SetGridText(grdUserList.selrow + i,grdUserList_Active,  "-1");

                    }
                }
            }
        }
}
function AddOnClick()
{   
    grdUserList.AddRow();
    if(chkGet.GetData()=="T")
        {
           
        }
        else
        {
            grdUserList.SetGridText(grdUserList.rows-1,grdUserList_Company,  lstCompany.GetData());
            grdUserList.SetGridText(grdUserList.rows-1,grdUserList_Organization,  lstDept.GetData());
            grdUserList.SetGridText(grdUserList.rows-1,grdUserList_Advance_type,  lstAdvType.GetData());
        }
}
function ongrid_celldblclick(obj)
{
    if ( ((event.col == grdUserList_Emp_ID) && (chkGet.GetData()=="T")) || (event.col == grdUserList_Emp_ID && grdUserList.GetGridData(event.row, grdUserList_Emp_PK)!="")) 
        {
            openEmpLookup2();
            if(txtEmpID.GetData()!="" && txtSearchName1.GetData()!="" && txtEmpPk.GetData()!="")
            {
			
                grdUserList.SetGridText(grdUserList.row,grdUserList_Emp_ID,  txtEmpID.GetData()); 
                grdUserList.SetGridText(grdUserList.row,grdUserList_Employee_Name,  txtSearchName1.GetData());
                grdUserList.SetGridText(grdUserList.row,grdUserList_Employee_LName,  txtSearchName1.GetData());
                grdUserList.SetGridText(grdUserList.row,grdUserList_Emp_PK,  txtEmpPk.GetData());
                grdUserList.SetGridText(grdUserList.row,grdUserList_Organization,  textGetDepartment.GetData());
            }
         }
         if ( ((event.col == grdUserList_Employee_Name) && (chkGet.GetData()=="T")) || (event.col == grdUserList_Employee_Name && grdUserList.GetGridData(event.row, 11)!="") )
        {
            openEmpLookup2();
            if(txtEmpID.GetData()!="" && txtSearchName1.GetData()!="" && txtEmpPk.GetData()!="")
            {
                grdUserList.SetGridText(grdUserList.row,grdUserList_Emp_ID,  txtEmpID.GetData()); 
                grdUserList.SetGridText(grdUserList.row,grdUserList_Employee_Name,  txtSearchName1.GetData());
                grdUserList.SetGridText(grdUserList.row,grdUserList_Employee_LName, txtSearchName1.GetData());
                grdUserList.SetGridText(grdUserList.row,grdUserList_Emp_PK,  txtEmpPk.GetData());
                grdUserList.SetGridText(grdUserList.row,grdUserList_Organization,  textGetDepartment.GetData());
            }
         }
         if ( ((event.col == grdUserList_Employee_LName) && (chkGet.GetData()=="T")) || (event.col == grdUserList_Employee_LName && grdUserList.GetGridData(event.row,grdUserList_Emp_PK)!="") )
        {
            openEmpLookup2();
            if(txtEmpID.GetData()!="" && txtSearchName1.GetData()!="" && txtEmpPk.GetData()!="")
            {
                grdUserList.SetGridText(grdUserList.row,grdUserList_Emp_ID,  txtEmpID.GetData()); 
                grdUserList.SetGridText(grdUserList.row,grdUserList_Employee_Name,  txtSearchName1.GetData());
                grdUserList.SetGridText(grdUserList.row,grdUserList_Employee_LName,  txtSearchName1.GetData());
                grdUserList.SetGridText(grdUserList.row,grdUserList_Emp_PK, txtEmpPk.GetData());
                grdUserList.SetGridText(grdUserList.row,grdUserList_Organization,  textGetDepartment.GetData());
            }
         }
         if (event.col == grdUserList_PL_Unit)
        {
            OnsearchPL2();
        }
}

function SaveOnClick()
{
	 dat_60010060.Call(); 
}

function OnDataReceive(objData)
{
    if(objData.id=="dat_60010060")
    {
         chkCheck.value=1;
        
    }
    if(objData.id=="datGetAllCompany")
    {
        searchUser();
    }
}

function DeleteOnClick()
{
        if(confirm("Do you want to delete ?"));
        {
            grdUserList.DeleteRow(); 
            SaveOnClick();
        }
}
function OnsearchPL()
{
    fpath  = System.RootURL + "/form/60/05/60050010_popup_2005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ac_SEL_60050010_popup_2005&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
         oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
        if ( oValue != null )
        {
            txtPLPK1.text = oValue[2]; 
            txtFName.text   = oValue[0];
            txtLName.text   = oValue[1];
            txtLName1.text   = oValue[1];
        }
}
function OnsearchPL2()
{
    fpath  = System.RootURL + "/form/60/05/60050010_popup_2005.aspx?comm_code="+ "" + "&comm_nm=" + '' + "&company=" + lstCompany.GetData() + '&dsqlid=ac_SEL_60050010_popup_2005&col_code=' + "PL CODE" + '&col_nm=' + "PL NAME";
         oValue = System.OpenModal( fpath , 600 , 400 , 'resizable:yes;status:yes');
        if ( oValue != null )
        {
		/*
			var grdUserList_PK=0, grdUserList_Emp_ID=1, 
			grdUserList_Employee_Name=2, 
			grdUserList_Employee_LName=3, 
			grdUserList_Company=4, grdUserList_Old_Code=5, 
			grdUserList_Organization=6, grdUserList_PL_Unit_PK=7, 
			grdUserList_PL_Unit=8, grdUserList_Advance_type=9, 
			grdUserList_Descsription=10, grdUserList_Emp_PK=11, grdUserList_Active=12;
			*/
            grdUserList.SetGridText(grdUserList.row,grdUserList_Advance_type,  lstAdvType.GetData());
            grdUserList.SetGridText(grdUserList.row,grdUserList_PL_Unit_PK,  oValue[2]);
            grdUserList.SetGridText(grdUserList.row,grdUserList_PL_Unit,  oValue[1]);
        }
}
function window_onBlur() {

}

</script>

<body leftmargin="5" onBlur="return window_onBlur()">
    <%=ESysLib.RenderControlHTML("dat_60010060","data") %>
    <%=ESysLib.RenderControlHTML("datGetAllCompany","data") %>

    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
        <tr style="height: 2%">
            <td>
                <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="6%">
                            Company</td>
                        <td width="20%">
                            <gw:list id="lstCompany" styles="width:99%" onchange="searchUser()" />
                        </td>
                        <td width="6%">
                            EmpID</td>
                        <td width="15%" align="left">
                            <gw:textbox id="txtSearchUserID" styles="width:95%" csstype="filter" onenterkey="searchUser()" />
                        </td>
                        <td width="8%" colspan="1" align="right">
                            <b style="color: #1b2ff2; cursor: hand" onclick="openEmpLookup()">Emp.Name</b></td>
                        <td width="20%">
                            <gw:textbox id="txtSearchName" styles="width:95%" csstype="filter" onenterkey="searchUser()" />
                        </td>
                        <td width="1%" colspan="1">
                            <gw:imgbtn id="btnPopup1" img="reset" alt="Reset" onclick="OnReset1()" />
                        </td>
                        <td align="left" width="8%">
                            <gw:checkbox id="chkGet"><b>Get.Name</b></gw:checkbox>
                        </td>
                        <td align="left" width="7%">
                            <gw:checkbox id="chkCheck" mode="01"><b>Active</b></gw:checkbox>
                        </td>
                        <td width="3%" align="right">
                            <gw:imgbtn id="btnSearch" img="search" alt="Search" text="Search" onclick="searchUser()" />
                        </td>
                        <td width="2%">
                            <gw:imgbtn id="btnNew" img="new" alt="New" text="New" onclick="AddOnClick()" />
                        </td>
                        <td width="2%">
                            <gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="SaveOnClick()" />
                        </td>
                        <td width="2%">
                            <gw:imgbtn id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="DeleteOnClick()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 2%">
            <td>
                <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="7%" align="left">
                            Organization</td>
                        <td width="27%">
                            <gw:list id="lstDept" styles="width:99%" onchange="searchUser()" />
                        </td>
                        <td width="11%" align="left">
                            Advance.type</td>
                        <td width="19%">
                            <gw:list id="lstAdvType" styles="width:99%" onchange="searchUser()" />
                        </td>
                        <td width="6%" colspan="1" align="left">
                            <b style="color: #1b2ff2; cursor: hand" onclick="OnsearchPL()">PL Unit</b></td>
                        <td width="10%" colspan="1">
                            <gw:textbox id="txtFName" styles="width:99%" csstype="mandatory" />
                        </td>
                        <td width="19%" colspan="6">
                            <gw:textbox id="txtLName" styles="width:99%" csstype="mandatory" />
                        </td>
                        <td width="1%" colspan="1">
                            <gw:imgbtn id="btnPopup" img="reset" alt="Reset" onclick="OnReset()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="height: 96%">
            <td>
                <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
   <!-- 0_pk|1.Emp ID|2.Employee Name|3.Employee LName|4.Company|5_Old Code|6.Department|7_PL_Unit_PK| 8.PL Unit|9.Advance type|10.Descsription|11_Emp_PK|12.Active"-->
                        <td colspan="14">
                            <%=ESysLib.RenderControlHTML("dat_60010060","grid") %>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="idInput1" text="" style="display: none" />
    <gw:textbox id="txtPartnerPk" text="" style="display: none" />
    <gw:textbox id="txtPLPK1" style="display: none" />
    <gw:textbox id="txtLName1" style="display: none" />
    <gw:textbox id="txtpk" style="display: none" />
    <gw:textbox id="txtEmpPk" style="display: none" />
    <gw:textbox id="txtEmpID" style="display: none" />
    <gw:textbox id="txtPwdEnc" style="display: none" />
    <gw:textbox id="txtreNum" text="" style="display: none" />
    <gw:textbox id="txtreMsg" text="" style="display: none" />
    <gw:list id="lstPL" style="display: none" />
    <gw:textbox id="textFname1" style="display: none" />
    <gw:textbox id="txtSearchName1" style="display: none" />
    <gw:textbox id="textGetDepartment" style="display: none" />
    <gw:textbox id="txtAc_level"  styles='display:none' />
         <gw:textbox id="txtSesion_company"  styles='display:none' />
         <gw:textbox id="txtUser_Pk"  styles='display:none' />
</body>
</html>
