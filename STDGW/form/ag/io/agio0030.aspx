<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<%ESysLib.SetUser("comm")%>

<script>
var deleteFlag = 'F';
var addFlag = 'F';
var iCountDeptID =0;
function BodyInit()
{
    System.Translate(document); 
    idemp_pk.text = "<%=session("EMPLOYEE_PK")%>";
    txtManager_ID.SetEnable(false);
    txtManager_Name.SetEnable(false);    
	dsoDeptEntry.StatusInsert();
	
	lstCompany.SetDataText("<%=ESysLib.SetListDataSQL("select PK,PARTNER_NAME from COMM.TCO_COMPANY where DEL_IF = 0 AND ACTIVE_YN='Y'")%>");
    lstDeptType.SetDataText("<%=ESysLib.SetListDataFUNC("SELECT comm.F_COMMONCODE('COEO0030','','') FROM DUAL" )%>");
  	txtCompanyPk.text         =   lstCompany.GetData();
  	dsoDeptTree.Call("SELECT");
  	
}
/*--------------------------------------*/
function OnCheckDeptId()
{
    dsoCheckDeptId.Call();
    
}

/*function OnCheckAjax()
{
    
    var HttpRequest = false;

    if (window.XMLHttpRequest) // Internet Explorer
    {
        HttpRequest = new XMLHttpRequest()
    }
    else  // Other browsers  
    {
        HttpRequest = new ActiveXObject("Microsoft.XMLHTTP");
    }

    var t=new Date();	
    if (!HttpRequest) return;
    alert(txtDeptPk.GetData() + "|" + txtDeptId.GetData());
    var url = "wcoeo00003_4.aspx?DeptPk=" + txtDeptPk.GetData() + "&DeptId=" + txtDeptId.GetData() + "&Date=" + t;
    
    HttpRequest.open("GET",url);
    HttpRequest.onreadystatechange = function()
    {
        if (HttpRequest.readyState == 4 && HttpRequest.status == 200)
        {
           iCountDeptID = HttpRequest.responseText ;
      
        }
   } 
   HttpRequest.send(null);
}*/
//------------------------------------------
function checkKey() 
{
     
	 var c = String.fromCharCode (event.keyCode); 
	 var x = c.toUpperCase().charCodeAt(0) ; 
	 event.keyCode = x; 
}
/*-----------------------------*/
function UpdateOnClick()
{
    
	if (confirm("Do you want to save data?"))
	{
	    
	    if(checkItemEmpty() && OnCheckDate() )
	    {
		    if(dsoDeptEntry.GetStatus()!=20 && dsoDeptEntry.GetStatus()!=40)
			    {
			        dsoDeptEntry.StatusUpdate();
			    }
    			
		        dsoDeptEntry.Call();
    		
	    }
	}
}

/*-----------------------------*/
function Add_subOnClick(){
	
	var upperDeptPk     = txtDeptPk.text;
    var upperDept       = txtUpperDept.text= txtDeptName.text;
	
	dsoDeptEntry.StatusInsert();
	txtCompanyPk.text   =   lstCompany.GetData();
   	txtUpperDeptPk.text = upperDeptPk;
	txtUpperDept.text   = upperDept;

}
//---------------------------------------
function AddOnClick()
{
	var t1,t2;
	t1=txtUpperDeptPk.text;
	t2=txtUpperDept.text;
	dsoDeptEntry.StatusInsert();
    txtCompanyPk.text         =   lstCompany.GetData();
    txtUpperDeptPk.text=t1;
    txtUpperDept.text=t2;
}
/*-------------------------------------*/
function DeleteOnClick()
{
    if(confirm("Are you sure you want to delete?" ))
	{
	    dsoDeptEntry.StatusDelete();
	    dsoDeptEntry.Call();
	}
}

/*------------------------------*/
function OnChange_com()
{
	txtUpperDept.SetDataText("");	
  	dsoDeptTree.Call("SELECT");
}

/*-----------------------------*/
function query()
{
	dsoDeptTree.Call("SELECT");
}

