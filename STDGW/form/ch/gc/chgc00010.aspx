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
    txtCheckGroup.text="0";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user= "<%=session("USER_ID")%>";   
    if((Trim(idemp_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        datUser_info.Call();     	    
    else
        lstDept_Code.value="ALL";
    idGrid.GetGridControl().ColFormat(6) = "(#,###.##)";            
    <%=ESysLib.SetGridColumnComboFormat( "idGrid" , 5 , "select vg.TPR_TASK_PK, vg.TASK_NAME from prod.VPROD_GROUP_TASK vg ORDER BY 2") %>; 
 }
  
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {      
        datGroupData.Call();
   }
   if (obj.id=="datGroupData")
   {
        
        if(tabMain.GetCurrentPageNo()==0)
        {
            lstGrp_Code.SetDataText(txtGroupData.text);
            var obj=lstGrp_Code.GetControl();
            if (obj.options.length ==2)
		        obj.options.selectedIndex=0;
	        else
		        obj.options.selectedIndex=obj.options.length-1;/**/
            datTaskData.Call();
        }
        else
        {
            //alert(1);
            lstGrp_Code1.SetDataText(txtGroupData.text);
            var obj=lstGrp_Code1.GetControl();
            if (obj.options.length ==2)
		        obj.options.selectedIndex=0;
	        else
		        obj.options.selectedIndex=obj.options.length-1;/**/
        }
   }
   if (obj.id=="datTaskData")
   {
        lstTask_Code.SetDataText(txtTaskData.text);        
        var ctrl=lstTask_Code.GetControl();   
        if(ctrl.options.length==2)
            ctrl.options.selectedIndex=0;
        else            
            ctrl.options.selectedIndex=ctrl.options.length-1; 
        
        lstChoose_Task.SetDataText(txtTaskData.text);
        var ctrl1=lstChoose_Task.GetControl();   
        if(ctrl1.options.length==2)
            ctrl1.options.selectedIndex=0;
        else            
            ctrl1.options.selectedIndex=ctrl1.options.length-1; 
            
                  
   }   
   if (obj.id=="datEmp")
   {
        idRecord.text= idGrid.rows-1 + " record(s)";
        var ctrl=idGrid.GetGridControl();
   }
   if (obj.id=="datCheckGroup")
   {
        if( txtCheckGroup.text!="1")
        {
            alert('This group is not in special rule');
            return
        }   
        else
            datEmp.Call("SELECT");
   }         
   if(obj.id=="datEmp1")
   {
        idRecord1.text= idGrid1.rows-1 + " record(s)";
        //var ctrl=idGrid.GetGridControl();
   }
}
 //---------------------------------------------------------
function OnSearch()
{
    if(lstGrp_Code.value=='ALL')       
        datEmp.Call();        
    else
        datCheckGroup.Call();
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

function OnChangeDept(depObj)
{
    txtDeptData.text=depObj.value;
    datGroupData.Call();
}

function OnChangeGroup(grp)
{
    datTaskData.Call();
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

function OnLoadExcell()
{
    
    var myApp = new ActiveXObject("Excel.Application");     
    var vfilename = document.all["inputfile"].value;    
    if (!CheckValidFile(vfilename) || vfilename =="")
    {
        alert("Please select excel file");
        return;
    }
    try
    {
        myApp.Workbooks.Open(vfilename); 
        var workSheet = myApp.ActiveSheet; 
        var semp_id,slb_price, emp_name;
        var maxRow =workSheet.UsedRange.Rows.Count;         
        for (var j =2;j <=maxRow; j++) 
        { 
            semp_id=workSheet.Cells(j,1).value;                        
            emp_name=workSheet.Cells(j,2).value;
            slb_price=workSheet.Cells(j,3).value;
            if (semp_id=="" )
               alert("Please input employee id at row " + j);
            else if (slb_price=="")
                alert("Please input labour price at row " + j);
            else if (isNaN(slb_price))
                alert("Please input labour price by number value at row " + j);            
            else
            {                             
                for(var i=1; i<idGrid.rows;i++)                
                    if(idGrid.GetGridData(i,2)==semp_id)
                    {
                        idGrid.SetGridText(i,6,slb_price);
                        break;
                    }                
            }/**/
        } 
        myApp.Quit();
    }
    catch(e)
    {
        alert("Could not read Excel File. (or) Excel was not installed in the machine you are using or it has incompatible version?"); 
    }
     /**/   
}
function CheckValidFile(vfile)
{
    var sext;
    sext=vfile.substring(vfile.length-4,vfile.length);
    if (sext!=".xls")
        return false;
    return true;
}

function OnReport()
{
    var url = System.RootURL + '/reports/ch/gc/rpt_group_task_template.aspx' ;
    window.open(url);
}

function OnSearch1()
{
    datEmp1.Call();
}

function OnSave1()
{
    datEmp1.Call();
}
function OnSetGrid()
{
     if(tabMain.GetCurrentPageNo()==0)
     {        
        var ctrl = idGrid.GetGridControl();
        txtTaskText.text=lstChoose_Task.value;
        //alert(txtTaskText.text);
        if(txtTaskText.text=="ALL")
        {
            alert("Cannot set ALL to grid, choose task again !");
            return;
        }
        for(var i=0; i<ctrl.SelectedRows;i++)
        {        
            var c=ctrl.SelectedRow(i);
            idGrid.SetGridData(c,5,txtTaskText);
        }        
     }
     else
     {
        var ctrl = idGrid1.GetGridControl();
        txtTaskText.text=idSetDate.value;
        for(var i=0; i<ctrl.SelectedRows;i++)
        {        
            var c=ctrl.SelectedRow(i);
            if(txtTaskText.text<idGrid1.GetGridData(c,3) && txtTaskText.text!="")
            {
                alert("Production date cannot be less than Join date at EmpID: " + idGrid1.GetGridData(c,1));
                continue;
            }
            else
                idGrid1.SetGridData(c,4,txtTaskText);
        }
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

<gw:data id="datCheckGroup" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_check_group" > 
                <input>                    
                   <input bind="lstGrp_Code" />
                </input> 
                <output>
                    <output bind="txtCheckGroup" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmp" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="5,6,7,8,9" function="hr.sp_sel_group_task"  procedure="hr.sp_upd_group_task" > 
                <input bind="idGrid" >
                    <input bind="lstDept_Code" />
                    <input bind="lstGrp_Code" />
                    <input bind="lstTask_Code" />
                    <input bind="lstStatus" />                         
                    <input bind="lstTmp" />
                    <input bind="txtTmp" />                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmp1" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="4,5" function="hr.sp_sel_product_date"  procedure="hr.sp_upd_product_date" > 
                <input bind="idGrid1" >
                    <input bind="lstDept_Code1" />
                    <input bind="lstGrp_Code1" />                    
                    <input bind="lstStatus1" />                         
                    <input bind="lstTmp1" />
                    <input bind="txtTmp1" />                    
                    <input bind="idFrom_DT" />
                    <input bind="idTo_DT" />
                </input>
                <output  bind="idGrid1" />
            </dso> 
        </xml> 
</gw:data>

<gw:tab id="tabMain"   style="width:100%;height:100%;" onpageactivate=""  > 
 
   <table name="Manage Ratio"  style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
         <tr style=" height:5%; border:1">	                
                <td colspan=2 align=right style="width:10%; border:0 " ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color=#0000FF"><font size=2>Department</font></a></td>
		        <td colspan=2 align=right style="width:15%;border:0">
		            <gw:list  id="lstDept_Code"  maxlen = "100" styles='width:100%' onchange="OnChangeDept(lstDept_Code)" >
                    <data>
                        <%=ESysLib.SetListDataSQL("select a.pk,a.dept_nm from comm.tco_dept a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>                
                <td colspan=1 align=right style="width:10%;border:0">
		            <font size=2>Group</font>
                </td>
                <td colspan=2 align=right style="width:20%;border:0">
		            <gw:list  id="lstGrp_Code" value='ALL'  maxlen = "40" styles='width:100%' onchange="OnChangeGroup()" >
                    <data>
                        <%=Esyslib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM" )%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>           
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
                <td colspan="7" style="border:0; width:25%" align=right>
                  <input id="inputfile" type="file" name="pic" size="40" accept="image/jpg">
                </td>               		                		        
            </tr>	
            <tr style=" height:4%; border:1">
                <td  style="border:0" colspan=2 align="right">Choose Task</td>
               <!-- <td  style="border:0" align=right>
                    
                </td> -->
                <td  style="border:0; width:10%">
                    <gw:list  id="lstChoose_Task" value='ALL'  maxlen = "40" styles='width:100%;' onchange="" >
                    <data>
                        <%=Esyslib.SetListDataSQL("select a.PK, a.TASK_NAME from prod.tpr_task a where a.DEL_IF=0 and a.USE_YN = 'Y' order by task_name" )%>|ALL|Select All
                    </data>
                    </gw:list></td>
                <td style="border:0">
                    <gw:icon id="idBtnSetTask" img="in" text="Set Task" onclick="OnSetGrid()" />
                </td>
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
		            <gw:textbox  id="txtTmp"  maxlen = "40" styles='width:100%' onenterkey="OnSearch()" />                    
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
                <td colspan=2 align=center style="width:4%;border:1;color:'red'" >
                    <font size=2><i><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></i></font>
                </td>
                <td align=left style="width:2%;border:0">
                    <gw:imgBtn img="process" id="ibtnProcess"   alt="Insert from Excell"  onclick="OnLoadExcell()"/>
                </td>
                <td align=left style="width:2%;border:0">
                    <gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" />
                </td>		        
		        <td align=left style="width:2%;border:0">
                    <gw:imgBtn id="ibtnSave" alt="Save" img="Save" text="Save" onclick="OnSave()" />
                </td>	
                <td align=left style="width:2%;border:0">
                    <gw:imgBtn id="ibtnDelete" alt="Delete" img="Delete" text="Delete" onclick="OnDelete()" />
                </td>
                <td align=left style="width:2%;border:0">
                    <gw:imgBtn id="ibtnReport" alt="Sample Report" img="excel" text="Sample Report" onclick="OnReport()" />
                </td>

            </tr>                                      
		    <tr style="height:85%; width:100%">
			    <td id="master" width="100%" colspan="16">
				    <gw:grid
					    id="idGrid"
					    header="_DEPT_PK|GROUP|EMP ID|FULL NAME|JOIN DATE|TASK|RATIO|_EMP_PK|_GROUP_PK|_GRP_TEMP"
					    format ="0|0|0|0|0|0|1|1|1|1"
					    aligns ="0|0|1|0|1|0|1|0|0|0"
					    editcol="0|0|0|0|0|1|1|0|0|0"
					    widths="0|2000|1200|3000|2500|2500|2000|0|0|0"
					    styles="width:100%;height:100%"					    
					    sorting="T"
					    oncellclick = ""
					    oncelldblclick=""
					    param="0,1,2,3,4,5,6,7,8,9" />
			    </td>
		    </tr>	
</table>       
 

  <table name="Manage Product Date" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1">
     
            <tr style="border:0; height:5%; width:100%" >
                <td style=" border:0; width:5%" align="right">
                    <a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color:#0000FF">
                        <font size=2>Department</font>
                    </a>
                </td>
                <td colspan=2 style=" border:0; width:10%">
                    <gw:list  id="lstDept_Code1" value='ALL'  maxlen = "100" styles='width:100%' onchange="OnChangeDept(lstDept_Code1)" >
                    <data>
                        <%=ESysLib.SetListDataSQL("select a.pk,a.dept_nm from comm.tco_dept a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>
                <td style=" border:0; width:5%" align="right">Group</td>
                <td style=" border:0; width:13%">
                    <gw:list  id="lstGrp_Code1" value='ALL'  maxlen = "40" styles='width:100%' onchange="" >
                    <data>
                        <%=Esyslib.SetListDataSQL("SELECT pk,Group_NM FROM Thr_Group WHERE DEL_IF = 0 and use_yn='Y'  order by seq, Group_NM" )%>|ALL|Select All
                    </data>
                    </gw:list>
                </td>
                <td  style=" border:0; width:5%" align="right">Search by</td>
                <td style=" border:0; width:6%" align="right">
                    <gw:list  id="lstTmp1" value='1'  maxlen = "40" styles='width:100%' onchange="OnChangeGroup()" >
                        <data>|1|Emp ID|2|Card ID|3|Full Name</data>
                    </gw:list>
                </td>
                <td colspan=3 style=" border:0; width:15%" align="right">
                    <gw:textbox  id="txtTmp1"  maxlen = "40" styles='width:100%' onenterkey="OnSearch1()">
                    </gw:textbox>
                </td>
                
                <td style=" border:0; width:3%" align="right">
                    <gw:imgBtn id="ibtnSearch1" alt="Search" img="search" text="Search" onclick="OnSearch1()" />
                </td>
                <td style=" border:0; width:3%" align="right">
                    <gw:imgBtn id="ibtnSave1" alt="Save" img="save" text="save" onclick="OnSave1()" />
                </td>
                <td style=" border:0; width:3%" align="right">
                    <gw:imgBtn id="ibtnReport1" alt="Report" img="excel" text="Report" onclick="" />
                </td>
            </tr>
            <tr style="border:0; height:4%; width:100%" >
               <td style=" border:0;" colspan="1" align="right"></td> 
                <td style=" border:0; width:5%" align="right">Join From</td>
                <td style=" border:0;" align="left">
                    <gw:datebox id="idFrom_DT" nullaccept text="" maxlen = "10" styles='width:90%' lang="<%=Session("Lang")%>" type="date"  />
                </td>
                <td style=" border:0; width:5%" align="right">Join To</td>
                <td style=" border:0; width:10%">
                    <gw:datebox id="idTo_DT"  text="" nullaccept maxlen = "10" styles='width:90%' lang="<%=Session("Lang")%>" type="date"  />
                </td>
                <td style=" border:0;" colspan="1" align="right">Status</td>
                <td style=" border:0;" colspan="1" align="right">
                    <gw:list  id="lstStatus1" value='A'  maxlen = "40" styles='width:100%' onchange="OnChangeGroup()" >
                        <data>
                            <%=Esyslib.SetListDataSQL("select v.CODE, v.CODE_NM from vhr_hr_code v where v.ID='HR0022'" )%>|ALL|Select All
                        </data>
                    </gw:list>
                </td>
                <td style=" border:0;" align="right">Set Date</td>
                <td style=" border:0;" align="right">
                    <gw:datebox id="idSetDate"  text="" nullaccept maxlen = "10" styles='width:90%' lang="<%=Session("Lang")%>" type="date"  />
                </td>
                <td style=" border:0;" align="center">
                    <gw:icon id="idBtnSetDate" img="in" text="Set Grid" onclick="OnSetGrid()" />
                </td>
                <td style=" border:0;" colspan=5 align="right">
                    <font size=2><i><gw:label id="idRecord1" text="0 record(s)" styles="width:100%;color=red" ></gw:label></i></font>
                </td>
            </tr>
            <tr style="width:100%; height:75%; border:0">
                <td colspan=16 style="width:100%; height:100%">
                    <gw:grid id='idGrid1'
                            header='GROUP|EMP ID|FULL NAME|JOIN DATE|START PRODUCTION|_EMP PK'
                            format  ='0|0|0|4|4|1'
                            aligns  ='0|1|0|1|1|0'
                            defaults='||||||'
                            editcol ='0|0|0|0|1|0'
                            widths='2500|1500|3000|2000|2000|0'
                            sorting='T'
                            param="0,1,2,3,4,5"
                            styles='width:100%; height:100%'
                            acceptNullDate
                            />
                </td>
            </tr>
  </table> 
  
</gw:tab>     
</body>
<gw:textbox id="idemp_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>        
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>     
     <gw:textbox id="txtGroupData" styles="display:none"/>
     <gw:textbox id="txtTaskData" styles="display:none"/>
     <gw:textbox id="txtTaskText" styles="display:none"/>
     <gw:textbox id="txtCheckGroup" styles="display:none"/>
</html>

