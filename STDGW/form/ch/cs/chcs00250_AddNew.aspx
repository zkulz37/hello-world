<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
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
        onChange_org(lstOrg); 
    }
    else if (obj.id=="datWorkGroup_info")
    {
		
		lstwg.SetDataText(txtwg_tmp.text + "|ALL|Select All");
        lstwg.value='ALL';	        	
	}
       else if (obj.id=="datEmp_popup")
       {
            if(idGrid.rows>1)
                Set_Enable();
            idRecord.text=idGrid.rows-1 + " Records.";
       }
       
}      
function onChange_org(obj)
{	
	txtorg_tmp.text=obj.value;
	datWorkGroup_info.Call();
	
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
    datEmp_popup.Call("SELECT");
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
//            Select|Deptpartment|Section|Emp ID|Full Name|Join Date|Status|_emp_pk
            aRow[0]=idGrid.GetGridData(i,1) //Deptpartment
            aRow[1]=idGrid.GetGridData(i,2) //Section
            aRow[2]=idGrid.GetGridData(i,3) //Emp ID
            aRow[3]=idGrid.GetGridData(i,4) //Full Name
            aRow[4]=idGrid.GetGridData(i,5) //Join Date
            aRow[5]=idGrid.GetGridData(i,7) //_emp_pk
            aRow[6]=idGrid.GetGridData(i,8) //_tco_org_pk
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
        aRowSel[3]=idtxtTmp.text;// text
        aRowSel[4]=lstNation.value;//nation
        aRowSel[5]=null;//dt
        aRowSel[6]=null;//dt
        aData[j]=aRowSel;
    }
    window.returnValue = aData; 			
	this.close();
}
//---------------------------------------------------
function OnSelectAll()
{   
    var aData =new Array();
    var j;
    j=0;
    var bSelect=false;
    for (var i=1;i<idGrid.rows;i++)
    {
            var aRow=new Array();
            bSelect=true;
            //            Select|Deptpartment|Section|Emp ID|Full Name|Join Date|Status|_emp_pk|_tco_org_pk
            aRow[0]=idGrid.GetGridData(i,1) //Deptpartment
            aRow[1]=idGrid.GetGridData(i,2) //Section
            aRow[2]=idGrid.GetGridData(i,3) //Emp ID
            aRow[3]=idGrid.GetGridData(i,4) //Full Name
            aRow[4]=idGrid.GetGridData(i,5) //Join Date
            aRow[5]=idGrid.GetGridData(i,7) //_emp_pk
            aRow[6]=idGrid.GetGridData(i,8) //_tco_org_pk            
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
        aRowSel[4]=lstNation.value;//nation
        aRowSel[5]=null;//dt
        aRowSel[6]=null;//dt
        aData[j]=aRowSel;
    }
    window.returnValue = aData; 			
	this.close();
}
//--------------------------------------------------
function OnExit()
{
    window.returnValue = Null; 			
	this.close();
}

</script>

<body>
<!------------main control---------------------->

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

<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_lst_wg_role"  > 
                <input>
                    <input bind="txtorg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>

<gw:data id="datEmp_popup" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="2,3,4,5,6,7,8" function="hr_sel_10030025_emp_popup"> 
                <input bind="idGrid" >
                    <input bind="lstOrg" />
                    <input bind="lstwg" />
                    <input bind="lstStatus" />                    
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstNation" />
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
                                <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
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
		            <td align=right style="width:2%"></td>
		            <td align=right style="width:3%"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
		            <td align=right style="width:3%"><gw:imgBtn img="select" id="ibtnSelect"    alt="Select"  onclick="OnSelect()"/></td>
		            <td align=right style="width:3%"><gw:imgBtn img="selectall" id="ibtnSelectAll"   alt="Select All"  onclick="OnSelectAll()"/></td>
		            <td align=right style="width:3%"><gw:imgBtn img="cancel" id="ibtnExit"   alt="Exit"  onclick="OnExit()"/></td>
                </tr>	
                <tr style="height:6%;border:0">	
                     <td align=right style="width:5%" ><gw:checkbox id="chkSelect" value="F" onclick="OnCheck()" ></gw:checkbox ></td>
                     <td align=left colspan=1 style="width:5%"><font color="black">Select</td>		            
		            <td align=right colspan=1 style="width:6%">Status</td>
		            <td align=left colspan=2 style="width:9%"><gw:list  id="lstStatus" value="A" maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM FROM VHR_HR_CODE WHERE ID='HR0022'")%>|ALL|Select All</data></gw:list></td>
                    <td colspan=2 style="width:10%;border:0;" align="right" >Nation</td>
                    <td colspan=3 style="width:15%;border:0;" align="left" >
                     <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
                        <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' and code in('01','02') order by code" )%>|ALL|Select All</data></gw:list>
                    </td>                    
		            <td align=right colspan=10 style="width:30%"style="color=#FF00CC" ><gw:label id="idRecord" text="0 record(s)" styles="width:100%;color:red" ></gw:label></td>
                </tr>	
	        </table>
	        <table id="tblMain" style="width:100%;height:88%" border=1 cellpadding="0" cellspacing="0">
	            <tr style="width:100%;height:100%">
	                <td id="tdMaster" style="width:100%">
	                    <gw:grid   
				        id="idGrid"  
				        header="Select|Deptpartment|Section|Emp ID|Full Name|Join Date|Status|_emp_pk|_tco_org_pk"   
				        format="3|0|0|0|0|0|0|0|0"  
				        aligns="0|0|0|0|0|0|0|0|0"  
				        defaults="||||||||"  
				        editcol="1|0|0|0|0|0|0|0|0|0"  
				        widths="1500|3000|3000|1500|3000|1500|2000|1500|0|0"  
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
    <gw:textbox id="txtorg_tmp" styles="display:none"/>
    <gw:textbox id="txtwg_tmp" styles="display:none"/> 
</body>
</html>

