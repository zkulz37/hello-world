<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>In - Out Temporary - Add New</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    idGrid.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    Set_DisEnable();
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
              datUser_info.Call(); 
    

}

function Set_Enable()
{
    ibtnSelect.SetEnable(1);
    chkSelect.SetEnable(1);
    ibtnSelectAll.SetEnable(1);
}
function Set_DisEnable()
{
    ibtnSelect.SetEnable(0);
    chkSelect.SetEnable(0);
    ibtnSelectAll.SetEnable(0);
}
function OnDataReceive(obj)
{
    if (obj.id=="datUser_info")
       {
            //datGroupData.Call();
       }
       else if (obj.id=="datIn_Out_Temp_popup")
       {
            if(idGrid.rows>1)
                Set_Enable();
            idRecord.text=idGrid.rows-1 + " Record(s).";
       }
       
}      
//----------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj
        
    }
    
}
function OnChangeDept()
{
    //txtDept.text=lstOrg.value;
    //datGroupData.Call();
}
function OnSearch()
{
    datIn_Out_Temp_popup.Call("SELECT");
}
function OnCheck()
{
    var tmp
    if(chkSelect.value=='F')
        tmp=0;
    else
        tmp=-1;
        
    var ctrl=idGrid.GetGridControl();
	if(ctrl.SelectedRows>0)
		for(var i=0;i<ctrl.SelectedRows;i++)
    		idGrid.SetGridText(ctrl.SelectedRow(i),0,tmp);
}
//--------------------------------------------------------------------------
function OnSelect()
{
  
    var aData =new Array();
    var j;
    j=0;
    var bSelect=false;
    for (var i=1;i<idGrid.rows;i++)
    {
        if (idGrid.GetGridData(i,0)=='-1')
        {   
            var aRow=new Array();
            bSelect=true;
            aRow[0]=idGrid.GetGridData(i,1) //get org nm
            aRow[1]=idGrid.GetGridData(i,2) //get work group 
            aRow[2]=idGrid.GetGridData(i,3) //get emp id
            aRow[3]=idGrid.GetGridData(i,4) //get full name
            aRow[4]=idGrid.GetGridData(i,5) //get work shift
            aRow[5]=Work_DT.value //get work date
            aRow[6]=idGrid.GetGridData(i,8) //emp pk
            aData[j]=aRow;
            j=j+1;
        }
        
    }
    if (bSelect==true)
    {
        var aRowSel=new Array();
        aRowSel[0]=lstOrg.value;//department
        aRowSel[1]=lstwg.value;//group
        aRowSel[2]=idSearch.value;//search by
        aRowSel[3]=idtxtTmp.text;//
        aRowSel[4]=Work_DT.value;//from_dt
        aData[j]=aRowSel;
    }
    window.returnValue = aData; 			
	this.close();
}
//---------------------------------------------------
function OnSelectAll()
{
//   if(Adj_DT.value=="")
//   {
//     alert("Choose Adjust date please!\nBạn phải nhập ngày điều chỉnh!");
//     return;
//   }   
    var aData =new Array();
    var j;
    j=0;
    var bSelect=false;
    for (var i=1;i<idGrid.rows;i++)
    {
        var aRow=new Array();
        bSelect=true;
        aRow[0]=idGrid.GetGridData(i,1) //get org nm
        aRow[1]=idGrid.GetGridData(i,2) //get work group 
        aRow[2]=idGrid.GetGridData(i,3) //get emp id
        aRow[3]=idGrid.GetGridData(i,4) //get full name
        aRow[4]=idGrid.GetGridData(i,5) //get work shift
        aRow[5]=Work_DT.value //get work date
        aRow[6]=idGrid.GetGridData(i,8) //emp pk
        aData[j]=aRow;
        j=j+1;
    }
    if (bSelect==true)
    {
        var aRowSel=new Array();
        aRowSel[0]=lstOrg.value;//department
        aRowSel[1]=lstwg.value;//group
        aRowSel[2]=idSearch.value;//search by
        aRowSel[3]=idtxtTmp.text;//
        aRowSel[4]=Work_DT.value;//from_dt
        aData[j]=aRowSel;
    }
    window.returnValue = aData; 			
	this.close();
}
//--------------------------------------------------
function OnExit()
{
    window.returnValue = ''; 			
	this.close();
}

</script>

