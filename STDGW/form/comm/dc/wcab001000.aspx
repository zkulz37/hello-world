<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
  
 <%ESysLib.SetUser("comm")%>
 
 <script>
var addFlag = 'F';
var userID = "";
userID ="<% =Session("LoginID")%>";
var codeadmin_yn;
codeadmin_yn ="<% =Session("CODEADMIN_YN")%>";

function BodyInit()
{
    idBtnUpdate.SetEnable(false);
	idBtnAdd.SetEnable(false);
	idBtnDelete.SetEnable(false);
	idBtnDelete1.SetEnable(false);
	
    idData_Dsql_CodeGroupTree.Call("SELECT");	
}
//------------------------------------------------------
function checkItemLength()
{
    var ctrl 	= idGrid_DTL.GetGridControl();
    var rownum 	= ctrl.Rows;

    if(rownum == 1)return false;

    var i;
    for(i=1; i<rownum; i++)
    {
	    if(idGrid_DTL.GetGridData(i, 0) != "")
	    {
		    if(idGrid_DTL.GetGridData(i, 2)==""  )
		    {
			    alert("Please enter ORD at row " + i + " ...");
			    return false;
		    }
		    if(idGrid_DTL.GetGridData(i, 4)==""  )
		    {
			    alert("Please enter Code at row " + i + " ...");
			    return false;
		    }
		    else
		    {
			    if(idGrid_DTL.GetGridData(i, 5)=="" )
			    {
				    alert("Please enter Code Name at row " + i + " ...");
				    return false;
			    }
		    }
		    if(idGrid_DTL.GetGridData(i, 4).length > idCODE_LEN.GetData())
		    {
			    alert("Please enter Code length at row " + i + " less or equal " + idCODE_LEN.GetData() + " character ...");
			    return false;
		    }
    		
	    }
	    else
	    {
		    if(idGrid_DTL.GetGridData(i, 4)!=""  )
		    {
			    if(idGrid_DTL.GetGridData(i, 5)=="" )
			    {
				    alert("Please enter Code Name at row " + i + " ...");
				    return false;
			    }
			    if(idGrid_DTL.GetGridData(i, 4).length > idCODE_LEN.GetData())
			    {
				    alert("Please enter Code length at row " + i + " less or equal " + idCODE_LEN.GetData() + " character ...");
				    return false;
			    }
			    if(idGrid_DTL.GetGridData(i, 2)==""  )
			    {
				    alert("Please enter ORD at row " + i + " ...");
				    return false;
			    }
		    }
	    }
    }
    return true;
}
//------------------------------------------------------
function checkNumber()
{
	var ctrl 	= idGrid_DTL.GetGridControl();
	var rownum 	= ctrl.Rows;
	
	if(rownum == 1)return false;
	
	var i;
	for(i=1; i<rownum; i++)
	{
	 	for(j=10; j <= 12; j++)
		{
			var ij_num 	= idGrid_DTL.GetGridData(i, j);
			ij_num		= ij_num.toUpperCase();
			if (isNaN(ij_num))
			{
				alert("Please enter is number at col " + i + " and " + j);
				return false;
			}
			if (parseInt(ij_num) < 0)
			{
				alert("Please enter is number > 0 at col " + i + " and " + j);
				return false;
			}
		}	
	}
	return true;
}
//------------------------------------------------------
function checkDupItems()
{
    var ctrl 	= idGrid_DTL.GetGridControl();
    var rownum 	= ctrl.Rows;
    if(rownum == 1)
    {
	    return false;
    }
    var i;
    for(i=1; i<rownum; i++)
    {
      for(j=i+1; j<rownum; j++)
      {
  	    var i_code 	= idGrid_DTL.GetGridData(i, 4);
	    i_code		= i_code.toUpperCase();
	    var j_code 	= idGrid_DTL.GetGridData(j, 4);
	    j_code		= j_code.toUpperCase();
    	
	    if(j_code == i_code)
	    {
		    if(j_code == "" ){	}
		    else
		    {
			    alert("Code already in use, please re-enter at rows " + i + " and " + j);
			    return false;
		    }
	    }
      }	
    }
    return true;
}
//------------------------------------------------------
function TabPopUp(fnameFile)
{
	var fpath = System.RootURL + "/form/comm/dc/" + fnameFile  ;
	var aValue  = System.OpenModal(  fpath , 900 , 600 , 'resizable:yes;status:yes');
}
//------------------------------------------------------
function treeItemOnclick()
{
    var obj = oTree.GetCurrentNode();	
	idInput_PK.text = obj.oid;
	idData_Dsql_Code_MST_Value.Call("SELECT");
	    
}
//------------------------------------------------------
function OnRecv_Value()
{
    idData_Dsql_Code_DTL_Value.Call("SELECT"); 
}
//------------------------------------------------------
function AddOnClick()
{
    idGrid_DTL.AddRow();
    idGrid_DTL.SetGridText(idGrid_DTL.rows - 1, 1, idInput_PK.text);
}
//--------------------------------------------------------
function DeleteOnClick()
{
    idGrid_DTL.DeleteRow();
}
//--------------------------------------------------------
function UnDeleteOnClick()
{
	idGrid_DTL.UnDeleteRow();
}

