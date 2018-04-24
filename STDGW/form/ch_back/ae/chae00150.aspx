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
var flag_tab=1;
var check_init=0;
function BodyInit()
{   
   
    if (v_language!="ENG")
        System.Translate(document);	
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
     menu_id.text=System.Menu.GetMenuID();
      lstOrg_Code.value="ALL";
	  lstWGrp_Code.value="ALL";
	  ibtnAdd.SetEnable(false);
	  ChangeColorItem(lstOrg_Code.GetControl());
      
              
      datCheck_View.Call();

     grdRelative.GetGridControl().ScrollTrack=true;	
     grdEmp.GetGridControl().ScrollTrack=true;	
     grdRelative.GetGridControl().FrozenCols =4;
     <%=ESysLib.SetGridColumnComboFormat("grdRelative",6,"select code,CODE_NM from vhr_hr_code where id='HR0024' order by code_nm") %>
    

}

//-----------------------------------------------
 function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenX+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
		lstOrg_Code.value=obj;
		onChange_org(1,lstOrg_Code)
   
    }
}

function OnChangeDept()
{
    //datTeamData.Call();
}

function OnDataReceive(obj)
{
       if(obj.id == "datCheck_View")
       {
            if(txtFlag_View.text == 'Y')
            {
                ibtnAdd.style.display = "none";
                ibtnSave.style.display = "none";
                ibtnDelete.style.display = "none";
            }
        
            if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	        {
                datUser_info.Call();     	    
	        }
            check_init =1;
       }
       else if (obj.id=="datUser_info")
       {
            ChangeColorItem(lstOrg_Code.GetControl());
            onChange_org(1,lstOrg_Code);
       }
       else if (obj.id=="datEmployee")
       {
            if (grdEmp.rows>1)
            {
                txtEmp_PK.text=grdEmp.GetGridData(1,0);
                datRelative.Call('SELECT');
            }
            else
            {
                grdRelative.ClearData();
                lblRecord.text="0 Record(s).";
            }
            
       }
       else if (obj.id=="datRelative")
       {
            lblRecord.text=grdRelative.rows-1 + " Record(s).";
             var fg=grdRelative.GetGridControl(); 	  
             fg.MergeCells =3	;
            fg.MergeCol(1) =true	;
            fg.MergeCol(2) =true	;
            fg.MergeCol(3) =true	;
            fg.MergeCol(4) =true	;
       }
       else if (obj.id=="datFind_Report")
       {
            var url=System.RootURL + '/reports/ch/ae/' + txtReport_tmp.text ;
         url += '?l_tco_org_pk='+ lstOrg_Code.value +'&l_wgroup_pk='+lstWGrp_Code.value+'&l_chktemp='+lstSearch.value;
         url += '&l_temp=' + txtSearch.text + '&l_status=' + lstStatus.value + '&l_relation=' + lstRelationship.value + '&l_start_dt=' + dtFromDT.value+ '&l_end_dt=' + dtToDT.value+ '&l_thr_emp_pk=' + txtEmp_PK.text+ '&l_start_dt_text=' + dtFromDT.text+ '&l_end_dt_text=' + dtToDT.text;   
		 url +='&p_job=' + lstJob.value + '&p_Nation=' + lstNation.value +'&l_depend='+ lstDepend.value ;
		 window.open(url);
       }
	   else if (obj.id=="datWorkGroup_info")
	   {
			lstWGrp_Code.SetDataText(txtwg_tmp.text + "|ALL|Select All");
            lstWGrp_Code.value ="ALL";
			check_init=1;
	   }
	   
}      

function OnSearch()
{
	//alert(dtFromDt);
	//alert(1);
	if(check_init==1)
	{
		if (imgMaster.status == "expand")
			datEmployee.Call('SELECT');
		else    
			datRelative.Call('SELECT');
	}		
}

function OnAdd()
{
    if (imgMaster.status == "expand")
    {
        var irow=grdEmp.row;
        if (irow>=1)
        {
            var sgrp=grdEmp.GetGridData(irow,1);
            var semp_id=grdEmp.GetGridData(irow,2);
            var sfull_nm=grdEmp.GetGridData(irow,3);
            var semp_pk=grdEmp.GetGridData(irow,0);
            grdRelative.AddRow();
            irow=grdRelative.rows-1;
            grdRelative.SetGridText(irow,2,sgrp);
            grdRelative.SetGridText(irow,3,semp_id);
            grdRelative.SetGridText(irow,4,sfull_nm);
            grdRelative.SetGridText(irow,1,semp_pk);
        }
    }
}

