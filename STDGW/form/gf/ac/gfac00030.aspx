<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
 <%ESysLib.SetUser("acnt")%>
 
<script type="text/javascript" language="javascript">
var flag = 0;
var g_select = false;
var AdminYN;
AdminYN  ="<%=Session("CODEADMIN_YN")%>";

function BodyInit()
{
    System.Translate(document); 
    dso_upd_Item.StatusInsert();
    BindingDataList();
    OnSearch();
    if (AdminYN == 'Y')
    {
        ibtnAdd.SetEnable(true);
        ibtnUpdate.SetEnable(true);
        ibtnDelete.SetEnable(true);
    }
    else
    {
        ibtnAdd.SetEnable(false);
        ibtnUpdate.SetEnable(false);
        ibtnDelete.SetEnable(false);
    }
    txtItemName.GetControl().focus();
}
//------------------------------------------------------------------------------------------

function BindingDataList()
{ 
    var ls_data     = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0050','','') FROM DUAL")%>";
    var ls_data1    = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0180','01','') FROM DUAL")%>";
    var ls_data2    = "<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('ACAB0190','','') FROM DUAL")%>";
    
    lst_INType.SetDataText(ls_data);
    lst_ItemType.SetDataText(ls_data1);
    lst_DataType.SetDataText(ls_data2);
}
//------------------------------------------------------------------------------------------

function OnSearch()
{
   /* if (dso_upd_Item.GetStatus() != 10)
    {
        dso_upd_Item.StatusInsert();
    }  */      
    dso_sel_item.Call("SELECT");
}
//------------------------------------------------------------------------------------------

function OnClick()
{
    if (idGrid.selrow == -1)
    {
        return;
    }
    if ((idGrid.rows > 1) && (idGrid.selrow < idGrid.rows))
	{
        var ctrl_idGrid = idGrid.GetGridControl();
        txt_PK.text = idGrid.GetGridData(idGrid.selrow, 0);
        txt_ItemNM.SetEnable(false);
        g_select = true;
 //       g_delete = false;
        dso_upd_Item.Call("SELECT");
    }
}
//------------------------------------------------------------------------------------------

function InTypeChange()
{
    if(lst_INType.GetData() != "T")
    {
        txt_SQLText.SetData("");
        txt_SQLText.SetReadOnly(true);
    }
    else
    {
        txt_SQLText.SetReadOnly(false);
    }
    if (!g_select)
    {
        if (txt_PK.GetData() == "")
        {
            if (dso_upd_Item.GetStatus() != 20)
            {
                dso_upd_Item.StatusInsert();
            }
        }
        else
        {
            //dso_upd_Item.StatusUpdate();
        }
    }
}
//------------------------------------------------------------------------------------------

function OnNew()
{
    flag = '1';
    g_select = false;
    dso_upd_Item.StatusInsert();
    txt_ItemNM.SetEnable(true);
    txt_ItemNM.GetControl().focus();
}
//------------------------------------------------------------------------------------------

function OnSave()
{
    if (CheckData())
    {
        g_select = false;
        if (dso_upd_Item.GetStatus() == 20)
        {
            
            dso_pro_item_dup.Call();
        }
        else
        {
        flag='1';
            dso_upd_Item.Call();
        }
    }
}
//------------------------------------------------------------------------------------------

function OnDelete()
{
    var ctrl 	= idGrid.GetGridControl();
	var rownum  = ctrl.Rows - 1;
	
	if (txt_PK.GetData() == '') 
	{
	    alert('Please Select Item to delete!!!'+'\n'+'Yêu cầu chọn Item cần xóa!!!');
	    return;
	}
    else
    {    
	    if (confirm('Are you sure you want to delete (' + txt_ItemNM.text + ') item?' +'\n'+ '    Bạn có chắc muốn xóa Item này?'))
	    { 
	        flag='1';
	        dso_pro_item_exist.Call();
	    }
	}
}
//------------------------------------------------------------------------------------------