//-----------------------------------------------------------
function UpdateOnClick()
{
    if(checkItemLength() && checkDupItems() && checkNumber() && checkORD())
    {
        idData_Dsql_Code_DTL_Value.Call();
    }    
}
//------------------------------------------------------
function checkORD()
{
	var ctrl	= idGrid_DTL.GetGridControl();
	var row 	= ctrl.Rows;
	var cnt = 0;
	if(ctrl.Row >1 )
	{
		for(i=1; i<row; i++)
		{
			var data = idGrid_DTL.GetGridData(i, 2);
			if(isNaN(data))
			{
				alert("Please enter at col " + i + " and " + j + " is number");
				return false;
			}
			if (parseInt(data) < 0)
			{
				alert("Please enter at col " + i + " and " + j + " is number");
				return false;
			}
		}
	}
	return true;
}
//------------------------------------------------------
function checkData()
{
	var ctrl 	= idGrid_DTL.GetGridControl();
	var rownum 	= ctrl.Row;
	var rownums 	= ctrl.Rows;
	if(rownum < 0){
		if(rownums > 1){}
	}
	else
	{
		if(codeadmin_yn == "Y")
		{
			if(idDTL_TYPE.GetData() == 1) {
				idBtnUpdate.SetEnable(false);
				idBtnAdd.SetEnable(false);
				idBtnDelete.SetEnable(false);
				idBtnDelete1.SetEnable(false);
			}
			else
			{
				idBtnUpdate.SetEnable(true);
				idBtnAdd.SetEnable(true);
				if(idGrid_DTL.GetRowStatus(ctrl.Row) >= 64)
				{
					idBtnDelete.SetEnable(false);
					idBtnDelete1.SetEnable(true);
				}
				else
				{
					idBtnDelete.SetEnable(true);
					idBtnDelete1.SetEnable(false);
				}
			}
		}
		else
		{
			if((idDTL_TYPE.GetData() == 1) || (idSYS_YN.GetData() =="Y"))
			{
				idBtnUpdate.SetEnable(false);
				idBtnAdd.SetEnable(false);
				idBtnDelete.SetEnable(false);
				idBtnDelete1.SetEnable(false);
			}
			else
			{	
				idBtnUpdate.SetEnable(true);
				idBtnAdd.SetEnable(true);
				if(idGrid_DTL.GetRowStatus(ctrl.Row) >= 64)
				{
					idBtnDelete.SetEnable(false);
					idBtnDelete1.SetEnable(true);
				}
				else
				{
					idBtnDelete.SetEnable(true);
					idBtnDelete1.SetEnable(false);
				}
			}
		}
	}
}
function checkDefault()
{
    var ctrl	= idGrid_DTL.GetGridControl();
	var row 	= ctrl.Rows;
	
	if(ctrl.Row >=1 && event.col == 3)
	{
		for(i=1; i<row; i++)
		{
			idGrid_DTL.SetGridText( i , 3, "0");
		}
		idGrid_DTL.SetGridText( ctrl.Row , 3, "-1");
	}
}
</script>

<body>

<gw:data id="idData_Dsql_CodeGroupTree" > 
    <xml> 
        <dso id="1" type="tree" user="comm" function="comm.sp_get_tco_abcodegrp" > 
            <input bind="oTree" />
            <output bind="oTree" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="idData_Dsql_Code_MST_Value" onreceive="OnRecv_Value()" > 
    <xml> 
        <dso id="2" type="control" function="comm.sp_get_dsql_code_master" >
            <input>
                <inout  bind="idInput_PK" />
                <inout  bind="idCODE_GRP" />
                <inout  bind="idCODE_GRP_NM" />              
                <inout  bind="idCODE_TYPE" /> 
                <inout  bind="idCODE_LEN" />                 
                <inout  bind="idSYS_YN" />
                <inout  bind="idDTL_TYPE" />
            </input>
        </dso>
    </xml>
</gw:data>

<gw:data id="idData_Dsql_Code_DTL_Value" > 
    <xml> 
        <dso id="3" type="grid" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15" function="comm.sp_get_dsql_code_detail" procedure="comm.sp_process_dsql_code_detail">
            <input bind="idGrid_DTL" >                            
                <input bind="idInput_PK" />                                            
            </input>
            <output bind="idGrid_DTL" />
        </dso>                    
    </xml>
