<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var v_language = "<%=Session("SESSION_LANG")%>";
var emp_pk_list;

var v_sel=0;
var v_org=1;
var v_recruit_dt=2;
var v_full_name=3;
var v_join_dt=4;
var v_birth_dt=5;
var v_place_birth=6;
var v_sex=7;
var v_address=8;
var v_position=9;
var v_person_id=10;
var v_issue_dt=11;
var v_place_person=12;
var v_prob_type=13;
var v_prob_sal=14;
var v_basic_sal=15;
var v_allowance=16;
var v_recruit_flag=17;
var v_seq_dt=18;
var v_rec_pk=19;
var v_pro_flag=0;
function BodyInit()
{
    
    
    grdEmployee.GetGridControl().FrozenCols =4;
    grdEmployee.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";

    menu_id.text=System.Menu.GetMenuID();
    BindingDataList();
    ChangeColorItem(lstOrg_Code.GetControl());
    datCheck_View.Call();
}
function BindingDataList()
{   
      var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0021' order by code_nm")%>";
       grdEmployee.SetComboFormat(v_place_birth,t1);
    
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0007' order by code_nm")%>";
       grdEmployee.SetComboFormat(v_sex,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0014' order by code_nm")%>";
       grdEmployee.SetComboFormat(v_place_person,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>";
       grdEmployee.SetComboFormat(v_position,t1);
       
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
//-----------------------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        lstOrg_Code.value=obj;
        //datDeptData.Call();
    }
    
}
//----------------------------------------------
function OnDataReceive(obj)
{
   if(obj.id == "datCheck_View")
   {
        if(txtFlag_View.text == 'Y')
        {
            ibtnDelete.style.display = "none";
            
        }
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
   }
   else if (obj.id=="datRecruited_Emp")
   {
        lblRecord.text=grdEmployee.rows-1 + " record(s).";
        for (var i=1;i<grdEmployee.rows;i++)
        {
            if (grdEmployee.GetGridData(i,v_recruit_flag)=="Yes")
                grdEmployee.SetCellBgColor(i, v_sel,i, v_rec_pk, 0xFFCC66);
            else
            {
                if (grdEmployee.GetGridData(i,v_sel)=="-1" && grdEmployee.GetGridData(i,v_seq_dt)!="")
                    grdEmployee.SetCellBgColor(i, v_sel,i, v_rec_pk, 0x99FFFF );
            }
        }
   }
   else if (obj.id=="datProcessRecruit")
   {
        v_pro_flag=0;
        if (txtResult.text=="0")
            alert("Processing was not complete!");    
         else
            alert("Processing was complete!");    
         txtSequence.text="";
         datRecruited_Emp.Call("SELECT");
        
   }
   else if (obj.id=="datUser_info")
   {
        ChangeColorItem(lstOrg_Code.GetControl());
        //datGroupData.Call();
   }
   else if (obj.id=="datFind_Report")
   {
        var url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?p_org=' + lstOrg_Code.value+'&p_wgroup='+lstWorkGroup.value +'&p_from_joindt=' +dtFrom_JoinDate.value +  '&p_tojoindt=' +dtTo_JoinDate.value +'&p_from_recruit=' +dtFrom_Recruit.value +  '&p_to_recruit=' +dtTo_Recruit.value +'&p_lst_temp=' + lstTemp.value + '&p_temp='+  txtTemp.text + '&p_pos=' + lstPosition.value + '&p_recruit_flag=' + lstRecruited_Flag.value;   
        window.open(url); 
        
   }    
       
}

//----------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//----------------------------------------------------
function OnSearch()
{
        chkCheckAll.value='F';   
        datRecruited_Emp.Call("SELECT");
       
}

//------------------------------------------------------------
function doSelectAll()
{	
	var tmp;
	if( chkCheckAll.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
     var ctrl = grdEmployee.GetGridControl();
    if (ctrl.SelectedRows >0)
        
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 && grdEmployee.GetGridData(row,v_recruit_flag)!="Yes")
			    {		
				    grdEmployee.SetGridText(row,v_sel,tmp);
			    }	
		    }
	else
	    for ( var i =  1 ; i < grdEmployee.rows ; i++ )
		    {
		        if (grdEmployee.GetGridData(i,v_recruit_flag)!="Yes")
				    grdEmployee.SetGridText(i,v_sel,tmp);
		    }
}
//-----------------------------------------------
function OnReport(n)
{
   
        txtReport_tmp.text="rpt_recruitment_list.aspx"
		datFind_Report.Call();
 
}

//------------------------
function  OnUpdate()
{
    imp_seq=new Date().getTime();
	txtSequence.text=imp_seq;
	v_pro_flag=1;
	for (var i=1;i<grdEmployee.rows;i++)
	{
	
	    if (grdEmployee.GetGridData(i,v_sel)=="-1")
	    {
	        
	//alert("vao");
	        grdEmployee.SetGridText(i,v_seq_dt,imp_seq); 
	        grdEmployee.SetRowStatus(i,16);
	    }    
	    else
	        grdEmployee.SetRowStatus(i,0);
	    
	}
	datRecruited_Emp.Call();
}
function OnProcess()
{
    if (v_pro_flag==1)
        {
            datProcessRecruit.Call();
        }
}
function On_AfterEdit()
{
  if (grdEmployee.GetGridData(event.row,v_recruit_flag)=="Yes" && event.col==v_sel && grdEmployee.GetGridData(event.row,v_sel)=="-1")
    {
        alert("This employee was be recruited!\n Nhân viên này đã được tuyển dụng vào công ty!");
        grdEmployee.SetGridText(event.row,event.col,0);
    }    
   // alert(grdEmployee.GetGridData(event.row,v_sel));
}
</script>
<body >
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



