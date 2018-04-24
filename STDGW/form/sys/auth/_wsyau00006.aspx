<!-- #include file="../../../system/lib/form.inc"  -->
<html>
<head>
    <title>User Authority Entry</title>
</head>
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<script>
var _gLoad = false;
function BodyInit()
{	
    BindDataList();
    txtClientDB.text = "<%=Session("APP_DBUSER")%>";
	OnSearch();
}

function BindDataList()
{
    var data = "<%=ESysLib.SetListDataSQL("SELECT PK, ORG_ID ||'-'|| ORG_NM FROM "+Session("APP_DBUSER")+".TCO_ORG WHERE DEL_IF = 0 ORDER BY 2")%>|%|Select All";
    
   
}

function OnSearch()
{
	
	dsoUserList.Call("SELECT");
	
}

function loadRoleByUser()
{
    _gLoad = true;
	txtUserPK.text = grdUserList.GetGridData(grdUserList.row, 3);
	dsoRoleList.Call("SELECT");
}

function addObjectTo() {
		
	
	        if(grdUserList.row <= 0){
	            alert("Please select user to add to role.");
	            return;
	        }
			if(grdRoleList.row <= 0){
	            alert("Please select role to add to user.");
	            return;
	        }
			//header="Role Name|UserID|Emp Name|Active|Start Date|End Date|Add YN|Edit YN|Del YN|Print YN|Confirm YN|Cancel YN|Undo YN|Redo YN|Export YN|Att File|Att File View|Att File Dowload|_PK|_UserPK|_RolePK"   
			
			
			grdMapping.AddRow();
			//header="User ID|Full Name|Employee ID|_PK"   
			grdMapping.SetGridText(grdMapping.rows-1 , 19, grdUserList.GetGridData(grdUserList.row,3)); //user pk				
			grdMapping.SetGridText(grdMapping.rows-1 , 20, grdRoleList.GetGridData(grdRoleList.row,1)); //role pk
			grdMapping.SetGridText(grdMapping.rows-1 , 0, grdRoleList.GetGridData(grdRoleList.row,0));//role name
			grdMapping.SetGridText(grdMapping.rows-1 , 1, grdUserList.GetGridData(grdUserList.row,0));//user id
			grdMapping.SetGridText(grdMapping.rows-1 , 2, grdUserList.GetGridData(grdUserList.row,1));//emp full name
			grdRoleList.RemoveRow();
			
	
}

function removeObjectFrom() {

	grdMapping.DeleteRow()//RemoveItem(i);
	
}

function UnRemoveObjectFrom() {
	grdMapping.UnDeleteRow()//RemoveItem(i);
}

function saveMapping()
{
    _gLoad = true;
	dsoUserRoleMapping.Call();
}
function OnDataReceive(dso)
{
    if(dso.id == "dsoRoleList")
    {
        dsoUserRoleMapping.Call("SELECT");
		 _gLoad = false;
    }
    else if(dso.id == "dsoUserRoleMapping")
    {
       if(_gLoad == true)
       {
            _gLoad = false;
            dsoRoleList.Call("SELECT");
       }
    }
}
function OnSearchRole(){
	dsoRoleList.Call("SELECT");
}
</script>

<body>

<gw:data id="dsoRoleList"  onreceive="OnDataReceive(this)" > 
	<xml> 
		<dso type="grid" function="es_sel_wsyau00006_role_user"  > 
			<input bind="grdRoleList" >	
			        <input bind="txtUserPK" />
					<input bind="txtRoleName" /> 
			</input> 
			<output bind="grdRoleList" /> 
		</dso> 
	</xml> 
