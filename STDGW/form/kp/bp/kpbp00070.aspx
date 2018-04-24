<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<head >
    <title>Level Code Entry</title>
</head>
<%ESysLib.SetUser("ec111")%>
<script>
var Insert      = 'F';
var Modify      = 'F';
var Delete    = 'F';
function BodyInit()
{
	System.Translate(document);
	BindingDataList();
}
//=======================================================================
function BindingDataList()
{
            var ls_Company = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0 order by 1")%>";
            lstCompanyM.SetDataText(ls_Company);
            lstCompany.SetDataText(ls_Company); 
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
                        parentName = txtUpper_Level.GetData();
                        parentID = txtLevel_Cd.GetData();
                        dso_update.StatusInsert();
                        txtParentPK.text = getparentPK;
                        txtUpper_Level.SetDataText(parentID);
                       // lstLevel.SetDataText(lstLevel.value + 1); 
                       var l_level = 0;
                        l_level = Number(lstLevel.value);
                        if(l_level <= 5)
                        {
                                lstLevel.SetDataText(l_level + 1);
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
                     dso_gridhide.Call("SELECT");
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
	else if(txtProject_Pk.GetData()=="")
    {
        alert('Please select  Project !!');
        OnPopUp('Project');
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
//=======================================================================
function OnPopUp(obj)
{
        switch(obj)
        {
                case 'Project':
                            var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
                            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            if(aValue != null)
                            {
                                    txtProject_Pk.text = aValue[0];
                                    txtProject_Cd.text = aValue[1];
                                    txtProject_Nm.text = aValue[2]; 
                            } 
                break;
				case 'ProjectM':
                            var fpath = System.RootURL + "/form/kp/bp/kpbp00060_1.aspx";
                            var aValue = System.OpenModal( fpath , 700 , 600 , 'resizable:yes;status:yes;toolbar=no;location:no;directories:no;menubar:no;scrollbars:no;'); 
                            if(aValue != null)
                            {
                                    txtProjectM_Pk.text = aValue[0];
                                    txtProjectM_Cd.text = aValue[1];
                                    txtProjectM_Nm.text = aValue[2]; 
									dso_tree.Call("SELECT");
                            } 
                break;
		}
}
</script>
<body>
<gw:data id="dso_update"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso id="1" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12" function="ec111.sp_sel_kpbp00070"   procedure="ec111.sp_upd_kpbp00070"> 
            <inout> 
                <inout bind="txtPK"/>
                <inout bind="txtParentPK" /> 
                <inout bind="lstCompany" /> 
                <inout bind="txtUpper_Level" />
                <inout bind="txtLevel_Cd" />
                
                <inout bind="chkLeaf_YN" />
                <inout bind="txtLevel_Nm" />
                <inout bind="txtLevelF_Nm" />
                <inout bind="txtLevelL_Nm" />
                <inout bind="lstLevel" />
                <inout bind="txtProject_Pk" />
                <inout bind="txtProject_Cd" />
                <inout bind="txtProject_Nm" />
            </inout>
        </dso> 
    </xml> 
</gw:data>
<!--------------------------------------------------------------------------------------->
  <gw:data id="dso_tree" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="1" type="tree" function="ec111.sp_sel_kpbp00070_1" > 
                <input>
                    <input bind="lstCompanyM" />   
                    <input bind="txtProjectM_Pk" />    
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
                                            <td width="23%" align="right">Company</td>
                                            <td width="77%" ><gw:list id="lstCompanyM" text="" styles="width:100%" /></td>
                                    </tr>
                                    <tr>
                                    		<td align="right" width=""><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('ProjectM')">Project</a></td>
                                            <td width="" colspan="4">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td width="40%">
                                                            <gw:textbox id="txtProjectM_Cd" readonly="true" styles='width:100%' />
                                                        </td>
                                                        <td width="60%">
                                                            <gw:textbox id="txtProjectM_Nm"  readonly="true" styles='width:100%' />
                                                        </td>
                                                        <td width="">
                                                            <gw:textbox id="txtProjectM_Pk" styles='width:100%;display:none' />
                                                        </td>
                                                        <td>
                                                            <gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProjectM_Cd.text='';txtProjectM_Nm.text='';txtProjectM_Pk.text='';" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                    </tr>
                                    <tr>
                                        <td align="right" width="">Level</td>
                                        <td width="" >
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                                     <td width="100%"><gw:textbox id="txtLevel" onenterkey="OnSearch()" style="width:100%" /></td>
                                                                     <td ><gw:imgbtn id="btSave1" img="search" alt="Search" onclick="OnSearch()" /></td> 
                                                        </tr>
                                                </table> 
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
                                        <td width="22%" align="right">Company</td>
                                        <td width="79%" ><gw:list id="lstCompany" text="" styles="width:100%" /></td>
                                        <td ><gw:imgbtn id="btnSave1" img="new" alt="New" onclick="OnNew()" /></td>
                                        <td ><gw:imgbtn id="btnSave" img="save" alt="Save" text="Save" onclick="onSave()" /></td>
                                        <td ><gw:imgbtn id="btnSave2" img="delete" alt="Delete"  onclick="OnDelete()" /></td>
                                    </tr>
                                    <tr>
                                    		<td align="right" width=""><a title="Click here to show Project" href="#" style="text-decoration: none" onClick="OnPopUp('Project')">Project</a></td>
                                            <td width="" colspan="4">
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td width="40%">
                                                            <gw:textbox id="txtProject_Cd" csstype="mandatory" readonly="true" styles='width:100%' />
                                                        </td>
                                                        <td width="60%">
                                                            <gw:textbox id="txtProject_Nm" csstype="mandatory" readonly="true" styles='width:100%' />
                                                        </td>
                                                        <td width="">
                                                            <gw:textbox id="txtProject_Pk" styles='width:100%;display:none' />
                                                        </td>
                                                        <td>
                                                            <gw:imgbtn id="btve2" img="reset" alt="Reset" onclick="txtProject_Cd.text='';txtProject_Nm.text='';txtProject_Pk.text='';" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                    </tr>
                                   <tr>
                                        <td width="" align="right">Upper Level</td>
                                        <td width="" colspan="4">
                                                    <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td width="66%"><gw:textbox id="txtUpper_Level"  readonly="true" text="" styles="width:100%" /></td>
                                                                <td style="width:14%" align="right">Level&nbsp;</td>
                                                                <td style="width:20%"><gw:list id="lstLevel" text="" styles="width:100%" /></td>
                                                            </tr>
                                                    </table>
                                        </td>
                                   </tr> 
                                    <tr>
                                            <td  width="" align="right">Level Code</td>
                                            <td width="" colspan="4">
                                                    <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td width="70%"><gw:textbox id="txtLevel_Cd" csstype="mandatory" text="" styles="width:100%" /></td>
                                                                <td style="width:30%" align="right">Leaf Y/N</td>
                                                                <td ><gw:checkbox id="chkLeaf_YN" value="F" /></td>
                                                            </tr>
                                                    </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width:">Name</td>
                                            <td width="" colspan="4"><gw:textbox id="txtLevel_Nm" csstype="mandatory" styles="width:100%" /></td>
                                        </tr>
                                        <tr>
                                            <td  align="right" width="">Foreign Name</td>
                                            <td colspan="4" width="">
                                                <gw:textbox id="txtLevelF_Nm"   style="width:100%"  />
                                            </td> 
                                        </tr>
                                        <tr>
                                            <td  align="right" width="">Local Name</td>
                                            <td colspan="4" width="">
                                                <gw:textbox id="txtLevelL_Nm"   style="width:100%"  />
                                            </td> 
                                        </tr> 
                            </table>
                        </td>
                   </tr>     
                </table>
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------------->
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

</body>
</html>
