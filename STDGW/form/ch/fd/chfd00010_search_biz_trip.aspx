<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>
<head runat="server">
    <title>Search Biz Trip</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var binit=true;
function BodyInit()
{ 	
    grdEmployee.GetGridControl().ScrollTrack=true;
    grdEmployee.GetGridControl().FrozenCols =5;
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
     txtTemp.text= "<%=session("emp_id")%>";
	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	else
	    datBiz_Trip_Popup.Call("SELECT");

}
function OnSearch()
{
    datBiz_Trip_Popup.Call("SELECT");
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
       if (obj.id=="datUser_info")
       {
            if (binit==true)
			{
			    datBiz_Trip_Popup.Call("SELECT");
			    bibit=false;
			}
       } 
	   else if (obj.id=="datBiz_Trip_Popup")
	        lblRecord.text=grdEmployee.rows-1 + " record(s)";
}     
function OnChangeDept()
{
    //txtDept.text=lstDept_Code.value;
    datGroupData.Call();
}
</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstDept" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                    <input bind="lstDept" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datBiz_Trip_Popup" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_Biz_Trip_Popup"> 
            <input> 
                <input bind="lstDept" /> 
                <input bind="lstGroup" /> 
                <input bind="chkTemp" /> 
                <input bind="txtTemp" /> 
                <input bind="dtFrom" /> 
                <input bind="dtTo" /> 
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
						        <td width="10%" align="right"><font color="black"><b >Department &nbsp;</b></td>
						        <td width="15%"><gw:list id="lstDept" styles="color:black;width:100%" value="ALL" onchange=""> 
	                                           <data><%=ESysLib.SetListDataSQL("SELECT PK,org_NM FROM comm.TCO_org WHERE DEL_IF = 0 order by org_ID")%>|ALL|Select All</data>
	                                           </gw:list > 
						        </td>
						        <td width="7%" align="right"><font color="black"><b >WGroup &nbsp;</b></td>
						        <td width="15%" colspan=2><gw:list id="lstGroup" styles="color:black;width:100%" value="ALL" onchange=""> 
	                                            <data><%=ESysLib.SetListDataSQL("SELECT PK,WorkGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workGroup_id")%>|ALL|Select All</data>
	                                            </gw:list > 
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
						        <td  colspan=2 align="left" valign="middle"><font color="black"><b style="color=#FF00CC; font-size:14">Double click on row to select</b></td>
						        <td  align="right"><font color="black"><b >Period &nbsp;</b></td>
						        <td  align="left" width="10%"><font color="black"><gw:datebox id="dtFrom"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="center" width="5%"><font color="black"><b >~</b></td>
						        <td  align="left"><font color="black"><gw:datebox id="dtTo"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="center" colspan=3><i><gw:label id="lblRecord" text="0 record(s)" styles="width:100%" ></gw:label></i></td>
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
			    header='_PK|Applicant No|Group NM|Emp ID|Full Name|Approver ID|Approver Name|_Cost Center|_Cost Type|Visiting Place|From|To'
                format='0|0|0|0|0|0|0|0|0|0|0|0'
                aligns='0|0|0|0|0|0|0|0|0|0|0|0'
                defaults='|||||||||||'
                editcol='1|1|1|1|1|1|1|1|1|1|1|1'
                widths='810|1560|1500|1305|2175|1320|2335|1515|1125|1635|1215|1200'
                sorting='T'
                styles='width:100%; height:100%'
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

				