</gw:data>

  <gw:data id="dsoUserList"  onreceive="" > 
      <xml> 
          <dso type="grid" function="es_sel_wsyau00006_user_list" > 
              <input bind="grdUserList"> 
                  <input bind="txtFullName" /> 
                  <input bind="txtEmpID" /> 
                  <input bind="txtClientDB" /> 
              </input> 
              <output bind="grdUserList" /> 
          </dso> 
      </xml> 
  </gw:data>

 <gw:data id="dsoUserRoleMapping"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="grid" parameter="3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20" function="es_sel_wsyau00006_userrole_map" procedure="es_upd_wsyau00006_userrole_map"> 
            <input bind="grdMapping" > 
                <input bind="txtUserPK" /> 
            </input> 
            <output bind="grdMapping" /> 
        </dso> 
    </xml> 
</gw:data> 

<table width="100%"  border="1">
	<tr>
		
		
		<td>
			<table width=100%>
				<tr>
				    <td>Emp name</td>
					<td width="50%"><gw:textbox id="txtFullName" styles="width:100%" onenterkey="OnSearch()" /></td>
					 <td>Emp ID</td>
					<td width="30%"><gw:textbox id="txtEmpID" styles="width:100%" onenterkey="OnSearch()" /></td>
				    <td width="3%"><gw:button id="btnSearch" img="search" alt="Search" onclick="OnSearch()" /></td>
			  </tr>
				<tr>
					<td colspan="6">
					       
					        <gw:grid   
                            id="grdUserList"  
                            header="User ID|Full Name|Employee ID|_PK"   
                            format="0|0|0|0"  
                            aligns="0|0|0|0"  
                            editcol="0|0|0|0"  
                            widths="100|400|100|1"  
                            styles="width:100%; height:250"   
                            sorting="T"  autosize="true"  
							oncellclick="loadRoleByUser()"
                            /> 
                         
					</td>
				</tr>
			</table>
		</td>
		<td rowspan="2" width="60%" valign="top">
			<table width="100%">
				<tr>
					<td width="85%"></td>
					<td><gw:button id="btnAdd" img="new" alt="Add" onclick="addObjectTo()"/> </td>
					<td><gw:button id="btnDelete" img="delete" alt="Remove" onclick="removeObjectFrom()"/> </td>				
					<td><gw:button id="btnUnDelete" img="udelete" alt="UnRemove" onclick="UnRemoveObjectFrom()"/> </td>									
					<td><gw:button id="btnSave" img="save" alt="Save" onclick="saveMapping()"/></td>
				</tr>
				<tr>
					<td colspan="5">
					 
				        <gw:grid   
			            id="grdMapping"  
			            header="Role Name|UserID|Emp Name|Active|Start Date|End Date|Add YN|Edit YN|Del YN|Print YN|Confirm YN|Cancel YN|Undo YN|Redo YN|Export YN|Att File|Att File View|Att File Dowload|_PK|_UserPK|_RolePK"   
			            format="0|0|0|3|4|4|3|3|3|3|3|3|3|3|3|3|3|3|0|0|0"  
			            aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			            defaults="|||-1|||||||||||||||||"  
			            editcol="0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0"  
			            widths="150|60|150|50|80|80|50|50|50|50|50|50|50|50|50|50|50|50|50|1|1|1"  
			            styles="width:100%; height:480"   
			            sorting="T"   autosize="true" 
			            oncelldblclick="removeObjectFrom()" /> 
			          
			        </td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		
		<td width="40%">
		   <table width="100%">
		       <tr>
					<td width="30%" >
						Role name
					</td>
					<td width="50%"><gw:textbox id="txtRoleName" styles="width:100%" onenterkey="OnSearchRole()" /></td>
				</tr>
				<tr>
					<td colspan=2>
						<gw:grid   
						id="grdRoleList"  
						header="Role Name|_PK"   
						format="0|0"  
						aligns="0|0"  
						editcol="0|0"  
						widths="300|1"  
						styles="width:100%; height:250"   
						sorting="T"   autosize="true" 
						oncelldblclick="addObjectTo()"  /> 
					</td>
				</tr>
		   </table>
	        
       
		</td>
		
		
	</tr>
</table>
<gw:textbox id="txtUserPK"   style="display:none" /> 
<gw:textbox id="txtClientDB"   style="display:none" /> 

</body>
</html>