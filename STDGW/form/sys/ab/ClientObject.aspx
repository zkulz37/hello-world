<!-- #include file="../../../system/lib/form.inc"  -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

function BodyInit()
{
	 
	//grdMapping.GetGridControl().FrozenCols = 6;
	///chkActive.value = "-1";
	OnSearchClient();
}

function OnFilterClientChange()
{
    if(lstClientKey.GetData() == "1")
    {
        txtClientID.text=txtFilterClient.text;
        txtClientName.text = "";
    }
    else if(lstClientKey.GetData() == "2")
    {
        txtClientID.text = "";
        txtClientName.text = txtFilterClient.text;
    }
    else
    {
        txtClientID.text = "";
        txtClientName.text = "";
    }
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


function OnSearchClient()
{    
    OnFilterClientChange();
    txtClientPK.text = "";
    grdObjList.ClearData();
    grdClientObjList.ClearData();
    //grdClientList.Refresh();
    dsoClientList.Call("SELECT");
}

function SelectClientList()
{
    if(grdClientList.rows <= 1)
        return;
    if(txtClientPK.text == grdClientList.GetGridData(grdClientList.row,0))
        return;
    txtClientPK.text = grdClientList.GetGridData(grdClientList.row,0);
    OnSearchObject();
}


function OnSearchObject()
{
    OnFilterObjectChange();
    if(txtClientPK.text == "")
    {
        alert("Client not selected\nThông tin Client chưa được chọn");
        return;
    }
    dsoObjectClientNotUseList.Call("SELECT");
}



function OnAddNewClientObjectRow()
{
    var objCtrl = grdObjList.GetGridControl();
	var mapCtrl = grdClientObjList.GetGridControl();
	var cln_pk;
    cln_pk = txtClientPK.text;
    
    if(cln_pk == "")
    {
        alert("Unknown Client or not selected\nClient chưa được chọn")
        return;
    }
    else
    {
        if(objCtrl.SelectedRows <= 0)
        {
            alert("Object not selected\nObject chưa được chọn")
            return;
        }
        else
        {
            for(i=objCtrl.Rows-1; i>=0; i--)//i=objCtrl.Rows-1; i>0; i--
            {
                if (objCtrl.IsSelected(i)) 
                {
                    grdClientObjList.AddRow();
                    //grdObjList : _PK|Object ID|Object Name|Local Name|Menu ID|Form URL  
					//grdClientObjList : "_PK|Object ID|Object Name|Local Name|Menu ID|Form URL|Description|Used|obj_pk|cln_pk"
					mapCtrl.TextMatrix(mapCtrl.Rows-1 , 1) = objCtrl.TextMatrix(i,1); //Object ID
					mapCtrl.TextMatrix(mapCtrl.Rows-1 , 2) = objCtrl.TextMatrix(i,2); //Object Name			
					mapCtrl.TextMatrix(mapCtrl.Rows-1 , 3) =  objCtrl.TextMatrix(i,3);//Local Name
					mapCtrl.TextMatrix(mapCtrl.Rows-1 , 4) =  objCtrl.TextMatrix(i,4);//Menu ID
					mapCtrl.TextMatrix(mapCtrl.Rows-1 , 5) =  objCtrl.TextMatrix(i,5)	//Form URL  
					mapCtrl.TextMatrix(mapCtrl.Rows-1 , 7) =  1;	//Used
					mapCtrl.TextMatrix(mapCtrl.Rows-1 , 8) =  objCtrl.TextMatrix(i,0);	//obj_pk
					mapCtrl.TextMatrix(mapCtrl.Rows-1 , 9) =  cln_pk;	//cln_pk
					
					objCtrl.RemoveItem(i);
					ShowInfo()
                }
            }
        }
    }
}

function OnRemoveClientObjectRow() 
{
	var objCtrl = grdObjList.GetGridControl();
	var mapCtrl = grdClientObjList.GetGridControl();
	var cln_pk;
    cln_pk = txtClientPK.text;
	var i = 0;

	//get selected row
	if (mapCtrl.SelectedRows >0) 
	{
		for (i=mapCtrl.Rows-1;i>0;i--) 
		{
			//Add row to mapping grid
			if (mapCtrl.IsSelected(i)) 
			{
				grdObjList.AddRow();
                //grdObjList : _PK|Object ID|Object Name|Local Name|Menu ID|Form URL  
				//grdClientObjList : "_PK|Object ID|Object Name|Local Name|Menu ID|Form URL|Description|Used|obj_pk|cln_pk"
				objCtrl.TextMatrix(objCtrl.Rows-1,1) = mapCtrl.TextMatrix(i , 1); //Object ID
				objCtrl.TextMatrix(objCtrl.Rows-1,2) = mapCtrl.TextMatrix(i , 2); //Object Name			
				objCtrl.TextMatrix(objCtrl.Rows-1,3) = mapCtrl.TextMatrix(i , 3); //Local Name
				objCtrl.TextMatrix(objCtrl.Rows-1,4) = mapCtrl.TextMatrix(i , 4);//Menu ID
				objCtrl.TextMatrix(objCtrl.Rows-1,5) = mapCtrl.TextMatrix(i , 5); //Form URL  
				objCtrl.TextMatrix(objCtrl.Rows-1,0) = mapCtrl.TextMatrix(i , 8);	//obj_pk
				
				grdClientObjList.DeleteRowAt(i)//RemoveItem(i);
			}
		}
	} 
	else 
	{
		alert ("Please select Client Object for removing.\nChọn ít nhất một dòng để xóa.");			
	}
	ShowInfo();
}

function OnUnRemoveClientObjectRow() 
{
	var objCtrl = grdObjList.GetGridControl();
	var mapCtrl = grdClientObjList.GetGridControl();
	var cln_pk;
	var i = 0;
    var j = 0;
	//get selected row
	if (mapCtrl.SelectedRows >0) 
	{
		for (i=mapCtrl.Rows-1;i>0;i--) 
		{
			//Add row to mapping grid
			if (mapCtrl.IsSelected(i)) 
			{
				for (j=objCtrl.Rows-1;j>0;j--) 
				{
					if (objCtrl.TextMatrix(j,0) == mapCtrl.TextMatrix(i , 8) ) 
					{
						objCtrl.RemoveItem(j);  //obj pk				
					}
				}
				grdClientObjList.UnDeleteRowAt(i)//RemoveItem(i);
			}
		}
	} 
	else 
	{
		alert ("Please select deleted ObjectRole for unRemoving.");
	}
}

function OnSavecClientObjectList()
{
    lblStatus.text = "Checking data ...";
	if(grdClientObjList.rows == 1)
    {
        alert("No data to process\nChưa có dữ liệu để cập nhật");
		lblStatus.text = "";
		return;
    }
	//CheckDupplicateData()
	else if(CheckDupplicateData(grdClientObjList,1) != 0 || CheckDupplicateData(grdClientObjList,4) != 0 || CheckDupplicateData(grdClientObjList,5) != 0) // bi trung
	{
		lblStatus.text = "";
		return;
	}
	else
    {
		lblStatus.text = "Start saving ...";
        if(!confirm("Are you sure Update all changes ?\nBạn có muốn cập nhật lại thay đổi không ?"))
		{
			lblStatus.text = "";
            return;
		}
        dsoObjectClientUsedList.Call();
		lblStatus.text = "Finished.";
        alert("Successfull update\nCập nhật thành công");
    }
}


function OnDataReceive(obj)
{
	lblStatus.text = "";
    if(obj.id == "dsoClientList")
    {
        ShowInfo();
    }
    else if(obj.id == "dsoObjectClientNotUseList")
    {
       dsoObjectClientUsedList.Call("SELECT");
       ShowInfo();
    }
    else if(obj.id == "dsoObjectClientUsedList")
    {
       ShowInfo();
    }
    else
    {
        ShowInfo();
        return;
    }
}

function ShowInfo()
{
    lblClient.text = grdClientList.rows - 1 + " record(s)"
    lblObject.text = grdObjList.rows - 1 + " record(s)"
    lblClientObject.text = grdClientObjList.rows - 1 + " record(s)"
}

function ShowClientManager()
{
    var strcom;
    var fpath = System.RootURL + "/form/sys/ab/ClientObjectManager.aspx";
    //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:50;dialogHeight:31;dialogLeft:5;dialogTop:30;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
        //txtUpperDept.text=obj;
        //datDeptData.Call();
        return;    
    }
    OnSearchClient();
    
}

