<!-- #include file="../../../system/lib/form.inc"  -->
<script>
var sStatus =0;
function BodyInit()
{
    BtnNewFolder.SetEnable( false );
	//BtnNewRoot.SetEnable( false );
	btnNewItem.SetEnable ( false);
    dsoMenuTree.Call("SELECT");
}

function OnSelectTreeNode()
{
	//return;
	var node = idItem.GetCurrentNode();
    
	//BtnNewFolder.SetEnable( false );
	//btnNewItem.SetEnable ( false);

	 //idUp.SetEnable ( false );
	 //idDown.SetEnable( false );
		 
	if ( node == null ) return;
	if(node.img == 1)
	{
		BtnNewFolder.SetEnable( false );
		btnNewItem.SetEnable ( false);
	}
	else
	{
		BtnNewFolder.SetEnable( true );
		btnNewItem.SetEnable ( true);
	}
	if ( node.oid != "0" )
	{
		lblPK.text = node.oid ;
		
		dsoAlertMenuEntry.Call("SELECT");
		 
	}
	else
	{
		ResetForm();
		BtnNewFolder.SetEnable( true );
		btnNewItem.SetEnable ( false);
	}
	btnSave.SetEnable( true );
	btnDelete.SetEnable( true );
}

function OnNewAddNewItem( type )
{
	ResetForm();
	dsoAlertMenuEntry.StatusInsert();
	var node = idItem.GetCurrentNode();

// node.img = 1 la item 
// mode.img = 0 la folder    
	if ( type == "ROOT" )
	{
		sStatus = 2;
		lblFormType.text = "Root Folder";
		lblFormTypeCode.text = "M";
		lblParentPK.text = "0";
		return;
	} 
	if ( node == null) return;
	
	if ( node.img == 1 ) 
	{
		var pnode = idItem.GetParentNode( node );
		lblParentPK.text = pnode.oid;
	}
	else
	{	
		lblParentPK.text = node.oid;
	}
	
	sStatus = 2;
	
	if ( type == "FOLDER" )
	{
		lblFormType.text = "Folder";
		lblFormTypeCode.text = "M";
	} 
	else
	{
		lblFormType.text = "Menu";
		lblFormTypeCode.text = "I";
	}
	
	SetIconState();
}

function  SetIconState()
{
	var bDisabled = ( sStatus == 0 );
	
	btnSave.SetEnable(!  bDisabled );
	btnDelete.SetEnable(! ( sStatus == 0 || sStatus == 2 ));
	
	if ( lblFormTypeCode.text == "M" )
	{
	 	txtFormURL.SetEnable(false);
	}
	else
	{
		txtFormURL.SetEnable(true);
	}
}

function ResetForm()
{
	lblPK.text = "";
	lblParentPK.text = "";
	txtMenuID.text = "";
	txtName.text = "";
	txtLName.text  = "";
	txtFName.text = "";
	txtFormURL.text = "";
	txtFormDesc.text = "";
	txtImage.text = "";
	lblFormType.text = "";
	txtSQL.SetData("");
	chkUse.value = "Y";
	lblFormTypeCode.text = "";
}

function OnDataReceive(obj)
{
	if (  obj.id == "dsoAlertMenuEntry" )
	{
	  
	    if(sStatus == 2 ||  sStatus == 3)
	    {
	        sStatus = 0;
	        dsoMenuTree.Call("SELECT");
	        
	    }
		return;
	}  
}

function OnSaveChange()
{
	dsoAlertMenuEntry.Call();
}

