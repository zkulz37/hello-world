<!-- #include file="../../../system/lib/form.inc" -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
<title>Untitled Page</title>
<style type="text/css">
<!--
.style1 {color: #FF0000}
-->
</style>
</head>

<script>
var startTime,interval_time
var v_language = "<%=Session("SESSION_LANG")%>";
var opt_value=2;

function BodyInit()
{   
   
    if (v_language!="ENG")
        System.Translate(document);	
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
     menu_id.text=System.Menu.GetMenuID();

     
      lstOrg.value="ALL";
	  lstWg.value="ALL";
      
	  
              
     idGridChild.GetGridControl().ScrollTrack=true;	
     idGridEmp.GetGridControl().ScrollTrack=true;
          
     	
     datCheck_View.Call();
}


//----------------------------------------------

function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:260;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj;
    
    }
}


function OnDataReceive(obj)
{
       if(obj.id == "datCheck_View")
        {
                if(txtFlag_View.text == 'Y')
                {
                    ibtnSave.style.display = "none";
                    ibtnDelete.style.display = "none";
                    ibtnAdd.style.display = "none";
                }
        
                if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
              datUser_info.Call(); 
            
        }
       else if (obj.id=="datMasterEmp")
       {
            idRecord.text=idGridEmp.rows-1 + " Record(s)."
             if (idGridEmp.rows==2)
                txtEmp_PK.text=idGridEmp.GetGridData(1,0);
       }
       else if (obj.id=="datFind_Report")
       {
            var url=System.RootURL + '/reports/ch/cs/' + txtReport_tmp.text ;
         url += '?p_org='+ lstOrg.value +'&p_wg='+lstWg.value+'&p_search_by='+lstSearch.value;
         url += '&p_value=' + txtSearch.text + '&p_from=' + FromDT.value + '&p_to=' + ToDT.value + '&p_status=' +lstStatus.value ;   
            window.open(url);
       }
       else if (obj.id=="datMasterEmpInList")
            idRecord.text=idGridEmp.rows-1 + " Record(s)."
	   
}      

function OnSearch()
{
     
    if (opt_value == 2)
    {
        idGridEmp.ClearData();
        idGridChild.ClearData();
        datMasterEmp.Call("SELECT");
        //alert(option_P.value);
    }
    else
    {
        idGridEmp.ClearData();
        idGridChild.ClearData();
        datMasterEmpInList.Call("SELECT");
    }
    
}

function OnAdd()
{
    //alert(txtEmp_PK.text);
    if(txtEmp_PK.text=="")
    {
        alert("Please select employee to add new");
        return;
    }
    idGridChild.AddRow();
    idGridChild.SetGridText(idGridChild.rows-1,1,txtEmp_PK.text);
}

function OnDelete()
{
    idGridChild.DeleteRow();
}

function OnSave()
{
    datLoadChildrenFromEmp.Call();
}

function OnReport()
{
}

function onClickOption(obj)
{
    opt_value = obj;
    switch(obj)
    {
        case 1:
            idGridEmp.ClearData();
            idGridChild.ClearData();
            break;
	    case 2:
	        idGridEmp.ClearData();
	        idGridChild.ClearData();
	        break;           
    }
}

function LoadChildren()
{
   if (idGridEmp.rows-1 > 0)
   {
        if (imgMaster.status=="expand")
        {
            txtEmp_PK.text=idGridEmp.GetGridData(idGridEmp.row,0);
            ibtnAdd.SetEnable(true);
            datLoadChildrenFromEmp.Call("SELECT");
        }
    }
}

function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            detail.style.display="none";
            imgMaster.status = "collapse";
			tbl.style.width="100%";
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Show detail"
			ibtnAdd.SetEnable(false);
          /*  tblMain.style.height="100%";
            tblUpper.style.height="5%";
            tblDetail.style.height="95%";*/
            
        }
        else
        {
            detail.style.display="";
            imgMaster.status = "expand";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Close detail"
			tbl.style.width="55%";
			ibtnAdd.SetEnable(true);
			//datWorkSchedule_detail.Call("SELECT")
          /*  tblMain.style.height="100%";
            tblUpper.style.height="5%";
            tblDetail.style.height="45%";
            tblMaster.style.height="50%";*/
            
        }
  
}

function OnReport()
{
    
    txtReport_tmp.text='rpt_baby_allowance.aspx';
    //alert(txtReport_tmp.text);
    datFind_Report.Call();
    //return;
}
</script>

<body style=" margin-bottom:0; margin-top:0; margin-right:0" >
<!-------------------data control----------------------->
<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="sp_pro_check_view"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
            </dso> 
        </xml> 
</gw:data>
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


<gw:data id="datMasterEmp" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  function="hr_sel_10030009_emp_child" > 
                <input bind="idGridEmp" >
                    <input bind="lstOrg" />
                    <input bind="lstWg" />
                    <input bind="lstSearch" />
                    <input bind="txtSearch" />
                    <input bind="lstStatus" /> 
                </input>
                <output  bind="idGridEmp" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datMasterEmpInList" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  function="hr_sel_10030009_emp_child_list" > 
                <input bind="idGridEmp" >
                    <input bind="lstOrg" />
                    <input bind="lstWg" />
                    <input bind="lstSearch" />
                    <input bind="txtSearch" />
                    <input bind="FromDT" />
                    <input bind="ToDT" />
                    <input bind="lstStatus" /> 
                </input>
                <output  bind="idGridEmp" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datLoadChildrenFromEmp" onreceive=""  > 
        <xml> 
            <dso  type="grid" parameter="0,1,2,3,4,5,6" function="hr_sel_10030009_child_fr_emp" procedure="hr_upd_10030009_children"> 
                <input bind="idGridChild">
                    <input bind="txtEmp_PK" /> 
                </input> 
                <output bind="idGridChild"/>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------main table----------------------------------->
