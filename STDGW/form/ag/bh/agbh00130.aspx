<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script>

function BodyInit()
{
    System.Translate(document); 
   //<%=ESysLib.SetGridColumnComboFormatString2( "grdList" ,4 , "1|Option 1|2|Option 2") %>;
   var lstDept_Data = "<%=ESysLib.SetListDataSQL("select a.pk,a.dept_nm from comm.tco_dept a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>";
   lstDept.SetDataText(lstDept_Data + "|ALL|Select All"); lstDept.value = "ALL";
   var lstWorkGroup_Data = "<%=ESysLib.SetListDataSQL("SELECT A.PK, A.WORKGROUP_NM FROM HR.THR_WORK_GROUP A WHERE A.DEL_IF = 0")%>";
   lstWorkGroup.SetDataText(lstWorkGroup_Data + "|ALL|Select All"); lstWorkGroup.value = "ALL";
   //OnSelectEvaYear();
}
   
function OnShowDept_popup()
{
	var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:240;edge:sunken;scroll:no;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        dsoLoadDepartment.Call();
    }
}   
   
   
   
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Work Group Mapping</title>
</head>
<body>

<gw:data id="dsoLoadDepartment" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperDept" /> 
                </input> 
                <output>
                    <output bind="lstDept" />
                </output>
            </dso> 
        </xml> 
</gw:data>



	<table width="100%" height="100%" border= "0">
		<tr>
			<td colspan="2">
				<table width="100%" height="100%" border= "0">
					<tr>
						<td width="85%"><fieldset><legend >Mapping infomation ...</legend>
							<table width="100%" height="100%" >
								<tr>
									<td width="9%" style="border:0;" align="right" ><a title="Click here to show department" onclick="OnShowDept_popup()" href="#tips" >
										Department </a>                  
									</td>
									<td width="13%" style="border:0;" align="left" >
										 <gw:list  id="lstDept" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeDept()" > </gw:list>
									</td>
									<td width="7%" style="border:0;" align="right" >Work group</td>
									<td width="11%" style="border:0;" align="left" >
									 <gw:list  id="lstWorkGroup" value='ALL' maxlen = "100" styles='width:100%' ></gw:list>
									</td>
									<td width="5%" style="border:0;" align="right" ></td>
								</tr>
							</table>
						</fieldset></td>
						<td width="15%"><fieldset><legend >...</legend>
							<table width = "100%" height = "100%" >
							<tr>
								<td></td>
								<td width = "3%"><gw:imgBtn id="btnSearch" img="search" alt="Search item" onclick="OnSearchData('COST_MAPPING')" /></td>
								<td width="3%"><gw:imgBtn id="idUDelete" img="udelete" alt="UnRemove" text="UnDelete" onclick="OnUnDeleteData()"/></td>
								<td width="3%"><gw:imgBtn id="idDelete" img="delete" alt="Remove" text="Delete" onclick="OnDeleteData()"/> </td>				
								<td width="3%"><gw:imgBtn id="idBtnSave" img="save" alt="Save" text="Save" onclick="OnSaveChangedData()"/></td>
								<td width = "3%"></td>
							</tr>
						</table>
						</fieldset></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height = "100%" >
			<td width="40%">
				<table width = "100%" height = "100%" border="0" >
					<tr>
						<td>UnMapping Group</td>
					</tr>
					<tr height = "100%" ><td >
						<gw:grid   
							id="grdList"  
							header="_THR_EVA_MASTER_PK|_EVA_TO_PK|_EVA_TO_GRADE_PK|Number of Employee|Option|S|A|B|C|D|E|_GS|_GA|_GB|_GC|_GD|_GE"   
							format="0|0|0|1|0|1|1|1|1|1|1|0|0|0|0|0|0"  
							aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
							defaults="||||1||||||||||||" 
							editcol="0|0|0|1|1|1|1|1|1|1|1|0|0|0|0|0|0" 
							widths="0|0|0|2000|2000|1500|1500|1500|1500|1500|1500|0|0|0|0|0|0" 
							styles="width:100%; height:100%"   
							sorting="T" oncelldblclick = ""  
							param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" onSelChange="" OnClick="" />
					</td></tr>
				</table>
			</td>
			<td width="60%">
				<table width = "100%" height = "100%" border="0" >
					<tr>
						<td>Group on Mapping</td>
					</tr>
					<tr height = "100%" ><td>
						<gw:grid   
							id="grdList"  
							header="_THR_EVA_MASTER_PK|_EVA_TO_PK|_EVA_TO_GRADE_PK|Number of Employee|Option|S|A|B|C|D|E|_GS|_GA|_GB|_GC|_GD|_GE"   
							format="0|0|0|1|0|1|1|1|1|1|1|0|0|0|0|0|0"  
							aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
							defaults="||||1||||||||||||" 
							editcol="0|0|0|1|1|1|1|1|1|1|1|0|0|0|0|0|0" 
							widths="0|0|0|2000|2000|1500|1500|1500|1500|1500|1500|0|0|0|0|0|0" 
							styles="width:100%; height:100%"   
							sorting="T" oncelldblclick = ""  
							param="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16" onSelChange="" OnClick="" />
					</td></tr>
				</table>
			</td>
		</tr>
	</table>
<gw:textbox id="txtUpperDept" styles="display:none"/>
</body>
</html>
