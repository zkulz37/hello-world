<!-- #include file="../../../system/lib/form.inc"  --> 
 <% ESysLib.SetUser("hr")%>
 <html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Register Evaluation (Manager - MBO)</title>
</head>
<script>
var v_language   = "<%=Session("SESSION_LANG")%>";
var v_company_pk = "<%=Session("COMPANY_PK")%>";
var v_emp_pk     = "<%=Session("EMPLOYEE_PK")%>";
var v_user_pk    = "<%=Session("USER_PK")%>";
var v_flag; // Y: Insert/Update
var v_confirm    = 'N'; // Y-N
var v_level      = '';
var v_reload    = 'N'; // Y-N
var THR_EVA_EMP_REVIEWER_PK;
var v_status;


function BodyInit()
{   
    if ( v_language != "ENG" )
        System.Translate(document);
    
  
    var data = "";
    data = "<%=ESysLib.SetListDataSQL("SELECT PK, EVA_YYYY ||' - ' || EVA_SEQ FROM THR_EVA_MASTER WHERE DEL_IF=0 AND CLOSE_YN = 'N' ORDER BY EVA_YYYY ||' - ' || EVA_SEQ DESC")%>";
    lstYear.SetDataText(data);
    txtManager_PK.text=v_emp_pk;
    
    OnClickChange();
}

function OnClickChange()
{
    
	ResetData();
            datchem000220_1.Call();    
    
}

function ResetData()
{
    ibtnSave.SetEnable(false);
    grdEmp.ClearData();
    grdEmpStatus.ClearData();
    imgEmp.SetDataText('');
    lbName.text='';
	lbOrg.text='';
    lbPos.text='';
    lbJob.text='';
    lbJoindt.text='';
	lbWG.text='';
    
}

function OnDataReceive(obj)
{
    switch(obj.id)
    {
        case 'datchem000220_2':
          //  imgEmp.SetDataText(txtPhoto_PK.text);
			auto_resize_column(grdEmp,0,grdEmp.cols-1,9);    
            //datchem000220_4.Call("SELECT");
           
        break;
		case 'datchem000220_3':
            imgEmp.SetDataText(txtPhoto_PK.text);
			//auto_resize_column(grdEmp,0,grdEmp.cols-1,9);    
            datchem000220_4.Call("SELECT");
           
        break;
		case 'datchem000220_4':
		ibtnSave.SetEnable(true);
		AfterEdit();
		break;
    }    
        
}

function treeItemOnclick()
{
    var obj = treeDept.GetCurrentNode();
    
    if (obj!=null)
        txtDeptPK.text = obj.oid;
        
    datchem000220_4.Call('SELECT');
}

function OnSearch()
{//alert("sdfds");
datchem000220_2.Call('SELECT');
}
function OnSave()
{
	if(confirm("Do you want to save?"))
	{datchem000220_4.Call();
	}
	
}

function OnSubmit()
{
    
}

function AfterEdit()
{   var temp=0;
	for(var i =1;i< grdEmpStatus.rows;i++)
	{ var  temp1=grdEmpStatus.GetGridData(i,5);
		if(temp1!="" && isNaN(temp1))
		grdEmpStatus.SetGridText(i,5,0);
		
		if(temp1!="" && !isNaN(temp1) && temp1 >grdEmpStatus.GetGridData(i,3) )
			{alert("This point is greater than maximum point");
				grdEmpStatus.SetGridText(i,5,'');
				temp1=0;
			}
		if(temp1!="")
		temp+=temp1*1;
		
	}
 lbPoint.text="Sum : "+temp +" (point)";
// grdEmp.SetGridText(grdEmp.row,7,temp);
}

function OnGridCellClick(obj)
{    
    if (obj.id == "grdEmp")
    {
       
        if (grdEmp.rows <= 1)
            return;
            
        txtEmpTmp_PK.text       = grdEmp.GetGridData(grdEmp.row ,0);
        datchem000220_3.Call();
    }
    
    
}
function ReportExcel()
{    
	
    //var url = "var url=System.RootURL + '/reports/hd/ah/rpt_working_period.aspx?p_1=' + IDMonth.value;";
	var url=System.RootURL + '/reports/ch/em/rpt_policy_behaviour_vst.aspx?p_thr_eva_master_pk='+ lstYear.value + '&P_TCO_ORG_PK='+ lstOrg.value + '&P_SEARCH_BY='+ lstTemp.value + '&P_SEARCH_TEMP='+ txtTemp.text +'&p_work_group=' + lstGrp_Code.value;
    window.open(url);    
    
}
function OnShowPopup()
{     
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        { //  txtUpperOrg.text=obj;
            lstOrg.value=obj;
        }
}

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//--
</script>
<body>

