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
    dsoSalaryGroupTree.Call("SELECT");
  	
}
/*--------------------------------------*/
/*function OnShowPopup(obj,obj2)
{
 var strcom;
        var fpath = System.RootURL + "/form/ag/io/agio0071_popup.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:no;unadorned:yes;help:no');
        if (obj!=null)
        {
            alert(obj);
            //datDeptData.Call();
            
        }
    
}
*/

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
	    
	    if(checkItemEmpty()  )
	    {
		    if(dsoGroupSalaryEntry.GetStatus()!=20 && dsoGroupSalaryEntry.GetStatus()!=40)
			    {
			        dsoGroupSalaryEntry.StatusUpdate();
			    }
    			
		        dsoGroupSalaryEntry.Call();
    		
	    }
	}
}

/*-----------------------------*/
function Add_subOnClick(){
	var t=txtSalaryGroupName.text;
    var t2=txtSalaryGroupPK.text;
	var t3=txtMaxID.text;  
	txtUpSalaryGroupName.text=txtSalaryGroupName.text;
    txtareaRemark.text="";
    txtSalaryGroupNameID.text="";
	txtSalaryGroupName.text="";
    txtareaRemark.text="";
    txtSalaryCode.text="";
    txtBasicSalary.text="";
    txtAllowance.text="";
    txtTechnical.text="";
    txtPosition.text="";
    txtSite.text="";
    txtSpecial.text="";
    txtOther.text="";
    
    txtUpKindPK.text=txtSalaryGroupPK.text;
    dsoGroupSalaryEntry.StatusInsert();
    txtUpSalaryGroupName.text=t;
    txtUpKindPK.text=t2;
	 txtUpSalaryGroupName.SetEnable(false);
    txtSalaryGroupName.SetEnable(true);
     txtSalaryGroupNameID.text=t3;
}
//---------------------------------------
function AddOnClick()
{   var t=txtUpSalaryGroupName.text;
    var t2=txtUpKindPK.text;
    var t3=txtMaxID.text;
	txtSalaryGroupNameID.text="";
	txtSalaryGroupName.text="";
    txtareaRemark.text="";
    txtSalaryCode.text="";
    txtBasicSalary.text="";
    txtAllowance.text="";
    txtTechnical.text="";
    txtPosition.text="";
    txtSite.text="";
    txtSpecial.text="";
    txtOther.text="";
    dsoGroupSalaryEntry.StatusInsert();
    txtUpSalaryGroupName.text=t; 
    txtUpKindPK.text=t2;
    txtUpSalaryGroupName.SetEnable(false);
    txtSalaryGroupName.SetEnable(true);
     txtSalaryGroupNameID.text=t3;    
}
/*-------------------------------------*/
function DeleteOnClick()
{
    if(confirm("Are you sure you want to delete?" ))
	{   dsoCheckDel.Call();
	    
	}
}

/*------------------------------*/
function OnChange_com()
{
	
}

/*-----------------------------*/
/*function query()
{
	//dsoSalaryGroupTree.Call("SELECT");
}
*/
/*-----------------check empty-----------------------*/
function checkItemEmpty()
{
	if(txtSalaryGroupName.text == "")
	{
		alert("Please enter salary group name");
		return false;
	}
    if(txtSalaryCode.text == "")
	{
		alert("Please enter salary group code");
		return false;
	}
	if(txtBasicSalary.text == "")
	{
		alert("Please enter basic salary");
		return false;
	}
	

	return true;
}

/*-----------------check date-----------------------*/
function OnCheckDate()
{
	return true;
}
//------------------------------------------
function treeItemOnclick()
{
    
	var obj = event.srcElement.GetCurrentNode();
    txtSalaryGroupNameID.text= obj.oid;
    txtSalaryGroupNameID.SetEnable(false);
    txtUpSalaryGroupName.SetEnable(false);
 
    txtSalaryGroupName.text="";
    txtUpSalaryGroupName.text="";
    txtareaRemark.text="";
    dsoGroupSalaryEntry.StatusSelect();
	dsoGroupSalaryEntry.Call("SELECT");
}



