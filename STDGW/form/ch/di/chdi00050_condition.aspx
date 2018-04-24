<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var binit=true;
var tab2=false;
var flag2=false;
var startTime,interval_time
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
   txtEmpPk.text="<%=Request.QueryString("p_emp_pk") %>";
   datSickCondition.Call("SELECT");
}
function OnSearch()
{   txtEmpPk.text="";
    datSickCondition.Call("SELECT");
}
function OnDataReceive(obj)
{
     if (obj.id=="datDeptData")
   {
        
             txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstOrg_Code.SetDataText(txtDeptData.text)    ;
            lstOrg_Code.value= txtUpperDept.text;		
        
   }
  
}

function OnClickGrid()
{if(grdAbsence.row>0)
        {
                var aRow=new Array();
                aRow[0]=grdAbsence.GetGridData(grdAbsence.row,1) //get emp pk
                aRow[1]=grdAbsence.GetGridData(grdAbsence.row,2) //get group
                window.returnValue = aRow; 			
	            this.close();
        }
}

//--------------------------------------------------
function CheckValid()
{   
}
//------------------------
function OnExit()
{
    window.returnValue = null; 		
	this.close();
}
//---------------------------------------------------
function EXITOnClick()
{
	OnExit();
}//------------------------------------------------
function OnChangeDept()
{
    datGroupData.Call();
}
//-----------------------------------------------
//----------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screeny+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        datDeptData.Call();
    }
    
}
//----------------------------------
</script>
<body >
<!-------------------data control----------------------->
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                    <input bind="lstOrg_Code" /> 
                </input> 
                <output>
                    <output bind="lstGrp_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->

<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr_sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
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
<!--------------------------------------------------------------->
<gw:data id="datSickCondition" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr_sp_sel_sick_condition" > 
                <input bind="grdAbsence">
                    <input bind="txtEmpPk" /> 
                    <input bind="lstOrg_Code" /> 
                    <input bind="lstGrp_Code" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" /> 
                    
                    
                   
                </input> 
                <output bind="grdAbsence"/>
            </dso> 
        </xml> 
</gw:data>

<!-------------------table----------------------->
   <table name="Current Sal" id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td width="10%" align="right" style="border:0;"><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Organization</a>                  
                        </td>
                        <td width="13%" align="left" style="border:0;">
                         <gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeDept(lstOrg_Code)" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk,org_nm from tco_org a where del_if=0 order by a.org_nm")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="6%" align="right" style="border:0;">Group</td>
                        <td width="13%"  align="left" style="border:0;">
                         <gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0   order by  workGroup_NM")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  width="8%"  align="right" valign="middle" style="border:0;">Search by</td>
					    <td   width="10%" style="border:0;">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td width="10%" align=center style="border:0" > 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:95%'/></td>
				        <td width="4%" style="border:0;" align="right" ></td>
				        <td width="4%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
                        <td width="4%" style="border:0" align="right">
                        
                        <td width="4%" style="border:0" align="right">
                        
                        </td>
                        <td width="4%" style="border:0" align="right">
                        <gw:imgBtn img="cancel" id="ibtnExit"   alt="Exit"  onclick="OnExit()"/>
                        </td>
                    </tr>
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                      <td colspan=12  ><font style="color:Blue">Double click to choose</font></td>  
                    </tr>
                    <tr style="border:1;width:100%;height:85%" valign="top">
                        <td colspan=12  style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdAbsence"  
                                header="Employee Name|Child Name|Child Birthday"
                                format="0|0|0"  
                                aligns="0|0|0"  
                                defaults="|||"  
                                editcol="0|0|0"  
                                widths="2500|2500|2500"  
                                styles="width:100%; height:100%" 
                                sorting="T" acceptNullDate   
                                oncelldblclick="OnClickGrid()"
                                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    
</body>
<gw:textbox id="txtresult" styles="display:none"/>
<gw:textbox id="txtEmpPk" styles="display:none"/>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  
<gw:textbox id="txtUpperDept" styles="display:none"/>
</html>
