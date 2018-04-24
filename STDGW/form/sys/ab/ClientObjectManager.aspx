<!-- #include file="../../../system/lib/form.inc"  -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script language="JavaScript" src="../../../lib/md5.js"></script>

<script>

function BodyInit()
{
    ClearForm();
    OnSearchClient();
    ShowInfo();
	txt_PK.text = "-1";
    
}

/*
// Kiem tra du lieu tai cot [row] co trung lap ko
//Input : obj : Luoi can kiem tra; row : cot can kiem tra
// Return : 0: Khong trung; >0 : co trung; -1 : errors
*/

function CheckDupplicateData(obj,col )
{
    if(col < 0)
        return -1;
    if(obj.Rows <= 1)
        return 0;
    var tmp = obj.GetGridControl();
    for(i=1; i<obj.rows; i++)
    {
        if(txtClientID.text.toUpperCase() == tmp.TextMatrix(i , col)&& txt_PK.text == "")
        {
            lb = ("Duplicate data at row : " + i + "; column : " + col + "; with value : " + tmp.TextMatrix(i , col));
            lb= lb + "\n" + "Dữ liệu bị trùng tại dòng : " + i + "; cột : " + col + "; với giá trị : " + tmp.TextMatrix(i , col)
            alert(lb)
            return i;
        }
    }
    return 0;
}

function ClearForm()
{
    txtClientID.text = "";
    txtClientName.text = "";
    txtClientLName.text = "";
    txtClientFName.text = "";
    txtClientAddress.text = "";
    txtClientPhone.text = "";
    txtClientFax.text = "";
    txtClientDescription.text = "";
	txtClientPass.text = "";
	txtClientPassCon.text = ""
	txt_PK.text = "-1";
    return;
}

function OnSearchClient()
{
    dsoSearchClient.Call("SELECT");
}

function OnDataReceive(obj)
{
    
    if(obj.id == "dsoSearchClient")
    {
        ShowInfo();
    }
}

function CheckValidClientData()
{
	if(txt_PK.text == "-2")
    {
        //alert("Some information invalid.\nMột số thông tin không được nhập đúng");
        //dsoSearchClient.Call("SELECT");
        return true;
    }
    if(CheckDupplicateData(grdClientList,1) != 0)// trung Cloient ID
        return false;
    if(txtClientID.text == "")// ID
    {
        alert("Client ID can't null.\nClient ID Không thể trống");
        return false;
    }
    if(txtClientName.text == "")// ID
    {
        alert("Client Name can't null.\nClient Name Không thể trống");
        return false;
    }
	if(txtClientPass.text == "" )// ID
    {
        alert("Password can't null.\nMật khẩu Không thể trống");
        return false;
    }
	if(txtClientPass.text != txtClientPassCon.text)// ID
    {
        alert("Wrong Confirm password.\nXác nhận mật khẩu ko đúng");
        return false;
    }
    return true;
}

function OnAddNewClient()
{
    ClearForm();
	txt_PK.text = "";		
}

function OnDeleteClient()
{
    var tmpctrl = grdClientList.GetGridControl();
    for(i=1; i<grdClientList.rows;i++)
    {
        if (tmpctrl.IsSelected(i)) 
        {
            grdClientList.DeleteRowAt(i)
        }
    }
	ClearForm();
	txt_PK.text = "-2";
}

function OnSaveAllChanges_Client()
{
	if(txt_PK.text == "-1")
		return;
    if(CheckValidClientData()== false) 
    {
        //alert("Some information invalid.\nMột số thông tin không được nhập đúng");
        //dsoSearchClient.Call("SELECT");
        return;
    }
    else
    {
		SetInfo();
		ClearForm();
		dsoSearchClient.Call();
        alert("All changes has been saved.\nThay đổi đã được cập nhật");
    }
        
}

function OnSelectClient()
{
	var rowindex = grdClientList.selrow;
	var mapCtrl = grdClientList.GetGridControl();
	//alert(mapCtrl.TextMatrix(rowindex,1));
	txtClientID.text = mapCtrl.TextMatrix(rowindex,1);
    txtClientName.text = mapCtrl.TextMatrix(rowindex,2);
    txtClientLName.text = mapCtrl.TextMatrix(rowindex,3);
    txtClientFName.text = mapCtrl.TextMatrix(rowindex,4);
    txtClientAddress.text = mapCtrl.TextMatrix(rowindex,5);
    txtClientPhone.text = mapCtrl.TextMatrix(rowindex,6);
    txtClientFax.text = mapCtrl.TextMatrix(rowindex,7);
    txtClientDescription.text = mapCtrl.TextMatrix(rowindex,8);
	txt_PK.text = mapCtrl.TextMatrix(rowindex,0);
	txtClientPass.text = mapCtrl.TextMatrix(rowindex,10);
	txtClientPassCon.text = mapCtrl.TextMatrix(rowindex,10);
}

function ShowInfo()
{
    lblClient.text = grdClientList.rows - 1 + " record(s)";
}


