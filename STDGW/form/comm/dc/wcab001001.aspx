<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>genuwin</title>
  </head>
  
 <%ESysLib.SetUser("comm")%>
 
 <script>
 function BodyInit()
 {
    iduID.SetEnable(false);
	iduREMARK.SetEnable(false);  
	idsubID.SetEnable(false);
	idsubREMARK.SetEnable(false);
	
    idData_Dsql_CodeGroupTree.Call("SELECT");
 }
 
 function treeItemOnclick()
 {
    idBtnAdd.style.display = 'none'; 	
	idBtnDelete.style.display = '';
	idBtnReset.style.display = '';
	var obj = event.srcElement.GetCurrentNode();
	
	idpPKSave.text = obj.parentNode.parentNode.oid;
	
    idInput1.SetDataText( obj.oid );
	idPKSave.SetDataText( obj.oid );
	
	
	idData_Dsql_Code_MST_POPUP.Call('SELECT');
 }
 
function checkKey() { 
	var c = String.fromCharCode (event.keyCode); 
	var x = c.toUpperCase().charCodeAt(0) ; 
	event.keyCode = x; 
	
}

 function treeDrop()
 {
 
 }
 
 function onReMST()
 {
    idPK1.SetDataText(idInput1.GetData());
	idKIND.SetDataText(idDTL_KIND.GetData());
	
    if ((idDTL_KIND.GetData() == 1) || (idDTL_KIND.GetData() == 2))
	{
		idBtnReset_Sub.style.display = '';
		idBtnReset.style.display = '';
	}
	if (idDTL_KIND.GetData() == 3)
	{
		idBtnReset_Sub.style.display = 'none';
		idBtnReset.style.display = '';
	}
		
    idData_Dsql_Code_uMST.Call("SELECT");
 }
 
 function ResetOnClick()
{
	if(iduID.text=="")
	{
		idBtnAdd.style.display 			= '';
		idBtnReset.style.display 		= 'none'; 
		idBtnDelete.style.display	 	= 'none';
		idBtnReset_Sub.style.display 	= 'none';
		idsubREMARK.SetDataText( "" );
		idsubID.SetDataText( "" );
		idsubID.style.display 		= 'none'; 
		idsubREMARK.style.display 	= 'none'; 
		idUSE_IF.SetDataText( "0" );
		idSYS_FLAG.SetDataText( "Y" );
		idDTL_KIND.SetDataText("1");
		idP_PK.SetDataText(idpPKSave.Text);
	}
	else
	{
	    idID.SetDataText("");
	    idREMARK.SetDataText("");
	    
		idBtnAdd.style.display 			= '';
		idBtnReset.style.display 		= 'none'; 
		idBtnDelete.style.display	 	= 'none';
		idBtnReset_Sub.style.display 	= 'none';		
		idsubID.style.display 		    = 'none'; 
		idsubREMARK.style.display 	    = 'none'; 				
		idUSE_IF.SetDataText( "0" );
		idSYS_FLAG.SetDataText( "Y" );		
		idsubREMARK.SetDataText( "" );
		idsubID.SetDataText( "" );		
		idREM_NUM1.SetDataText("");
		idREM_NUM2.SetDataText("");
		idREM_NUM3.SetDataText("");
		idREM_CHA1.SetDataText("");
		idREM_CHA2.SetDataText("");
		idREM_CHA3.SetDataText("");
		idP_PK.SetDataText(idpPKSave.Text);		
		
	}
}

function Reset_SubOnClick()
{
	if(iduID.text=="")
	{
		idBtnAdd.style.display 			= '';
		idBtnReset.style.display 		= 'none'; 
		idBtnDelete.style.display	 	= 'none';
		
		idBtnReset_Sub.style.display 	= 'none';
		
		iduID.SetDataText( idID.text );
		iduREMARK.SetDataText( idREMARK.text );
		
		idUSE_IF.SetDataText( "0" );
		idSYS_FLAG.SetDataText( "Y" );
		idDTL_KIND.SetDataText("1");
		idsubREMARK.SetDataText( "" );
		idsubID.SetDataText( "" );
		idsubID.style.display 		= 'none'; 
		idsubREMARK.style.display 	= 'none'; 
	
		alert("Please input information ... ");
		idP_PK.SetDataText(idPKSave.text);
	}
	else
	{
	
		idBtnAdd.style.display 			= '';
		idBtnReset.style.display 		= 'none'; 
		idBtnDelete.style.display	 	= 'none';
		
		idBtnReset_Sub.style.display 	= 'none';
		
		iduID.SetDataText( idID.text );
		iduREMARK.SetDataText( idREMARK.text );
		idID.SetDataText("");
		idREMARK.SetDataText("");
		idUSE_IF.SetDataText( "0" );
		idSYS_FLAG.SetDataText( "Y" );
		alert("Please input information ... ");
		idP_PK.SetDataText(idPKSave.text);
		idsubREMARK.SetDataText( "" );
		idsubID.SetDataText( "" );
		idsubID.style.display 		= 'none'; 
		idsubREMARK.style.display 	= 'none'; 
	}
}

