<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
 
<script type="text/javascript" language="javascript">

function BodyInit()
{
    OnSearch();
}

function OnSearch()
{
    idGridD.ClearData();
    dso_search_item_code.Call("SELECT");
}

function OnRowClick_Master()
{
    if (idGridM.selrow == -1)
    {
        return;
    }
    if ((idGridM.rows > 1) && (idGridM.selrow < idGridM.rows))
	{
        var ctrl_idGrid = idGridM.GetGridControl();
        txt_MasterPK.text = idGridM.GetGridData(idGridM.selrow, 0);
        ctrl_idGrid.isSelected(idGridM.selrow)= true;
        dso_upd_item_code_entry.Call("SELECT");
    }
}

function OnNew()
{
    if (txt_MasterPK.text != '')
    {
        idGridD.AddRow();
    }
    else
    {
        alert('Please, Click item name first then add New'+'\n'+'Bạn hãy chọn tên Item trước sau đó ấn New');
    }
}

function OnCheck_Detail()
{
    for(var i=1; i<idGridD.rows; i++)
    {
        if(idGridD.GetGridData(i,2)== "")
        {
            alert('      Code in row ' + i + ' not null!!!'+'\n'+'Code ở hàng '+ i + ' không được rỗng!!!');
            return false;
        }
        else
        {
            var data = idGridD.GetGridData(i, 2);
            if(data.length > 10 )
	        {
		        alert('Data too large for column!!!'+'\n'+'Dữ liệu quá lớn!!!');
			    return false;
		    }
        }
        if(idGridD.GetGridData(i,3)== "")
        {
            alert('Sub Item Name in row ' + i + ' not null'+'\n'+'  Sub Item Name không được rỗng!!!');
            return false;
        }
        else
        {
            var data1 = idGridD.GetGridData(i, 3);
            if(data1.length > 30 )
	        {
		        alert('Data too large for column'+'\n'+'    Dữ liệu quá lớn!!!');
			    return false;
		    }
        }
        
        if(idGridD.GetGridData(i,4)== "")
        {
            alert('Sub Item Name Local in row ' + i + ' not null!!!'+'\n'+'  Sub Item Name Local không được rỗng!!!');
            return false;
        }
        else
        {
            var data2 = idGridD.GetGridData(i, 3);
            if(data2.length > 30 )
	        {
		        alert('Data too large for column'+'\n'+'  Dữ liệu quá lớn');
			    return false;
		    }
        }
    }
    if (!Check_Duplicate())
    {
        return false;
    }
    return true;
}

function Check_Duplicate()
{
    for(var i=1; i<idGridD.rows - 1; i++)
    {
        for(var j=i+1; j<idGridD.rows; j++)
        {
            if (idGridD.GetGridData(i,2) == idGridD.GetGridData(j,2))
            {
                alert('Value of ' + idGridD.GetGridData(i,2) + ' of Code in row ' + j + ' is duplicated!'+'\n'+'    Giá trị ' + idGridD.GetGridData(i,2) + ' của hàng ' + j + ' đã tồn tại!');
                return false;
            }
        }
    }
    return true;
}

function OnSave()
{
    if (!OnCheck_Detail())
    {
        return;
    }
    for(var i=1;i<idGridD.rows;i++)
    {
        if(idGridD.GetGridData(i,1)== "")
        {
            idGridD.SetGridText(i,1,txt_MasterPK.text);
        }
    }
    dso_upd_item_code_entry.Call();
}

function OnDelete()
{
    var ctrl = idGridD.GetGridControl();
	var n    = ctrl.rows;
	var row  = ctrl.row;
	
    if(n < 1)
	{
	   alert('Please Select Item Code to delete!!!'+'\n'+'Bạn hãy lựa chọn Item Code cần xóa!!!');
	   return;
	}
	else
	{   
	    if ( row < 0 ) 
		{
		    alert('Please Select Item Code to delete!!!'+'\n'+'Bạn hãy lựa chọn Item Code cần xóa!!!!');
		}
		else
		{
	        if(confirm('Are you sure you want to delete?'+'\n'+'Bạn có chắc muốn xóa Item này?'))
	        { 
	            idGridD.DeleteRow();
                dso_upd_item_code_entry.Call();
	        }
	    }
	}
}

</script>
<body>

    <gw:data id="dso_search_item_code" onreceive="" >
        <xml>
            <dso id="1" type="grid" parameter="0" function="acnt.SP_SEL_ITEM_CODE_ENTRY">
                <input bind="idGridM" >
                    <input bind="txt_ItemName"/>
                </input>
                <output bind="idGridM" />
            </dso>
        </xml>
    </gw:data>

    <gw:data id="dso_upd_item_code_entry" onreceive="" >
        <xml>
            <dso id="2" type="grid" parameter="0,1,2,3,4" function="acnt.SP_SEL_DETAIL_ITEMCODE_ENTRY" procedure="acnt.SP_UDP_ITEM_CODE_ENTRY">
                <input bind="idGridD" >
                    <input bind="txt_MasterPK"/>
                </input>
                <output bind="idGridD" />
            </dso>
        </xml>
    </gw:data>


<table  width="100%" cellpadding="0" cellspacing="0" border="1">
	<tr>
		<td width="25%">
			<table  id="LeftTopTB" height="20">
				<tr>
					<td width="35%" align="center"><font color=black ><b>Item name</b></font>&nbsp;</td>
					<td width="45%"><gw:textbox id="txt_ItemName"   csstype="filter" maxlen="30" onenterkey="OnSearch()"/></gw:textbox></td>					
					<td width="20%"><gw:imgBtn  id="ibtnSelect"     img="search"     onclick="OnSearch()" /> </td>  
											
				</tr>
			</table>
		</td>
		<td width="75%">
			<table id="RightTopTB" height="20">
				<tr>
					<td width="90%"></td>
					<td><gw:imgBtn id="btnAdd"      img="new"       alt="New"       onclick="OnNew()" /></td>
					<td><gw:imgBtn id="btnSave"     img="save"      alt="Save"      onclick="OnSave()" /></td>
					<td><gw:imgBtn id="btnDelete"   img="delete"    alt="Delete"    onclick="OnDelete()" /></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td width="35%">
			<table id="LeftBottomTB" width="100%" align="top">
				<tr>
					<td><gw:grid id="idGridM"  
						    header="_PK|Item Name(Eng)|Item Name(Local)"   
						    format="0|0|0"  
						    aligns="0|0|0"  
						    defaults="||"  
						    editcol="0|0|0"  
						    widths="0|2000|1500"  
						    styles="width:100%; height:450"   
						    sorting="T"   
						    param="0,1,2"
						    oncellclick="OnRowClick_Master()"/> 								
					</td>
				</tr>
			</table>						
		</td>
		<td width="65%">
			<table id="RightBottomTB" width="100%" height="100%"  align="top" >
				<tr>
					<td>
					    <gw:grid id="idGridD"
						    header="_PK|_TA_AGITEMD_PK|Code|SubItem Name|SubItem Name Local"
						    format="0|0|0|0|0"  
						    aligns="0|0|0|0|0"  
						    defaults="||||"  
						    editcol="0|0|1|1|1"  
						    widths="0|0|1500|3500|4000"
						    styles="width:100%; height:450"
						    sorting="T"
						    param="0,1,2,3,4"
						    />
					</td>
				</tr>
			</table>
		</td>
	</tr>	
</table>

<gw:textbox id="txt_MasterPK" styles="display:none" />

</body>
</html>