function OnDeleteItem()
{
	if(confirm("Do you want to delete this Item?\n If you delete it. \nThe role object and object entity which has related with this menu will be deleted too."))
    {
        dsoAlertMenuEntry.StatusDelete();
        sStatus = 3;
        //dsoAlertMenuEntry.Call();        
	}
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

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Alert Menu</title>
</head>
<body>

<gw:data id="dsoMenuTree"  onreceive="OnDataReceive(this)" onerror="OnDataError(this)" > 
        <xml> 
            <dso id="1" type="tree" function="SP_es_SEL_ALERT_MENU"   > 
                <input bind="idItem" > 
                </input> 
                <output bind="idItem" /> 
            </dso> 
        </xml> 
</gw:data> 

<gw:data id="dsoAlertMenuEntry"  onreceive="OnDataReceive(this)"  onerror="OnDataError(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,2,3,4,5,6,7,8,10,11,12" function = "SP_es_SEL_ALERT_MENU_ENTRY" procedure="SP_es_UPD_ALERT_MENU_ENTRY"> 
            <inout> 
                <inout bind="lblPK" />
                <inout bind="lblParentPK" /> 
                <inout bind="txtMenuID" />
                <inout bind="txtName" />
                <inout bind="txtLName" /> 
                <inout bind="txtFName" />
                <inout bind="txtFormURL" />
                <inout bind="txtFormDesc" />
                <inout bind="txtImage" /> 
                <inout bind="lblFormType" /> 
                <inout bind="txtSQL" />
                <inout bind="chkUse" />
				<inout bind="lblFormTypeCode" />
             </inout>
        </dso> 
    </xml> 
</gw:data> 

	<table width="100%" height="100%" border="1" cellspacing="1" cellpadding="1">
		<tr width="100%" height="100%">
			<td width="40%" height="100%">
				<table width="100%" height="100%" border="0">
					<tr width="100%" ><td>
						<table>
							<tr>
								<td width="85%"></td>
								<td width="5%"><gw:icon text="New Root Folder" img="in" id="BtnNewRoot" onclick="OnNewAddNewItem('ROOT')" /></td>
								<td width="5%"><gw:icon text="New Folder" img="in" id="BtnNewFolder" onclick="OnNewAddNewItem('FOLDER')" /></td>
								<td width="5%"><gw:icon text="New Item" img="in"  id="btnNewItem" onclick="OnNewAddNewItem('ITEM')" /></td>
							</tr>
						</table>
					</td></tr>
					<tr width="100%" height="100%"><td>
							<gw:tree id="idItem" style="width:100%; height:100%;overflow:auto;" onclicknode="OnSelectTreeNode()"/>
					</td></tr>
				</table>
			</td>
			<td width="60%" valign="top" >
				<table width="100%" height = "100%" border="0">
					<tr>
						<td width="100%" colspan = "4">
							<table>
								<tr>
									<td width="90%"></td>
									<td width="5%"><gw:icon text="Save" img="in"  id="btnSave" onclick="OnSaveChange()" /></td>
									<td width="5%"><gw:icon text="Delete" img="in" id="btnDelete" onclick="OnDeleteItem()" /></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td width="15%">Form Name</td>
						<td width="85%" colspan = "3"><gw:textbox styles="width:100%" id="txtName"/></td>
					</tr>
					<tr>
						<td width="15%">Local Name</td>
						<td width="35%"><gw:textbox styles="width:100%" id="txtLName"/></td>
						<td width="15%">Foreign Name</td>
						<td width="35%"><gw:textbox styles="width:100%" id="txtFName"/></td>
					</tr>
					<tr>
						<td width="15%">Form ID</td>
						<td width="35%"><gw:textbox styles="width:100%" id="txtMenuID"/></td>
						<td width="15%">Form URL</td>
						<td width="35%"><gw:textbox styles="width:100%" id="txtFormURL"/></td>
					</tr>
					<tr>
						<td width="15%">Form Desc</td>
						<td width="35%" colspan="3"><gw:textbox styles="width:100%" id="txtFormDesc"/></td>
					</tr>
					<tr>
						<td width="15%">Image</td>
						<td width="85%" colspan="3">
							<table width="100%" >
								<tr>
									<td width="55%" ><gw:textbox id="txtImage" styles="width:100%"/></td>
									<td width="15%" colspan = "2"><input size="5" type="File" id="img" enable></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td width="15%"></td>
						<td width="85%" colspan="3">
							<table width="100%" >
								<tr>
									<td width="15%">Form type :</td>
									<td width="20%" align="left"><gw:label id="lblFormType"/></td>
									<td width="65%" align="right"><gw:checkbox id="chkUse" mode="01" onclick="changeDate(1)"><b>Use Y/N</b></gw:checkbox></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr height = "80%">
						<td width="15%">SQL Statement</td>
						<td width="85%" colspan = "3">
							<gw:textarea id="txtSQL" text="" styles="width:100%;height:100%;font-size:15" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<gw:label id="lblPK" style="display:none" />
	<gw:label id="lblParentPK" style="display:none" />
	<gw:label id="lblFormTypeCode" style="display:none" />
</body>
</html>
