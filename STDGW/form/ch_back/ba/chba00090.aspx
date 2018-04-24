<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user= "<%=session("USER_ID")%>";
   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
}
//----------------------------------------------
function OnDataReceive(obj)
{
    if (obj.id=="datRegisterOT")
    {
            lblRecord.text=idGrid.rows-1 +" Record(s)";
    }    
       
}
//----------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//------------------------------------------------
function OnChangeDept()
{
    datGroupData.Call();
}
//----------------------------------------------------
function OnSearch()
{
    datRegisterOT.Call("SELECT");
}


//-----------------------------------------------
function OnReport()
{
        var url =System.RootURL + '/reports/ch/ba/rpt_register_ot.aspx?p_tco_dept_pk=' + lstOrg_Code.value + '&p_thr_group_pk=' + lstWGrp_Code.value + '&p_dt=' + dtDate.value + '&p_workshift=' + lstWS.value + '&p_search_by=' + idSearch.value + '&p_search_temp=' + idtxtTmp.text;
        window.open(url); 
}
</script>
<body >
<!-------------------data control----------------------->

<!------------------------------------------>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datRegisterOT" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0" function="HR_SEL_10020009"> 
                <input bind="idGrid" >
                    <input bind="lstOrg_Code" />
                    <input bind="lstWGrp_Code" />
                    <input bind="lstWS" />
                    <input bind="dtDate" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
   <table id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:10%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td width="10%" style="border:0;" align="right" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" >Organization</a>                  
                        </td>
                        <td width="15%" style="border:0;" align="left" >
                         <gw:list  id="lstOrg_Code"  value="ALL" styles='width:100%' onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM TCO_ORG A WHERE A.DEL_IF=0 CONNECT BY PRIOR  A.PK=A.P_PK START WITH NVL(A.P_PK,0)=0")%>|ALL|Select All
                                </data>
                            </gw:list>
                        </td>
                        <td width="8%" style="border:0;" align="right" >Work Group</td>
                        <td width="13%" style="border:0;" align="left" >
                         <gw:list  id="lstWGrp_Code" value="ALL"  styles='width:100%' >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0") %>|ALL|Select All
                            </data></gw:list></td>
                        <td width="9%" style="border:0;" align="right">Work Shift</td>
				        <td colspan=5 width="26%" style="border:0;"><gw:list  id="lstWS" value="ALL"  maxlen = "100" styles='width:100%' onchange="OnChangeShift()">
                           <data><%=ESysLib.SetListDataSQL("SELECT pk,shift||'-'||remark FROM thr_work_shift WHERE DEL_IF = 0 and use_yn='Y'  order by shift")%>|ALL|WS-Select All</data></gw:list></td>
                        <td width="7%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport()"/>
                        </td>
                        <td width="3%" style="border:0" align="right"></td>
                        <td width="3%" style="border:0" align="right"></td>
                        <td width="3%" style="border:0" align="right"></td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td  style="border:0" align="right" valign="middle">Search by</td>
					    <td  style="border:0">
					        <gw:list  id="idSearch" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list>
				        </td>
                        <td colspan=2 align=right  style="border:0"> 
					        <gw:textbox id="idtxtTmp" onenterkey   ="OnSearch()" styles='width:96%'/>
				        </td>
                        
                         <td style="border:0;" align="right" >Date</td>
                        <td  colspan=2 style="border:0;" align="left" ><gw:datebox id="dtDate"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
                        <td  colspan=1 style="border:0;" align="right" >
                        
                        </td>
						<td style='width:10%' style="border:0;" align="right" >
						
                    <!--    <gw:list  id="idNation" value="01" styles='width:100%' onchange=""> 
							        <data><%=Esyslib.SetListDataSQL("select code, code_nm from vhr_hr_code v where v.id='HR0009'" )%>|ALL|Select All</data> 
					        </gw:list> -->
                        </td>
                        <td colspan=3 style="border:0" align="right"><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" />
                        </td>
                        <td align="right" style="border:0" valign="bottom"></td>
                    </tr>
                    
                </table>
                <table width="100%" id="tblMaster" style="height:90%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:50%" valign="top">
                        <td colspan=15 style="width:100%;height:50%;"> 
                             <gw:grid   
                                id="idGrid"  
                                header="Department|Group|Emp ID|Full Name|Join DT|Position|Job"   
                                format="0|0|0|0|0|0|0"  
                                aligns="0|0|0|0|0|0|0"  
                                defaults="||||||"  
                                editcol="0|0|0|0|0|0|0"  
                                widths="3000|3000|1000|3000|1500|1500|1500"  
                                styles="width:100%; height:100%" 
                                sorting="T"   /> 
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtEmp_PK" styles="display:none"/>
<gw:textbox id="txtReg_PK" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
</body>


</html>
