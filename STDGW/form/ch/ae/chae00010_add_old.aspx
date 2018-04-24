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
        obj[1]=grdEmployee.GetGridData(irow,1); //pk
        obj[2]=grdEmployee.GetGridData(irow,2); //pk
        obj[3]=grdEmployee.GetGridData(irow,3); //pk
        obj[4]=grdEmployee.GetGridData(irow,4); //pk
        obj[5]=grdEmployee.GetGridData(irow,5); //pk
        obj[6]=grdEmployee.GetGridData(irow,6); //pk
        obj[7]=grdEmployee.GetGridData(irow,7); //pk
        obj[8]=grdEmployee.GetGridData(irow,8); //pk
        obj[9]=grdEmployee.GetGridData(irow,9); //pk
        obj[10]=grdEmployee.GetGridData(irow,10); //pk
        obj[11]=grdEmployee.GetGridData(irow,11); //pk
        obj[12]=grdEmployee.GetGridData(irow,12); //pk
        obj[13]=grdEmployee.GetGridData(irow,13); //pk
        obj[14]=grdEmployee.GetGridData(irow,14); //pk
        obj[15]=grdEmployee.GetGridData(irow,15); //pk
        obj[16]=grdEmployee.GetGridData(irow,16); //pk
        obj[17]=grdEmployee.GetGridData(irow,17); //pk
        obj[18]=grdEmployee.GetGridData(irow,18); //pk
        obj[19]=grdEmployee.GetGridData(irow,19); //pk
        obj[20]=grdEmployee.GetGridData(irow,20); //pk
        obj[21]=grdEmployee.GetGridData(irow,21); //pk
        obj[22]=grdEmployee.GetGridData(irow,22); //pk
        obj[23]=grdEmployee.GetGridData(irow,23); //pk
        obj[24]=grdEmployee.GetGridData(irow,24); //pk
        obj[25]=grdEmployee.GetGridData(irow,25); //pk
        obj[26]=grdEmployee.GetGridData(irow,26); //pk
        obj[27]=grdEmployee.GetGridData(irow,27); //pk
        obj[28]=grdEmployee.GetGridData(irow,28); //pk
        obj[29]=grdEmployee.GetGridData(irow,29); //pk
        obj[30]=grdEmployee.GetGridData(irow,30); //pk
        obj[31]=grdEmployee.GetGridData(irow,31); //pk
        obj[32]=grdEmployee.GetGridData(irow,32); //pk
        obj[33]=grdEmployee.GetGridData(irow,33); //pk
        obj[34]=grdEmployee.GetGridData(irow,34); //pk
        obj[35]=grdEmployee.GetGridData(irow,35); //pk
        obj[36]=grdEmployee.GetGridData(irow,36); //pk
        obj[37]=grdEmployee.GetGridData(irow,37); //pk
        
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
  

</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->
<gw:data id="datEmployeePopup"> 
    <xml> 
        <dso  type="grid" function="hr_sp_sel_add_old"> 
            <input> 
                <input bind="lstOrg_Code" /> 
                <input bind="chkTemp" /> 
                <input bind="txtTemp" /> 
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
					        <tr>   
						        <td width="10%" align="right"><font color="black"><b >Organization</b></td>
						        <td width="25%"><gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list> 
						        </td>
						        <td width="10%" align="right"><font color="black"><b>Search by &nbsp;</b>
						        </td>
						        <td width="8%">
							        <gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data> 
							        </gw:list>
						        </td>
        						
						        <td width="15%"> 
							        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
						        <td width="2%" ></td>
						        <td width="3%" align="left">
							        <gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" />
						        </td>
						        <td width="2%" ></td>
						        <td width="3%" align="right">
							       <gw:imgBtn id="ibtnExit" alt="Exit" img="Cancel" text="Exit" onclick="OnExit()" />
						        </td>
					        </tr>
					        <tr>   
						        <td width="100%" colspan=11 align="left" valign="middle"><font color="black"><b style="color=#FF00CC; font-size:14">Double click on row to select</b></td>
					        </tr>
				        </table>
			        </td>
		        </tr>
		    </table>
	    </td> 
	</tr>		   
	<tr align = top> 
	    <td align = top  width="100%" style="height:93%" >
  		    <gw:grid   
			    id="grdEmployee"  
			    header="_PK|EMP_ID|_employee_type2|FULL_NAME|_FULL_FNAME|_PHOTO_PK|_SEX|_birth_dt|_PLACE_BIRTH|_NATION|_TEL|PERMANENT_ADDR|PRESENT_ADDR|_EDU_TYPE|PERSON_ID|_ISSUE_DT
                |_PLACE_PER_ID|_MARRIED_YN|_ETHNIC_TYPE|_RELIG_TYPE|_ALE_DAY_IN_YEAR|_EMPLOYEE_TYPE|_OT_YN|_JOB_TYPE|_POS_TYPE
                |_SALARY_TYPE|_PASS_PORT_NO|_PASS_PORT_DT|_NET_SALARY_YN|_MONEY_KIND
                |_LABOR_NO|_LABOR_DT|_PIT_TAX_NO|_COST_GROUP|_COST_KIND|_native_country|_newcomer|_k_name"
			    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
			    defaults="|||||||||||||||||||||||||||||||||||||"
			    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
			    widths="1000|1000|1000|3000|1000|1000|1000|1000|1000|1000|1000|3000|3000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000"
			    styles="width:100%; height:100%"   
			    sorting="T"   
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

				