</gw:data>
            
<table  width="100%" cellpadding="0" cellspacing="0" border="1">
	<tr>
		<td width="25%">			
			<table id="LeftTopTB" height="20" width="100%">
				<tr>
					<td width="100%">
						<table id="LeftTopTB1" height="15" width="100%" border="0">
							<tr>
								<td width="45%"></td>
								<td width="10%" align="center"><gw:icon id="idBtnMaster" img="in" text="Code Group Entry" onclick="TabPopUp('wcab001001.aspx')" styles='width:100%'/></td>
								<td width="45%"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>			
		</td>
		<td width="75%">						
			<table id="Table1" width="100%" height="100%"  align="top" border="1">				
				<tr>
					<td width="100%">
						<table width="100%" border="0">
							<tr>								
								<td width="10%"><gw:textbox id="idCODE_GRP" styles='width:100%'	/></td>
								<td width="33%"><gw:textbox id="idCODE_GRP_NM" styles='width:100%'/></td>								
								<td width="7%" align="right"><font color="black" ><b>Type</b></font></td>
								<td width="8%"><gw:textbox id="idCODE_TYPE" styles='width:100%'	csstype="mandatory"/></td>
								<td width="6%" align="right"><font color="black" ><b>Length</b></font></td>
								<td width="8%"><gw:textbox id="idCODE_LEN" styles='width:100%'	 csstype="mandatory"/> </td>
								<td width="6%" align="right"><font color="black" ><b>Active</b></font></td>
								<td width="4%"><gw:checkbox id="idInput_USEYN"   	  value="1" defaultvalue="1|0" onchange="OnChange_Use()"/></td>
								<td width="4%"><gw:imgBtn img="new"      alt="new"      id="idBtnAdd" 	  onclick="AddOnClick()" /></td>					
								<td width="4%"><gw:imgBtn img="delete"   alt="delete"   id="idBtnDelete"  onclick="DeleteOnClick()" /></td>  
								<td width="4%"><gw:imgBtn img="udelete"  alt="undelete" id="idBtnDelete1" onclick="UnDeleteOnClick()" /></td>  
								<td width="4%"><gw:imgBtn img="save"     alt="save"     id="idBtnUpdate"  onclick="UpdateOnClick()" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</td>
	</tr>
	<tr>
		<td width="25%">			
			<table id="LeftBottomTB" width="100%" height="100%" >
			    <tr>
					<td height="100%">
					    <gw:tree ID = "oTree" style="width:100%; height:425;overflow:auto;" onclicknode="treeItemOnclick()" />
                    </td>
				</tr>
            </table>								
		</td>
	    <td width="75%">
	        <table id="RightGrid" width="100%" height="100%">
	            <tr>
				    <td width="100%">
				        <script>
                            document.writeln('<gw:grid');
                            document.writeln('id="idGrid_DTL"');
                            document.writeln('header="_PK|_TC_ABCODE_MST_PK|ORD|DEF YN|Code|Code Name|Code Local Name|Code Foreign Name|Group Code|Use|NUM_VALUE1|NUM_VALUE2|NUM_VALUE3|CHA_VALUE1|CHA_VALUE2|CHA_VALUE3|_DEL_IF"');
                            document.writeln('format="0|0|1|3|0|0|0|0|2|3|0|0|0|0|0|0|0"');
                            document.writeln('aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"');
                            document.writeln('defaults="|||||||||-1|||||||"');
                            document.writeln('editcol="0|0|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"');
                            document.writeln('widths="0|0|600|800|0|2000|2000|2000|2000|0|0|0|0|0|0|0|0"');
                            document.writeln('styles="width:100%; height:425"');
                            document.writeln('sorting="T"');
                            document.writeln('param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16"');
                            document.writeln('oncellclick="checkData();checkDefault()"/>');
                        </script>	 
				    </td>
			    </tr>
	        </table>
	    </td>		
	</tr>	
</table>	

<gw:textbox id="idInput_PK" 		style="Display:none" />
<gw:textbox id="idREM_NUM1" 		style="Display:None" />
<gw:textbox id="idREM_NUM2" 		style="Display:None" /> 
<gw:textbox id="idREM_NUM3" 		style="Display:None" /> 
<gw:textbox id="idREM_CHA1" 		style="Display:None" /> 
<gw:textbox id="idREM_CHA2" 		style="Display:None" /> 
<gw:textbox id="idREM_CHA3" 		style="Display:None" />
<gw:textbox id="idSYS_YN" 		 	style="Display:None" />
<gw:textbox id="idDTL_TYPE" 		style="Display:None" />
</body>
</html>
