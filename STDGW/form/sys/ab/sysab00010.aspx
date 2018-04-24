<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Untitled Document</title>
</head>
<%  ESysLib.SetUser("esys")%>
<script>

var G1_Rownum=0,
	G1_pk=1,
	G1_User_Name=2,
	G1_Password=3,
	G1_dbuser_pwd_md5=4;
function BodyInit()
{
    dat_griddetail.Call("SELECT");
}
function OnAddnew()
{
	EnableButton(btnNew.id);
	txtAct.text = "INSERT";
	/*
    idgrid.AddRow();
	idgrid.SetGridText(idgrid.rows-1, G1_Rownum, idgrid.rows-1);
	/**/
}
function EnableButton(obj)
{
	var flag = (obj == "btnNew");
	btnNew.SetEnable(!flag);
	btnSave.SetEnable(flag);
	btnDelete.SetEnable(flag);
}

function OnSearch()
{
    dat_griddetail.Call("SELECT");
}
function OnDelete()
{
	if(txtUser.text == ""){alert("Please select user!");return false;}
	if ( confirm( "Do you want user "+idgrid.GetGridData(idgrid.row, G1_User_Name)+" to delete?" ) ) 
	{
		EnableButton(btnNew.id);
		txtAct.text = "DELETE";
		dso_sysab00010.Call();
		/*idgrid.DeleteRow();
		dat_griddetail.Call();*/
	}
}
function OnSave()
{	
    if(CheckData()==true)
    {
		dso_sysab00010.Call();
		//dat_griddetail.Call();
    }
}
function grid_ondblclick(){
	if(idgrid.row > 0){
		txtPK.text = idgrid.GetGridData(idgrid.row, G1_pk);
		txtUser.text = idgrid.GetGridData(idgrid.row, G1_User_Name);
		txtPass.text = idgrid.GetGridData(idgrid.row, G1_Password);
		EnableButton(btnNew.id);
		txtAct.text = "UPDATE";
	}
}
function CheckData()
{
	if(txtUser.text == ""){alert("Please input user name!"); return false;}
	if(txtPass.text == ""){alert("Please input password!"); return false;}
	return true;
	/*
    for(var i=1;i<idgrid.rows;i++)
          {
            if(idgrid.GetGridData(i,G1_User_Name) == "")
             {
                alert("Please input user name at row "+ i);
                
                return false;
             }
             if(idgrid.GetGridData(i,G1_Password) == "")
             {
                alert("Please input password at row "+i);
                return false;
             }
             
          }
          return true;
	*/
}
function CheckDuplicate()
{  
    var gr ;
    if(idgrid.rows > 2)
    {  
        //gr = idgrid.GetGridData(idgrid.rows-1, G1_User_Name);    
       for(var i = 1; i < idgrid.rows-1; i++)
        {
            if(idgrid.GetGridData(i, G1_User_Name).toLowerCase() == txtUser.text.toLowerCase())
            {
                alert('User '+idgrid.GetGridData(i, G1_User_Name)+' is already. Please check again!!!'+ '\n' +'    Tên '+idgrid.GetGridData(i, G1_User_Name)+' này đã tồn tại. Yêu cầu kiểm tra lại!!!');             
                return false ;
            }
        }
    }    
    return true;  
}

function OnDataReceive(obj){
	switch (obj.id){
		case "dso_sysab00010":
			txtUser.text = "";
			txtPass.text = "";
			txtPK.text = "";
			txtAct.text = "INSERT";
			dat_griddetail.Call("SELECT");
		break;
		case "dat_griddetail":
			EnableButton("btnSearch1");
		break;
	}
}
</script>
<body>
<gw:data id="dso_sysab00010" onreceive="OnDataReceive(this)"> 
	<xml> 
		<dso  type="process" procedure="esys.sp_upd_sysab00010" > 
			<input> 
				 <input bind="txtAct" />
				 <input bind="txtPK" /> 
				 <input bind="txtPK" /> 
				 <input bind="txtUser" /> 
				 <input bind="txtPass" />
				 <input bind="txtmd5" />
			</input>
			<output>
				<output bind="txtPK" /> 
			</output>
		 </dso> 
	</xml> 
</gw:data>
<gw:data id="dat_griddetail"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4" function="esys.sp_sel_sysab00010" procedure=""   > 
            <input bind="idgrid">                    
                <input bind="txtUser" /> 
            </input> 
            <output bind="idgrid"></output>
        </dso> 
    </xml> 
</gw:data>
<!----------------------------------------------------------------------------------------------->
    <table style="width: 100%; height: 100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="width: 100%; height: 5%">
            <td width="100%">
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>
                            <table border="0" width="100%" id="table1">
                                <tr>
                                    <td>
                                        <fieldset style="padding: 2; width: 100%; height: 100%">
                                            <table border="0" width="100%" id="table2">
                                                <tr>
													<td width="25%"></td>
                                                    <td align="center" width="10%">User Name:</td>
                                                    <td width="15%">
                                                        <gw:textbox id="txtAct" styles='display:none'  />
														<gw:textbox id="txtPK" styles='display:none'  />
														<gw:textbox id="txtmd5" styles='display:none'  />
														<gw:textbox id="txtUser" styles='width:100%' onenterkey="OnSearch()" />
                                                    <td align="center" width="10%">Password :</td>
													<td width="15%">
														<gw:textbox id="txtPass" styles='width:100%' passwd="true" />
													</td>
													<td>
                                                        <gw:imgbtn id="btnSearch1" img="search" width="100%" img="in" text="Search" onclick="OnSearch()" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="btnNew" img="new" width="100%" img="in" text="Add New" onclick="OnAddnew()" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="btnSave" img="save" width="100%" img="in" text="Save" onclick="OnSave()" />
                                                    </td>
                                                    <td>
                                                        <gw:imgbtn id="btnDelete" img="delete" width="100%" img="in" text="Process" onclick="OnDelete()" />
                                                    </td>
                                                    <td width="25%"></td>
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
        <tr style="width: 100%; height: 95%">
            <td width="100%">
                <table align="top" cellspacing="0" cellpadding="0" border="0" style="width: 100%;
                    height: 100%;">
                    <tr valign="top">
                        <td width="100%">
                            
                            <gw:grid id="idgrid" header="No|_pk|User Name|_Password|Pasword"
                                format="0|0|0|0|0" aligns="0|0|0|0|0" defaults="||||" editcol="0|0|0|0|0"
                                widths="1000|0|600|1500|2000" 
								styles="width:100%; height:100%" autosize="T"
                                sorting="F"  onafteredit="" autosize="T" onclick="grid_ondblclick();";/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <gw:textbox id="txt_pk"      style="display:none"/>
</body>
</html>