<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_FIND_REPORT_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="txtOrg_tmp_pk" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<gw:data id="datRecruited_Emp" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10010076 " procedure="HR_upd_10010076" parameter="18,19"> 
                <input>
                    <input bind="lstOrg_Code" /> 
                    <input bind="lstWorkGroup" /> 
                    <input bind="dtFrom_JoinDate" /> 
                    <input bind="dtTo_JoinDate" />
                    <input bind="dtFrom_Recruit" /> 
                    <input bind="dtTo_Recruit" />
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" />
                    <input bind="lstPosition" />
                    <input bind="lstRecruited_Flag" />
                    <input bind="txtSequence" />
                </input> 
                <output bind="grdEmployee" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datProcessRecruit" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10010076_RECRUITED" > 
                <input>
                    <input bind="txtSequence" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
   <table id="expand" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=0 cellpadding="0" cellspacing="0">
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
                        <td colspan="5" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
                        <td colspan="7" style="border:0;" align="left" >
                         <gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="5" style="border:0;" align="right">Work Group</td>
				        <td colspan="8" width="7%" style="border:0;">
						 <gw:list  id="lstWorkGroup" value='ALL' maxlen = "100" styles='width:100%' >
							<data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data>
							</gw:list>
						</td>
				        <td colspan="5" style="border:0;" align="right">Recruited Date</td>
                        <td colspan="5" style="border:0;" align="right"  >
                         <gw:datebox id="dtFrom_Recruit" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /> </td>
						<td colspan="2" align=center>~</td>
						<td colspan="5" style="border:0;" align="left" >
                         <gw:datebox id="dtTo_Recruit" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                        <td  colspan="2"  style="border:0;" align="right" >
                      
                          <gw:icon id="ibtnSearch" img="in" text="Search" onclick="OnSearch()" />
                        </td>
                        <td  colspan="2"  style="border:0" align="right">
                        <gw:icon id="ibtnRecruited" img="in" text="Set Recruited" onclick="OnUpdate()" />
                        </td>
                        <td  colspan="2"  style="border:0" align="right">
                        <gw:icon id="ibtnProcess" img="in" text="Insert Emp" onclick="OnProcess()" />
                         
                        </td>
                        <td  colspan="2"  style="border:0" align="right">
                         <gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport()"/>
                        </td>
                    </tr>
					<tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan="5" style="border:0;" align="right" >Position</td>
                        
                        <td colspan="7" style="border:0;" align="left" ><gw:list  id="lstPosition" value='ALL' maxlen = "100" styles='width:100%' >
							<data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All</data></gw:list></td>
                        <td colspan="5" style="border:0;" align="right">Recruited Flag</td>
				        <td colspan="8" width="7%" style="border:0;">
						 <gw:list  id="lstRecruited_Flag" value='N' maxlen = "100" styles='width:100%' >
							<data>|Y|Yes|N|No|ALL|Select All</data>
							</gw:list>
						</td>
						 <td colspan="5" style="border:0;" align="right">Join Date</td>
                        <td colspan="5" style="border:0;" align="right"  >
                         <gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /> </td>
						<td colspan="2" align=center>~</td>
						<td colspan="5" style="border:0;" align="left" >
                         <gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
                        </td>
                         <td  colspan="1"  style="border:0;" align="right" >
                        </td>
                        <td  colspan="1"  style="border:0" align="right">
                        </td>
                        <td  colspan="1"  style="border:0" align="right">
                        </td>
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                       <td colspan="1" style="border:0" align="center"><gw:checkbox id="chkCheckAll" value="F" onclick="doSelectAll()" ></gw:checkbox ></td>
                       <td colspan="2"></td>
						<td colspan="5" style="border:0" align="right">
                        <td style="border:0;" colspan="17" align="center" ><gw:label id="lblRecord"  text="0 record(s)." maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:13" />
                        </td>
                       <td colspan="6" style="border:0" align="right" valign="middle">
                            <font color="black" >Search by</font></td>
					   <td colspan="4" style="border:0">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Person ID</data> 
					        </gw:list>
				        </td>
				        <td colspan="7" style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
				        </td>
				      
                    
                        
                    </tr>
                    <tr style="border:1;width:100%;height:90%" valign="top">
                        <td colspan="50" style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdEmployee"  
                                header="SELECT|ORGANIZATION|RECRUIT DT|FULL NAME|JOIN DATE|BIRTH DATE|PLACE BIRTH| SEX | ADDRESS|POSITION|PERSON ID|ISSUE DATE|PLACE PERSON ID|PROBATION TYPE|PROBATION SAL|BASIC SAL|ALLOWANCE|RECRUITED FLAG|_Sequence Dt|_PK"   
                                format="3|0|0|0|0|4|2|2|0|2|0|4|2|0|0|0|0|0|0|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"    
                                defaults="|||||||||||||||||||"  
                                editcol="1|0|0|0|0|1|1|1|1|1|1|1|1|0|0|0|0|0|0|0"  
                                widths="1000|1500|1500|3000|1500|1500|1500|1000|1500|1500|1500|1000|1200|1500|1500|1500|1500|1500|1000|0"   
                                styles="width:100%; height:100%"   
                                sorting="T" 
                                onafteredit="On_AfterEdit()"
                                 /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtOption" text="2" styles="display:none"/>   
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtOrg_tmp_pk" text="" styles="display:none"  />
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />  
<gw:textbox id="txtSequence" text="" styles="display:none"  />  
</html>
