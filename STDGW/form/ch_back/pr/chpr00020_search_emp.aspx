<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{ 	
    grdEmployee.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
    
	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}

}
function OnSearch()
{
    datEmployeePopup.Call("SELECT");
}
function OnSelect()
{
    OnExit();
}
function OnExit()
{
    var obj= Array();
    var irow;
    irow=grdEmployee.row;
    if (irow>0) 
    {
        obj[0]=grdEmployee.GetGridData(irow,0); //pk
        obj[1]=grdEmployee.GetGridData(irow,3); //emp id
        obj[2]=grdEmployee.GetGridData(irow,4); //full name
        obj[3]=grdEmployee.GetGridData(irow,5); //org_pk
        obj[4]=grdEmployee.GetGridData(irow,1); //org_nm
        obj[5]=grdEmployee.GetGridData(irow,6); //approve_pk
        obj[6]=grdEmployee.GetGridData(irow,7); //approve_id
        obj[7]=grdEmployee.GetGridData(irow,8); //approve_nm
    }    
    else 
    {
        obj=null;
    }
	window.returnValue = obj; 
	window.close();
}
function EXITOnClick()
{
	OnExit();
}
//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
      /* if (obj.id=="datUser_info")
       {
            datTeamData.Call();
       } 
        else if (obj.id=="datDeptData")
       {
            if(txtHr_level.text=="6")
                    txtDeptData.text=txtDeptData.text+"|ALL|Select All";
                lstOrg.SetDataText(txtDeptData.text)    ;
                
                  obj=lstOrg.GetControl()
		        if (obj.options.length ==2)
			        obj.options.selectedIndex=0;
		        else
			        obj.options.selectedIndex=obj.options.length-1;
            datTeamData.Call();
       }
       else if (obj.id=="datTeamData")
       {
            obj=lstWG.GetControl();
	        if (obj.options.length ==2)
		        obj.options.selectedIndex=0;
	        else
		        obj.options.selectedIndex=obj.options.length-1;
            
       }*/
	   
}     
function OnChangeDept()
{
    //txtDept.text=lstDept_Code.value;
    datTeamData.Call();
}
</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmployeePopup"> 
    <xml> 
        <dso  type="grid" function="hr_CHPR10190002_sel_emp_rec"> 
            <input> 
                <input bind="lstOrg" /> 
                <input bind="lstWG" /> 
                <input bind="chkTemp" /> 
                <input bind="txtTemp" /> 
				<input bind="lstNation" /> 
            </input> 
            <output bind="grdEmployee" /> 
        </dso> 
   </xml> 
</gw:data> 
<table style='margin-left:10px' align = top class="itable" cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
	<tr> 
	    <td  align = top >
		    <table align = top  width="100%" style="height:7%">
		        <tr>
			        <td align="Left">
				        <table   border="0" CELLSPACING="0" CELLPADDING="0" style="height:inherit" >
							<tr width="100%">
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
							</tr>
					        <tr>   
						        <td colspan="7" align="right"><font color="black"><b >Organization &nbsp;</b></td>
						        <td colspan="15"><gw:list id="lstOrg" styles="color:black;width:100%" value="ALL" onchange=""> 
									   <data>
											<%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a where a.del_if=0 and a.org_type='06' order by a.seq")%>|ALL|Select All
										</data>
								   </gw:list > 
						        </td>
						        <td colspan="7" align="right"><font color="black"><b>Work-Group &nbsp;</b>
						        </td>
						        <td colspan="15" > <gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                                             <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                                             </td>
						        <td colspan= "" ></td>
						        <td colspan="2" align="left">
							        <gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" />
						        </td>
						        <td colspan="2" ></td>
						        <td colspan="2" align="right">
							       <gw:imgBtn id="ibtnExit" alt="Exit" img="Cancel" text="Exit" onclick="OnExit()" />
						        </td>
					        </tr>
							<tr>   
						        <td colspan="7" align="right"><font color="black"><b >Nation &nbsp;</b></td>
						        <td colspan="10"><gw:list id="lstNation" styles="color:black;width:100%" value="01" onchange=""> 
									   <data>
											<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm")%>|ALL|Select All ...
										</data>
								   </gw:list > 
						        </td>
								<td colspan="5"></td>
						        <td colspan="7" align="right"><font color="black"><b>Search by &nbsp;</b>
						        </td>
						        <td colspan="5">
							        <gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data> 
							        </gw:list>
						        </td>
        						
						        <td colspan="10"> 
							        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
						        <td colspan="" ></td>
					        </tr>
					        <tr>   
						        <td colspan="50" align="left" valign="middle"><font color="black"><b style="color=#FF00CC; font-size:14">Double click on row to select</b></td>
					        </tr>
				        </table>
			        </td>
		        </tr>
		    </table>
	    </td> 
	</tr>		   
	<tr align = top> 
	    <td align = top style="width:100%;height:93%" >
  		    <gw:grid   
			    id="grdEmployee"  
			    header="_PK|Organization|Work Group|Emp ID|Full Name|_ORG_PK|_Approver_PK|Approver_ID|Approver_Name"   
			    format="0|0|0|0|0|0|0|0|0"  
			    aligns="0|0|0|0|0|0|0|0|0"  
			    defaults="||||||||"  
			    editcol="0|0|0|0|0|0|0|0"  
			    widths="0|2000|1500|2000|1000|2500|2000|2000|2000"  
			    styles="width:100%; height:100%"   
			    sorting="T"   
			    autosize="true"
			    oncelldblclick ="OnSelect()" /> 
    	
  	    </td>
    </tr>
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
</body>
</html>

				
