<!-- #include file="../../../system/lib/form.inc"  -->

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<%ESysLib.SetUser(Session("APP_DBUSER"))%>

<script>
var deleteFlag = 'F';
var addFlag = 'F';
var iCountDeptID =0;
function BodyInit()
{	
    System.Translate(document); 
    dsoEmpKindTree.Call("SELECT");
}
/*--------------------------------------*/
function OnCheckDeptId()
{
    dsoCheckDeptId.Call();
    
}

function OnUse()
{lstUse.value;
dsoCheckleaf.Call();
}
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
		    if(dsoEmpKindEntry.GetStatus()!=20 && dsoEmpKindEntry.GetStatus()!=40)
			    {
			        dsoEmpKindEntry.StatusUpdate();
			    }
    			
		        dsoEmpKindEntry.Call();
    		
	    }
	}
}

/*-----------------------------*/
function Add_subOnClick(){
	var t=txtEmpKind.text;
    var t2=txtKindPK.text;
	var t3=txtMaxID.text;  
	txtEmpKindID.text="";
	txtUpEmpKind.text=txtEmpKind.text;
    txtareaRemark.text="";
    txtUpKindPK.text=txtKindPK.text;
    dsoEmpKindEntry.StatusInsert();
    txtUpEmpKind.text=t;
    txtUpKindPK.text=t2;
	 txtUpEmpKind.SetEnable(false);
    txtEmpKind.SetEnable(true);
     txtEmpKindID.text=t3;
     txtUseYN.text="Y";
	lstUse.value="Y";
}
//---------------------------------------
function AddOnClick()
{   var t=txtUpEmpKind.text;
    var t2=txtUpKindPK.text;
    var t3=txtMaxID.text;
	txtEmpKindID.text="";
	txtEmpKind.text="";
	txtareaRemark.text="";
    dsoEmpKindEntry.StatusInsert();
    txtUpEmpKind.text=t; 
    txtUpKindPK.text=t2;
    txtUpEmpKind.SetEnable(false);
    txtEmpKind.SetEnable(true);
     txtEmpKindID.text=t3;    
     txtUseYN.text="Y";
	lstUse.value="Y";
    
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
	//dsoEmpKindTree.Call("SELECT");
}
*/
/*-----------------check empty-----------------------*/
function checkItemEmpty()
{
	if(txtEmpKind.text == "")
	{
		alert("Please enter employee kind");
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
    txtEmpKindID.text= obj.oid;
    txtEmpKindID.SetEnable(false);
    txtUpEmpKind.SetEnable(false);
 
    txtEmpKind.text="";
    txtUpEmpKind.text="";
    txtareaRemark.text="";
    dsoEmpKindEntry.StatusSelect();
	dsoEmpKindEntry.Call("SELECT");
}



//------------------------------------------
function OnDataReceive(dso)
{    
    
    if (dso.id=="dsoCheckleaf")
    {    
        // alert(txtUseYN.text);
        if(iduser_pk.text=="FALSE")
            {lstUse.value=txtUseYN.text;
            alert("You can't change using employee kind!");
            }
            else
            txtUseYN.text=lstUse.value;
     
    }
    
    if (dso.id=="dsoEmpKindEntry")
    {    lstUse.value=txtUseYN.text;
        // alert(txtUseYN.text);
        if( dsoEmpKindEntry.GetStatus()!=0 )
        {
            dsoEmpKindTree.Call("SELECT");
            
        }
    }
    if (dso.id=="dsoCheckDel")
    {
     if(iduser_pk.text=="FALSE")
            {//lstUse.value=txtUseYN.text;
            alert("You can't delete employee kind!");
            }
         else 
         {  //lstUse.value=txtUseYN.text;
            dsoEmpKindEntry.StatusDelete();
	        dsoEmpKindEntry.Call();
    
         }  
       
    }
   
        
    
}
//-------------------------------------------
function OnShowDeptID()
{
  
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

//----------------------
function OnReset()
{
 }
</script>

<body>
<!------------------------------------->
<gw:data id="dsoEmpKindTree"   > 
        <xml> 
            <dso id="1" type="tree" function="hr_sp_sel_emp_kind_tree" > 
                <input>
                  
                    <input bind="iduser_pk" />  
                </input> 
                <output bind="tvEmpKindTree" /> 
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dsoCheckDel" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_check_Del_emp_kind" > 
                <input>
                  
                  <input bind="txtEmpKindID" />  
                </input> 
                <output>
                <output bind="iduser_pk" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------->
<gw:data id="dsoCheckleaf" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_check_Del_emp_kind" > 
                <input>
                  
                  <input bind="txtEmpKindID" />  
                </input> 
                <output>
                <output bind="iduser_pk" /> 
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------->


<!------------------------------->
<gw:data id="dsoEmpKindEntry" onreceive="OnDataReceive(this)" onerror="OnDataError(this)" > 
    <xml> 
        <dso type="control" parameter="0,2,3,4,7" function = "HR_SEL_80020013" procedure="HR_UPD_80020013"> 
            <inout> 
                
               <inout bind="txtEmpKindID"/>
               <inout bind="txtUpEmpKind"/>
               <inout bind="txtEmpKind"/>
               <inout bind="txtareaRemark"/>
               <inout bind="txtUpKindPK" />
               <inout bind="txtKindPK" />
               <inout bind="txtMaxID" />
               <inout bind="txtUseYN" />
             </inout>
        </dso> 
    </xml> 
</gw:data> 
   <table width="100%" cellpadding="0" cellspacing="0" border="1">
	
	<tr height="100%" width="100%">
		
		<td width="30%">
		<table id="LeftBottomTB" width="100%" height="100%" align="top">
				
				<tr>
					<td> <!-- Master Grid Control here. Remember add this function oncellclick="RowClick()"--> 
						<gw:tree  id="tvEmpKindTree" style="width:100%; height:410;overflow:auto;" onclicknode="treeItemOnclick()" >
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
							<td width="25%">Upper Emloyee Kind</td>
							<td width="75%"><gw:textbox id="txtUpEmpKind" maxlen=100 styles='width:100%;'   csstype="mandatory"/></td>
							</tr>
							<tr style="height:5%">
							<td width="25%">Emloyee Kind ID</td>
							<td width="75%"><gw:textbox id="txtEmpKindID" maxlen=100 styles='width:100%;'   csstype="mandatory"/></td>
							</tr>
							<tr style="height:5%">
							<td width="25%">Emloyee Kind </td>
							<td width="75%"><gw:textbox id="txtEmpKind" maxlen=100 styles='width:100%;'   csstype=""/></td>
							</tr>
							<td width="25%">Use Y/N </td>
							<td width="75%">
							    <gw:list  id="lstUse" value=" " styles='width:50%' onchange="OnUse()">
                            <data>|Y|Yes|N|No
                            </data>
                            </gw:list>
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
<gw:textbox id="txtKindPK" styles="display:none"/>
<gw:textbox id="txtMaxID" styles="display:none"/>
<gw:textbox id="txtUseYN" styles="display:none"/>
</body>
</html>
<!------------------->
                
<!------------------->
               
<!------------------->
		