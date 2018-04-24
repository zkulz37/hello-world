<!-- #include  file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Page</title>
</head>
<script language="JavaScript" src="../../../system/lib/md5.js"></script>

<script>

function BodyInit()
{
    chkCheck.SetDataText("-1");
    BindingDataList();
    AddOnClick();
    OnChangeUserType();
    DisableControl();
	txtClientDB.text = "<%=Session("APP_DBUSER")%>";
    searchUser();
}
function DisableControl()
{
    txtPartnerName.SetEnable(false);
    txtPartAddress.SetEnable(false);
    txtPhone.SetEnable(false);
    txtFax.SetEnable(false);
    txtEmail.SetEnable(false);
    txtWebsite.SetEnable(false);
}
function BindingDataList()
{   
 
 lstLanguage.SetDataText("<%=ESysLib.SetListDataSQL("SELECT 'ENG','English' FROM DUAL UNION SELECT 'VIE','Vietnamese' FROM DUAL UNION SELECT 'KOR','Korean' FROM DUAL")%>");
 
 lstUserType.SetDataText("<%=ESysLib.SetListDataFUNC("SELECT F_COMMONCODE('COBS0020','','') FROM DUAL")%>");
 var datatext = "<%=ESysLib.SetListDataFUNC("SELECT F_COMMONCODE('COBS0010','','') FROM DUAL")%>" ;
 lstAccount.SetDataText(datatext);
 lstFinancialManagement.SetDataText(datatext);
 lstSale.SetDataText(datatext);
 lstProduction.SetDataText(datatext);
 lstInventory.SetDataText(datatext);
 lstPurchasing.SetDataText(datatext);
 lstHR.SetDataText(datatext);
 lstExecutiveInfo.SetDataText(datatext);
}

function searchUser()
{
	getUser.Call("SELECT");
}

function openEmpLookup(num)
{
	var url = '/form/sys/auth/wsyau00001_1.aspx' ;
	o = System.OpenModal( System.RootURL+ url , 700 , 500 , 'resizable:yes;status:yes') 
	if ( o != null )
	{       
		if(num== 0) 
		  txtSearchName.text = o[1];
		else 
		{
			txtEmpPk.text = o[0];
			txtName.text = o[1];
			txtTel.text = o[2];
			txtMobile.text = o[3];
			txtLivingAddr.text = o[5];
			txtGroup.text = o[9];
			txtJob.text = o[4];
			txtPosition.text = o[6];
			txtDept.text = o[7];
			
		}
	}	
}
function loadUserDetail(){
		
	var row  = grdUserList.row;
	txtPk.text = grdUserList.GetGridData(row,5);
	userEntry.StatusSelect();  
	userEntry.Call("SELECT");
	
}

function AddOnClick()
{
  if(userEntry.GetStatus()!= 20){
	userEntry.StatusInsert();
	chkActive.SetDataText("-1");
	txtPwd.text="";
	txtConfirmPwd.text="";
	txtClientDB.text = "<%=Session("APP_DBUSER")%>";
  }
  else{
    alert("Now you can register new user.");
  }
	
}

function SaveOnClick(){
	
	var status = userEntry.GetStatus();
	
	if (status != 40) //40 status delete
	{
	     
		if (checkData()) 
		{
		 
			if (txtPwdEnc.text != txtPwd.text) 
			{
				txtPwdEnc.text = b64_md5(txtPwd.text);
			}
			
	        if(status==20)
	        {
	            userEntry.Call();
	        }
	        else
	        { 
	            
	            userEntry.StatusUpdate();
		        userEntry.Call();
		    }
		}   
	}
	else 
	{
		    
			userEntry.Call();
	}
}

