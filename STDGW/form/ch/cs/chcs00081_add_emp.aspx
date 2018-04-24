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

    var   
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>";
       grdEmployee.SetComboFormat(5,t1); //position

    datCheck_Close.Call();
}
function OnSearch()
{
    datEmployeePopup.Call("SELECT");
}


//--------------------------------------------------------------------------
function OnSelectRow()
{
    
  
    var aData =new Array();
    var j;
    j=0;
    
    for (var i=1;i<grdEmployee.rows;i++)
    {
        if (grdEmployee.GetGridData(i,0)=='-1')
        {   
           var aRow=new Array();
            aRow[0]=grdEmployee.GetGridData(i,1); //THR_EMP_PK
            aRow[1]=grdEmployee.GetGridData(i,2); //emp id
            aRow[2]=grdEmployee.GetGridData(i,3); //full name
            aRow[3]=grdEmployee.GetGridData(i,4); //department
            aRow[4]=dtMonth.value; //work mon
            aRow[5]= txtflag.text; //flag close yn

            aData[j]=aRow;
            j=j+1;

        }
        
    }
    
    window.returnValue = aData; 			
	this.close();
}

function OnExit()
{
    EXITOnClick();
}
function EXITOnClick()
{
	window.returnValue = null; 
	window.close();
}
//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
       if (obj.id=="datUser_info")
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
            //obj=lstWG.GetControl();
	        if (obj.options.length ==2)
		        obj.options.selectedIndex=0;
	        else
		        obj.options.selectedIndex=obj.options.length-1;
            
       }
       else if(obj.id=="datEmployeePopup")
       {
            idRecord.text=grdEmployee.rows-1 + " Records.";
       }
	   
}     
function OnChangeDept()
{
    //txtDept.text=lstDept_Code.value;
    datTeamData.Call();
}


//--------------------------------

function OnCheckAll()
{
    var tmp;
    if(chkSelectAll.GetData()=='T')
        tmp=-1;
    else
        tmp=0;
        
    var ctrl=grdEmployee.GetGridControl();
	if(ctrl.SelectedRows>0)
		for(var i=0;i<ctrl.SelectedRows;i++)
    		grdEmployee.SetGridText(ctrl.SelectedRow(i),0,tmp);
}
function OnChangeMon()
{
    datCheck_Close.Call();
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


<gw:data id="datEmployeePopup" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid" function="hr_sel_10030023_popup"> 
            <input> 
                <input bind="lstOrg" /> 
                <input bind="lstPos" /> 
                <input bind="chkTemp" /> 
                <input bind="txtTemp" />
                <input bind="dtMonth" />
                <input bind="lststatus" />
            </input> 
            <output bind="grdEmployee" /> 
        </dso> 
   </xml> 
</gw:data> 
<gw:data id="datCheck_Close" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030023_check_mon" > 
                <input>
                    <input bind="dtMonth" /> 
                </input> 
                <output>
                    <output bind="txtflag" />
                </output>
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
						        <td colspan="15"><gw:list id="lstOrg" styles="color:black;width:100%" value="ALL" > 
									   <data>
											<%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM TCO_ORG A WHERE A.DEL_IF=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All
										</data>
								   </gw:list > 
						        </td>
						        <td colspan="7" align="right"><font color="black"><b>Position</b>
						        </td>
						        <td colspan="13" > <gw:list  id="lstPos" value='ALL' maxlen = "100" styles='width:100%' >
                                             <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All</data></gw:list>
                                             </td>
						        <td colspan= "" ></td>
						        <td colspan="2" align="left">
							       
						        </td>
						        <td colspan="2" align="right">
							       <gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" />
						        </td>
						        <td colspan="2" align="right">
							        <gw:imgBtn id="ibtnSelect" alt="Select" img="Select" text="Exit" onclick="OnSelectRow()" />
						        </td>
						        <td colspan="2" align="right">
							       <gw:imgBtn id="ibtnExit" alt="Exit" img="Cancel" text="Exit" onclick="OnExit()" />
						        </td>
					        </tr>
							<tr>   
						        <td colspan="7" align="right"><font color="black">Work Month</td>
						        <td colspan="4"><gw:datebox id="dtMonth"  maxlen = "10" text="" onchange="OnChangeMon()" styles='width:100%'lang="<%=Session("Lang")%>" type=month />
						        </td>
						        <td colspan="5" ></td>
								<td colspan="6"></td>
						        <td colspan="7" align="right"><font color="black"><b>Search by </b>
						        </td>
						        <td colspan="5">
							        <gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data> 
							        </gw:list>
						        </td>
        						
						        <td colspan="8"> 
							        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
						        
						        <td colspan="3" align="right" >status</td>
						        <td colspan="5" >
						         <gw:list  id="lststatus" value="A" styles='width:100%' onchange=""> 
									        <data>|A|Active|R|Resign|ALL|Select All</data> 
							        </gw:list>
						        </td>
					        </tr>
					        <tr>   
					            <td colspan="3" align="right"><gw:checkbox id="chkSelectAll" value="F" onclick="OnCheckAll()" ></gw:checkbox ></td>
						        <td colspan="4" align="left">Select</td>
						        <td colspan="4">
						        </td>
						        <td colspan="8" align="right"></td>
								<td colspan="3"></td>
						        <td colspan="7" align="right"></b>
						        </td>
						        <td colspan="5">
							      
						        </td>
        						
						        <td colspan="8"> 
							        
						        </td>
						        
						        <td colspan="3" align="right" ></td>
						        <td colspan="5" style="color=#FF00CC" ><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label>
						        
						        </td>
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
			    header="Select|_THR_EMP_PK|EMP_ID|FULL NAME|DEPARTMENT|POSITION|JOIN DATE|_JOB"
					format="3|0|0|0|0|0|4|1"
					aligns="0|0|0|0|0|0|0|0"
					defaults="|||||||"
					editcol="0|0|0|0|0|0|0|0"
					widths="1000|0|2000|3000|2000|2000|1500|500" 
			    styles="width:100%; height:100%"   
			    sorting="T"   
			    
			   /> 
    	
  	    </td>
    </tr>
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtflag"  styles="display:none"/>
</body>
</html>

				