<!------------------------------------->

<gw:data id="datchem000220_2" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="" function="hr.SP_SEL_CHEM00220_2"> 
                <input bind="grdEmp" >
                    
					<input bind="lstYear" />
					<input bind="lstOrg" />
					<input bind="lstTemp" />
					<input bind="txtTemp" />
					<input bind="txtManager_PK" />
					<input bind="lstGrp_Code" />                   
                </input>
                <output  bind="grdEmp" />
                
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem000220_1" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="hr.sp_pro_chem000220_1" > 
            <input>
                <input bind="lstYear" />
            
            </input>
	       <output>	            
	            <output bind="lblPeriod" /> 
	            <output bind="txtSchedule" />
	        
	       </output>
        </dso> 
    </xml> 
</gw:data>


<gw:data id="datchem000220_3" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="hr.SP_SEL_CHEM00220_3" > 
            <input>
                <input bind="txtEmpTmp_PK" />
            
            </input>
	       <output>	            
	            <output bind="txtPhoto_PK" /> 
	            <output bind="lbName" />
				<output bind="lbJoindt" />
				<output bind="lbOrg" />
				<output bind="lbPos" />
				<output bind="lbJob" />
				<output bind="lbWG" />
			</output>
        </dso> 
    </xml> 
</gw:data>

<gw:data id="datchem000220_4" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6" function="hr.SP_SEL_CHEM00220_4"   procedure="SP_UPD_CHEM00220_3"> 
                <input bind="grdEmployee" >
                    <input bind="txtEmpTmp_PK" />	                   
                </input>
                <output  bind="grdEmpStatus" />
                
            </dso> 
        </xml> 
