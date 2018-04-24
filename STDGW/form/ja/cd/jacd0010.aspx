<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Caddy Entry</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>

var G1_PK               = 0,
    G1_ID       = 1,
    G1_Name         = 2,
    G1_LName      = 3;
var Insert   = 'F';
 var Modify   = 'F';
 var Delete = 'F';
//-----------------------------------------------------------------------------------------
function BodyInit()
{   
    SetDisable();
    //data_jacd0010_1.StatusInsert();
    //----------------------------------------
    OnSearch();
    //----------------------------------------
    grdCaddy_Eva.SetComboFormat(4, '#10;Excellence|#20;Good|#30;Satisfaction|#40;Average|#50;Poor');
    grdCaddy_Eva_Monthly.SetComboFormat(3, '#10;Excellence|#20;Good|#30;Satisfaction|#40;Average|#50;Poor');
    var data="DATA|10|Available|20|Bussy|30|Day off"; 
    lstStatus.SetDataText(data);
    lstStatus.value=10;
}
function SetDisable()
{
    txtbirthday.SetEnable(false);
    //txtID.SetEnable(false);
    txtName.SetEnable(false);
    txtLName.SetEnable(false);
    txtbirthday.SetEnable(false);
    txtGender.SetEnable(false);
}
//-----------------------------------------------------------------------------------------
function onClick()
{      
    txtMasterPK.SetDataText(grdCaddy.GetGridData(grdCaddy.row, G1_PK));
   // alert(txtMasterPK.text);
     
    data_jacd0010_1.StatusSelect();
    //idTab_Child.SetPage(0);
    Tab_search_1_lan=true;
    data_jacd0010_1.Call('SELECT');
    
}
//-----------------------------------------------------------------------------------------
function OnSearch()
{
    data_jacd0010.Call('SELECT');
}
//-----------------------------------------------------------------------------------------
function OnNew(obj)
{
    switch (obj.id)
    {
        case 'btnAddNewM' :
             var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
             var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
            if (obj!=null)
            {
                data_jacd0010_1.StatusInsert();
                checkActive.value ="Y";
                //imgItem.SetDataText(txtItemPhotoPK.text);
                txtEmp_PK.text=obj[0];//pk NV
                //txtID.text=obj[1];// MA NV
                txtName.text=obj[2]; // Ten
                txtLName.text=obj[8]; //Ten
                txtbirthday.text=obj[25] ;//Ngay sinh
                txtGender.text=obj[26] ;//Gioi Tinh
                txtPhone.text=obj[27]; //Dien thoai
                //idTab_Child.SetPage(0);
                grdCaddy_Eva.ClearData();
                grdCaddy_Eva_Monthly.ClearData();
            }
        break;
        case 'btnAddNew2' :
             if(txtMasterPK.text!="")
             {
                grdCaddy_Eva_Monthly.AddRow();
                SetPKToGridMonthly(txtMasterPK.text); 
             }
             
        break;
        case 'btnAddNew1' :
             if(txtMasterPK.text!="")
             {
                Tab_search_1_lan=false;
                grdCaddy_Eva.AddRow();
                SetMasterPKToGrid(txtMasterPK.text);
             }
        break;
    }     
}
//-----------------------------------------------------------------------------------------
function OnDelete(obj)
{
    switch (obj.id)
        {
            case 'btnDeleteM' :
                 if (confirm("Are you sure delete ?") == true )
                    {
                        data_jacd0010_1.StatusDelete();
                        data_jacd0010_1.Call();
                        Delete='T';
                    }
            break;
            case 'btnDeleteD1' :
                if (confirm("Are you sure delete ?") == true )
                    {
                         grdCaddy_Eva.DeleteRow();
                         dso_caddy_eva.Call();
                    }
            break;
            case 'btnDeleteD2' :
                    if (confirm("Are you sure delete ?") == true )
                    {
                         grdCaddy_Eva_Monthly.DeleteRow();
                         //dso_caddy_eva_monthly.Call();
                    }
            break;
        }     
}
//-----------------------------------------------------------------------------------------
function OnSave(obj)
{   
        switch (obj.id)
        {
            case 'btnSave' :
                if(CheckDataIsValid())
                {
                     txtItemPhotoPK.SetDataText(imgItem.oid);
                     Insert='T';
                     data_jacd0010_1.Call();  
                 }
            break;
            case 'btnSaveD' :
                dso_caddy_eva.Call();
            break;
            case 'btnSaveD1' :
                 Tab_search_1_lan=true;
                 //dso_caddy_eva_monthly.Call();
            break;
        }     
}
function CheckDataIsValid()
{
    if(txtID.text == "")
    {
        alert("Please input caddy number.");
        return false;
    }
    
    if(txtName.text == "")
    {
        alert("Please input caddy name.");
        return false;
    }
    
    return true;
}
function SetMasterPKToGrid(p_masterPK){
    for(var i=0;i<grdCaddy_Eva.rows;i++){
        if(grdCaddy_Eva.GetGridData(i,5) == ""){
            grdCaddy_Eva.SetGridText(i,5,p_masterPK);
        }
    }
}
function SetPKToGridMonthly(p_masterPK){
    for(var i=0;i<grdCaddy_Eva_Monthly.rows;i++){
        if(grdCaddy_Eva_Monthly.GetGridData(i,1) == ""){
            grdCaddy_Eva_Monthly.SetGridText(i,1,p_masterPK);
        }
    }
}
//-----------------------------------------------------------------------------------------
var flag_daily_save =false;
function OnRece(obj)
{
	switch(obj.id)
	{
		case 'data_jacd0010_1':			
			imgItem.SetDataText(txtItemPhotoPK.text);
			if(Insert=="T" || Delete=="T") 
			{
				if(Insert=="T")  
				{
					   data_jacd0010.Call('SELECT'); 
					   Insert="F"; 
				}
				else
				{
					data_jacd0010.Call('SELECT');
					Delete="F";
				} 
			}
			else
			{
				//dso_caddy_eva_monthly.Call('SELECT');
				Insert="F";
			}   
		break;
		case 'data_jacd0010':
			lbRecord.text = grdCaddy.rows-1 + ' record(s)';
		break;
	}
}
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
 var Tab_search_1_lan=true;