function OnDelete()
{
	if(check_init==1)
	{
		grdRelative.DeleteRow();
	}	
}

function OnSave()
{
	if(check_init==1)
	{
		if(confirm("Do you want to save?"))
			datRelative.Call();
	}	
}


function onClickOption(obj)
{
    opt_value = obj;
    switch(obj)
    {
        case 1:
            grdEmp.ClearData();
            grdRelative.ClearData();
            break;
	    case 2:
	        grdEmp.ClearData();
	        grdRelative.ClearData();
	        break;           
    }
}

function LoadRelative()
{
   if (grdEmp.rows-1 > 0)
   {
        if (imgMaster.status=="expand")
        {
            ibtnAdd.SetEnable(true);
            txtEmp_PK.text=grdEmp.GetGridData(grdEmp.row,0);
            datRelative.Call("SELECT");
        }
    }
}

//----------------------------------------------

function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            imgMaster.status = "collapse";
			tdDetail.style.display="none";
            tdDetail.style.width="0%";
            tdMaster.style.height="100%";
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Open Employees";
			txtEmp_PK.text="";
			ibtnAdd.SetEnable(false);
        }
        else
        {
            imgMaster.status = "expand";
            tdDetail.style.display="";
            tdDetail.style.width="30%";
            tdMaster.style.height="70%";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Close Employees";
			if (grdEmp.rows-1 > 0)
               ibtnAdd.SetEnable(true);
        }
  
}

