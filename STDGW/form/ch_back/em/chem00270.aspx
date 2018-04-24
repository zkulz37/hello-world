<!-- #include file="../../../system/lib/form.inc"  --> 
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
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
    
    //OnClickChange();
    //OnClickChange();
}

function OnClickChange()
{
    
	ResetData();
            datchem000210_1.Call();    
    
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
        case 'datchem000210_2':
          //  imgEmp.SetDataText(txtPhoto_PK.text);
			auto_resize_column(grdEmp,0,grdEmp.cols-1,9);    
            //datchem000210_4.Call("SELECT");
           
        break;
		case 'datchem000210_3':
            imgEmp.SetDataText(txtPhoto_PK.text);
			//auto_resize_column(grdEmp,0,grdEmp.cols-1,9);    
            datchem000210_4.Call("SELECT");
           
        break;
		case 'datchem000210_4':
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
        
    datchem000210_4.Call('SELECT');
}

function OnSearch()
{//alert("sdfds");
datchem000210_2.Call('SELECT');
}
function OnSave()
{
	if(confirm("Do you want to save?"))
	{datchem000210_4.Call();
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
 grdEmp.SetGridText(grdEmp.row,7,temp);
}

function OnGridCellClick(obj)
{    
    if (obj.id == "grdEmp")
    {
       
        if (grdEmp.rows <= 1)
            return;
            
        txtEmpTmp_PK.text       = grdEmp.GetGridData(grdEmp.row ,0);
        datchem000210_3.Call();
    }    
    
}




function OnShowPopup()
{     
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {   
		//txtUpperOrg.text=obj;
          lstOrg.value=obj;  
        }
}

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
function ReportExcel()
{    
	
    //var url = "var url=System.RootURL + '/reports/hd/ah/rpt_working_period.aspx?p_1=' + IDMonth.value;";
	var url=System.RootURL + '/reports/ch/em/rpt_working_behaviour_vst.aspx?p_thr_eva_master_pk='+ lstYear.value + '&P_TCO_ORG_PK='+ lstOrg.value + '&P_SEARCH_BY='+ lstTemp.value + '&P_SEARCH_TEMP='+ txtTemp.text+'&p_userpk='+ txtManager_PK.text +'&p_work_group='+lstGrp_Code.value;
    window.open(url);    
    
}
//--
</script>
<body>

<!------------------------------------->
<!--
<gw:data id="datchem000210_2" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="" function="sp_pro_chem000210_2"> 
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

<gw:data id="datchem000210_1" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="sp_pro_chem000210_1" > 
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


<gw:data id="datchem000210_3" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="process" procedure="sp_pro_chem000210_3" > 
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

<gw:data id="datchem000210_4" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6" function="sp_pro_sel_chem000210_4"   procedure="sp_pro_upd_chem000210_4"> 
                <input bind="grdEmployee" >                    
					  <input bind="txtEmpTmp_PK" />
					  <input bind="txtgroup" />				
                </input>
                <output  bind="grdEmpStatus" />
                
            </dso> 
        </xml> 
</gw:data> -->
<table id="main" cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%; margin-left:0; margin-top:0">
    <tr>
        <td colspan=1 width="40%" valign="top" id="left">
            <table style="width:100%; height:100%" border="0">
                <tr style="height:16%">
                    <td colspan=2>
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
                    <td valign="top" width="70%" >
                        <table style="width:100%;height:100%; margin-left:0; margin-top:0;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" border="1">
                            <tr style="height:5%; ; " >
								<td style="width:10%;border:0" align="right" valign="middle"> <a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Oganization</a></td>
								<td colspan=1 style="width:20%;border:0" valign="middle"><gw:list  id="lstOrg" value='ALL'>
									 <data>
										<%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and  TCO_COMPANY_PK='" + session("company_pk")+ "'  connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
									</data>
								</gw:list></td>
								<td width="5%" style="border:0;" align="right" valign="middle">WG</td>
								<td colspan=2 style="border:0;" align="left" valign="middle" ><gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
									<data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data></gw:list>
								</td>
							</tr>
							<tr height="5%">
								<td style="width:10%;border:0" align="right" valign="middle">Level</td>
								<td colspan=1 style="width:20%;border:0" valign="middle">
									<gw:list  id="lstLevel" value='ALL' maxlen = "100" styles='width:100%' >
									</gw:list>
								</td>
								<td width="5%" style="border:0;" align="right" valign="middle"></td>
								<td width="15%" colspan=2 style="border:0;" align="left" valign="middle" >
								</td>
							</tr>
							 <tr height="5%">
								<td  style="border:0">
									<gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
											<data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID</data> 
									</gw:list>
								</td>
								<td  align=right style="border:0"> 
									<gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles="width:100%"/>
								</td>
								<td width="8%" style="border:0;">
									<gw:imgBtn img="search" id="ibtnSearch"   alt="search"  onclick="OnSearch()"/>
								</td>
								<td width="12%" align="left" style="border:0;">
									<gw:imgBtn img="excel" id="ibtnReport"   alt="Report"  onclick="ReportExcel()" styles="display:none"/>												
								</td>
								<td></td>
							</tr>	
							<tr height="85%" >
								<td colspan="5" style="">
									<gw:grid id="grid1" 
									header="_thr_eva_emp_pk|Level|Status|Name|Emp ID|Org|WorkGroup" 
									format="0|0|0|0|0|0|0" 
									aligns="0|0|0|0|0|0|0" 
									defaults="|||||||" 
									editcol="|||||||" 
									widths="0|700|1000|2000|1000|2000|2000" 
									styles="width:100%;height:100%" 
									oncellclick="OnGridCellClick(this)"
									editcolcolor="true"
									 />
								</td> 
							</tr>
                           
                        </table>
                    </td>
					<td colspan="1" width="30%" valign="top" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black;background-color:#BDE9FF">
						<table width="100%"  style="background-color:#BDE9FF">
							<tr >
								<td width="40%" height="30%" valign="top" align="center" >
									<gw:image id="imgEmp" view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:160;height:155"  />
								</td>								
							</tr>
							<tr height="10%"><td valign="top"></td></tr>
							<tr height="10%"><td valign="top"><gw:label id="lblEmpID" text="EmpID" styles="font-weight: bold;"/></td></tr>
							<tr height="10%"><td valign="top"><gw:label id="lblName" text="Name" styles="font-weight: bold;" /></td></tr>
							<tr height="10%"><td valign="top"><gw:label id="lblOrg" text="Org" styles="font-weight: bold;" /></td></tr>
							<tr height="10%"><td valign="top"><gw:label id="lblWg" text="WG" styles="font-weight: bold;" /></td></tr>
							<tr height="10%"><td valign="top"><gw:label id="lblJoinDt" text="JoinDt" styles="font-weight: bold;" /></td></tr>
							<tr height="10%"><td valign="top"><gw:label id="lblPos" text="Position" styles="font-weight: bold;" /></td></tr>
							<tr height="10%"><td valign="top"><gw:label id="lblJob" text="Job" styles="font-weight: bold;" /></td></tr>													
                         </table>           
					</td>
                </tr>
            </table>
        </td>
        <td width="60%"  valign="top" id="right">
            <table width="100%" cellpadding="0" cellspacing="1" border="0" style="height:100%;border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black" >
                
				<tr style="height:75%"  >
                    <td colspan="1" style="">
                        <gw:grid id="grid2" 
                        header="_pk|Element Type|Factor|Score|Score 1st|Score 2nd" 
                        format="0|0|0|-1|-1|-1" 
                        aligns="0|0|0|0|0|0" 
                        defaults="||||||" 
                        editcol="0|0|0|0|1|1" 
                        widths="0|3500|3500|1200|1200|1200" 
                        styles="width:100%;height:100%" 
                        oncellclick="OnGridCellClick(this)"
                        onafteredit="AfterEdit()"
                        editcolcolor="true"
                        param="0,1,2,3,4,5" />
                    </td>
                </tr> 
				<tr style="height:25%; width:100%">
					<td style=" width:100%">
						<table style="height:100%; width:100%;;background-color:#BDE9FF">
							<tr style="height:50%"> 
								<td style="width:20%" align="center">1st</td>
								<td style="width:80%"><gw:textarea id="txt1st" text="" rows="6" styles="width:100%" /></td>
							<tr/>
							<tr style="height:50%"> 
								<td align="center">2nd</td>
								<td><gw:textarea id="txt2nd" text="" rows="6" styles="width:100%" /></td>
							<tr/>
						</table>
					</td>
				</tr>				
            </table>
        </td>
		
		<!--
		<td width="60%"  valign="top" id="right">
            <table width="100%" cellpadding="0" cellspacing="1" border="0" style="height:100%;" >
                <tr style="height:100%"  >
                    <td colspan="2" style="border-bottom: solid 1 Black; border-left: solid 1 Black; border-right: solid 1 Black; border-top: solid 1 Black">
                        <gw:grid id="grid3" 
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
        </td>   -->      
    </tr>    
</table>
<gw:textbox id="txtEmpTmp_PK" styles="display:none"/>
<gw:textbox id="txtManager_PK" styles="display:none"/>
<gw:textbox id="txtPhoto_PK" styles="display:none"/>
<gw:textbox id="txtgroup" text="HR0170" styles="display:none"/>

</body>