//------------------------------------------
function OnDataReceive(dso)
{
    
    if (dso.id=="dsoGroupSalaryEntry")
    {
        if( dsoGroupSalaryEntry.GetStatus()!=0 )
        {
            dsoSalaryGroupTree.Call("SELECT");
            
        }
    }
    if (dso.id=="dsoCheckDel")
    {
     if(iduser_pk.text=="FALSE")
            alert("You can't delete salary group!");
         else 
         {  dsoGroupSalaryEntry.StatusDelete();
	        dsoGroupSalaryEntry.Call();
    
         }  
       
    }
   
        
    
}
//-------------------------------------------

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

//----------------------
function OnReset()
{
 }
</script>

<body>
<!------------------------------------->
<gw:data id="dsoSalaryGroupTree"   > 
        <xml> 
            <dso id="1" type="tree" function="hr.sp_sel_group_salary_tree" > 
                <input>
                  
                    <input bind="iduser_pk" />  
                </input> 
                <output bind="tvDept" /> 
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dsoCheckDel" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_check_Del_salary_group" > 
                <input>
                  
                  <input bind="txtSalaryGroupNameID" />  
                </input> 
                <output>
                <output bind="iduser_pk" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------->


<!------------------------------->
<gw:data id="dsoGroupSalaryEntry" onreceive="OnDataReceive(this)" onerror="OnDataError(this)" > 
    <xml> 
        <dso type="control" parameter="0,2,3,4,6,7,8,9,10,11,12,13" function = "hr.sp_sel_group_salary" procedure="hr.sp_upd_group_salary"> 
            <inout> 
                
               <inout bind="txtSalaryGroupNameID"/>
               <inout bind="txtUpSalaryGroupName"/>
               <inout bind="txtSalaryGroupName"/>
               <inout bind="txtareaRemark"/>
               <inout bind="txtUpKindPK" />
               <inout bind="txtSalaryGroupPK" />
               <inout bind="txtSalaryCode" />
               <inout bind="txtBasicSalary" />
               <inout bind="txtAllowance" />
               <inout bind="txtTechnical" />
               <inout bind="txtPosition" />
               <inout bind="txtSite" />
               <inout bind="txtSpecial" />
               <inout bind="txtOther" />
               <inout bind="txtMaxID" />
             </inout>
        </dso> 
    </xml> 