</gw:data>
<table id="main" cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%; margin-left:0; margin-top:0">
    <tr>
        <td width="45%" valign="top" id="left">
            <table style="width:100%; height:100%" border="0">
                <tr style="height:16%">
                    <td>
                        <table border="0" style="width:100%;height:100%; margin-left:0; margin-top:0;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" style="background-color:#BDE9FF">
                            <tr>
                                <td width="30%" align="right">Evaluation #</td>
                                <td width="70%" colspan="4" style="">
                                    <gw:list  id="lstYear" styles='width:100%' onchange="OnClickChange()" ></gw:list>
                                </td>
                            </tr>
                            <tr>
                                <td width="30%" align="right">Evaluation Period</td>
                                <td width="70%" style="width:100%; font-size:larger" nowrap colspan="4"><gw:label id="lblPeriod" text=""/></td>
                            </tr>
                            <tr>
                                <td width="30%" align="right">Schedule</td>
                                <td width="70%" style="width:100%; font-size:larger" nowrap colspan="4" ><gw:label id="txtSchedule" text="" /></td>
                            </tr>
                        </table>  
                    </td>
                </tr>
                <tr style="height:84%">
                    <td valign="top" >
                        <table style="width:100%;height:100%; margin-left:0; margin-top:0;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" border="1">
                            
                            <tr style="height:95%" >
                                <td style="width:100%; height:100%" valign="top">
                                    <table style="width:100%;height:100%" border="0">
                                        <tr valign="top">
                                            <td style="width:100%; height:100%" valign="top">
                                                <table style="width:100%;height:100%" border="0">
                                                    <tr valign="top">
                                                        <td style="width:10%; height:10%" align="right" valign="middle"> <a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Oganization</a></td>
                                                        <td colspan=1 style="width:20%; height:10%" valign="middle"><gw:list  id="lstOrg" value='ALL'>
														 <data>
														<%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from comm.tco_org a  where a.del_if = 0 and  TCO_COMPANY_PK='" + session("company_pk")+ "'  connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
														</data>
														</gw:list></td>
														<td width="5%" style="border:0;" align="right" valign="middle">Work Group</td>
														<td width="15%" colspan=2 style="border:0;" align="left" valign="middle" ><gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
															<data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data></gw:list>
														</td>
                                                    </tr>
													 <tr valign="top">
													 <td  style="border:0">
														<gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
																<data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID</data> 
														</gw:list>
														</td>
													<td  align=right style="border:0"> 
														<gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles="width:100%"/>
													</td>
													<td width="8%">
													<gw:imgBtn img="search" id="ibtnSearch"   alt="search"  onclick="OnSearch()"/>
													
													</td>
													<td width="12%" align="right">
													<gw:imgBtn img="excel" id="ibtnReport"   alt="Report"  onclick="ReportExcel()"/>
													
													</td>
													<td></td>
													</tr>	
                                                    <tr >
                                                        <td colspan="6" style="width:50%; height:90%">
                                                            <gw:grid id="grdEmp" 
                                                            header="_thr_eva_emp_pk|Organization|Emp ID|Emp Name|Position|Job|Join date|Sum Point" 
                                                            format="0|0|0|0|0|0|4|0" 
                                                            aligns="0|0|0|0|0|0|0|0" 
                                                            defaults="|||||||" 
                                                            editcol="|||||||" 
                                                            widths=""0|2000|2000|2000|2000|1000|1000|1000" 
                                                            styles="width:100%;height:100%" 
                                                            oncellclick="OnGridCellClick(this)"
                                                            editcolcolor="true"
                                                             />
                                                        </td> 
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>                                
                                
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
        <td width="55%"  valign="top" id="right">
            <table width="100%" cellpadding="0" cellspacing="1" border="0" style="height:100%;" >
                <tr style="height:30%"  >
                    <td colspan="2" width="100%" valign="top">
						<table width="100%" >
                                        <tr >
                                            <td width="40%" rowspan=7 valign="top" align="center" >
                                                <gw:image id="imgEmp" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:180;height:155"  />
                                            </td>
											<td width="10%">Full Name:</td>
											<td width="50%"><gw:label id="lbName" styles='color:red;width:100%;font-weight: bold;font-size:13' /></td>
                                        </tr>
										<tr>
											<td>Join date:</td>
											<td><gw:label id="lbJoindt" styles='color:red;width:100%;font-weight: bold;font-size:13'  /></td>
                                        
										</tr>
										<tr>
											<td>Organization:</td>
											<td><gw:label id="lbOrg" styles='color:red;width:100%;font-weight: bold;font-size:13' /></td>
                                        
										</tr>
										<tr>
											<td>Position:</td>
											<td><gw:label id="lbPos" styles='color:red;width:100%;font-weight: bold;font-size:13' /></td>
                                        </tr>
										<tr>
											<td>Job:</td>
											<td><gw:label id="lbJob" styles='color:red;width:100%;font-weight: bold;font-size:13' /></td>
                                        </tr>
										<tr>
											<td>WGroup:</td>
											<td><gw:label id="lbWG" styles='color:red;width:100%;font-weight: bold;font-size:13' /></td>
                                        </tr>
                                       
                         </table>           
					</td>
				</tr>
				<tr style="height:5%"  >
                    <td  align="center"><gw:label id="lbPoint" text="Sum: 0 (point)" styles='color:red;width:100%;font-weight: bold;font-size:13' /></td>
					<td  align="center">
                     
					 <gw:imgBtn img="save" id="ibtnSave"   alt="Save"  onclick="OnSave()"/>
                    </td>
                </tr>
                <tr style="height:70%"  >
                    <td colspan="2" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
                        <gw:grid id="grdEmpStatus" 
                        header="_PK|_group|_code|_max|Factor Name|Point|Remark" 
                        format="0|0|0|0|0|-1|0" 
                        aligns="0|0|0|0|0|0|0" 
                        defaults="||||||" 
                        editcol="0|1|1|1|1|1|1" 
                        widths="0|0|0|0|3000|1000|3000" 
                        styles="width:100%;height:100%" 
                        oncellclick="OnGridCellClick(this)"
                        onafteredit="AfterEdit()"
                        editcolcolor="true"
                        param="0,1,2,3,4,5,6" />
                    </td>
                </tr>
                
            </table>
        </td>        
    </tr>    
</table>
<gw:textbox id="txtEmpTmp_PK" styles="display:none"/>
<gw:textbox id="txtManager_PK" styles="display:none"/>
<gw:textbox id="txtPhoto_PK" styles="display:none"/>
</body>



