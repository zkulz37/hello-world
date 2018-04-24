<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("hr")%>
<head>
    <title>General Info - Employee</title>

    <script>
 //---------------------------------------------------------
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var flag=0;
var main_col=0;
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    idemp_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user= "<%=session("USER_ID")%>";   
    if((Trim(idemp_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        datUser_info.Call();     	    
    else
        lstDept_Code.value="ALL";
    //<%=ESysLib.SetGridColumnComboFormat( "idGrid" , 5 ,  "select a.PK, a.TASK_NAME from prod.tpr_task a where a.DEL_IF=0 and a.USE_YN = 'Y' order by task_name") %>; //group         
    onClickOption(1);
 }
 
 
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {      
        datGroupData.Call();
   }
   if (obj.id=="datGroupData")
   {
        lstGrp_Code.SetDataText(txtGroupData.text);
        var obj=lstGrp_Code.GetControl();
        if (obj.options.length ==2)
		    obj.options.selectedIndex=0;
	    else
		    obj.options.selectedIndex=obj.options.length-1;/**/
        datTaskData.Call();
   }
   if (obj.id=="datTaskData")
   {
        lstTask_Code.SetDataText(txtTaskData.text);        
        var ctrl=lstTask_Code.GetControl();   
        if(ctrl.options.length==2)
            ctrl.options.selectedIndex=0;
        else            
            ctrl.options.selectedIndex=ctrl.options.length-1;
       /* 
        lstTask_Code1.SetDataText(txtTaskData.text);
        var ctrl1=lstTask_Code1.GetControl();   
        if(ctrl1.options.length==2)
            ctrl1.options.selectedIndex=0;
        else            
            ctrl1.options.selectedIndex=ctrl1.options.length-1;
            /**/
   }   
   if (obj.id=="datEmp")
   {
        idRecord.text= idGrid.rows-1 + " record(s)";
   }
         
}
 //---------------------------------------------------------
function OnSearch()
{
    datEmp.Call("SELECT");
}
 
function OnShowPopup()
{
    
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:260;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstDept_Code.value=obj;
        txtUpperDept.text=obj;
        OnChangeDept(lstDept_Code);
    } 
    /**/   
}

function OnShowItemPopup()
{    
    var url = System.RootURL + '/form/ch/gc/chgc00060_01.aspx?p_group=' + lstGrp_Code.value + '&p_from_dt=' + idFrom_DT.value + '&p_to_dt='+idTo_DT.value;
    var obj = System.OpenModal( url , 650 , 350 , 'resizable:no;status:yes') ;
    if(obj!=null)
    {
        lstItem.value=obj;
    }
} 
function OnChangeDept(depObj)
{
    txtDeptData.text=depObj.value;
    datGroupData.Call();
}

function OnChangeGroup(grp)
{
    datTaskData.Call();
}

function onClickOption(num)
{
   
} 


function OnReport(num)
{    
   
}
function OnSave()
{
    if(confirm("Are you sure to save these change(s), Old these data of these Emp(s) will be deleted"))
    {
        datEmp.Call();
    }
}
function OnDelete()
{
    if(confirm("Are you sure to delete ?"))
    {
        idGrid.DeleteRow();
        //datEmp.Call();
    }
}

/*
function OnSetGrid()
{
    var ctrl = idGrid.GetGridControl();
    if(lstTask_Code1.value=='ALL')
    {
        alert('Choose task plan to set to selected rows on grid !');
        return;
    }
    txtTaskText.text=lstTask_Code1.value;
    for(var i=0; i<ctrl.SelectedRows;i++)
    {        
        var c=ctrl.SelectedRow(i);
        idGrid.SetGridData(c,5,txtTaskText);
    }
}/**/
</script>

</head>
<body>
 <gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="idemp_pk" />
                </input> 
                <output>
                    <output bind="lstDept_Code" />
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