<table name="Report" id="tblReport" width="100%" cellpadding="0" cellspacing="0" border=0 style="height:98%;">
<tr style="width:100%;height:100%" valign="top">
<td width="100%">
<table width="100%" id="Table2" style="height:17%" border=0 cellpadding="0" cellspacing="0">
    <tr style="border:0;width:100%;height:5%" valign="center" >
        <td width="81" align="right" style="width: 81px" ><a title="Click here to show Organization" onClick="OnShowPopup()" href="#tips" >
        Organization </a>
        </td>
        <td width="156" align="left" style="width: 16%" >
            <gw:list id="lstOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                <data>
                <%= ESysLib.SetListDataSQL("select pk,org_nm from tco_org a where del_if=0 order by a.org_id")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
        <td width="81" align="right" >Group</td>
        <td width="151" align="left" >
            <gw:list id="lstWg" value='ALL' maxlen = "100" styles='width:100%' >
                <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All
                </data>
            </gw:list>
        </td>
        <td width="80" align="right" >Search by
        </td>
        <td width="109" align="left" >
            <gw:list id="lstSearch" value="2" styles='width:100%' onchange=""> 
            <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
            </gw:list>
        </td>
        <td width="110" align="left" ><gw:textbox id="txtSearch" onenterkey ="OnSearch()" styles='width:100%'/></td>
        <td width="213" align=right>
            <table width="70%" border="0">
              <tr align="center">
                <td></td>
                <td><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
                <td><gw:imgBtn id="ibtnAdd" alt="Add" img="New" text="Search" onclick="OnAdd()" /></td>
                <td><gw:imgBtn id="ibtnSave" alt="Save" img="Save" text="Save" onclick="OnSave()" /></td>
                <td><gw:imgBtn id="ibtnDelete" alt="Delete" img="Delete" text="Delete" onclick="OnDelete()" /></td>
	            <td><gw:imgBtn id="ibtnReport" alt="Report" img="Excel" text="Report" onclick="OnReport()" /></td>
              </tr>
            </table>
        </td>
    </tr>
    <tr style="border:0;width:100%;height:5%" align=top cellpadding="0" cellspacing="0" >
        <td align="right" style="width: 81px" ><input type="radio" id="inList" name="option_P" value="1" onclick="onClickOption(1)" >
        <td > List in Allowance</td>
        <td align="right"><input type="radio" id="notInList" name="option_P" value="2" checked onclick="onClickOption(2)" ></td>
        <td>Not in List</td>
        <td>From:<gw:datebox id="FromDT"  maxlen = "9" text="" styles='width:80%'lang="<%=Session("Lang")%>" /></td>
        <td>To:<gw:datebox id="ToDT"  maxlen = "9" text="" styles='width:80%'lang="<%=Session("Lang")%>" /></td>
        <td><gw:list id="lstStatus" value='ALL' maxlen = "100" styles='width:100%' >
                    <data>|ALL|Status All|A|Active|R|Resign
                    </data>
                    </gw:list></td>
        <td>
            <table width="100%" border="0">
              <tr>                                              
                <td width="90%" align=center ><span class="style1"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></span></td>
                <td width="10%" align=right><img status="expand" id="imgMaster" alt="Close detail" src="../../../system/images/close_popup.gif" style="cursor:hand" onclick="OnToggle()"  /></td>
              </tr>
            </table>
        </td>
    </tr>
</table>

<table id="Table1" style="width:100%;height:88%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="tbl" width="55%">
				<gw:grid
					    id="idGridEmp"
					    header="_EMP_PK|Group|Emp ID|Full Name|Join Date|Remarks"
					    format="0|0|0|0|0|0"
					    aligns="0|0|0|0|1|1"
					    defaults="|||||"
					    editcol="0|0|0|0|0|0"
					    widths="0|1500|1500|2500|1500|1500"
					    styles="width:100%;height:100%"
					    sorting="T"
					    onclick = "LoadChildren();"/>
			</td>
			<td id="detail" width="45%">
				<gw:grid
					    id="idGridChild"
					    header="_PK|_EMP_PK|Child Name|Birth Date|Start Date|End Date|Remarks"
					    format="0|0|0|4|4|4|0"
					    aligns="0|0|0|1|1|1|1"
					    defaults="||||||"
					    editcol="0|0|1|1|1|1|1"
					    widths="0|0|2500|1500|1500|1500|1500"
					    styles="width:100%;height:100%"
					    sorting="T"
					     acceptNullDate
					    oncelldblclick = ""/>
			</td>
		</tr>	
	</table>
	

</td>
</tr>
</table>



    <gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="lbltmp" styles="display:none"/>
    <gw:textbox id="lbltmp2" styles="display:none"/>
    <gw:textbox id="txtEmp_PK" styles="display:none"/>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />

</body>

</html>
