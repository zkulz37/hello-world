<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var p_work_mon="<%=Request.querystring("p_work_mon")%>";

function BodyInit()
{ 	
    grdEmployee.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
        txtWorkMon.text=p_work_mon;   
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
        obj[2]=grdEmployee.GetGridData(irow,5); //full name
        obj[3]=grdEmployee.GetGridData(irow,8); //join date
        obj[4]=grdEmployee.GetGridData(irow,1); //deparment
        obj[5]=grdEmployee.GetGridData(irow,9); //social no
        obj[6]=grdEmployee.GetGridData(irow,2); //group_nm
        obj[7]=grdEmployee.GetGridData(irow,10); //Tel
        obj[8]=grdEmployee.GetGridData(irow,11); //Name_VN
        obj[9]=grdEmployee.GetGridData(irow,12); //Dept_VN
        obj[10]=grdEmployee.GetGridData(irow,13); //Pos_E
        obj[11]=grdEmployee.GetGridData(irow,14); //Pos_VN
        obj[12]=grdEmployee.GetGridData(irow,15); //Pos_Code
        obj[13]=grdEmployee.GetGridData(irow,16); //Dept_pk
        obj[14]=grdEmployee.GetGridData(irow,17); //Group_pk
        obj[15]=grdEmployee.GetGridData(irow,18); //Manager_pk
        obj[16]=grdEmployee.GetGridData(irow,19); //Manager ID
        obj[17]=grdEmployee.GetGridData(irow,20); //Manager Name
        obj[18]=grdEmployee.GetGridData(irow,21); //Education
        obj[19]=grdEmployee.GetGridData(irow,22); //Married_YN
        obj[20]=grdEmployee.GetGridData(irow,23); //PerID
        obj[21]=grdEmployee.GetGridData(irow,24); //PerID
        obj[22]=grdEmployee.GetGridData(irow,25); //Manager kind
        obj[23]=grdEmployee.GetGridData(irow,26); //Manager kind name
        obj[29]=grdEmployee.GetGridData(irow,27); //Manager kind name
        obj[24]=grdEmployee.GetGridData(irow,28); //Company
        obj[25]=grdEmployee.GetGridData(irow,29); //Birthday
        obj[26]=grdEmployee.GetGridData(irow,30); //Sex Kind
        obj[27]=grdEmployee.GetGridData(irow,31); //Phone
        obj[28]=grdEmployee.GetGridData(irow,32); //FName
        obj[29]=grdEmployee.GetGridData(irow,33); //OLD Salary
        obj[30]=grdEmployee.GetGridData(irow,34); //New Salary
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
       if(obj.id == "datEmployeePopup")
       {
         idRecord.text = grdEmployee.rows -1 +" Record(s)";
       }
       
	   
}     
function OnChangeDept()
{
    //txtDept.text=lstOrg.value;
    
}
function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:200;dialogTop:200;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
             lstOrg.value=obj;
             
        }
}
function OnChangeValue(obj)
{
    if(obj=="1")
    {
        if(lstAbsence.value == "ALL")
        {
            alert("Please choose absence type for search.\nBạn phải chọn một kiểu vắng để tìm kiếm.");
            dtFromDate.value="";
            dtToDate.value = "";
        }
    }
    else if(obj == "2")
    {
        if(lstAbsence.value == "ALL")
        {
            alert("Please choose absence type for search.\nBạn phải chọn một kiểu vắng để tìm kiếm.");
            txtTimes.text ="";
        }
    }
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

<gw:data id="datEmployeePopup" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid" function="HR_SEL_10040003_POPUP"> 
            <input> 
                <input bind="lstOrg" /> 
                <input bind="lstWG" /> 
                <input bind="chkTemp" /> 
                <input bind="txtTemp" /> 
				<input bind="lstNation" /> 
				<input bind="txtWorkMon" /> 	
                <input bind="lstAbsence" /> 	
                <input bind="dtFromDate" /> 	
                <input bind="dtToDate" /> 	
                <input bind="txtTimes" /> 				
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
						        <td colspan="7" align="right"><font color="black"><b ><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Organization</a></b></td>
						        <td colspan="15"><gw:list id="lstOrg" styles="color:black;width:100%" value="ALL" onchange=""> 
									   <data>
											<%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
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
									        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data> 
							        </gw:list>
						        </td>
        						
						        <td colspan="10"> 
							        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
						        <td colspan="" ></td>
					        </tr>
                            <tr>   
						        <td colspan="7" align="right"><font color="black"><b >Absence Type </b></td>
						        <td colspan="10">
                                    <gw:list  id="lstAbsence" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                                        <data>
                                            <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0003'")%>|ALL|Select All
                                        </data>
                                    </gw:list>
						        </td>
								<td align=right colspan="5"> Absence Date</td>
						        <td align=left colspan="7" align="right"><font color="black">
                                    <gw:datebox id="dtFromDate" type="date" styles='width:100%' nullaccept onchange="OnChangeValue(1)"  lang="<%=Session("Lang")%>"/>
						        </td>
						        <td align=right colspan="5">
							        <gw:datebox id="dtToDate" type="date" styles='width:100%' nullaccept onchange="OnChangeValue(1)"  lang="<%=Session("Lang")%>"/>
						        </td>
        						
						        <td align=right colspan="7"> 
							        <b>Absence Times >=</b>
						        </td>
                                <td align=left colspan="3"> 
							        <gw:textbox id="txtTimes" onchange  ="OnChangeValue(2)" styles='width:100%'/>
						        </td>
						        <td align=center colspan="6" >
                                    <gw:label id="idRecord" text="0 Records" styles="color:red;width:100%;font-weight: bold;font-size:12" ></gw:label>
                                </td>
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
			    header="_PK|Organization|Work Group|Emp ID|Card ID|Full Name|OLD CODE|Personal ID|Join Date|_social_no|_Tel|_Name_VN|_Dept_VN|_Pos_nm|_Pos_Kname|_Pos_Type|_Dept_PK|_Group_PK|_Approver_PK|_Approver_ID|_Approver_Name|_Education|_Married_YN|_PersonID|_Address|_manager_kind|manager nm|Email|_COMPANY_PK|Birthday|Sex|Tel|Full_FName|_ol_sal|new_sal"   
			    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    aligns="0|0|0|1|1|0|1|1|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|0|0|0"  
			    defaults="|||||||||||||||||||||||||||||||||||"  
			    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    widths="0|2000|1500|1000|1000|2500|0|2000|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
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
    <gw:textbox id="txtWorkMon" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
</body>
</html>

				