function CheckDupplicateData(obj,col )
{
    if(col < 0)
        return -1; // khong trung
    if(obj.Rows <= 1)
        return 0; // khong trung
    var tmp = obj.GetGridControl();
    for(i=1; i<obj.rows; i++)
    {
        for( j = i+1; j<obj.rows; j++)
		{
			if(tmp.TextMatrix(i , col) == tmp.TextMatrix(j , col))
			{
				lb = ("Duplicate data at row : " + j + " with value : " + tmp.TextMatrix(j , col));
				lb= lb + "\n" + "Dữ liệu bị trùng tại dòng : " + j +  " với giá trị : " + tmp.TextMatrix(j , col)
				alert(lb)
				return i;
			}
		}
    }
    return 0; // khong trung
}

</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Client Objects Manager</title>
</head>
<body>

<gw:data id="dsoClientList"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="grid" function="esys.sp_sel_client_list"  > 
            <input bind="grdClientList"  > 
				<input bind="txtClientID" /> 
                <input bind="txtClientName" /> 	
            </input> 
            <output bind="grdClientList" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoObjectClientNotUseList"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="grid" function="esys.SP_SEL_CLIENT_OBJ_NOT_USED"  > 
            <input bind="grdObjList"  > 
                <input bind="txtClientPK" />
				<input bind="txtObjID" /> 
                <input bind="txtObjName" /> 	
                 <input bind="txtFormUrl" /> 
            </input> 
            <output bind="grdObjList" /> 
        </dso> 
    </xml> 