function checkData(){
	if (Trim(txtUserID.text) == "") {
		alert("UserID cann't be blank.");
		return false;
	}
	if(Trim(txtEmpPk.text) == "" && lstUserType.GetData() == "0") {
		alert("Not found mapping employee. Please remapping employee for this account.");
		return false;
	}	
	if(Trim(txtName.text) == "") {
		alert("Employee name cann't be blank.Please input name for this user.");
		return false;
	}	
	if (Trim(txtPwd.text) == "") {
		alert('Password cannt be blank.');
		return false;
	}
	if (txtPwd.text != txtConfirmPwd.text) {
		alert('Password and Confirm password differ. Please re-enter.');
		return false;		
	}
	if (lstLanguage.GetData() == "") {
		alert('Default language cannt be blank.');
		lstLanguage.GetControl().focus();
		return false;
	}	
	if(lstUserType.GetData()!="0")
	{
        if (Trim(txtDept.text) == "") {
		    alert('Please input the name of the department.');
		    return false;
	    }
	    if (txtGroup.text == "") {
		    alert('Please input the name of the group.');
		    return false;		
	    }
	    
	}
	
	return true;
}

function OnDataReceive(objData)
{
    
    var status = userEntry.GetStatus();
    if(objData.id=="userEntry")
    {
        
        if( status==20 || status==10 || status==40)
        {
            userEntry.StatusSelect();
            searchUser();
        }
        else
        {
            txtPwd.text= txtPwdEnc.text;
            txtConfirmPwd.text= txtPwdEnc.text;
            OnChangeUserType();
        }
        
    }
    else if(objData.id == "dsoChekUserAvailable"){
      var arr = event.array;
      lblStatus.GetControl().style.fontWeight = "bold";
      
      if(arr.length > 0){
         if(arr[0][0] == "EXISTED"){
            lblStatus.text = "The user name '"+ arr[0][1] +"' was existed.";
            lblStatus.GetControl().style.color = "Red";
            btnSave.SetEnable(false);
         }
         else{
            lblStatus.text = "You can use this user name '"+ arr[0][1] +"'.";
            lblStatus.GetControl().style.color = "Green";
            btnSave.SetEnable(true);
         }
      }
      else{
            lblStatus.text = "You can use this user name '"+ txtUserID.text +"'.";
            lblStatus.GetControl().style.color = "Green";
            btnSave.SetEnable(true);
      }
      
    }
	else if (objData.id == "dsoCopyRole"){
		if(txtCopyRoleResult.text != ''){
			alert(txtCopyRoleResult.text);
		}
	}
    
}

function DeleteOnClick(){
    if(txtPk.text == ""){
        alert("Please select a user to delete.");
        return;
    }
    if(confirm("Do you want to delete this user?")){
        userEntry.StatusDelete();
        SaveOnClick();
    }
}
function OnChangeUserType(){
    if(lstUserType.GetData()!="0"){
        txtName.SetEnable(true);
        btnPopup.SetEnable(false);
    }
    else{
        txtName.SetEnable(false);
        btnPopup.SetEnable(true);
    }
}
function OnCopyRole()
{
    if(confirm("Do you want to copy role?")){
	   if(txtPk.text == ""){
			alert("Please select a destination user to copy role.");
			return;
		}
		if(txtFromUserID.text == ""){
			alert("Please input user id to be copy role.");
			txtFromUserID.GetControl().focus();
			return;
		}
		dsoCopyRole.Call();
	}
}
</script>

<body leftmargin="5">


<gw:data id="dsoCopyRole" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="process" procedure="es_pro_copy_user_role" > 
            <input> 
                <input bind="txtFromUserID" />
				<input bind="rbKeepRole"/>
                <input bind="txtPk" />
            </input>
            <output>
				<output bind="txtCopyRoleResult" />
			</output>
        </dso> 
    </xml> 
</gw:data>

 <gw:data id="dsoChekUserAvailable" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="array" parameter="0,1" function="gasp.sp_sel_check_user_exist" > 
                <input bind="noneed" >
                    <input bind="txtUserID" />  
                </input> 
                <output bind="noneed" /> 
            </dso> 
        </xml> 
 </gw:data>
 
<gw:data id="getUser"> 
    <xml> 
        <dso type="grid" function="gasp.sp_get_user" > 
            <input> 
                <input bind="txtSearchUserID" />
                <input bind="txtSearchName" />
                <input bind="chkCheck" />
				<input bind="txtClientDB" />
             </input>
            <output  bind="grdUserList"/>
        </dso> 
    </xml> 