function OnReport()
{
    
    txtReport_tmp.text='rpt_relative.aspx';
    datFind_Report.Call();
}
function onChange_org(tab,obj)
{
	flag_tab=tab;
	txtorg_tmp.text=obj.value;
	datWorkGroup_info.Call();
	
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
            <dso  type="list" procedure="HR_SP_SEL_USER_ROLE2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_SEL_WG_ROLE"  > 
                <input>
                    <input bind="txtorg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

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

<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_SP_PRO_GROUP_DATA_ALL" > 
                <input>
                    <input bind="lstOrg_Code" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmployee" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10010015_EMP_RELATIVE" > 
                <input bind="grdEmp" >
                    <input bind="lstOrg_Code" />
                    <input bind="lstWGrp_Code" />
                    <input bind="lstSearch" />
                    <input bind="txtSearch" />
                    <input bind="lstStatus" />
					<input bind="lstNation" />
					<input bind="lstJob" />
                </input>
                <output  bind="grdEmp" />
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datRelative" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" parameter="0,1,5,6,7,8,9,10,11,12,13,14,15,16,17" function="HR_SEL_10010015_RELATIVE" procedure="HR_UPD_10010015_RELATIVE"> 
                <input bind="grdRelative">
                    <input bind="lstOrg_Code" />
                    <input bind="lstWGrp_Code" />
                    <input bind="lstSearch" />
                    <input bind="txtSearch" />
                    <input bind="lstStatus" />
                    <input bind="lstRelationship" />
                    <input bind="dtFromDT" />
                    <input bind="dtToDT" />
                    <input bind="txtEmp_PK" /> 
					<input bind="lstNation" />
					<input bind="lstJob" />
					<input bind="lstDepend" />
                </input> 
                <output bind="grdRelative"/>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_FIND_REPORT" > 
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
<table width="100%" id="Table2" style="height:10%" border=0 cellpadding="0" cellspacing="0">
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
    <tr style="border:0;width:100%;height:5%" valign="center" >
        <td colspan="5" align="right" style="width: 81px" > <a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Oganization</a></td>
        <td colspan="10" align="left" style="width: 16%" >
            <gw:list id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="onChange_org(1,lstOrg_Code)" >
                <data>
                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                </data>
            </gw:list>
        </td>
        <td nowrap  colspan="4" align="right" >Work Group</td>
        <td colspan="10" align="left" >
            <gw:list  id="lstWGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
				<data><%=ESysLib.SetListDataSQL("select a.pk,a.workgroup_nm from thr_work_group a where a.del_if=0  order by a.workgroup_nm")%>|ALL|Select All</data>
			</gw:list>
        </td>
		<td nowrap  colspan="5" align="right">Job</td>
        <td colspan="10" align="left" style="width: 16%" >
            <gw:list id="lstJob" value='ALL' maxlen = "100" styles='width:100%' >
                <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0108' order by code_nm")%>|ALL|Select All</data>
            </gw:list>
        </td>
		<td colspan="1" ></td>
        <td colspan="1" align="right"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch()" /></td>
        <td colspan="1" align="right" ><gw:imgBtn id="ibtnAdd" alt="Add" img="New" text="Search" onclick="OnAdd()" /></td>
        <td colspan="1" align="right" ><gw:imgBtn id="ibtnSave" alt="Save" img="Save" text="Save" onclick="OnSave()" /></td>
        <td colspan="1" align="right" ><gw:imgBtn id="ibtnDelete" alt="Delete" img="Delete" text="Delete" onclick="OnDelete()" /></td>
        <td colspan="1" align="right" ><gw:imgBtn id="ibtnReport" alt="Report" img="Excel" text="Report" onclick="OnReport()" /></td>
    </tr>
	<tr style="border:0;width:100%;height:5%" valign="center" >
        <td colspan="5" align="right" >Nation</td>
        <td colspan="10" align="left" >
            <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
				<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
        </td>
		<td nowrap  colspan="4" align="right" >Search by
        </td>
        <td colspan="5" colspan=2 align="left" >
            <gw:list id="lstSearch" value="2" styles='width:100%' onchange=""> 
            <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Contract NO</data> 
            </gw:list>
        </td>
        <td colspan="5" align="left" ><gw:textbox id="txtSearch" onenterkey ="OnSearch()" styles='width:100%'/></td>
        <td colspan="5" align="right" >Status</td>
        <td colspan="10"> <gw:list  id="lstStatus"  value='A'  maxlen = "100" styles='width:100%' value="551">       
            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0022' order by code_nm")%>
                |ALL|Select All
            </data>
             </gw:list> </td>
    </tr>
    <tr style="border:0;width:100%;height:5%" align=top cellpadding="0" cellspacing="0" >
        <td colspan="1" style="border:0;"  align="right" valign="bottom">
			<img status="collapse" id="imgMaster" alt="Show Detail Items" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle()"  /> </td>
        
        <td colspan="4" align="right">Relationship</td>
        <td colspan="10"> <gw:list  id="lstRelationship"  value='ALL' maxlen = "100" styles='width:100%' value="551">       
            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0024' order by code_nm")%>
                |ALL|Select All
            </data>
             </gw:list> </td>
        <td nowrap colspan="4" align="right">Effected Date</td>
        <td colspan="4"  ><gw:datebox id="dtFromDT" nullaccept maxlen = "9" text="" styles='width:80%'lang="<%=Session("Lang")%>" /></td>
        <td colspan="1" align="center" ><b>~</b></td>
        <td colspan="5"><gw:datebox id="dtToDT"  maxlen = "9" text="" nullaccept styles='width:80%'lang="<%=Session("Lang")%>" /></td>
        <td colspan="5" align="right" ><b>Depend Flag</b></td>
        <td colspan="5" align="right" >
            <gw:list  id="lstDepend"  value='ALL' maxlen = "100" styles='width:100%' >       
                <data>
                    |ALL|Select All|1|Yes|2|No
                </data>
             </gw:list>
        </td>
        <td colspan="11" align="center"><gw:label id="lblRecord" text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12"></gw:label></td>
        
    </tr>
</table>

<table id="Table1" style="width:100%;height:87%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="width:100%;height:100%">
			<td id="tdDetail" width="30%" style="display:none">
				<gw:grid
					    id="grdEmp"
					    header="_EMP_PK|Team/Section|Emp ID|Full Name"
					    format="0|0|0|0"
					    aligns="0|0|0|0"
					    defaults="|||"
					    editcol="0|0|0|0"
					    widths="0|1500|1500|2500"
					    styles="width:100%;height:100%"
					    sorting="T"
					    oncellclick = "LoadRelative();"
                        />
			</td>
			<td id="tdMaster" width="70%">
				<gw:grid
					    id="grdRelative"
                        header="_PK|_EMP PK|Organization|Emp ID|Full Name|Name|Relation|Birth Date|Birth Place|Address|Telephone|Job|Salary|_Remark|Depend Flag|Start Date|End Date|Working At SHB"   
                        format="0|0|0|0|0|0|0|0|0|0|0|0|1|0|3|4|4|3"  
                        aligns="0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                        defaults="||||||||||||||||"  
                        editcol="0|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|1"  
                        widths="0|0|1600|1200|2500|2500|1200|1200|1200|3000|1200|1400|1300|2000|1300|1300|1300|1300"  
                        styles="width:100%; height:100%"   
                        sorting="T"   
                        acceptNullDate
                       /> 
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
    <gw:textbox id="txtEmp_PK" styles="display:none"/>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>
	<gw:textbox id="txtorg_tmp" styles="display:none"/>
	<gw:textbox id="txtwg_tmp" styles="display:none"/> 
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  /> 
</body>

</html>