/*-----------------check empty-----------------------*/
function checkItemEmpty()
{
	if(txtDeptId.GetData() == "")
	{
		alert("Please enter department ID ...");
		return false;
	}
	if(txtDeptName.GetData() == "")
	{
		alert("Please enter department name ...");
		return false;
	}
	if(lstDeptType.GetData() == "")
	{
		alert("Please enter department type ...");
		return false;
	}
	if(dtStartDate.GetData() == "")
	{
		alert("Please enter start date...");
		return false;
	}
	return true;
}

/*-----------------check date-----------------------*/
function OnCheckDate()
{
	var std_dt, etd_dt ;
	std_dt = dtStartDate.GetData();
	etd_dt = dtEndDate.GetData();
	if (parseInt(etd_dt) < parseInt(std_dt))
	{
		alert("End Date can not less than Start date....");
		return false;
	}
	return true;
}
//------------------------------------------
function treeItemOnclick()
{
    
	var obj = event.srcElement.GetCurrentNode();
    txtDeptPk.text= obj.oid;
    dsoDeptEntry.StatusSelect();
	dsoDeptEntry.Call("SELECT");
}



//------------------------------------------
function OnDataReceive(dso)
{
    
    if (dso.id=="dsoDeptEntry")
    {
        if( dsoDeptEntry.GetStatus()!=0 )
        {
            dsoDeptTree.Call("SELECT");
            
        }
    }
    
    if (dso.id=="dsoCheckDeptId")
    {
        
        if (txtCountDepId.text!="0")
        {
            alert("Duplicated Department Id, please input another!");
            var crtl=txtDeptId.GetControl();
            crtl.focus();
        }
    }
}
//-------------------------------------------
function OnShowDeptID()
{
    var url = '/form/ag/io/agio0030_deptid.aspx?DeptId=' + txtDeptId.text  ;
	o = System.OpenModal( System.RootURL+ url , 900 , 450 , 'resizable:yes;status:yes') 
}
function OnDataError(oData)
{
  //alert(eval(oData).errmsg);
    if (eval(oData).errno == 20001)
    {
		alert("Database problem 1: "+ eval(oData).errmsg);
    }
    else if (eval(oData).errno == 20002)
    {
		alert("Database problem 2: "+ eval(oData).errmsg);
    }
	else if (eval(oData).errno > 0)
	{
		alert("Unexpected error: "+ eval(oData).errmsg);
	}	
	
}
function Numbers(e) 
{ 
  //  var ctrl=idTEL.GetControl(); 
    var keynum; 
    var keychar; 
    var numcheck; 
    keynum =event.keyCode; 
        
    if(window.event) // IE 
    { 
      keynum = e.keyCode; 
    } 
    else if(e.which) // Netscape/Firefox/Opera 
    { 
      keynum = e.which; 
    } 
    keychar = String.fromCharCode(keynum); 
    numcheck = /\d/; 
    return numcheck.test(keychar); 
}
//----------------------------------------------
function OnShowManager()
{
    if (txtDeptPk.text!="")
    {
        var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
        var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	    if (obj!=null)
	    {
	        txtManager_PK.text=obj[0];
	        txtManager_ID.text=obj[1];
	        txtManager_Name.text=obj[2];
	    }
	}
}
//----------------------
function OnReset()
{
    txtManager_PK.text="";
    txtManager_ID.text="";
    txtManager_Name.text="";
}
</script>

<body>

<gw:data id="dsoDeptTree"   > 
        <xml> 
            <dso id="1" type="tree" function="comm.sp_sel_dept_tree" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="idemp_pk" />  
                </input> 
                <output bind="tvDept" /> 
            </dso> 
        </xml> 
</gw:data>
<!------------------------------->

<gw:data id="dsoCheckDeptId"  onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="process"  procedure="comm.sp_pro_check_dup_deptid" > 
                <input>
                    <input bind="txtDeptPk" /> 
                    <input bind="txtDeptId" /> 
                </input> 
                <output> 
                    <output bind="txtCountDepId" />
                </output>  
            </dso> 
        </xml> 