</gw:data> 
   <table width="100%" cellpadding="0" cellspacing="0" border="1">
	
	<tr height="100%" width="100%">
		
		<td width="30%">
		<table id="LeftBottomTB" width="100%" height="100%" align="top">
				
				<tr align="top">
					<td> <!-- Master Grid Control here. Remember add this function oncellclick="RowClick()"--> 
						<gw:tree  id="tvDept" style="width:100%; height:410;overflow:auto;" onclicknode="treeItemOnclick()" >
						</gw:tree>				
					</td>
				</tr>
			</table>			
						
		</td>
		<td width="70%" >
			<table  width="100%" style="height:100%">
			    <tr style="height:5%">
			    <td>
			    <table id="RightTopTB" width="100%" height="100%">
						<tr style="height:100%">
							<td width="78%"></td>
							<td width="4%"><gw:imgBtn img="new"    	   alt="New"    	id="btnAdd" 		onclick="AddOnClick()" /></td>		
							<td width="4%"><gw:imgBtn img="new_sub"    alt="New Sub"    id="btnAddSub" 	onclick="Add_subOnClick()" /></td>		
							<td width="4%"><gw:imgBtn img="delete" 	   alt="Delete"     id="btnDelete" 	onclick="DeleteOnClick()" /></td>  
							<td width="4%"><gw:imgBtn img="save"   	   alt="Save"   	id="btnUpdate" 	onclick="UpdateOnClick()" /></td>
							
						</tr>
					</table>
					</td>
			    </tr>
			    <tr style="height:95%">
			    <td>
			     <table id="RightBottomTB" width="100%" style="height:100%"  align="top" >
							<tr style="height:5%">
							<td width="25%" >  Upper Salary Group</td>
							<td width="75%"><gw:textbox id="txtUpSalaryGroupName" maxlen=100 styles='width:100%;'   csstype="mandatory" /></td>
							</tr>
							<tr style="height:5%">
							<td width="25%">Salary Group ID</td>
							<td width="75%"><gw:textbox id="txtSalaryGroupNameID" maxlen=100 styles='width:100%;'   csstype="mandatory"  /></td>
							</tr>
							<tr style="height:5%">
							<td width="25%">Salary Group Name </td>
							<td width="75%"><gw:textbox id="txtSalaryGroupName" maxlen=100 styles='width:100%;'   csstype=""/></td>
							</tr>
							<tr style="height:5%">
							<td width="25%">Salary Group Code </td>
							<td width="75%"><gw:textbox id="txtSalaryCode" maxlen=100 styles='width:100%;'   csstype=""/></td>
							</tr>
							
							<tr style="height:5%">
							<td width="25%">Basic Salary </td>
							<td width="75%"><gw:textbox id="txtBasicSalary" maxlen=100 styles='width:100%;'   csstype="" type="number" format="#,###,###,###,###.##R"/></td>
							</tr>
							
							
							<tr style="height:15%" >
							<td   width="100%" colspan="4">
							<table width="100%" >
							    <tr style="height:0%" width="100%">
							        <td colspan="50"></td>
							    </tr>
							    <tr >
							        <td colspan="5">Allowance </td>
							        <td colspan="20"><gw:textbox id="txtAllowance" maxlen=100 styles='width:100%;'   type="number" format="#,###,###,###,###.##R"/> </td>
							        <td colspan="5" align="right">Technical </td>
							        <td colspan="20"><gw:textbox id="txtTechnical" maxlen=100 styles='width:100%;'   type="number" format="#,###,###,###,###.##R"/> </td>
							        
							    </tr>
							    <tr >
							        <td colspan="5">Position </td>
							        <td colspan="20"><gw:textbox id="txtPosition" maxlen=100 styles='width:100%;'   type="number" format="#,###,###,###,###.##R"/> </td>
							        <td colspan="5"align="right">Site </td>
							        <td colspan="20"><gw:textbox id="txtSite" maxlen=100 styles='width:100%;'  type="number" format="#,###,###,###,###.##R"/> </td>
							        
							    </tr>
							    <tr >
							        <td colspan="5">Special </td>
							        <td colspan="20"><gw:textbox id="txtSpecial" maxlen=100 styles='width:100%;'   type="number" format="#,###,###,###,###.##R"/> </td>
							        <td colspan="5"align="right">Other </td>
							        <td colspan="20"><gw:textbox id="txtOther" maxlen=100 styles='width:100%;'   type="number" format="#,###,###,###,###.##R"/> </td>
							        
							    </tr>
							</table>
							</td>
							</tr>
							
							<tr style="height:5%">
							<td width="25%">Remark</td>
							<td width="75%"></td>
							</tr>
							
							<tr style="height:80%">
							<td colspan="2" valign="top"><gw:textarea id="txtareaRemark" maxlen=100 styles='width:100%;height:200'  onkeypress="checkKey()" csstype=""/></gw:textarea></td>
							</tr>
							
							
						</table>
						</td>
			    </tr>
			</table>		
					
		</td>
	
	</tr>
	
</table>

<gw:textbox id="iduser_pk" styles="display:none"/>

<gw:textbox id="txtUpKindPK" styles="display:none"/>
<gw:textbox id="txtSalaryGroupPK" styles="display:none"/>
<gw:textbox id="txtMaxID" styles="display:none"/>

</body>
</html>
<!------------------->
                
<!------------------->
               
<!------------------->
		