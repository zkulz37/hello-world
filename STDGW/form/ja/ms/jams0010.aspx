<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Caddy Entry</title>
</head>
<%  ESysLib.SetUser("crm")%>

<script>
 function BodyInit()
 {    
    //OnToggle(2);
    BindingDataList();
    data_Personal.StatusInsert();
 }
function BindingDataList()
{
    var data,dataMemberType,dataGender,dataNation;
    dataMemberType    = "<%=ESysLib.SetListDataSQL("SELECT PK, NAME FROM crm.tcm_member_type WHERE DEL_IF=0 and Type =10 and pk not in(8,9) ")%>";
    dataGender = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" )%>||";
	dataNation = "<%=ESysLib.SetListDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'" )%>||"; 
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT PK, NAME FROM crm.tcm_member_type WHERE DEL_IF=0 and Type =10 and pk in(2,3,4,8,9,92)") %> "; 
	grdAS_Member.SetComboFormat(3,data);
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'" ) %> "; 
	grdAS_Member.SetComboFormat(7,data);
	grdMemberS.SetComboFormat(2,data);
	data = "<%=ESysLib.SetGridColumnDataSQL("SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'" ) %> "; 
	grdAS_Member.SetComboFormat(12,data); 
	/*<%=ESysLib.SetGridColumnComboFormat("grdAS_Member" , 4, "SELECT PK, NAME FROM crm.tcm_member_type WHERE DEL_IF=0")%>;
	<%=ESysLib.SetGridColumnComboFormat("grdAS_Member" , 7, "SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='GEN'")%>;
	<%=ESysLib.SetGridColumnComboFormat("grdAS_Member" , 11, "SELECT CODE, NAME FROM  COMM.TCO_COMMCODE WHERE DEL_IF=0 AND PARENT_CODE='NAT'")%>;*/
	 var data = "data|1|Single|2|Family||";
     lstMaritalStatus.SetDataText(data); 
    lstMemberType.SetDataText(dataMemberType);
    lstMemberTypeS.SetDataText(dataMemberType);
    lstNationality.SetDataText(dataNation); 
    lstGender.SetDataText(dataGender);  
	OnSearch();
}
var flag='';
function OnToggle(obj)
{
    if (obj==1) //master
    {
        if(imgMaster.status == "expand")
        {           
            companyID.style.display="none";
            imgMaster.status = "collapse";
            imgMaster.src = "../../../system/images/down_orange.gif";
        }
        else
        {
            companyID.style.display="";
            imgMaster.status = "expand";
            imgMaster.src = "../../../system/images/up_orange.gif";
        }
    }
    if(obj==2)
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
}
function OnSearch()
{
    flag='select';
	data_jams0010.Call("SELECT");
}
function GridOnCellClick()
{
    if (grdMemberS.row > 0 )
        {
			txtMasterPK.text = grdMemberS.GetGridData(grdMemberS.row,0);
			flag = "";
            data_Personal.Call("SELECT");
        }
}
function OnNew(pos)
{
    switch (pos)
    {
        case 'Individual' :
            data_Personal.StatusInsert();
            imgItemPerson.SetDataText("");
            imgItem_AS_Member.SetDataText("");
            grdAS_Member.ClearData();
        break;
        case 'Corporate' :
            if(txtMasterPK.text !="")
            {
               grdAS_Member.AddRow();
               for(var i=1; i < grdAS_Member.rows;i++)
                {
                    if ( grdAS_Member.GetGridData( i, 2) == '' )
                    {
                        grdAS_Member.SetGridText( i,2 , grdAS_Member.rows-1);
                    }    
                }
                GetPK();
            }
			else
			{
				alert("Please,input information in master then save.after you can add new detail.");
			}
        break;
    }
} 
function GetPK()
{
    for(var i=0; i < grdAS_Member.rows;i++)
        {
            if ( grdAS_Member.GetGridData( i, 1) == '' )
            {
                grdAS_Member.SetGridText( i, 1, txtMasterPK.text);
            }    
        }
}
function validate()
{
	if(lstMemberType.value == '2' || lstMemberType.value == '3' || lstMemberType.value == '4')
	{
		if(txtCompanyNameCorp.text == "")
            {
                alert('Please, input company name.');
                 return false;
            }
	}
	return true;
}
function OnSave(pos)
{
    switch (pos)
    {
        case 'Personal' :
		/*
            if(lstMemberType.value != '1' && lstMemberType.value != '52')
            {
                txtPhotoIndividualPK.SetDataText("");
            }
            else
            {
                txtPhotoIndividualPK.text = imgItemPerson.oid;
            }
		*/	
			if (imgItemPerson.oid != '')
			{
				txtPhotoIndividualPK.text = imgItemPerson.oid;
			}
			
			if(validate())
			{
				flag='Save';
				data_Personal.Call();
			}
        break;
        case 'AS_Member' :
            txtPhotoCoporatePK.SetDataText(imgItem_AS_Member.oid);
            if(grdAS_Member.row > 0)
            { 
                grdAS_Member.SetGridText(grdAS_Member.row, 13, txtPhotoCoporatePK.text); 
            } 
            dat_AS_Member.Call();
        break;
    }
}
function OnDataReceive(obj)
{
  switch (obj.id)
    {
         case "data_Personal" :
           if(flag=='Save' || flag=='Delete')
            {
				OnSave("AS_Member");
            }
            else
            {
                imgItemPerson.SetDataText(txtPhotoIndividualPK.text);
                imgItem_AS_Member.SetDataText("");
                
                dat_AS_Member.Call("SELECT");
            }
			StatusControl();
         break;
         case "dat_AS_Member":
		    imgItemPerson.SetDataText(txtPhotoIndividualPK.text);
			imgItem_AS_Member.SetDataText("");
			if(flag=='Save' || flag=='Delete'){
				data_jams0010.Call("SELECT");
			}
		break;
         
    }
}  
function OnPicture()
{
   var picture_pk = grdAS_Member.GetGridData(grdAS_Member.row,13);
   imgItem_AS_Member.SetDataText(picture_pk); 
}
function StatusControl()
{
    if(lstMemberType.value == '2' || lstMemberType.value == '3' || lstMemberType.value == '4')
    { 
       document.all("tab_Company_information").style.display = "none";
    }
    else
    {
        document.all("tab_Company_information").style.display = "";
    }
}
function OnDelete(obj)
{
    switch (obj)
    {
        case 'Master' :
            if(txtMasterPK.text !="")
            {
                if(confirm('Are you sure you want to delete ?'))
	            {
                    flag='Delete';
                    data_Personal.StatusDelete();
                    data_Personal.Call();
                }
             }
        break;
        case 'Detail' :
            if(confirm('Are you sure you want to delete ?'))
	        {
                grdAS_Member.DeleteRow();
                dat_AS_Member.Call();
            }
            
        break;
    }
}
function OnAttachFile()
{
		var path	= System.RootURL + "/form/ja/ms/jams0010_PhotoPopup.aspx?member_pk=" + txtMasterPK.text;
        var object	= System.OpenModal( path ,775 , 400 ,  'resizable:yes;status:yes', this);
}
</script>

