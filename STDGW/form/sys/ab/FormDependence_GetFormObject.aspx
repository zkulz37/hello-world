<!-- #include file="../../../system/lib/form.inc"  -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

function BodyInit()
{
	 
	//grdMapping.GetGridControl().FrozenCols = 6;
	///chkActive.value = "-1";
	OnSearchObject();
}

function OnDataReceive(obj)
{
	lblObject.text = grdObjList.rows - 1 + " record(s)";
	return;
}

function OnSearchObject()
{
    OnFilterObjectChange();
    dsoObjectClientNotUseList.Call("SELECT");
}

function OnFilterObjectChange()
{
    if(lstObjKey.GetData() == "1")
    {
        txtObjID.text=txtFilterObj.text;
        txtObjName.text = "";
        txtFormUrl.text = "";
    }
    else if(lstObjKey.GetData() == "2")
    {
        txtObjID.text = "";
        txtObjName.text = txtFilterObj.text;
        txtFormUrl.text = "";
    }
    else if(lstObjKey.GetData() == "3")
    {
        txtObjID.text = "";
        txtObjName.text = "";
        txtFormUrl.text = txtFilterObj.text;
    }
    else
    {
        txtObjID.text = "";
        txtObjName.text = "";
        txtFormUrl.text = "";
    }
}

function OnSelectObject()
{
	var code_data=new Array();
	var ctrl = grdObjList.GetGridControl();
	if(ctrl.SelectedRows == 0)
	{
	   alert("Please Select an Item.");
	   return ;
	}
	else
	{
		//Form ULR
		code_data[0] = grdObjList.GetGridData( ctrl.row , 5 );
		window.returnValue = code_data;
		this.close();
	}
	return;
}



</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>

<gw:data id="dsoObjectClientNotUseList"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="grid" function="gasp.SP_SEL_CLIENT_OBJ_NOT_USED"  > 
            <input bind="grdObjList"  > 
                <input bind="txtClientDB" />
				<input bind="txtObjID" /> 
                <input bind="txtObjName" /> 	
                 <input bind="txtFormUrl" /> 
            </input> 
            <output bind="grdObjList" /> 
        </dso> 
    </xml> 
</gw:data> 




    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="150">&nbsp;</td>
        <td width="130"  align="center">Filter Key </td>
        <td width="400"><gw:list id="lstObjKey" value="1"  styles="width:100%" onchange="OnFilterObjectChange()">
			            <data>DATA|1|Object ID|2|Object Name|3|Form URL</data>
                    </gw:list></td>
        <td width="100"  align="center">Value</td>
        <td width="400"><gw:textbox id="txtFilterObj" styles="width:100%" onenterkey="OnSearchObject()"  /></td>
        <td width="2%"><gw:imgBtn id="btnSearchObj" img="search" alt="Search" onclick="OnSearchObject()" /></td>
        <td width="5%">&nbsp;</td>
        <td width="15%"><gw:label id="lblObject" /></td>
        <td width="6%">&nbsp;</td>
        <td width="6%">&nbsp;</td>
      </tr>
      <tr>
        <td height="440" colspan="10">
			<gw:grid   
					    id="grdObjList"  
					    header="_PK|Object ID|Object Name|Local Name|Menu ID|Form URL"
					    format="0|0|0|0|0|0"  
					    aligns="0|0|0|0|0|0"  
					    defaults="|||||"  
					    editcol="0|0|0|0|0|0"  
					    widths="0|1500|2500|2500|1500|3000"  
					    styles="width:100%; height:100%"   
					    sorting="T"   
					    param="0,1,2,3,4,5" acceptNullDate="true"  oncelldblclick="OnSelectObject()" />
		</td>
      </tr>
	  <tr>
        <td colspan="10"></td>
      </tr>
    </table>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
<gw:textbox id="txtObjID"  text="" styles="display:none" />
<gw:textbox id="txtObjName"  text="" styles="display:none" />
<gw:textbox id="txtClientDB" text="<%=Session("APP_DBUSER")%>" styles="display:none" />
<gw:textbox id="txtFormUrl" text="" styles="display:none" />
</html>