<body>
<!------------main control---------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datIn_Out_Temp_popup" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="2,3,4,5,6,7,8,9" function="HR.sp_sel_in_out_temp_pop"> 
                <input bind="idGrid" >
                    <input bind="lstOrg" />
                    <input bind="lstwg" />
                    <input bind="Work_DT" />
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />
                    <input bind="lstEmpType" />
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>


<!--------------------main table--------------------------------->
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
	<tr>
	    <td>
	        <table style="width:100%;height:12%" cellpadding="0" cellspacing="0" valign="top" border="0" >	
	            <tr style="height:6%;border:0">	
		            <td align=right colspan=2 style="width:10%" ><a title="Click here to show department" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
		            <td align=right colspan=3 style="width:15%"><gw:list  id="lstOrg" value="ALL"  maxlen = "100" styles='width:100%' onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM COMM.TCO_ORG A WHERE A.DEL_IF=0 CONNECT BY PRIOR  A.PK=A.P_PK START WITH NVL(A.P_PK,0)=0")%>|ALL|Select All
                            </data>
                        </gw:list>
                    </td>
		            <td align=right colspan=2 style="width:10%">Work Group</td>
		            <td align=right colspan=3 style="width:15%"><gw:list  id="lstwg" value="ALL" maxlen = "100" styles='width:100%' >
                        <data><%=ESysLib.SetListDataSQL("SELECT A.PK,A.WORKGROUP_NM FROM THR_WORK_GROUP A WHERE A.DEL_IF=0 ORDER BY A.WORKGROUP_ID ")%>|ALL|Select All</data></gw:list>
                    </td>
                    <td align=right colspan=2 style="width:10%">Search by</td>
		            <td align=left colspan=2 style="width:10%"><gw:list  id="idSearch" value="1" styles="width:98%" onChange="">
                                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
		            <td align=right colspan=2 style="width:10%"><gw:textbox id="idtxtTmp" maxlen = "50" styles="width:100%" onenterkey="OnSearch()" /></td>
		            <td align=right style="width:8%"></td>
		            <td align=right style="width:3%"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		            <td align=right style="width:3%"><gw:imgBtn img="select" id="ibtnSelect"    alt="Select"  onclick="OnSelect()"/></td>
		            <td align=right style="width:3%"><gw:imgBtn img="selectall" id="ibtnSelectAll"   alt="Select All"  onclick="OnSelectAll()"/></td>
		            <td align=right style="width:3%"><gw:imgBtn img="cancel" id="ibtnExit"   alt="Exit"  onclick="OnExit()"/></td>
                </tr>	
                <tr style="height:6%;border:0">	
                     <td align=right style="width:5%" ><gw:checkbox id="chkSelect" value="F" onclick="OnCheck()" ></gw:checkbox ></td>
                     <td align=left colspan=2 style="width:10%"><font color="black">Select</td>
		            <td align=right colspan=2 style="width:10%" >Work Date</td>
		            <td align=left colspan=2 style="width:10%"><gw:datebox id="Work_DT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=right colspan=3 style="width:10%">Employee Type</td>
		            <td align=left colspan=3 style="width:10%"><gw:list  id="lstEmpType" value="ALL" maxlen = "100" styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code_nm")%>|ALL|Select All</data></gw:list></td>
                    <td style="width:5%;border:0;" align="right" >Nation</td>
                    <td style="width:10%;border:0;" align="left" >
                     <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
                        <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' and code in('01','02') order by code" )%>|ALL|Select All</data></gw:list>
                    </td>                    
		            <td align=right colspan=4 style="width:30%;color:Red;" ><gw:label id="idRecord" text="0 record(s)" styles="width:100%;color:Red;" ></gw:label></td>
                </tr>	
	        </table>
	        <table id="tblMain" style="width:100%;height:88%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGrid"  
				        header="Select|Organization|Work Group|Emp ID|Full Name|WS|Join Date|Work Date|_emp_pk"   
				        format="3|0|0|0|0|0|0|4|0"  
				        aligns="0|0|0|1|0|1|1|1|0"  
				        defaults="|||||||||"  
				        editcol="1|0|0|0|0|0|0|0|0|0"  
				        widths="1500|2000|1500|1500|3000|400|1500|800|800|0"  
				        styles="width:100%; height:100% "   
				        sorting="T"   
				        oncellclick     = ""/>
	                </td>
	            </tr>
	        </table>
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