function OnChange_kind()
{   
    idPK1.SetDataText(idInput1.GetData());
	idKIND.SetDataText(idDTL_KIND.GetData());
	
	if((idDTL_KIND.GetData() == 1) || (idDTL_KIND.GetData() == 3))
	{
		idsubID.SetDataText("");
		idsubID.style.display 	= 'none'; 
		
		idsubREMARK.SetDataText("");		
		idsubREMARK.style.display 	= 'none'; 
	}
	else
	{
		idsubID.style.display 	= ''; 
		idsubREMARK.style.display 	= ''; 
	}
}

function AddOnClick()
{
    idData_Dsql_Code_MST_POPUP.Call();
}

function OnChange_Use()
{
	if(idUSE_IF.value == 1)	{
	}
	else
	{
		idID.SetEnable(true);
		idREMARK.SetEnable(true);
		idCODE_TYPE.SetEnable(true);
		idCODE_LEN.SetEnable(true);
		idSYS_FLAG.SetEnable(true);
		idDTL_KIND.SetEnable(true);
		idREM_NUM1.SetEnable(true);
		idREM_NUM2.SetEnable(true);
		idREM_NUM3.SetEnable(true);
		idREM_CHA1.SetEnable(true);
		idREM_CHA2.SetEnable(true);
		idREM_CHA3.SetEnable(true);
	}
}

function OnRecv_uMST()
{
    if((idDTL_KIND.GetData() == 1) || (idDTL_KIND.GetData() == 3))
	{
		idsubID.SetDataText("");
		idsubREMARK.SetDataText("");
		idsubID.style.display 	= 'none'; 
		idsubREMARK.style.display 	= 'none'; 
	}
	else
	{
		idsubID.style.display 	= ''; 
		idsubREMARK.style.display 	= ''; 	
		
		idData_Dsql_Code_MST_SubCode.Call("SELECT");
	}
}

function UpdateOnClick()
{
    idData_Dsql_chkDTLMST.Call("SELECT");
}

function OnRecv_DTLMST()
{
    if(idnum.GetData() == 0)
	{	
		if(confirm("Do you want to save ?" ))
		{
		    //idCODE_GRP.text
		    
			idData_Dsql_Code_MST_POPUP.Call(); 
			//idData_Dsql_TCode_MST.Call('SELECT');
    	}
	}
	else
	{
		if(idDTL_KIND.GetData() == 1)
		{
		    alert("Group code have any code so can not change upper ...");
		}		
		else
		{
			if(confirm("Do you want to save ?" ))
			{   
			    //idCODE_GRP.text
			   
				idData_Dsql_Code_MST_POPUP.Call();
				//idData_Dsql_TCode_MST.Call('SELECT');
			}
		
		}
	}    
}
</script>

<body>
<gw:data id="idData_Dsql_CodeGroupTree" > 
    <xml> 
        <dso id="1" type="tree" user="comm"  function="comm.sp_get_tco_abcodegrp" > 
            <input bind="oTreeMST" />
            <output bind="oTreeMST" /> 
        </dso> 
    </xml> 
</gw:data>