<body>
    <gw:data id="data_jams0010" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="grid" function="CRM.sp_sel_jams0010" >
                <input>
                    <input bind="lstMemberTypeS" /> 
                    <input bind="txtName" />
                </input>
                <output bind="grdMemberS" /> 
            </dso>
        </xml>
    </gw:data>
    <!------------------------------------------------------------->
    <gw:data id="data_Personal" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21" function="CRM.sp_sel_jams0010_1" procedure="crm.sp_upd_jams0010_1">
                <inout>
                    <inout bind="txtMasterPK" /> 
                    <inout bind="lstMemberType" />
                    <inout bind="txtMemberID" /> 
                    <inout bind="txtMemberName" />     
                    <inout bind="lstGender" /> 
                    <inout bind="txtPasspost" />                                        
                    <inout bind="lstNationality" />
                    <inout bind="txtMobile" />    
                    <inout bind="dtbirthday" />                    
                    <inout bind="txtHomeTel" />
                    <inout bind="lstMaritalStatus" />                    
                    <inout bind="txtHomeAddress" />
                    <inout bind="txtCompanyNameCorp" />       
                    <inout bind="txtNatureBusiness" />
                    <inout bind="txtBusinessAddress" />                    
                    <inout bind="txtEmailAddress" />                                        
                    <inout bind="txtBusinessTelCorp" />                    
                    <inout bind="txtFaxNo" />  
                    <inout bind="txtPhotoIndividualPK" />
                    <inout bind="chkActive" />
					<inout bind="dtValidFrom" />  
                    <inout bind="dtValidTo" />
                 </inout>
            </dso>
        </xml>
    </gw:data>
    <!---------------------------------------------------->
    <gw:data id="dat_AS_Member" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid"   parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" function="CRM.sp_sel_jams0010_2" procedure="CRM.sp_upd_jams0010_2"> 
            <input bind="grdAS_Member">                    
                <input bind="txtMasterPK" /> 
            </input> 
            <output bind="grdAS_Member" />
        </dso> 
    </xml> 