function CheckData()
{
   if(lst_INType.GetData() == "T")
   {
	   if(Trim(txt_SQLText.GetData())=="" )
	   {
		  alert('  Please input SQL text!'+'\n'+'Bạn hãy nhập câu SQL text!');
		  txt_SQLText.GetControl().focus();
		  return false;
	   }
	}
   if(txt_ItemNM.GetData() == "")
   {
		alert('You must input Item Name!'+'\n'+'Bạn hãy nhập Item Name!');
		txt_ItemNM.GetControl().focus();
		return false;
   } 
   return true;
}
//------------------------------------------------------------------------------------------

function Upcase()
{
    var c = String.fromCharCode (event.keyCode); 
	var x = c.toUpperCase().charCodeAt(0) ; 
	event.keyCode = x; 
}
//------------------------------------------------------------------------------------------

function OnCheck_Dup()
{
    if (Number(txt_dupPK.text) == 0)
    {
        txt_ItemNM.SetEnable(false);
        dso_upd_Item.Call();
    }         
    else
    {
        alert('Item name ('+ txt_ItemNM.GetData()+ ') is existed. Please check again!!!'+ '\n' +'   Tên Item này đã tồn tại. Yêu cầu kiểm tra lại!!!');
        return;
    }
}
//------------------------------------------------------------------------------------------

function Check_Item()
{
    var flag;
    flag = dso_upd_Item.GetStatus();
    if (!g_select)
    {
        if (Number(flag) == 10)
        {
            OnSearch();
        }
        else if (Number(flag) == 20)
        {
            txt_ItemNM.SetEnable(true);
            txt_ItemNM.GetControl().focus();
            OnSearch();
        }
        else if (Number(flag) == 40)
        {
            dso_upd_Item.StatusInsert();
            txt_ItemNM.SetEnable(true);
            txt_ItemNM.GetControl().focus();
            OnSearch();
        }
    }
    if(lst_INType.GetData() != "T")
    {
        txt_SQLText.SetReadOnly(true);
    }
    else
    {
        txt_SQLText.SetReadOnly(false);
    }
}
//------------------------------------------------------------------------------------------

function OnDataReceive(p_oData)
{
    switch(p_oData.id)
    {
        case "dso_upd_Item":
            Check_Item();
        break;

        case "dso_sel_item":
            
            InTypeChange();
            
        break;

        case "dso_pro_item_dup":
            OnCheck_Dup();
        break;

        case "dso_pro_item_exist":
             DeleteItem();
        break;
    }
}
//------------------------------------------------------------------------------------------

function DeleteItem()
{
    if (Number(txt_exist1.GetData()) > 0)
    {
        alert('  You must delete Item Code in form Item Entry frist!!!'+'\n'+'Bạn phải xóa Item ở form Account Code Entry trước!!!');
        return;
    }
    else 
    {
        if (Number(txt_exist2.GetData()) > 0)
        {
            alert('You must delete Item Code in form Item Code Entry frist!!!'+'\n'+'       Bạn phải xóa Item ở form Item Code Entry!!!');
            return;
        }
        else
        {
            g_select = false;
            dso_upd_Item.StatusDelete();
            dso_upd_Item.Call("");
        }
    }
}
//------------------------------------------------------------------------------------------

function Upcase()
{
    var c = String.fromCharCode (event.keyCode);
	var x = c.toUpperCase().charCodeAt(0);
	event.keyCode = x;
}
//------------------------------------------------------------------------------------------
function OnSelect()
{
   var obj=new Array();
    obj[0]=flag;
    
    if (idGrid.row >0)
    {
        obj[1] = idGrid.GetGridData(idGrid.row, 0);
    }
    else
        obj[1]=0;
    
	window.returnValue = obj; 
	window.close();
}