<!------------------------------------->
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                   <input bind="txtDeptData" />
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datTaskData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_task_data_all" > 
                <input>
                   <input bind="lstDept_Code" /> 
                   <input bind="lstGrp_Code" />
                </input> 
                <output>
                    <output bind="txtTaskData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmp" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0" function="hr.sp_sel_manage_price" procedure=""> 
                <input bind="idGrid" >
                    <input bind="lstDept_Code" />
                    <input bind="lstGrp_Code" />
                    <input bind="lstTask_Code" />
                    <input bind="idFrom_DT" /> 
                    <input bind="idTo_DT" />                                        
                    <input bind="lstItem" />                      
                    <input bind="lstTmp" />
                    <input bind="txtTmp" />
                    <input bind="lstStatus" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<form name="Group Emp Task" id="EmpTask" > 
   <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	    <table style="width:100%;height:8%" cellpadding="0" cellspacing="0" valign="top" border="1" >		    
            <tr style=" height:5%; border:1">	                
                <td colspan=2 align=right style="width:10%;border:0" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF"><font size=2>Department</font></a></td>
		        <td colspan=1 align=right style="width:15%;border:0">
		            <gw:list  id="lstDept_Code"  maxlen = "100" styles='width:100%' onchange="OnChangeDept(lstDept_Code)" >
                    <data>
                        <%=ESysLib.SetListDataSQL("select a.pk,a.dept_nm from comm.tco_dept a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>
                
                <td colspan=2 align=right style="width:10%;border:0">
		            <font size=2>Group</font>
                </td>
                <td colspan=2 align=right style="width:20%;border:0">
		            <gw:list  id="lstGrp_Code" value='ALL'  maxlen = "40" styles='width:100%' onchange="OnChangeGroup()" >
                    <data>
                        <%=Esyslib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM" )%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>
             <!--  <td style=" width:5%"></td> -->
                <td colspan=1 align=right style="width:6%;border:0">
		            <font size=2>Task</font>
                </td>
                <td colspan=1 align=right style="width:10%;border:0">
		            <gw:list  id="lstTask_Code" value='ALL'  maxlen = "40" styles='width:100%' onchange="" >
                    <data>
                        <%=Esyslib.SetListDataSQL("select a.PK, a.TASK_NAME from prod.tpr_task a where a.DEL_IF=0 and a.USE_YN = 'Y' order by task_name" )%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>
                <td style="border:0; width:7%" align=right><font size=2>From date</font></td>
                <td style="border:0; width:8%"><gw:datebox id="idFrom_DT"  maxlen = "15" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="" /></td>
                <td style="border:0; width:7%" align=right><font size=2>To date</font></td>
                <td colspan="3" style="border:0; width:8%"><gw:datebox id="idTo_DT"  maxlen = "15" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="" /></td>
                
                	                		                		        
            </tr>	
            <tr style=" height:4%; border:1">
                <td colspan=1></td>
                <td  style="border:0" align=right>
                 <a title="Click here to show department" onclick="OnShowItemPopup()" href="#tips" style="text-decoration : none; color=#0000FF">
                <font size=2>Item</font></a>
                </td>
                <td  style="border:0"><gw:list  id="lstItem" value='ALL'  maxlen = "40" styles='width:100%' onchange="" >
                    <data>
                        <%=Esyslib.SetListDataSQL("select a.PK, a.TASK_NAME from prod.tpr_task a where a.DEL_IF=0 and a.USE_YN = 'Y' order by task_name" )%>|ALL|Select All
                    </data>
                    </gw:list></td>
                <td style="border:0"></td>
            <!--
                    -->
                <td colspan=1 align=right style="width:10%;border:0">
		            <font size=2>Search by</font>
                </td>
                <td colspan=1 align=right style="width:9%;border:0">
		            <gw:list  id="lstTmp"  maxlen = "40" styles='width:100%' onchange="" >
                    <data>
                        |1|Emp ID|2|Name|3|Card Num
                    </data>
                    </gw:list>
                </td>
                <td colspan=1 align=right style="width:10%;border:0">
		            <gw:textbox  id="txtTmp"  maxlen = "40" styles='width:100%' onenterkey="OnSearch()">                    
                    </gw:textbox>
                </td>
                <td colspan=1 align=right style="width:8%;border:0">
		            <font size=2>Status</font>
                </td>  
                <td colspan=1 align=right style="width:8%;border:0">
                    <gw:list  id="lstStatus"  maxlen = "40" value='A' styles='width:100%' onchange="" >
                    <data>
                        <%=Esyslib.SetListDataSQL("select code, code_nm from vhr_hr_code where id='HR0022'" )%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>
                <td colspan=3 align=center style="width:4%;border:1;color:'red'" >
                    <font size=2><i><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></i></font>
                </td>
                
                <td align=left style="width:3%;border:0">
                    <gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" />
                </td>		        
		        <td align=left style="width:3%;border:0">
                    <gw:imgBtn id="ibtnSave" alt="Save" img="Save" text="Save" onclick="OnSave()" />
                </td>	
                <td align=left style="width:3%;border:0">
                    <gw:imgBtn id="ibtnDelete" alt="Delete" img="Delete" text="Delete" onclick="OnDelete()" />
                </td>
<!--                <td colspan=1 align=right style="width:8%;border:0">
		            <font size=2>Confirm Date</font>
                </td>
                <td colspan=1 align=left style="width:8%;border:0">
		            <gw:datebox id="idConfirm_DT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" onchange="" />
                </td>
                <td colspan=1></td> -->
            </tr>                                      
	    </table>
	    <table id="tbl" style="width:100%;height:85%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		    <tr style="height:100%">
			    <td id="master" width="100%">
				    <gw:grid
					    id="idGrid"
					    header="_DEPT_PK|GROUP|EMP ID|NAME|ITEM NAME|TASK NAME|EMP PRICE|_EMP_PK|_TASK_PK|_GROUP_PK|_ITEM_PK"
					    format ="0|0|0|0|0|0|1|1|1|1|1"
					    aligns ="0|0|1|0|0|0|1|0|0|0|0"
					    editcol="0|0|0|0|0|0|1|0|0|0|0"
					    widths="0|2000|1200|3000|3500|2500|2000|0|0|0|0"
					    styles="width:100%;height:100%"					    
					    sorting="T"
					    oncellclick = ""
					    oncelldblclick=""
					    param="0,1,2,3,4,5,6,7,8,9,10" />
			    </td>
		    </tr>	
	    </table>	    	    
</table>
    <gw:textbox id="idemp_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>        
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>     
     <gw:textbox id="txtGroupData" styles="display:none"/>
     <gw:textbox id="txtTaskData" styles="display:none"/>
     <gw:textbox id="txtTaskText" styles="display:none"/>
</body>
</html>