<gw:data id="idData_Dsql_Code_MST_POPUP" onreceive="onReMST()" > 
    <xml> 
        <dso id="2" type="control" parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15"  function="comm.sp_get_dsql_code_master_popup" procedure="comm.sp_process_code_master_popup">
            <input>
                <inout  bind="idInput1"/>
                <inout  bind="idID"/>
                <inout  bind="idP_PK"/>
                <inout  bind="idCODE_TYPE" />
                <inout  bind="idCODE_LEN" />
                <inout  bind="idSYS_FLAG" />
                <inout  bind="idDTL_KIND" />
                <inout  bind="idCODE_GRP" />
                <inout  bind="idREM_NUM1" />
                <inout  bind="idREM_NUM2" />
                <inout  bind="idREM_NUM3" />
                <inout  bind="idREM_CHA1" />
                <inout  bind="idREM_CHA2" />
                <inout  bind="idREM_CHA3" />                
                <inout  bind="idREMARK"/>
                <inout  bind="idUSE_IF" />
            </input>
        </dso>
    </xml>
</gw:data>


<gw:data id="idData_Dsql_Code_uMST" onreceive="OnRecv_uMST()" > 
    <xml> 
        <dso id="3" type="control" function="comm.sp_get_dsql_code_umaster" >
            <input>
                <inout  bind="idP_PK" />
                <inout  bind="iduID" />
                <inout  bind="iduREMARK" />                              
            </input>
        </dso>                    
    </xml>
</gw:data>

<gw:data id="idData_Dsql_Code_MST_SubCode" > 
    <xml> 
        <dso id="5" type="control" user="comm"  function="comm.sp_get_code_mst_subcode" > 
            <input>
                <inout bind="idCODE_GRP"/>                
                <inout bind="idsubID"/>
                <inout bind="idsubREMARK"/>
            </input>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="idData_Dsql_chkDTLMST"  onreceive="OnRecv_DTLMST()"> 
    <xml> 
        <dso id="6" type="control" user="comm"  function="comm.sp_get_check" > 
            <input>
                <inout bind="idInput1"/>                
                <inout bind="idnum"/>
            </input>
        </dso> 
    </xml> 
</gw:data>