</script>
<body style="margin:0; padding:0;">

    <gw:data id="dso_sel_item" onreceive="OnDataReceive(this)" >
        <xml>
            <dso type="grid" parameter="0" function="acnt.SP_SEL_ITEMNAME">
                <input bind="idGrid" >
                    <input bind="txtItemName"/>
                </input>
                <output bind="idGrid" />
            </dso>
        </xml>
    </gw:data>
   
    <gw:data id="dso_upd_Item" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="control" parameter="0,1,2,3,4,5,6,7,8,9,10" function="acnt.SP_SEL_DETAIL_ITEMNAME" procedure = "acnt.SP_UDP_ITEM_ENTRY"> 
            <inout> 
                <inout bind="txt_PK"/>
                <inout bind="txt_ItemNM" />
                <inout bind="txt_ItemLNM" />
                <inout bind="lst_INType" />
                <inout bind="lst_ItemType" />
                <inout bind="lst_DataType" />
                <inout bind="rd_EXPItem" />
                <inout bind="rd_AutoPost" />
                <inout bind="txt_SQLText" />
                <inout bind="txt_Remark" />
                <inout bind="rd_EditItem" />
            </inout>
            </dso> 
        </xml> 
    </gw:data> 
    
    <gw:data id="dso_pro_item_dup"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="process" procedure="ACNT.SP_PRO_ITEM_DUPLICATE" > 
                <input> 
                     <input  bind="txt_ItemNM"/>
                </input>  
                <output>  
                     <output  bind="txt_dupPK"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    
    <gw:data id="dso_pro_item_exist"  onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="process" procedure="ACNT.SP_PRO_ITEM_EXIST" > 
                <input> 
                     <input  bind="txt_PK"/>
                </input>  
                <output>  
                     <output  bind="txt_exist1"/>
                     <output  bind="txt_exist2"/>
               </output> 
            </dso> 
        </xml> 
    </gw:data>
    

