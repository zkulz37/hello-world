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
    datRecPopup.Call("SELECT");
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
//    _PK|_org_pk|Organization|_wg_pk|Work Group|Full Name|Birth Day|_birth_place_code|Birth_Place|_sex_code|Sex|Personal ID|Issue Date|_place_id_code|Place ID|Join Date|
//    permanent addr|_Pos_type|Position|_prob_type_code|Prob Type|Begin Probation|End Probation|_ethinic_code|Ethnic|_religion_code|Religion|_edu_code|Education|_nation_code|
//    Nation|_salary_type_code|Salary Type|_money_kind_code|Money Kind|_employee_type_code|Employee Type|_sal_period_code|Salary Period|Annual Leave

        obj[0]=grdEmployee.GetGridData(irow,0); //pk
        obj[3]=grdEmployee.GetGridData(irow,5); //Full Name
        obj[1]=grdEmployee.GetGridData(irow,1); //_org_pk
        obj[2]=grdEmployee.GetGridData(irow,3); //_wg_pk
        
        obj[4]=grdEmployee.GetGridData(irow,6); //Birth Day
        obj[5]=grdEmployee.GetGridData(irow,7); //_birth_place_code
        obj[6]=grdEmployee.GetGridData(irow,9); //_sex_code
        obj[7]=grdEmployee.GetGridData(irow,11); //Personal ID
        obj[8]=grdEmployee.GetGridData(irow,12); //Issue Date
        obj[9]=grdEmployee.GetGridData(irow,13); //_place_id_code

        obj[10]=grdEmployee.GetGridData(irow,15); //Join Date
        obj[11]=grdEmployee.GetGridData(irow,16); //permanent addr
        obj[12]=grdEmployee.GetGridData(irow,17); //_Pos_type
        obj[13]=grdEmployee.GetGridData(irow,19); //_prob_type_code
        obj[14]=grdEmployee.GetGridData(irow,21); //Begin Probation
        obj[15]=grdEmployee.GetGridData(irow,22); //Begin Probation
        obj[16]=grdEmployee.GetGridData(irow,23); //_ethinic_code
        obj[17]=grdEmployee.GetGridData(irow,25); //_religion_code
        obj[18]=grdEmployee.GetGridData(irow,27); //_edu_code
        obj[19]=grdEmployee.GetGridData(irow,29); //_nation_code
        obj[20]=grdEmployee.GetGridData(irow,31); //_salary_type_code
        obj[21]=grdEmployee.GetGridData(irow,33); //_money_kind_code
        obj[22]=grdEmployee.GetGridData(irow,35); //_employee_type_code
        obj[23]=grdEmployee.GetGridData(irow,37); //_sal_period_code
        obj[29]=grdEmployee.GetGridData(irow,39); //Annual Leave        
    }    
    else 
    {
        obj=null;
    }
    //alert(obj[0]);
	window.returnValue = obj; 
	window.close();
}
function EXITOnClick()
{
	OnExit();
}
 
</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->
<gw:data id="datUser_info" onreceive=""  > 
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

<gw:data id="datRecPopup"> 
    <xml> 
        <dso  type="grid" function="HR_sel_10010077_recruit_popup"> 
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
						        <td colspan="7" align="right"><font color="black"><b >Organization </b></td>
						        <td colspan="15"><gw:list id="lstOrg" styles="color:black;width:100%" value="ALL" onchange=""> 
									   <data>
											<%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a where a.del_if=0 and a.org_type='06' order by a.seq")%>|ALL|Select All
										</data>
								   </gw:list > 
						        </td>
						        <td colspan="7" align="right"><font color="black"><b>Work-Group </b>
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
						        <td colspan="7" align="right"><font color="black"><b >Nation </b></td>
						        <td colspan="10"><gw:list id="lstNation" styles="color:black;width:100%" value="01" onchange=""> 
									   <data>
											<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm")%>|ALL|Select All ...
										</data>
								   </gw:list > 
						        </td>
								<td colspan="5"></td>
						        <td colspan="7" align="right"><font color="black"><b>Search by </b>
						        </td>
						        <td colspan="5">
							        <gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|4|Per ID</data> 
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
			    header="_PK|_org_pk|Organization|_wg_pk|Work Group|Full Name|Birth Day|_birth_place_code|Birth_Place|_sex_code|Sex|Personal ID|Issue Date|_place_id_code|Place ID|Join Date|permanent addr|_Pos_type|Position|_prob_type_code|Prob Type|Begin Probation|End Probation|_ethinic_code|Ethnic|_religion_code|Religion|_edu_code|Education|_nation_code|Nation|_salary_type_code|Salary Type|_money_kind_code|Money Kind|_employee_type_code|Employee Type|_sal_period_code|Salary Period|Annual Leave" 
			    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    aligns="0|0|1|0|1|0|1|0|1|0|1|1|1|0|1|1|0|0|1|0|1|1|1|0|1|0|1|0|1|0|1|0|1|0|1|0|1|0|1|1"  
			    defaults="||||||||||||||||||||||||||||||||||||||||"  
			    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    widths="0|0|2000|0|2000|2500|1500|0|2000|0|1500|1500|1500|0|2000|1500|2000|0|1500|0|1500|1500|1500|0|1500|0|1500|0|1500|0|1500|0|1500|0|1500|0|1500|0|1500|1500"  
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

				