<table  width="100%" cellpadding="0" cellspacing="0" border="1">
	<tr>
		<td width="35%" >
			<%--<table id="LeftTopTB" height="20" width="100%">
				<tr>					
					<td width="40%">
						<gw:radio id="idCHKSearch" value="1" > 
							<span value="1" > <font color="black" >ID</font></span>
							<span value="2" > <font color="black" >Remark </font> </span>
						</gw:radio >																		
					</td>
					<td width="30%">
						<gw:textbox id="idInput_ID" 		maxlen = "7" 	styles='width:100%' onenterkey ="OnEnterTextBox()" csstype="filter"/>								
					<td width="30%">
					    <gw:imgBtn id="idSearch" img="search" text="Search" onclick="Search()"/>
					</td>
				</tr>
			</table>--%>
		</td>
		<td width="65%">
		    <table id="RightTopTB" height="20">
			    <tr>
				    <td width="70%"><gw:checkbox id="idOPTION"   	value="Y"       defaultvalue="Y|N" />Option</td>
				    <td width="5%"><gw:imgBtn id="idcancel" 		img="cancel"	alt="cancel" onclick="ExitOnClick()"      styles='width:100%' /></td>
				    <td width="5%"><gw:imgBtn id="idBtnReset" 		img="new"    	alt="new"    onclick="ResetOnClick()"  	  styles='width:100%' /></td>
				    <td width="5%"><gw:imgBtn id="idBtnReset_Sub" 	img="new_sub"   alt="newsub" onclick="Reset_SubOnClick()" styles='width:100%' /></td>    				
				    <td width="5%"><gw:imgBtn id="idBtnDelete" 		img="delete"    alt="delete" onclick="DeleteOnClick()" 	  styles='width:100%' /></td>  				    
				    <td width="5%"><gw:imgBtn id="idBtnUpdate" 		img="save"      alt="update" onclick="UpdateOnClick()" 	  styles='width:100%' /></td>
				    <td width="5%"><gw:imgBtn id="idBtnAdd" 		img="save"      alt="save" 	 onclick="AddOnClick()" 	  styles='width:100%' /></td>				    
			    </tr>
		    </table>
		</td>
	</tr>
	<tr>
	<!-- Tree view --> 
	<td width="35%" >		
		  <table align="top"  cellspacing=0 cellpadding=0  width="100%" height="470">		 
			<tr>
				<td height="100%"  >
                    <gw:tree  id="oTreeMST" style="width:100%; height:470;overflow:auto;" onclicknode="treeItemOnclick()" onNodeDrop = "treeDrop()" dragmode=true />
				</td>	
			</tr>
		  </table>
	</td>	
	
	<!--Control-->
	<td width="65%">
        <table id="RightBottomTB" width="100%" height="100%"  align="top" >
            <tr>
			    <td width="100%">
				     <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
				      <tr>
						    <td width="25%" align="right"><font color="black" ><b>Upper &nbsp;</b> </font></td>
						    <td width="75%">
							    <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
							      <tr>
								    <td width="20%"><gw:textbox id="iduID"  text="" styles='width:100%;color:blue' onkeypress="checkKey()"/></td>
								    <td width="80%"><gw:textbox id="iduREMARK"  text="" styles='width:100%' onkeypress="checkKey()"/></td>    								
							      </tr>
							    </table>
						    </td>
				      </tr>
				    </table>
			    </td>
		    </tr>
			<tr>
				<td width="100%">
					 <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
					  <tr>
							<td width="25%" align="right"><font color="black" ><b>ID &nbsp; </b></font></td>
							<td width="75%">
								<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
								  <tr>
									<td width="20%"><gw:textbox id="idID"  text=""  	maxlen = "8" styles='width:100%' 	 csstype="mandatory" onkeypress="checkKey()"/> </td>
									<td width="80%"><gw:textbox id="idREMARK"  text="" 	maxlen = "100" styles='width:100%'   csstype="mandatory" onkeypress="checkKey()"/></td>
									
								  </tr>
								</table>
							</td>
					  </tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="100%">
					 <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
					  <tr>
							<td width="25%" align="right"><font color="black" ><b>Code Type &nbsp; </b></font></td>
							<td width="75%">
								<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
								  <tr>
										<td width="100%">
											<gw:radio id="idCODE_TYPE" value="C" > 
												<span value="N" > <font color="black" >NUMBER</font>&nbsp;&nbsp;&nbsp;</span>
												<span value="C" > <font color="black" >CHAR</font>&nbsp;&nbsp;&nbsp; </span>
											</gw:radio >
										</td>
								  </tr>
								</table>
							</td>
					  </tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="100%">
					 <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
					  <tr>
							<td width="25%" align="right"><font color="black" ><b>Code Length &nbsp; </b></font></td>
							<td width="75%">
								<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
								  <tr>
										<td width="100%">
											<gw:list  id="idCODE_LEN" value="" styles='width:50%' > 
											<data> LIST|1|1|2|2|3|3|4|4|5|5|6|6|7|7|8|8|9|9</data> 
											</gw:list>
										</td>
								  </tr>
								</table>
							</td>
					  </tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="100%">
					 <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
					  <tr>
							<td width="25%" align="right"><font color="black" ><b>Sys Flag &nbsp; </b></font></td>
							<td width="75%">
								<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
								  <tr>
										<td width="100%">
											<gw:checkbox id="idSYS_FLAG" value="Y" defaultvalue="Y|N" />
										</td>
								  </tr>
								</table>
							</td>
					  </tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="100%">
					 <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
					  <tr>
							<td width="25%" align="right"><font color="black" ><b>Detail Kind &nbsp; </b></font></td>
							<td width="75%">
								<table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
								  <tr>
										<td width="50%">
											<gw:radio id="idDTL_KIND" value="0" onchange="OnChange_kind()"> 
												<span value="1" > <font color="black" >Upper</font>&nbsp;&nbsp;&nbsp;</span>
												<span value="3" > <font color="black" >Code</font>&nbsp;&nbsp;&nbsp; </span>
												<span value="2" > <font color="black" >Subcode</font>&nbsp;&nbsp;&nbsp; </span>
											</gw:radio >
										</td>
									
										<td width="20%"><gw:textbox id="idsubID" styles="width:100%;" onkeypress="checkKey()"/> </td>
									 	<td width="30%"><gw:textbox id="idsubREMARK" styles="width:100%;" onkeypress="checkKey()"/> </td>
										<td width="5%"><gw:imgBtn   id="idSearch" styles='width:80%' img="search" text="Search"  onclick="Popup()" /> <td>
								  </tr>
								</table>
							</td>
					  </tr>
					</table>
				</td>
			</tr>
	        <tr>
		        <td width="100%">
			         <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
			          <tr>
				        <td width="25%" align="right"><font color="black" ><b>REM_NUM1 &nbsp; </b></font></td>
				        <td width="75%">
					        <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
					          <tr>
							    <td width="100%"><gw:textbox id="idREM_NUM1"  text="" maxlen = "100" styles='width:100%' onkeypress="checkKey()" /></td>
					          </tr>
					        </table>
				        </td>
			          </tr>
			        </table>
		        </td>
	        </tr>
	        <tr>
		        <td width="100%">
			         <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
			          <tr>
					        <td width="25%" align="right"><font color="black" ><b>REM_NUM2 &nbsp; </b></font></td>
					        <td width="75%">
						        <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
						          <tr>
								        <td width="100%"><gw:textbox id="idREM_NUM2"  text="" maxlen = "100" styles='width:100%' onkeypress="checkKey()"/></td>
						          </tr>
						        </table>
					        </td>
			          </tr>
			        </table>
		        </td>
	        </tr>
	        <tr>
		        <td width="100%">
			         <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
			          <tr>
					        <td width="25%" align="right"><font color="black" ><b>REM_NUM3 &nbsp; </b></font></td>
					        <td width="75%">
						        <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
						          <tr>
								        <td width="100%"><gw:textbox id="idREM_NUM3"  text="" maxlen = "100" styles='width:100%' onkeypress="checkKey()"/></td>
						          </tr>
						        </table>
					        </td>
			          </tr>
			        </table>
		        </td>
	        </tr>
	        <tr>
		        <td width="100%">
			         <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
			          <tr>
					        <td width="25%" align="right"><font color="black" ><b>REM_CHA1 &nbsp; </b></font></td>
					        <td width="75%">
						        <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
						          <tr>
								        <td width="100%"><gw:textbox id="idREM_CHA1"  text="" maxlen = "100" styles='width:100%' onkeypress="checkKey()"/></td>
						          </tr>
						        </table>
					        </td>
			          </tr>
			        </table>
		        </td>
	        </tr>
	        <tr>
		        <td width="100%">
			         <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
			          <tr>
					        <td width="25%" align="right"><font color="black" ><b>REM_CHA2 &nbsp; </b></font></td>
					        <td width="75%">
						        <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
						          <tr>
								        <td width="100%"><gw:textbox id="idREM_CHA2"  text="" maxlen = "100" styles='width:100%' onkeypress="checkKey()"/></td>
						          </tr>
						        </table>
					        </td>
			          </tr>
			        </table>
		        </td>
	        </tr>
	        <tr>
		        <td width="100%">
			         <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
			          <tr>
					        <td width="25%" align="right"><font color="black" ><b>REM_CHA3 &nbsp; </b></font></td>
					        <td width="75%">
						        <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
						          <tr>
								        <td width="100%"><gw:textbox id="idREM_CHA3"  text="" maxlen = "100" styles='width:100%' onkeypress="checkKey()"/></td>
						          </tr>
						        </table>
					        </td>
			          </tr>
			        </table>
		        </td>
	        </tr>
        	
	        <tr>
		        <td width="100%">
			         <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
			          <tr>
					        <td width="25%" align="right"><font color="black" ><b>USE_IF &nbsp; </b></font></td>
					        <td width="75%">
						        <table  border="0" cellpadding="0" cellspacing="0" style="width:100%;" >
						          <tr>
								        <td width="100%">
									        <gw:checkbox id="idUSE_IF"   value="1" defaultvalue="0|1" onchange="OnChange_Use()"/>
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
<gw:textbox id="idInput1" 	style="Display:None" />
<gw:textbox id="idpPKSave"  style="Display:none" /> 
<gw:textbox id="idPKSave" 	style="Display:none" /> 
<gw:textbox id="idP_PK"  	style="Display:none" />
<gw:textbox id="idYNCODE"   style="Display:none" />  
<gw:textbox id="idCODE_GRP" style="Display:None"/> 
<gw:textbox id="idDEL_IF"  	style="Display:None" />
<gw:textbox id="idCRT_DT" 	style="Display:None" />
<gw:textbox id="idCRT_BY" 	style="Display:None" /> 
<gw:textbox id="idMOD_DT" 	style="Display:None" />
<gw:textbox id="idMOD_BY" 	style="Display:None" />
<gw:textbox id="idsubPK" 	style="Display:none" />   
<gw:textbox id="idnum"      style="Display:none" />
<gw:textbox id="idPK1"  	style="Display:None" />   
<gw:textbox id="idKIND"  	style="Display:None" />   

<gw:textbox id="test"  	style="Display:None" />   
</body>
</html>
