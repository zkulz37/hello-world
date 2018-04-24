<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Item Entry</title>
</head>
<%ESysLib.SetUser("ec111")%>
<script>
var Insert      = 'F';
var Modify      = 'F';
var Delete		= 'F';
var project_pk;
function BodyInit()
{
	System.Translate(document);
	BindingDataList();
	project_pk = "<%=Request.querystring("p_porject_pk")%>";
	txtProjectPk.text = project_pk;
	OnSearch();
	OnNew();
}
//=======================================================================
function BindingDataList()
{
	ls_Level = "<%=ESysLib.SetListDataFUNC("SELECT ACNT.SF_A_GET_COMMONCODE('EACAB052') FROM DUAL")%>"; 
	lstLevel.SetDataText(ls_Level);  
}
//=======================================================================
function OnToggle()
 {
    var left  = document.all("idLEFT");    
    var right = document.all("idRIGHT");   
    var imgArrow = document.all("imgArrow");       
    if(imgArrow.status == "expand")
    {
        left.style.display="none";       
        imgArrow.status = "collapse";
        right.style.width="100%";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        left.style.display="";
        imgArrow.status = "expand";
        right.style.width="70%";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
 }
//=======================================================================
function OnNew()
{
	if((idGridHide.GetGridData(idGridHide.rows -1, 1)=='T'))
	{
		alert("You cannot add the level code at node!!");
	}  
	else
	{  
		var getparentPK="", parentID="",parentName="";
		getparentPK = txtPK.text;
		parentName	= txtUpper_Level.GetData();
		parentID	= txtLevel_Cd.GetData();
		dso_update.StatusInsert();

		txtParentPK.text = getparentPK;
		txtProjectPk.text = project_pk;
		txtUpper_Level.SetDataText(parentID);
		var l_level = 0;
		l_level = Number(lstLevel.value);

		if(l_level <= 5)
		{
			if (txtUpper_Level.text != '')
			{
				lstLevel.SetDataText(l_level + 1);
			}
		}  
		else
		{
			return;
		}
		Insert = 'T';
	} 
}
function OnSearch()
{  
    dso_tree.Call("SELECT");
}
//=======================================================================
function OnDataReceive(obj)
{   
	if(obj.id=="dso_update")
	{
		if((Insert == 'T') || (Modify == 'T') || (Delete=='T'))
		{
			Insert = 'F';
			Modify = 'F';
			Delete = 'F';
			dso_tree.Call("SELECT");
		}
		else
		{
			//dso_gridhide.Call("SELECT");
		} 
	}
}
//=======================================================================
function OnClick()
{
    var obj = event.srcElement.GetCurrentNode();
	txtPK.SetDataText( obj.oid );
    dso_update.Call("SELECT");
}
//=======================================================================
function OnDelete()
{
    if(confirm("Are you sure you want to delete ?"))
    {
        dso_update.StatusDelete();
        dso_update.Call();
        Delete='T';
    }
}
//=======================================================================
function onValidate()
{
    if(txtLevel_Cd.GetData()=="")
    {
        alert('Please input Level code !!');
        txtLevel_Cd.GetControl().focus();
        return false;
    }
    else if(txtLevel_Nm.GetData()=="")
    {
        alert('Please input Level name !!');
        txtLevel_Nm.GetControl().focus();
        return false;
    }
    return true;
}
//=======================================================================
function onSave()
{
    if(onValidate())
    {
        dso_update.Call();
    }
}
</script>
<body>
<gw:data id="dso_update"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="control" parameter="0,1,2,3,4,5,6" function="ec111.sp_sel_kpsh00010_item"   procedure="ec111.sp_upd_kpsh00010_item"> 
            <inout> 
                <inout bind="txtPK"/>
                <inout bind="txtParentPK" />
				<inout bind="txtUpper_Level" />
                <inout bind="txtLevel_Cd" />                
                <inout bind="txtLevel_Nm" />
                <inout bind="lstLevel" />
                <inout bind="txtProjectPk" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
<gw:data id="dso_tree" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso id="1" type="tree" function="ec111.sp_sel_kpsh00010_item_1" > 
			<input>   
                <input bind="txtProjectPk" />
				<input bind="txtLevel" />  
			</input> 
			<output bind="idTree" /> 
		</dso> 
	</xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
 <gw:data id="dso_gridhide" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso id="1" type="grid" function="ec111.sp_sel_kpbp00070_2" > 
			<input>
				<input bind="txtPK" />                    
			</input> 
			<output bind="idGridHide" /> 
		</dso> 
	</xml> 
</gw:data>

<table style="background: #BDE9FF; height: 100%; width: 100%">
	<tr>
		<td style="background: white; width: 40%" id="idLEFT">
			<table style="height: 100%; width: 100%" cellpadding="0" cellspacing="0">
				<tr style="height: 1%;width:100%">
					<td>
						<fieldset style="width:100%;padding:0">
							<table  style="width: 100%">
								<tr>
									<td align="right" width="10%">Level</td>
									<td width="90%">
										<gw:textbox id="txtLevel" onenterkey="OnSearch()"	style="width:100%" />
									</td>
									<td >
										<gw:imgbtn id="btnSearch" img="search" alt="Search" onclick="OnSearch()"/>
									</td>                                         
								</tr>
							</table>
						</fieldset>
					</td>
				</tr>
				<tr style="height: 99%;width:100%">
				  <td  valign="top" width="100%"><gw:tree  id="idTree" style="width:100%;height:100%;overflow:scroll" onclicknode="OnClick()" ></gw:tree></td>
				</tr>
			</table>
		</td>
		<td style="background: white; width: 60%" id="idRIGHT">
			<table cellpadding="0" cellspacing="0" style="width: 100%;height:100%" border="0">
			   <tr style="width:100%;height:100%" valign="top">
					<td width="100%">
						<table style="width:100%" cellpadding="0" cellspacing="3" border="0">
							<tr>
								<td style="width:40%" align="right">Code&nbsp;</td>
								<td style="width:57%">
									<gw:list id="lstLevel" text="" styles="width:100%" />
								</td>
								<td style="width:1%">
									<gw:imgbtn id="btnSave1" img="new" alt="New" onclick="OnNew()" />
								</td>
								<td style="width:1%">
									<gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave()" />
								</td>
								<td style="width:1%">
									<gw:imgbtn id="btnSave2" img="delete" alt="Delete"  onclick="OnDelete()" />
								</td>
							</tr>
							<tr>
								<td width="40%" align="right">Upper Code</td>
								<td width="60%" colspan="4">
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr>
											<td width="66%">
												<gw:textbox id="txtUpper_Level"  readonly="true" text="" styles="width:100%" />
											</td>
										</tr>
									</table>
								</td>
							</tr> 
							<tr>
								<td  align="right">Level Code</td>
								<td colspan="4">
									<table width="100%" cellpadding="0" cellspacing="0">
										<tr>
											<td width="70%"><gw:textbox id="txtLevel_Cd" csstype="mandatory" text="" styles="width:100%" /></td>
										</tr>
									</table>
								</td>
								</tr>
								<tr>
									<td align="right" style="width:">Name</td>
									<td width="" colspan="4"><gw:textbox id="txtLevel_Nm" csstype="mandatory" styles="width:100%" /></td>
								</tr>
						</table>
					</td>
			   </tr>     
			</table>
		</td>
</tr>
</table>

<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor: hand;
	position: absolute; left: 1; top: 0;" onClick="OnToggle()" />
   <gw:grid id="idGridHide" header="pk|Y/N" 
	format="0|0"
	aligns="0|0" 
	defaults="|" 
	editcol="0|0" 
	widths="500|500"
	style="display:none;width:200; height:200"/>
 
<gw:textbox id="txtParentPK"  text="" style="display:none" />      
<gw:textbox id="txtPK"  text="" style="display:none" />      
<gw:textbox id="txtProjectPk" styles='width:100%;display:none' />
</body>
</html>