function OnchangeTab()
{ 
    if(idTab_Child.GetCurrentPageNo()==1 && Tab_search_1_lan == true)
    {
        grdCaddy_Eva.ClearData();
        dso_caddy_eva.Call("SELECT");
    }
}
function OnPopup()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
             var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
            if (obj!=null)
            {
                //checkActive.value ="Y";
                txtEmp_PK.text=obj[0];//pk NV
                txtEmployeeID.text=obj[1]; // Emp.ID
                txtName.text=obj[2]; // Ten
                txtLName.text=obj[8]; //Ten
                txtbirthday.text=obj[25] ;//Ngay sinh
                txtGender.text=obj[26] ;//Gioi Tinh
                txtPhone.text=obj[27]; //Dien thoai
                //idTab_Child.SetPage(0);
            }    
}
//-----------------------------------------------------------------------------------------

</script>

<body>
    <!---------------------------------------------------------------------------------->
    <gw:data id="data_jacd0010" onreceive="OnRece(this)">
        <xml> 
            <dso id="1" type="grid" function="crm.sp_sel_jacd0010" > 
                <input bind="grdCaddy" >
                    <input bind="txtCName" />
                    <input bind="chkActiveYN" />    
                    <input bind="chkPART_TIME_YN" /> 
                </input>
                <output bind="grdCaddy" />
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------------------------------------->
    <gw:data id="data_jacd0010_1" onreceive="OnRece(this)"> 
        <xml>
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="crm.sp_sel_jacd0010_1" procedure="CRM.SP_upd_jacd0010_1" >
                <input>
                    <inout  bind="txtMasterPK" />
                    <inout  bind="txtID" /> 
                    <inout  bind="txtName" /> 
                    <inout  bind="txtLName" /> 
                    <inout  bind="txtbirthday" /> 
                    <inout  bind="txtGender" /> 
                    <inout  bind="txtExpYear" /> 
                    <inout  bind="txtPhone" />
                    <inout  bind="txtItemPhotoPK" />
                    <inout  bind="checkParttime" />
                    <inout  bind="checkActive" />
                    <inout  bind="txtDec" />
                    <inout  bind="txtEmp_PK" />
                    <inout  bind="lstStatus" />
                    <inout  bind="txtEmployeeID" />
                    <inout  bind="dtResignDate" />
                </input>
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------------------------------>
    <table style="background: #BDE9FF; height: 100%; width: 100%">
        <tr>
            <td style="background: white; width: 30%" id="idLEFT">
                <table style="height: 100%; width: 100%">
                   <tr style="height: 1%"></tr>
                    <tr style="height: 1%">
                        <td style="width: 24%" align="right">
                            Active</td>
                        <td style="white-space: nowrap;width:5%"  >
                            <gw:checkbox id="chkActiveYN"  defaultvalue="Y|N" value="Y" />
                        </td>
                        <td style="width: 50%" align="right">
                            Part time</td>
                        <td style="white-space: nowrap;width:5%" colspan="1"  >
                            <gw:checkbox id="chkPART_TIME_YN"  defaultvalue="Y|N" value="N" />
                        </td>
                        <td style="width: 15%">
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td >
                            Caddy</td>
                        <td  colspan ="2" >
                            <gw:textbox id="txtCName" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                        <td align="right" colspan="3" >
                            <b style="color: Blue; cursor: hand">
                                <gw:label id="lbRecord">record(s)</gw:label>
                            </b>
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="6">
                            <gw:grid id="grdCaddy" header='_pk|Caddy No|Full Name|Full Lname'
                                format='0|0|0|0' aligns='0|0|0|0' defaults='|||'
                                editcol='0|0|0|0' widths='0|1500|2000|2000' autosize="T"
                                sorting='T'  styles="width:100%;height:100%" 
                                oncellclick="onClick()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="background: white; width: 70%" id="idRIGHT">
                <table style="height: 100%; width: 100%" border="0">
                    <tr style="height: 1%">
                        <td style="width: 60%" align="right">
                        </td>
                        <td style="width: 40%">
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 97%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnAddNewM" img="new" alt="New" onclick="OnNew(this)" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDeleteM" img="delete" alt="Delete" onclick="OnDelete(this)" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave(this)" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 7%" valign="top">
                        <td colspan="2">
                            <fieldset>
                                <legend></legend>
                                <table id="PersionalID" style="height: 100%; width: 100%">
                                    <tr style="height: 7%" valign="top">
                                        <td style="width: 80%" align="right">
                                            <table style="height: 100%; width: 100%">
                                                <tr style="height: 1%;">
                                                    <td style="width: 15%; white-space: nowrap" align="right">
                                                        Caddy No</td>
                                                    <td style="width: 56%">
                                                        <gw:textbox id="txtID" styles="width: 100%" /> 
                                                    </td>
                                                    <td style="width: 10%" align="right">
                                                        <a title="Click here to select Requester" onclick="OnPopup()" href="#tips"
                                                          style="text-decoration: none"; color="#0000ff"><b>Emp.ID</b></a></td>
                                                    <td style="width: 21%; white-space: nowrap">
                                                         <gw:textbox id="txtEmployeeID" readonly="T" styles="width: 100%" /> 
                                                    </td>
                                                </tr>
                                                <tr style="height: 1%;">
                                                    <td style="width: 20%; white-space: nowrap" align="right">    
                                                        Caddy Name</td>
                                                    <td style="width: 47%" colspan="3">
                                                       <gw:textbox id="txtName" styles="width: 100%" /> 
                                                    </td>
                                                </tr>
                                                <tr style="height: 1%;">
                                                    <td style="width: 20%; white-space: nowrap" align="right">
                                                       Caddy LName</td>
                                                    <td style="width: 47%" colspan="3">
                                                        <gw:textbox id="txtLName" styles="width: 100%" />
                                                    </td>
                                                </tr>  
                                                <tr style="height: 1%;">
                                                    <td style="width: 20%; white-space: nowrap" align="right">
                                                       </td>
                                                    <td style="width: 47%">
                                                        <gw:checkbox id="checkActive"  defaultvalue="Y|N" value="Y" style="width: 10%" />Active
                                                    </td>
                                                    <td style="width: 10%" align="right">
                                                        <gw:checkbox id="checkParttime"  defaultvalue="Y|N" value="Y" /></td>
                                                    <td style="width: 23%; white-space: nowrap">
                                                        Part Time
                                                    </td>
                                                </tr>
                                                <tr style="height: 1%;"> 
                                                    <td colspan="4"> 
                                                        <table style="height: 100%; width: 100%">
                                                            <tr style="height: 1%;">
                                                                <td style="width: 20%; white-space: nowrap" align="right">
                                                                    Birthday</td>
                                                                <td style="width: 40%">
                                                                    <gw:textbox id="txtbirthday" styles="width: 100%"  />
                                                                </td>
                                                                <td style="width: 10%" align="right">
                                                                     Gender</td>
                                                                <td style="width: 30%; white-space: nowrap">
                                                                    <gw:textbox id="txtGender" styles="width: 100%"  />
                                                                </td>
                                                            </tr>
                                                            <tr style="height: 1%;">
                                                                <td style="width: 20%; white-space: nowrap" align="right">
                                                                    Experience</td>
                                                                <td>
                                                                    <gw:textbox id="txtExpYear" styles="width: 100%" type="number" format="#,###" />
                                                                </td>
                                                                <td style="white-space: nowrap" align="right">
                                                                    Phone</td>
                                                                <td>
                                                                    <gw:textbox id="txtPhone" styles="width: 100%" /> 
                                                                </td>
                                                            </tr>
                                                            <tr style="height: 1%;">
                                                                <td style="width: 20%; white-space: nowrap" align="right">
                                                                    Resign Date</td> 
                                                                <td style="width: 40%">
                                                                    <gw:datebox id="dtResignDate" nullaccept="T" styles='width:100%'lang="1"/>
                                                                </td>
                                                                <td style="width: 10%; white-space: nowrap" align="right">
                                                                    Status</td>
                                                                <td style="width: 30%">
                                                                    <gw:list id="lstStatus" styles='width:100%' />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width: 20%">
                                            <gw:image id="imgItem" table_name="CRM.TGM_MEMBERPHOTO" procedure="CRM.SP_UPD_TGM_MEMBERPHOTO" styles="width:98%;height:100%" style='border:1px solid #1379AC' view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" style='border: 1px solid #1379AC' />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 1%;">
                            <td colspan="3">
                            <table style="height: 100%; width: 100%">
                            <tr>
                                <td style="width: 18%; white-space: nowrap" align='center'>
                                       Description</td>
                                    <td style="width: 82%" colspan="2">
                                        <gw:textarea rows="5" id="txtDec" styles="width: 100%" />
                                    </td>
                            </tr>
                            </table>
                            </td>
                    </tr>
					<tr style="height: 92%;"></tr>
                </table>
            </td>
        </tr>
    </table>
    <!---------------------------------------------------------------------->
    <img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif"
        style="cursor: hand; position: absolute; left: 1; top: 0;" onclick="OnToggle()" />    
    
    <gw:textbox id="txtMasterPK" styles="display:none" />
    <gw:textbox id="txtItemPhotoPK" styles="display:none" />
    
    <gw:textbox id="txtCaddy_Eva" styles="display:none" />
    <gw:textbox id="txtEmp_PK" styles="display:none" />
	
	 <gw:grid id="grdCaddy_Eva" header='_pk|Caddy No|Full Name|Full Lname'
		format='0|0|0|0' aligns='0|0|0|0' defaults='|||'
		editcol='0|0|0|0' widths='0|1500|2000|2000' autosize="T"
		sorting='T'  styles="display:none" 
		oncellclick="onClick()" />
		<gw:grid id="grdCaddy_Eva_Monthly" header='_pk|Caddy No|Full Name|Full Lname'
		format='0|0|0|0' aligns='0|0|0|0' defaults='|||'
		editcol='0|0|0|0' widths='0|1500|2000|2000' autosize="T"
		sorting='T'  styles="display:none" 
		oncellclick="onClick()" />
    <!---------------------------------------------------------------------->
</body>
</html>
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  