</gw:data>
    <gw:data id="userEntry" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,31,32,33,34,35"   function="gasp.sp_get_user_entry2" procedure="gasp.sp_user_entry"> 
            <input> 
                <inout bind="txtPk" />
                <inout bind="txtName" />
	            <inout bind="txtUserID" />
	            <inout bind="txtPwdEnc" />
	            <inout bind="lstLanguage" />
	            <inout bind="lstUserType" />
	            <inout bind="txtTel" />
	            <inout bind="txtMobile" />
	            <inout bind="txtLivingAddr" />
	            <inout bind="chkActive" />
	            <inout bind="txtUrgentContact" />
	            <inout bind="dtStartDT" />
	            <inout bind="dtEndDT" />
	            <inout bind="chkAnnouncement" />
	            <inout bind="chkSecurityAdmin" />
	            <inout bind="lstAccount" />
	            <inout bind="lstFinancialManagement" />
	            <inout bind="lstSale" />   
	            <inout bind="lstProduction" />
	            <inout bind="lstInventory" />
	            <inout bind="lstPurchasing" />
	            <inout bind="lstHR" />
	            <inout bind="lstExecutiveInfo" />
	            <inout bind="txtEmpPk" />
	            <inout bind="txtClientDB" />
	            <inout bind="txtPartnerName" />   
	            <inout bind="txtPartAddress" />
	            <inout bind="txtPhone" />
	            <inout bind="txtFax" />
	            <inout bind="txtEmail" />
	            <inout bind="txtWebsite" />
	            <inout bind="txtDept" />
	            <inout bind="txtGroup" />
	            <inout bind="txtJob" />
	            <inout bind="txtPosition" />
                <inout bind="txtOrgPk" />
	            
	       </input>
        </dso> 
    </xml> 