<table  width="100%" cellpadding="0" cellspacing="0" border="1">
	<tr>
		<td width="45%">
						
						<table id="LeftTopTB" height="20">
							<tr>
								<td width="30%">Item name</td>
								<td width="50%"><gw:textbox id="txtItemName" csstype="filter" onenterkey="OnSearch()" onkeypress="Upcase()"/> &nbsp;</td>
								<td width="20%"><gw:imgBtn id="ibtnSelect" img="search" onclick="OnSearch()" /> </td>
								
							</tr>
						</table>
		</td>
		<td width="55%">
					
				<table width="100%" id="RightTopTB" height="20" border="0">
					<tr>
						<td width="90%"></td>
						<td><gw:imgBtn img="select"     id="select" 	   styles='width:100%'	onclick="OnSelect()" /></td>	
						<td><gw:imgBtn img="new"     id="ibtnAdd" 	   styles='width:100%'	onclick="OnNew()" /></td>					
						<td><gw:imgBtn img="save"    id="ibtnUpdate"   styles='width:100%'	onclick="OnSave()" /></td>
						<td><gw:imgBtn img="delete"  id="ibtnDelete"   styles='width:100%'  onclick="OnDelete()" /></td>  
					</tr>							
				</table>
					
		</td>
	</tr>
	<tr>
		<td width="45%">
			<table id="LeftBottomTB" width="100%" valign="top">
				<tr>
					<td> 
						<gw:grid   
							id="idGrid"  
							header="_PK|Item Name(Eng)|Item Name(Local)"   
							format="0|0|0"  
							aligns="0|0|0"  
							defaults="||"  
							editcol="0|0|0"  
							widths="0|2500|1500"  
							styles="width:100%; height:450"   
							sorting="T"   
							param="0,1,2" onclick ="OnClick()" /> 
					</td>
				</tr>
			</table>
		</td>
		<td width="55%" align="center">
						
						<table id="RightBottomTB" width="100%" height="100%" align="center" >
							<tr>
								<td > <!-- Detail Grid Control here --> </td>
							</tr>
							<tr align="center">
								<td width="30%" align="right">Item Name</td>
								<td width="70%">
									<table width="100%">
										<tr>
											<td width="100%">
												<gw:textbox id="txt_ItemNM" maxlen="30" text="" styles='width:60%' onkeypress ="Upcase()" csstype = 'mandatory' />
											</td>
										</tr>
									</table>
									
								</td>
							</tr>
							<tr>
								<td width="30%" align="right">Item Name(Local)</td>
								<td width="70%">
									<table width="100%">
										<tr>
											<td width="100%">
												<gw:textbox id="txt_ItemLNM" maxlen="30" styles='width:60%'/> 
											</td>
										</tr>
									</table>
									
								</td>
							</tr>
							<tr>
								<td width="30%" align="right">Input Type</td>
								<td width="70%">
									<table width="100%">
										<tr>
											<td width="100%">
												<gw:list id="lst_INType" styles='width:60%' onchange="InTypeChange()"></gw:list >
											</td>
										</tr>
									</table>
								 </td>
							</tr>
							<tr>
								<td width="30%" align="right">Item Type</td>
								<td width="70%">
									<table width="100%" ID="Table1">
										<tr>
											<td width="100%">
												<gw:list id="lst_ItemType" styles='width:60%' onchange="InTypeChange()"> 
												</gw:list >
											</td>
										</tr>
									</table>
								 </td>
							</tr>
							<tr>
								<td width="30%" align="right">Data Type</td>
								<td width="70%">
									<table width="100%" >
										<tr>
											<td width="100%">
												<gw:list id="lst_DataType" styles='width:60%' onchange="InTypeChange()"> 
												</gw:list >
											</td>
										</tr>
									</table>
								 </td>
							</tr>
							<tr>
								<!--
								<td width="30%" align="right" visible="true">Disbursement Yes/No</td>
								-->
								<td width="70%" colspan="4">
									<table>
										<tr>
											<td>
												<gw:radio id="rd_EXPItem" value="1" style='display:none'> 
												<span value="Y" >YES</span>
												<span value="N" >NO</span>
												</gw:radio >
											</td>
										</tr>
									</table>
								</td>
							</tr>
																					
							<tr>
							<!--
								<td width="30%" align="right" visible="true">AutoPost</td>
								-->
								<td width="70%" colspan="4">
									<table>
										<tr>
											<td>
												<gw:radio id="rd_AutoPost" value="1" style='display:none'> 
												<span value="N" >No Use</span>
												<span value="Y" >Use</span>
												</gw:radio >
											</td>
										</tr>
									</table>
								</td>
							</tr>
                            
                            <tr>
								<td width="30%" align="right">Edit Yes/No</b></font></td>
								<td width="70%" colspan="4">
									<table>
										<tr>
											<td>
												<gw:radio id="rd_EditItem" value="N" > 
												<span value="Y" >YES</span>
												<span value="N" >NO</span>
												</gw:radio >
											</td>
										</tr>
									</table>
								</td>
							</tr>

							<tr>
								<td width="30%" align="right">SQL Text</td>																								
								<td width="70%"><gw:textarea id="txt_SQLText" styles="width:100%;height:180;"></gw:textarea></td>
							</tr>
							<tr>
								<td width="30%" align="right">Description</td>																																
								<td width="70%"><gw:textbox id="txt_Remark" maxlen="100" styles="width:100%"></gw:textbox></td>
							</tr>
																
						</table>
			<!-- End of Table2 -->
		</td>		
    </tr>
</table>

<gw:textbox id="txt_PK"         style="display:none"/> 
<gw:textbox id="txt_dupPK"      style="display:none"/> 
<gw:textbox id="txt_exist1"     style="display:none"/> 
<gw:textbox id="txt_exist2"     style="display:none"/> 

</body>
</html>