function SetInfo()
{	
	if(txt_PK.text == "-1" ) // ko biet lam gi
	{
		return;
	}
	if(txt_PK.text == "") // adneww
	{
		grdClientList.AddRow();
		var tmp = grdClientList.GetGridControl();
		tmp.TextMatrix(grdClientList.rows - 1,1) = txtClientID.text;
		tmp.TextMatrix(grdClientList.rows - 1,2) = txtClientName.text;
		tmp.TextMatrix(grdClientList.rows - 1,3) = txtClientLName.text;
		tmp.TextMatrix(grdClientList.rows - 1,4) = txtClientFName.text;
		tmp.TextMatrix(grdClientList.rows - 1,5) = txtClientAddress.text;
		tmp.TextMatrix(grdClientList.rows - 1,6) = txtClientPhone.text;
		tmp.TextMatrix(grdClientList.rows - 1,7) = txtClientFax.text;
		tmp.TextMatrix(grdClientList.rows - 1,8) = txtClientDescription.text;
		
		tmp.TextMatrix(grdClientList.rows - 1,10) = b64_md5(txtClientPass.text);		
	}
	if(txt_PK.text > "0") //update
	{
		var tmp = grdClientList.GetGridControl();
		for(i=1; i<grdClientList.rows; i++)
		{
			if(tmp.TextMatrix(i , 0)== txt_PK.text)// PK
			{
				//mapCtrl.TextMatrix(i,1) = txtClientID.text;
				tmp.TextMatrix(i,2) = txtClientName.text;
				tmp.TextMatrix(i,3) = txtClientLName.text;
				tmp.TextMatrix(i,4) = txtClientFName.text;
				tmp.TextMatrix(i,5) = txtClientAddress.text;
				tmp.TextMatrix(i,6) = txtClientPhone.text;
				tmp.TextMatrix(i,7) = txtClientFax.text;
				tmp.TextMatrix(i,8) = txtClientDescription.text;
				
				if(tmp.TextMatrix(i,10) != txtClientPass.text)
					tmp.TextMatrix(i,10) = b64_md5(txtClientPass.text);	
				
				//alert(tmp.TextMatrix(i,-1));
				//tmp.SetRowStatus(i,32);
				tmp.TextMatrix( i , tmp.cols -1   ) = 16;
				return;
			}
		}
	}
	else
		return;
	
}
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Client manager</title>
</head>
<body>

<gw:data id="dsoSearchClient"  onreceive="OnDataReceive(this)">
    <xml>
        <dso type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10"  function="ESYS.SP_SEL_CLIENT_SEARCH"  procedure="ESYS.SP_UDP_CLIENT_MANAGER" >
            <input bind="grdClientList"  > 
				<input bind="txtClientID" /> 
                <input bind="txtClientName" /> 	
                <input bind="txtClientLName" /> 	
                <input bind="txtClientFName" /> 	
                <input bind="txtClientAddress" /> 	
                <input bind="txtClientPhone" /> 	
                <input bind="txtClientFax" /> 	
                <input bind="txtClientDescription" /> 	
            </input> 
            <output bind="grdClientList" />
        </dso>
    </xml>
</gw:data>

    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td >&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td width="20%"><gw:label id="lblClient" /> </td>
        <td width="10%"><gw:icon id="idBtnClear" img="in" text="Clear" onclick="ClearForm()" /></td>
        <td width="4%"><gw:imgBtn id="idBtnSearch" img="search" alt="Search client" text="Save" onclick="OnSearchClient()"/></td>
        <td width="4%"><gw:imgBtn id="idBtnNew" img="new" alt="Add new client" text="New" onclick="OnAddNewClient()" /></td>
        <td  width="4%"><gw:imgBtn id="idBtnDelete" img="delete" alt="Delete selected client" text="Delete" onclick="OnDeleteClient()"/></td>
        <td  width="4%"><gw:imgBtn id="idBtnSave" img="save" alt="Updae selected client" text="Update" onclick="OnSaveAllChanges_Client()"/></td>
      </tr>
      <tr>
        <td height="5">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="2%">&nbsp;</td>
        <td width="13%">Client ID </td>
        <td width="34%"><gw:textbox id="txtClientID" styles="width:30%" csstype="mandatory" onenterkey="OnSearchClient()"  /></td>
        <td width="2%"></td>
        <td width="10%">Address</td>
        <td width="39%"><gw:textbox id="txtClientAddress" styles="width:100%" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Client Name </td>
        <td><gw:textbox id="txtClientName" styles="width:100%" onenterkey="OnSearchClient()"  /></td>
        <td>&nbsp;</td>
        <td>Phone </td>
        <td><gw:textbox id="txtClientPhone" styles="width:50%" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Local Name </td>
        <td><gw:textbox id="txtClientLName" styles="width:100%" /></td>
        <td>&nbsp;</td>
        <td>Fax  </td>
        <td><gw:textbox id="txtClientFax" styles="width:50%" /></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>Foreign Name </td>
        <td><gw:textbox id="txtClientFName" styles="width:100%" /></td>
        <td>&nbsp;</td>
        <td>Description</td>
        <td><gw:textbox id="txtClientDescription" styles="width:100%" /></td>
      </tr>
	  <tr>
        <td>&nbsp;</td>
        <td>Password</td>
        <td><gw:textbox id="txtClientPass" styles="width:100%" passwd='T' csstype="mandatory" onenterkey="" /></td>
        <td>&nbsp;</td>
        <td>Confirm pass</td>
        <td><gw:textbox id="txtClientPassCon"  passwd='T'  styles="width:100%" csstype="mandatory" onenterkey="" /></td>
      </tr>
      <tr>
        <td height="10">&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
    </table>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="320"><gw:grid   
					    id="grdClientList"               
					    header="_PK|Client ID|Client Name|Local Name|Foreign Name|Address|Phone|Fax|Description|Use|_password"
					    format="0|0|0|0|0|0|0|0|0|3|0"  
					    aligns="0|0|0|0|0|0|0|0|0|0|0"  
					    defaults="|||||||||1|"  
					    editcol="0|0|0|0|0|0|0|0|0|1|1"  
					    widths="0|1500|2500|2500|2500|2500|1500|1500|2500|500|0"  
					    styles="width:100%; height:100%"   
					    sorting="T"   
					    param="0,1,2,3,4,5,6,7,8,9,10" onSelChange="OnSelectClient()" OnClick=""  /> 
		</td>
      </tr>
    </table>
	<gw:textbox id="txt_PK" text="" styles="display:none" />
</body>
</html>
