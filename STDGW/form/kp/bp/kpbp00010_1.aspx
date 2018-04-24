<!-- #include file="../../../system/lib/form.inc"  -->
  <head>
    <title>Add a New Project</title>
  </head>
  
 <% ESysLib.SetUser("ec111")%>
 
 <script>
var flag = 0; //not yet modify information
var bAdd=false;
//the columns of Grid
var iDPK                    = 0,
    iDtco_abcodegrp_pk      = 1,
    iDORD                   = 2,
    iDDEF_YN                = 3,
    iDCODE                  = 4,
    iDCode_Name             = 5,
    iDCode_Local_Name       = 6,
    iDCode_Foreign_Name     = 7,
    iDGroup_Code            = 8,
    iDSYS_Y_N               = 9,
    iDUse                   = 10;
    
//PK|_tco_abcodegrp_pk|ORD|DEF YN|CODE|Code Name|Code Local Name|Code Foreign Name|Group Code|SYS Y/N|Use
function BodyInit()
{
     var data ;
      var arr;
	 data = "<%=ESysLib.SetListDataFUNC("SELECT acnt.sf_a_get_company('') FROM DUAL")%>";   
     cboCompany_1.SetDataText(data);
     cboCompany_1.value = "<%=Session("COMPANY_PK") %>";
	 dat_kpbp00010_11.StatusInsert();
	 chkIndependent_3.SetDataText("Y");
}

//--------------------------
function onSave()
{
	
	dat_kpbp00010_11.Call();
}
//--------------------------
function CloseOnClick()
{
    var obj=new Array();
    obj[0]=txtprojectPK_0.GetData();
    obj[1]=txtProject_cd_2.GetData();
    obj[2]=txtProject_nm_4.GetData();
    obj[3]=txtSiteLocation_5.GetData();
	window.returnValue = obj; 
	window.close();
}
 </script>

<body>

<!---------------------------------------------------------->
 <gw:data id="dat_kpbp00010_11" onreceive=""> 
        <xml> 
            <dso id="3" type="control" parameter="0,1,2,3,4,5" function="ec111.sp_sel_kpbp00010_11" procedure="ec111.sp_upd_kpbp00010_11">
                <input>
                     <inout bind="txtprojectPK_0"  />
                     <inout bind="cboCompany_1"  />
                     <inout bind="txtProject_cd_2"  />
                     <inout bind="chkIndependent_3"  />
                     <inout bind="txtProject_nm_4"  />
                     <inout bind="txtSiteLocation_5"  />
                 </input>
            </dso>
        </xml>
    </gw:data>
<!-- MainTable -->
<table    style='margin-left:10px' cellpadding="0" cellspacing="0" border="1" style="width:100%;height:100%">
	<tr style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top">
	    <td>
		   <table border="1" width="100%" bordercolor="#00FFFF" bordercolorlight="#00FFFF" bordercolordark="#00FFFF"  style="border-collapse: collapse">
				<tr>
					<td width="30%">Company</td>
					<td colspan="65%" colspan="2"><gw:list id="cboCompany_1" styles="width:100%;" /></td>
					<td width="2%"><gw:imgbtn id="btnsaveMST" img="save" alt="Save" onclick="onSave()" /></td>
					<td width="3%"><gw:imgbtn id="btnsaveMST" img="cancel" alt="Close" onclick="CloseOnClick()" /></td>
				</tr>
				<tr>
					<td width="30%">Project code</td>
					<td width="30%"><gw:textbox id="txtProject_cd_2" csstype="mandatory" styles="width:100%;"  /></td>
					<td width="40%" colspan="2" align="right">Independent project</td>
				    <td width="2%"><gw:checkbox id="chkIndependent_3" defaultvalue="Y|N" value="Y"  /></td>
				</tr>
				<tr>
					<td width="30%">Project name</td>
					<td width="70%" colspan="4"><gw:textbox id="txtProject_nm_4" csstype="mandatory" styles="width:130%;"  /></td>
				</tr>
				<tr>
					<td width="30%">Site Location</td>
					<td width="70%" colspan="4"><gw:textbox id="txtSiteLocation_5" csstype="mandatory" styles="width:130%;"  /></td>
				</tr>
			</table>
	       

        </td>
	</tr>
</table>
	   
    <gw:textbox id="txtprojectPK_0"  styles="display:none" />
  
	

</body>
</html>