</gw:data> 

<gw:data id="dsoObjectClientUsedList"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso type="grid" parameter="0,6,7,8,9" function="esys.SP_SEL_CLIENT_OBJ_USED"  procedure="ESYS.SP_UPD_CLIENT_OBJ_LIST" > 
            <input bind="grdClientObjList"  > 
                <input bind="txtClientPK" />
            </input> 
            <output bind="grdClientObjList" /> 
        </dso> 
    </xml> 
</gw:data> 





<table width="100%" border="1" cellspacing="1" cellpadding="1">
  <tr>
    <td height="90%" style="width: 40%">
    <table width="100%" height="30%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="9%" height="20%">Filter key</td>
        <td style="width: 12%">
            <gw:list id="lstClientKey" value="A" onchange="OnFilterClientChange()">
			            <data>DATA|1|Client ID|2|Client Name</data>
                    </gw:list>
        </td>
        <td width="5%">Value</td>
        <td width="15%"><gw:textbox id="txtFilterClient" styles="width:100%" /></td>
        <td width="5%"><gw:imgBtn id="btnSearchClient" img="search" alt="Search" onclick="OnSearchClient()" /></td>
        <td width="5%"><gw:imgBtn id="btnClientMan" img="popup" alt="Client Manager" onclick="ShowClientManager()" /></td>
        <td width="15%"><gw:label id="lblClient" /> </td>
      </tr>
      <tr>
        <td height="30%" colspan="7">
            <gw:grid   
					    id="grdClientList"  
					    header="_PK|Client ID|Client Name|Address|Phone|Fax|Description"
					    format="0|0|0|0|0|0|0"  
					    aligns="0|0|0|0|0|0|0"  
					    defaults="||||||"  
					    editcol="0|0|0|0|0|0|0"  
					    widths="0|1500|2500|2500|2000|2000|2500"  
					    styles="width:100%; height:250"   
					    sorting="T"   
					    param="0,1,2,3,4,5,6" onSelChange="SelectClientList()" OnClick="SelectClientList()"  /> 
        </td>
      </tr>
    </table>
      <table width="100%" height="30%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="9%" height="20%">Filter key</td>
        <td style="width: 12%">
            <gw:list id="lstObjKey" value="A" onchange="OnFilterObjectChange()">
			            <data>DATA|1|Object ID|2|Object Name|3|Form URL</data>
                    </gw:list>
        </td>
        <td width="5%">Value</td>
        <td width="15%"><gw:textbox id="txtFilterObj" styles="width:100%" /></td>
        <td width="5%"><gw:imgBtn id="btnSearchObj" img="search" alt="Search" onclick="OnSearchObject()" /></td>
        <td width="5%"><gw:imgBtn id="btnAddObj" img="auto" alt="Add selected object to used list" onclick="OnAddNewClientObjectRow()" /></td>
        <td width="15%"><gw:label id="lblObject" /> </td>
      </tr>
      <tr>
        <td height="30%" colspan="7">
            <gw:grid   
					    id="grdObjList"  
					    header="_PK|Object ID|Object Name|Local Name|Menu ID|Form URL"
					    format="0|0|0|0|0|0"  
					    aligns="0|0|0|0|0|0"  
					    defaults="|||||"  
					    editcol="0|0|0|0|0|0"  
					    widths="0|1500|2500|2500|1500|3000"  
					    styles="width:100%; height:250"   
					    sorting="T"   
					    param="0,1,2,3,4,5" acceptNullDate="true"  oncelldblclick="OnAddNewClientObjectRow()" /> 
        </td>
      </tr>
    </table></td>
    <td width="60%">
    <table width="100%" height="10%" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="11%" height="23">&nbsp;</td>
        <td width="47%"><gw:label id="lblClientObject" /> </td>
		<td width="11%"><gw:label id="lblStatus" /></td>
        <td width="5%"><gw:imgBtn id="idBtnSave" img="save" alt="Save" text="Save" onclick="OnSavecClientObjectList()"/></td>
        <td width="5%"><gw:imgBtn id="idDelete" img="delete" alt="Remove" text="Delete" onclick="OnRemoveClientObjectRow()"/> </td>				
        <td width="5%"><gw:imgBtn id="idUDelete" img="udelete" alt="UnRemove" text="UnDelete" onclick="OnUnRemoveClientObjectRow()"/></td>
      </tr>
      <tr>
        <td height="90%" colspan="6">
            <gw:grid   
					    id="grdClientObjList"  
					    header="_PK|Object ID|Object Name|Local Name|Menu ID|Form URL|Description|Used|_obj_pk|_cln_pk"
					    format="0|0|0|0|0|0|0|3|0|0"  
					    aligns="0|0|0|0|0|0|0|0|0|0"  
					    defaults="|||||||||"
					    editcol="0|0|0|0|0|0|1|1|0|0"  
					    widths="0|1500|2500|2500|1500|3000|3000|0|0|0"
					    styles="width:100%;  height:500"   
					    sorting="T"   
					    param="0,1,2,3,4,5,6,7,8,9" acceptNullDate="true" oncelldblclick="" />
        </td>
      </tr>
    </table></td>
  </tr>
</table> 
<gw:textbox id="txtClientID"  text="" styles="display:none" />
<gw:textbox id="txtClientName"  text="" styles="display:none" />
<gw:textbox id="txtObjID"  text="" styles="display:none" />
<gw:textbox id="txtObjName"  text="" styles="display:none" />
<gw:textbox id="txtClientPK" text="" styles="display:none" />
<gw:textbox id="txtFormUrl" text="" styles="display:none" />
</body>
</html>