</gw:data>
    <!-------------------------->
    <gw:data id="dso_ShowPicture" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="crm.sp_sel_jams0010_2_showpicture" > 
                <input>
                  <input bind="txtShowPicture" />  
                </input> 
                <output>
                <output bind="txtPhotoCoporatePK" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
    <!---------------------------------------------------------------->
    <table style="background: #BDE9FF; height: 100%; width: 100%">
        <tr>
            <td style="background: white; width: 30%" id="idLEFT">
                <table style="height: 100%; width: 100%">
                    <tr style="height: 1%">
                    </tr>
                    <tr style="height: 1%">
                        <td style="width: 27%">
                            Member
                        </td>
                        <td style="width: 72%">
                            <gw:list id="lstMemberTypeS" styles='width:100%' onchange="OnSearch()" />
                        </td>
                        <td style="width: 1%">
                            <gw:imgbtn img="search" alt="Search" onclick="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 1%">
                        <td>
                            Name</td>
                        <td colspan="2">
                            <gw:textbox id="txtName" styles="width: 100%" onenterkey="OnSearch()" />
                        </td>
                    </tr>
                    <tr style="height: 97%">
                        <td colspan="6">
                            <gw:grid id="grdMemberS" header='_pk|Member Name/Company|Gender|ID' format='0|0|0|0'
                                aligns='0|0|0|0' defaults='|||' editcol='0|0|0|0' widths='0|1500|2000|2000' sorting='T'
                                styles="width:100%;height:100%" autosize="T" oncellclick="GridOnCellClick()" />
                        </td>
                    </tr>
                </table>
            </td>
            <td style="background: white; width: 70%" id="idRIGHT">
                <table style="height: 100%; width: 100%" border="0">
                    <tr style="height: 1%" valign="top">
                        <td style="width: 50%" align="right">
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 27%">
                                        Member Type
                                    </td>
                                    <td style="width: 40%">
                                        <gw:list id="lstMemberType" styles='width:100%' onchange="StatusControl()" />
                                    </td>
                                    <td style="width: 10%" align="right">
                                    </td>
                                    <td style="width: 23%; white-space: nowrap">
                                        <gw:icon id="ibtnPhoto" text="Attach File" img="in" styles="width:100%"
                                            onclick="OnAttachFile()" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td style="width: 50%">
                            <table style="height: 100%; width: 100%">
                                <tr>
                                    <td style="width: 97%">
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnAddNew" img="new" alt="New" onclick="OnNew('Individual')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnDelete" img="delete" alt="Delete" onclick="OnDelete('Master')" />
                                    </td>
                                    <td style="width: 1%">
                                        <gw:imgbtn id="btnSave" img="save" alt="Save" onclick="OnSave('Personal')" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="height: 7%" valign="top">
                        <td colspan="2">
                            <fieldset>
                                <legend>Personal information</legend>
                                <table id="tab_Company_information" style="height: 100%; width: 100%">
                                    <tr style="height: 7%" valign="top">
                                        <td style="width: 80%" align="right">
                                            <table style="height: 100%; width: 100%">
                                                <tr style="height: 1%;">
                                                    <td style="width: 20%; white-space: nowrap" align="right">
                                                        Member No</td>
                                                    <td style="width: 47%">
                                                        <gw:textbox id="txtMemberID" styles="width: 100%" />
                                                    </td>
                                                    <td style="width: 10%" align="right">
                                                        Nationality</td>
                                                    <td style="width: 23%; white-space: nowrap">
                                                        <gw:list id="lstNationality" styles='width:100%' />
                                                    </td>
                                                </tr>
                                                <tr style="height: 1%;">
                                                    <td style="width: 20%; white-space: nowrap" align="right">
                                                        Member Name</td>
                                                    <td style="width: 47%">
                                                        <gw:textbox id="txtMemberName" styles="width: 100%" />
                                                    </td>
                                                    <td style="width: 10%" align="right">
                                                        Gender</td>
                                                    <td style="width: 23%; white-space: nowrap">
                                                        <gw:list id="lstGender" styles='width:100%' />
                                                    </td>
                                                </tr>
                                                <tr style="height: 1%;">
                                                    <td style="width: 20%; white-space: nowrap" align="right">
                                                        Mobile Phone</td>
                                                    <td style="width: 47%">
                                                        <gw:textbox id="txtMobile" styles="width: 100%" />
                                                    </td>
                                                    <td style="width: 10%" align="right">
                                                        Marital Status</td>
                                                    <td style="width: 23%; white-space: nowrap">
                                                        <gw:list id="lstMaritalStatus" styles='width:100%' />
                                                    </td>
                                                </tr>
                                                <tr style="height: 1%;">
                                                    <td style="width: 20%; white-space: nowrap" align="right">
                                                        Passpost.No</td>
                                                    <td style="width: 47%">
                                                        <gw:textbox id="txtPasspost" styles="width: 100%" />
                                                    </td>
                                                    <td style="width: 10%" align="right">
                                                        Birthday</td>
                                                    <td style="width: 23%; white-space: nowrap">
                                                        <gw:datebox id="dtbirthday" maxlen="10" text="" styles='width:100%' lang="1" nullaccept="T"  />
                                                    </td>
                                                </tr>
                                                <tr style="height: 1%;">
                                                    <td colspan="4">
                                                        <table style="height: 100%; width: 100%">
                                                            <tr style="height: 1%;">
                                                                <td style="width: 20%; white-space: nowrap" align="right">
                                                                    Home Tel</td>
                                                                <td style="width: 47%">
                                                                    <gw:textbox id="txtHomeTel" styles="width: 100%" />
                                                                </td>
                                                                <td style="width: 10%" align="right">
                                                                    Active</td>
                                                                <td style="width: 23%; white-space: nowrap">
                                                                    <gw:checkbox id="chkActive" defaultvalue="Y|N" value="N" />
                                                                </td>
                                                            </tr>
                                                            <tr style="height: 1%;">
                                                                <td style="width: 20%; white-space: nowrap" align="right">
                                                                    Home Address</td>
                                                                <td style="width: 47%" colspan="3">
                                                                    <gw:textbox id="txtHomeAddress" styles="width: 100%" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width: 20%">
                                            <gw:image id="imgItemPerson" table_name="CRM.TGM_MEMBERPHOTO" procedure="CRM.SP_UPD_TGM_MEMBERPHOTO"
                                                styles="width:98%;height:130" style='border: 1px solid #1379AC' view="/binary/ViewFile.aspx"
                                                post="/binary/PostFile.aspx" style='border: 1px solid #1379AC' />
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr style="height: 30%" valign="top">
                        <td colspan="2">
                            <fieldset>
                                <legend>Company information</legend>
                                <table id="companyID" style="height: 100%; width: 100%" >
                                    <tr style="height: 7%" valign="top">
                                        <td style="width: 100%" align="right">
                                            <table style="height: 100%; width: 100%">
                                                <tr style="height: 1%;">
                                                    <td style="width: 20%; white-space: nowrap" align="right">
                                                        Company Name</td>
                                                    <td style="width: 40%">
                                                        <gw:textbox id="txtCompanyNameCorp" styles="width: 100%" />
                                                    </td>
                                                    <td style="width: 10%" align="right">
                                                        Nature Of Business</td>
                                                    <td style="width: 30%; white-space: nowrap">
                                                        <gw:textbox id="txtNatureBusiness" styles="width: 100%" />
                                                    </td>
                                                </tr>
                                                <tr style="height: 1%;">
                                                    <td style="width: 20%; white-space: nowrap" align="right">
                                                        Company Address</td>
                                                    <td style="width: 40%">
                                                        <gw:textbox id="txtBusinessAddress" styles="width: 100%" />
                                                    </td>
                                                    <td style="width: 10%" align="right">
                                                        Email</td>
                                                    <td style="width: 30%; white-space: nowrap">
                                                        <gw:textbox id="txtEmailAddress" styles="width: 100%" />
                                                    </td>
                                                </tr>
                                                <tr style="height: 1%;">
                                                    <td style="width: 20%; white-space: nowrap" align="right">
                                                        Business Tel</td>
                                                    <td style="width: 40%">
                                                        <gw:textbox id="txtBusinessTelCorp" styles="width: 100%" />
                                                    </td>
                                                    <td style="width: 10%" align="right">
                                                        Fax No</td>
                                                    <td style="width: 30%; white-space: nowrap">
                                                        <gw:textbox id="txtFaxNo" styles="width: 100%" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                                  <table style="height: 100%; width: 100%">
                                    <tr style="height: 1%;">
										<td style="width: 15%" align="right">  
											Valid From
                                        </td>
										<td style="width: 10%; white-space: nowrap">
                                             <gw:datebox id="dtValidFrom" maxlen="10" text=""  styles='width:100%' lang="1" />
                                          </td>
										  <td style="width: 15%" align="right">
											Valid To
                                        </td>
										<td style="width: 10%; white-space: nowrap">
                                             <gw:datebox id="dtValidTo" maxlen="10" text="" nullaccept="T" styles='width:100%' lang="1" />
                                          </td>
										  <td style="width: 41%" align="left">
                                            
                                        </td>
                                        <td style="width: 3%">
                                            <gw:imgbtn id="btnAddNewCop" img="new" alt="New" onclick="OnNew('Corporate')" />
                                        </td>
                                        <td style="width: 3%">
                                            <gw:imgbtn id="btnDeleteCop" img="delete" alt="Delete" onclick="OnDelete('Detail')" />
                                        </td>
                                        
                                    </tr>
                                </table>
                            
                        </td>
                    </tr>
                    <tr style="height: 61%" valign="top">
					  <td colspan=2>
							<table style="width: 100%; height: 100%" cellpadding=0 cellspacing=0 >
								<tr>
									<td style="width:90%;">
										<table width="100%" height="100%" border="1">
											<tr>
												<td style="width: 100%">
													<gw:grid id="grdAS_Member" header="_pk|_PARENT_PK|No|Member Type|Member Name|*Member No|PassPost/ID|Gender|Birthday|Mobile Phone|Telephone|Email|Nationality|_Photo_pk|Active|Valid From|Valid To"
														format="0|0|0|0|0|0|0|0|4|0|0|0|0|0|3|4|4" aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
														defaults="||||||||||||||||" editcol="1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1" widths="1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"
														styles="width:100%; height:100%" sorting="T" acceptnulldate="T" autosize="T" oncellclick="OnPicture()"
														onclick="" />
												</td>
											</tr>
										</table>
									</td>
									<td style="width:10%; background: white">
										<table style="width:100%; height: 100%">
											<tr style="height: 20%">
												<td>
													<gw:image id="imgItem_AS_Member" table_name="CRM.TGM_MEMBERPHOTO" procedure="CRM.SP_UPD_TGM_MEMBERPHOTO"
														styles="width:100;height:120" style='border: 1px solid #1379AC' view="/binary/ViewFile.aspx"
														post="/binary/PostFile.aspx" style='border: 1px solid #1379AC' />
												</td>
											</tr>
										</table>
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
        position: absolute; left: 1; top: 0;" onclick="OnToggle(2)" />
    <!--<img status="expand" id="imgPersional" src="../../../system/images/up_orange.gif" style="cursor: hand;
                                                position: absolute; left: 228; top: 45;" onclick="OnToggle(0)" />-->
    <gw:textbox id="txtMasterPK" styles="display:none" />
    <gw:textbox id="txtPhotoIndividualPK" styles="display:none" />
    <gw:textbox id="txtPhotoCoporatePK" styles="display:none" />
    <gw:textbox id="txtCaddy_Eva" styles="display:none" />
    <gw:textbox id="txtEmp_PK" styles="display:none" />
    <gw:textbox id="txtShowPicture" styles="display:none" />
    <!---------------------------------------------------------------------->
</body>
</html>