</gw:data>
<!------------------------------->
<gw:data id="dsoDeptEntry" onreceive="OnDataReceive(this)" onerror="OnDataError(this)" > 
    <xml> 
        <dso type="control" parameter="0,1,3,4,5,6,7,8,9,10,11,12,13,14,15" function = "COMM.sp_sel_dept" procedure="comm.sp_upd_dept_entry"> 
            <inout> 
                <inout bind="txtDeptPk" />
                <inout bind="txtUpperDeptPk" />
                <inout bind="txtUpperDept" /> 
                <inout bind="txtDeptId" />
                <inout bind="txtDeptName" />
                <inout bind="txtDeptLocalName" /> 
                <inout bind="txtDeptForeignName" />
                <inout bind="lstDeptType" />
                <inout bind="dtStartDate" /> 
                <inout bind="dtEndDate" /> 
                <inout bind="txtareaRemark" />
                <inout bind="txtCompanyPk" /> 
                <inout bind="txtSeq" /> 
                <inout bind="txtManager_PK" /> 
                <inout bind="lstManager_Kind" /> 
                <inout bind="txtManager_ID" /> 
                <inout bind="txtManager_Name" /> 
                
             </inout>
        </dso> 
    </xml> 
</gw:data> 
   <table width="100%" cellpadding="0" cellspacing="0" border="1">
	<tr>
		<td width="30%">
						<!-- Table1 contain master buttons and text box -->
						<table id="LeftTopTB" width="100%">
							<tr>
								<td width="100%">
									<table id="LeftTopTB1" height="15" width="100%" border="0">
										<tr>
											<td width="9%" align="left"><font color="black" ><b>Company&nbsp;</b></font></td>
											<td width="27%">
												 <gw:list id="lstCompany" styles='width:100%' onchange="OnChange_com()"> 
													 <data></data> 
												 </gw:list> 
											</td>
											<td width="4%" align="right"><gw:imgBtn id="btnSearch" img="search"  alt="search" onclick="query()" /> </td>
										</tr>
									</table>
								</td>
							</tr>
							
						</table>
						<!-- End of Table1--->
		</td>
		<td width="70%">
					<!-- Table2 contain detail buttons and text box -->
					<table id="RightTopTB" width="100%">
						<tr>
							<td width="78%"></td>
							<td width="4%"><gw:imgBtn img="new"    	   alt="New"    	id="btnAdd" 		onclick="AddOnClick()" /></td>		
							<td width="4%"><gw:imgBtn img="new_sub"    alt="New Sub"    id="btnAddSub" 	onclick="Add_subOnClick()" /></td>		
							<td width="4%"><gw:imgBtn img="delete" 	   alt="Delete"     id="btnDelete" 	onclick="DeleteOnClick()" /></td>  
							<td width="4%"><gw:imgBtn img="save"   	   alt="Save"   	id="btnUpdate" 	onclick="UpdateOnClick()" /></td>
							
						</tr>
					</table>
		</td>
	
	</tr>
	<tr>
		<td width="30%"> 
			<table id="LeftBottomTB" width="100%" align="top">
				<tr>
					<td> <!-- Master Grid Control here. Remember add this function oncellclick="RowClick()"--> 
						<gw:tree  id="tvDept" style="width:100%; height:410;overflow:auto;" onclicknode="treeItemOnclick()" >
						</gw:tree>
					</td>
				</tr>
			</table>			
		</td>
		<td width="70%">
						<!-- Table2 contain detail grid -->
						<table id="RightBottomTB" width="100%" height="100%"  align="top" >
							<tr>
									<td width="100%"> 
										<table width="100%">
											  <tr> 
												<td width="25%" align="right"><font color="black" ><b>Upper Department&nbsp;&nbsp;</b></font></td>
												<td width="75%" colspan=4><gw:textbox id="txtUpperDept" maxlen=100 styles='width:100%'  onkeypress="checkKey()" csstype=""/></td>
											  </tr>
											  <tr> 
												<!--<td width="25%" align="right"><font color="black" ><b>Department 
												  ID&nbsp;&nbsp;</b></font></td> -->
												  <td width="25%" align="right"><a title="Click here to show department summary" onclick="OnShowDeptID()" href="#tips" style="text-decoration : none; color=#0000FF"><b>Department ID</b></a></td>
												<td width="75%"  colspan=5><gw:textbox id="txtDeptId" maxlen="10" styles='width:100%'    onBlur="OnCheckDeptId()"  onkeypress="checkKey()" csstype="mandatory"/></td>
											  </tr>
											  <tr> 
												<td width="25%" align="right"><font color="black" ><b>Department 
												  name&nbsp;&nbsp;</b></font></td>
												<td width="75%"  colspan=5><gw:textbox id="txtDeptName" maxlen="100" styles='width:100%'  onkeypress="" csstype="mandatory"/></td>
											  </tr>
											  <tr> 
												<td width="25%" align="right"><font color="black" ><b>Local name&nbsp;&nbsp;</b></font></td>
												<td width="75%"  colspan=5><gw:textbox id="txtDeptLocalName" maxlen="100" styles='width:100%'  onkeypress="checkKey()" csstype=""/></td>
											  </tr>
											  <tr> 
												<td width="25%" align="right"><font color="black" ><b>Foreign 
												  name&nbsp;&nbsp;</b></font></td>
												<td width="75%" colspan=5><gw:textbox id="txtDeptForeignName" maxlen="100" styles='width:100%'  onkeypress="checkKey()" csstype=""/></td>
											  </tr>
											  <tr> 
												<td width="25%" align="right"><font color="black" ><b>Type&nbsp;&nbsp;</b></font></td>
												<td width="20%" > <gw:list id="lstDeptType" styles='width:100%'> <data></data> </gw:list > </td>
												<td width="10%" align="right"><font color="black" ><a title="Select Manager" onclick="OnShowManager()" href="#tips" style="text-decoration : none; color=#0000FF"><b>Manager&nbsp;</b></a></font></td>  
												<td width="12%"  ><gw:textbox id="txtManager_ID" maxlen="100" styles='width:100%'   csstype=""/></td>
											    <td width="30%"  ><gw:textbox id="txtManager_Name" maxlen="100" styles='width:100%'  csstype=""/></td> 
											    <td width="3%"  ><gw:imgBtn id="ibtnResetE" alt="Reset" img="Reset" text="Reset" onclick="OnReset()" /></td> 
											  </tr>
											  <tr> 
												<td width="25%" align="right"><font color="black" ><b>Start Date&nbsp;&nbsp;</b></font></td>
												<td width="20%" ><gw:datebox id="dtStartDate" maxlen=10 styles='width:31%'  lang="1" onchange = "OnCheckDate()" nullaccept/></td>
												<td width="22%" colspan=2 align="right"><font color="black" ><b>Manager Kind&nbsp;</b></font></td>  
												<td width="33%" colspan=2 ><gw:list id="lstManager_Kind" value="" styles='width:100%'> <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0071' order by code_nm")%>||</data> </gw:list ></td>
											    
											  </tr>
											  <tr> 
												<td width="25%" align="right"><font color="black" ><b>End Date&nbsp;&nbsp;</b></font></td>
												<td width="75%" colspan=4><gw:datebox id="dtEndDate" maxlen=10 styles='width:31%'  lang="1" onchange = "OnCheckDate()" nullaccept/></td>
											  </tr>
											  <tr> 
												<td width="25%" align="right"><font color="black" ><b>Seq &nbsp;</b></font></td>
												<td width="75%" colspan=4><gw:textbox id="txtSeq" maxlen="10" styles='width:15%'  onkeypress="return Numbers(event)" csstype=""/></td>
											  </tr>
											  <tr> 
												<td align="right"><font color="black" ><b>Remark&nbsp;&nbsp;</b></font></td>
												<td  colspan=4><gw:textarea id="txtareaRemark" maxlen=100 styles='width:100%;height:140'  onkeypress="checkKey()" csstype=""/></gw:textarea></td>
											  </tr>
										 
										</table>
									</td>			
							</tr>
						</table>
						<!-- End of Table2 -->		
		</td>
	</tr>	
</table>
<gw:textbox id="txtDeptPk" maxlen=100 styles='width:100%;display:none'   csstype=""/>
<gw:textbox id="txtUpperDeptPk" maxlen=100 styles='width:100%;display:none'   csstype=""/>
<gw:textbox id="txtCompanyPk" maxlen=100 styles='width:100%;display:none'   csstype=""/>
<gw:textbox id="txtCountDepId" maxlen=100 styles='width:100%;display:none'   csstype=""/>
<gw:textbox id="idemp_pk" styles="display:none"/>
<gw:textbox id="txtManager_PK" styles="display:none"/>
</body>
</html>