</gw:data>
    <table width="100%" height="100%" border="1" cellspacing="0" cellpadding="0">
        <tr>
            <td width="50%" valign="top">
                <table width="100%">
                    <tr>
                        <td width="15%">
                            <b>UserID/EmpID</b></td>
                        <td width="20%">
                            <gw:textbox id="txtSearchUserID" styles="width:95%" csstype="filter" onenterkey="searchUser()" />
                        </td>
                        <td width="20%">
                            &nbsp;&nbsp;<b>Employee Name</b></td>
                        <td width="20%">
                            <gw:textbox id="txtSearchName" styles="width:95%" csstype="filter" onenterkey="searchUser()" />
                        </td>
                        <td width="1%" align="center">
                            <gw:button id="btnNewSub2" img="popup" alt="popup" onclick="openEmpLookup(0)" />
                        </td>
                        <td align="center" width="15%">
                            <gw:checkbox id="chkCheck" mode="01"><b>Active</b></gw:checkbox>
                        </td>
                        <td width="1%" align="right">
                            <gw:button id="btnSearch" img="search" alt="Search" text="Search" onclick="searchUser()" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="7">
                        <div style="width:100%; height:460; overflow:auto;">
                            <gw:grid id="grdUserList" header="Emp ID|Emp Name|UserID|Mobile|Living Addr|_PK"
                                format="0|0|0|0|0|0" aligns="0|0|0|0|0|0"
                                editcol="0|0|0|0|0|0"
                                autosize="true" 
                                styles="width:100%; height:100%" sorting="T" paging="true" pageview="18"
                                acceptnulldate="T" oncellclick="loadUserDetail()" />
                        </div>        
                        </td>
                    </tr>
                </table>
            </td>
            <td align="center" valign="top">
                <table width="99%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="100%">
                                        <table width="100%">
                                            <tr>
                                                <td width="20%">
                                                   <gw:label id="lblStatus" /></td>
                                                <td width="1%">
                                                    <gw:button id="btnNew" img="new" alt="New" text="New" onclick="AddOnClick()" />
                                                </td>
                                                <td width="1%">
                                                    <gw:button id="btnDelete" img="delete" alt="Delete" text="Delete" onclick="DeleteOnClick()" />
                                                </td>
                                                <td width="1%">
                                                    <gw:button id="btnSave" img="save" alt="Save" text="Save" onclick="SaveOnClick()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
					<tr>
						<td>
                            <fieldset style="padding: 5">
                                <legend><font color="black"><b>Copy User Role Information</b></font></legend>
                                <table width="100%">
                                    <tr>
                                        <td width="5%" style="white-space:nowrap;">From user</td>	
												<td width="10%"><gw:textbox id="txtFromUserID" styles="width:99%" /></td>	
												<td width="5%" style="white-space:nowrap;">Keep Exists Role</td>	
												<td width="10%">
													<gw:radio id="rbKeepRole" value="Y" > 
														<span value="Y">Yes</span>
														<span value="N">No</span>
													</gw:radio>
												</td>	
												
												<td width="5%">
                                                    <gw:icon id="btnCopyRole"   text="Copy" onclick="OnCopyRole()" />
                                                </td>
									</tr>
								</table>
							</fieldset>
						</td>
					</tr>
                    <tr>
                        <td>
                            <fieldset style="padding: 5">
                                <legend><font color="black"><b>User Information</b></font></legend>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <table width="100%">
                                                <tr>
                                                    <td width="15%" align="left">
                                                        UserID</td>
                                                    <td width="35%">
                                                        <gw:textbox id="txtUserID" styles="width:99%" csstype="mandatory" onBlur ="dsoChekUserAvailable.Call('SELECT');" />
                                                    </td>
                                                    <td width="15%" align="left">
                                                        Emp Name</td>
                                                    <td width="32%">
                                                        <gw:textbox id="txtName" styles="width:99%" csstype="mandatory" />
                                                    </td>
                                                    <td width="3%" align="center">
                                                        <gw:imgbtn id="btnPopup" img="popup" alt="popup" onclick="openEmpLookup(1)" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="15%" align="left">
                                                        Password</td>
                                                    <td width="35%">
                                                        <gw:textbox id="txtPwd" passwd="T" styles="width:100%" csstype="mandatory" />
                                                    </td>
                                                    <td width="15%" align="left">
                                                        User Type</td>
                                                    <td colspan="2">
                                                        <gw:list id="lstUserType" styles="width:100%;" onchange="OnChangeUserType()"> </gw:list>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="15%" align="left">
                                                        Confirm Pwd</td>
                                                    <td width="35%">
                                                        <gw:textbox id="txtConfirmPwd" passwd="T" csstype="mandatory" styles="width:100%" />
                                                    </td>
                                                    <td width="15%" align="left">
                                                        Language</td>
                                                    <td colspan="3" width="35%">
                                                        <gw:list id="lstLanguage" styles="width:100%;background-color : #fffaaf;"> 
                                                     </gw:list>
                                                    </td>
                                                </tr>
                                                
                                                <tr>
                                                    <td width="15%">
                                                        Dept</td>
                                                    <td width="35%">
                                                        <gw:textbox id="txtDept" csstype="mandatory" styles="width: 100%;" />
                                                    </td>
                                                    <td width="15%">
                                                        Group</td>
                                                    <td colspan="3" width="35%">
                                                        <gw:textbox id="txtGroup" csstype="mandatory" styles="width: 100%;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="15%">
                                                        Job</td>
                                                    <td width="35%">
                                                        <gw:textbox id="txtJob" csstype="mandatory" styles="width: 100%;" />
                                                    </td>
                                                    <td width="15%">
                                                        Position</td>
                                                    <td colspan="3" width="35%">
                                                        <gw:textbox id="txtPosition" csstype="mandatory" styles="width: 100%;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="15%">
                                                        Tel No</td>
                                                    <td width="35%">
                                                        <gw:textbox id="txtTel" styles="width: 100%;" />
                                                    </td>
                                                    <td width="15%">
                                                        Mobile No</td>
                                                    <td colspan="3" width="35%">
                                                        <gw:textbox id="txtMobile" styles="width: 100%;" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                   <td colspan=6>
                                                        <table width=100%>
                                                            <tr>
                                                                <td width="15%">
                                                                    Living Addr</td>
                                                                <td width="35%">
                                                                    <gw:textbox id="txtLivingAddr" styles="width: 100%;" />
                                                                </td>
                                                                <td width="5%">
                                                                    Active</td>
                                                                <td width="5%">
                                                                    <gw:checkbox id="chkActive" value="0" mode="01" />
                                                                </td>
                                                                <td width="10%">
                                                                    Contact</td>
                                                                <td width="30%">
                                                                    <gw:textbox id="txtUrgentContact" styles="width: 100%;" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                   </td>
                                                </tr>
                                                <tr>
                                                    
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 5">
                                            <legend><font color="black"><b>Client Information</b></font></legend>
                                            <table width="100%">
                                                <tr>
                                                    <td width="15%">
                                                       Client</td>
                                                    <td width="35%" align="left" colspan="3">
                                                        <gw:textbox id="txtPartnerName" styles="width:100%" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="15%">
                                                        Address</td>
                                                    <td width="35%" align="left" colspan="3">
                                                        <gw:textbox id="txtPartAddress" styles="width:100%" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="15%">
                                                        Phone</td>
                                                    <td width="35%">
                                                        <gw:textbox id="txtPhone" styles="width:100%" />
                                                    </td>
                                                    <td width="15%">
                                                        Fax</td>
                                                    <td width="35%">
                                                        <gw:textbox id="txtFax" styles="width:100%" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="15%">
                                                        Email</td>
                                                    <td width="35%">
                                                        <gw:textbox id="txtEmail" styles="width:100%" />
                                                    </td>
                                                    <td width="15%">
                                                        Web site</td>
                                                    <td width="35%">
                                                        <gw:textbox id="txtWebsite" styles="width:100%" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 5">
                                            <legend><font color="black"><b>Security Information</b></font></legend>
                                            <table width="100%">
                                                <tr>
                                                    <td width=15%>
                                                        <b>Accounting</b></td>
                                                    <td width=35%>
                                                        <gw:list id="lstAccount" styles="width:100%;"> </gw:list>
                                                    </td>
                                                    <td width=15%>
                                                        Financial Mgt</td>
                                                    <td width=35%>
                                                        <gw:list id="lstFinancialManagement" styles="width:100%;"></gw:list>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        Sales</td>
                                                    <td>
                                                        <gw:list id="lstSale" styles="width:100%;"></gw:list>
                                                    </td>
                                                    <td align="left">
                                                        Production</td>
                                                    <td>
                                                        <gw:list id="lstProduction" styles="width:100%;"> </gw:list>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <b>Inventory</b></td>
                                                    <td>
                                                        <gw:list id="lstInventory" styles="width:100%;"> </gw:list>
                                                    </td>
                                                    <td align="left">
                                                        Purchasing</td>
                                                    <td>
                                                        <gw:list id="lstPurchasing" styles="width:100%;"> </gw:list>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left">
                                                        <b>HR</b></td>
                                                    <td>
                                                        <gw:list id="lstHR" styles="width:100%;"> </gw:list>
                                                    </td>
                                                    <td align="left">
                                                        Executive Info</td>
                                                    <td>
                                                        <gw:list id="lstExecutiveInfo" styles="width:100%;"> </gw:list>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4">
                                                        <table width="100%">
                                                            <tr>
                                                                <td width="15%">
                                                                    Announcement</td>
                                                                <td width="5%" align="left">
                                                                    <gw:checkbox id="chkAnnouncement" mode="01" />
                                                                </td>
                                                                <td width="15%">
                                                                    Sec.Admin</td>
                                                                <td width="5%" align="left">
                                                                    <gw:checkbox id="chkSecurityAdmin" mode="01" />
                                                                </td>
                                                                <td align="left">
                                                                    Start Date</td>
                                                                <td>
                                                                    <gw:datebox nullaccept='T' id="dtStartDT" styles="width:80%" lang="1" />
                                                                </td>
                                                                <td align="left">
                                                                    End Date</td>
                                                                <td colspan="3">
                                                                    <gw:datebox nullaccept='T' id="dtEndDT" styles="width:80%" lang="1" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="idInput1" text="" style="display: none" />
	<gw:textbox id="txtClientDB" text="" style="display: none" />
    <gw:textbox id="txtPk" style="display: none" />
    <gw:textbox id="txtEmpPk" style="display: none" />
    <gw:textbox id="txtPwdEnc" style="display: none" />
    <gw:textbox id="txtreNum" text="" style="display: none" />
    <gw:textbox id="txtreMsg" text="" style="display: none" />
	<gw:textbox id="txtCopyRoleResult" text="" style="display: none" />
    <gw:textbox id="txtOrgPk" text="" style="display: none" />
</body>
</html>
