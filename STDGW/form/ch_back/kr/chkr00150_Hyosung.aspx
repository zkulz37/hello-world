<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var dis_pk="";
//"Select|_PK|Organization|Emp ID|Full Name|Work Group|Position|Join Date|Create New|Train Type|Train Name
//|Start Date|End Date|Location|Institude|Pass Y/N|Description|Times"
var g1_select = 0;
    g1_pk = 1;
    g1_org = 2;
    g1_emp_id =3;
    g1_fullname =4;
    g1_work_group =5;
    g1_position =6;
    g1_join_dt =7;
    g1_create_new =8;
    g1_train_type =9;
    g1_train_name =10;
    g1_start_dt = 11;
    g1_end_dt = 12;
    g1_location = 13;
    g1_institude = 14;
    g1_pass_yn = 15;
    g1_description = 16;
    g1_times= 17;
    g1_train_pk =18; 
    
var g2_train_type = 9;
    g2_times = 17;

function BodyInit()
{
    grdTrain.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
   
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";
   user="<%=session("USER_ID")%>";
   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
}
//----------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        datDeptData.Call();
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
//----------------------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {
        if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstOrg_Code.SetDataText(txtDeptData.text)    ;
            
              obj=lstOrg_Code.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=0;
        
   }
   else if (obj.id=="datTrain")
   {
       lblRecord.text=grdTrain.rows-1 + " record(s)";
       auto_resize_column(grdTrain,0,grdTrain.cols-1,10);
       
   }
   
   else if (obj.id=="datFind_Report")
   {
        var url =System.RootURL + '/reports/ch/ae/' + txtReport_tmp.text + '?p_user=' + user + '&dis_pk=' + dis_pk;
        window.open(url);
   }
}

//------------------------------------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
//----------------------------------------------------
function OnSearch()
{
    datTrain.Call("SELECT");
}
//-------------------------------------------------------------
function OnReport(obj)
{   
    var url=System.RootURL;
        if(obj==1)
        {   
            url=url + '/reports/ch/kr/rpt_training_history_summary.aspx?p_tco_org_pk=' + lstOrg_Code.value + '&p_wg_pk=' + lstWorkGroup.value + '&p_position=' + lstPosition.value + '&p_nation=' + lstNation.value ;
                url=url + '&p_status=' + lstStatus.value + '&p_from_join_dt=' +dtFrom_JoinDate.value + '&p_to_join_dt=' + dtTo_JoinDate.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text ;
                url=url + '&p_from_start_dt=' + dtFromStart.value  + '&p_to_start_dt=' + dtToStart.value     ;
                url=url + '&p_from_end_dt=' + dtFromEnd.value  + '&p_to_end_dt=' + dtToEnd.value  ;
        }
        else if(obj==2)   
        {   
           url=url + '/reports/ch/kr/rpt_personal_training_history.aspx?p_tco_org_pk=' + lstOrg_Code.value + '&p_wg_pk=' + lstWorkGroup.value + '&p_position=' + lstPosition.value + '&p_nation=' + lstNation.value ;
                url=url + '&p_status=' + lstStatus.value + '&p_from_join_dt=' +dtFrom_JoinDate.value + '&p_to_join_dt=' + dtTo_JoinDate.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text ;
                url=url + '&p_from_start_dt=' + dtFromStart.value  + '&p_to_start_dt=' + dtToStart.value     ;
                url=url + '&p_from_end_dt=' + dtFromEnd.value  + '&p_to_end_dt=' + dtToEnd.value  ;
        }
        else if(obj==3)
        {
             
           
        }
     window.open(url); 
}

</script>
<body >
<!-------------------data control----------------------->

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
<!------------------------------------------>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------->
<!------------------------------------------>
<gw:data id="datTrain" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="HR.SP_SEL_TRAINEE_SUMMARY" > 
                <input bind="grdTrain" >
                    <input bind="lstOrg_Code" /> 
                    <input bind="lstWorkGroup" />
                    <input bind="lstPosition" />
                    <input bind="lstNation" />
                    <input bind="lstStatus" />
                    <input bind="dtFrom_JoinDate" />
                    <input bind="dtTo_JoinDate" />
                    <input bind="lstTemp" />
                    <input bind="txtTemp" />
					<input bind="dtFromStart" />
                    <input bind="dtToStart" />
                    <input bind="dtFromEnd" />
                    <input bind="dtToEnd" />
                </input>
                <output  bind="grdTrain" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
   <table id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
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
                        <td colspan="5" style="border:0;" align="right" ><a title="Click here to show" onclick="OnShowPopup(1)" href="#tips" >
                            Organization </a>          </td>
                        <td colspan="10"  style="border:0;" align="left" >
                         <gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0  order by NVL(A.SEQ,99999)")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="5"  style="border:0;" align="right" >Work Group</td>
                        <td colspan="10"  style="border:0;" align="left" ><gw:list  id="lstWorkGroup" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT PK, WORKGROUP_NM FROM THR_WORK_GROUP WHERE DEL_IF = 0")%>|ALL|Select All</data></gw:list></td>
                         <td colspan="5"  style="border:0;" align="right" >Position</td>
                        <td colspan="9"  style="border:0;" align="left" >
                         <gw:list  id="lstPosition" value='ALL' maxlen = "100" styles='width:100%' >
                            <data>
                                <%= ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All
                            </data>
                         </gw:list>
                        </td>
						<td colspan="1" style="border:0;" align="right" ></td>
                        <td colspan="1" style="border:0;" align="right" >
                         
                        </td>
                        <td colspan="1" style="border:0" align="right">
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td colspan="1" style="border:0" align="right">
                         
                        </td>
                        <td colspan="1" style="border:0" align="right">
                         
                        </td>
                        <td colspan="1" style="border:0;" align="right" >
                          
                        </td>
                    </tr>					
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan="5" style="border:0;" align="right" >Nation</td>
                        <td colspan="10"  style="border:0;" align="left" ><gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
							<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list></td>
                        <td colspan="5" style="border:0;" align="right" >Status</td>
                        <td colspan="10" style="border:0;" align="left" >
                         <gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%' >
                           <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0022' order by code_nm")%>|ALL|Select All
                            </data></gw:list>
                        </td>
                        <td colspan="5" style="border:0;" align="right">Join Date</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  colspan="1" style="border:0;" align="center">~</b></td>
				        <td colspan="4" style="border:0;"><gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan="5" style="border:0;" align="right"><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" />
                        </td>
                        
                    </tr>
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan="1" style="border:0" align="right" valign="middle">
                        
                        </td>
						<td colspan="4" align="right">Search by</td>
					    <td colspan="5" style="border:0">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list>
				        </td>
                        <td colspan=5  style="border:0"> 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
				        </td>
                        
                         <td  colspan="5" style="border:0;" align="right">Start Date</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtFromStart" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  colspan="1" style="border:0;" align="center">~</td>
				        <td  colspan="5" style="border:0;"><gw:datebox id="dtToStart" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>

                        <td  colspan="5" style="border:0;" align="right">End Date</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtFromEnd" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  colspan="1" style="border:0;" align="center">~</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtToEnd" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=2 style="border:0" align="right"></td>
                        <td colspan="1" style="border:0" align="right">                           
                           <gw:imgBtn img="excel" id="ibtnReport1"    alt="Report History"  onclick="OnReport(1)"/>
                        </td>
                        <td colspan="1" style="border:0" align="right">
                            <gw:imgBtn img="excel" id="ibtnReport2"    alt="Report Personal"  onclick="OnReport(2)"/>
                        </td>
                        <td>
                            
                        </td>
                        <td align="right" style="border:0" valign="bottom"></td>
                        
                    </tr>
                    
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=50 style="width:100%;height:100%;"> 
                            <table width="100%" id="tblMaster" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%;height:100%" valign="top">
                                    <td>
                                     <gw:grid   
                                        id="grdTrain"  
                                        header="_PK|Organization|Emp ID|Full Name|Work Group|Position|Join Date|Train Name|Start Date|End Date|Location|Institude|Pass Y/N|Scope"   
                                        format="0|0|0|0|0|0|0|0|0|0|2|0|0|2"  
                                        aligns="0|0|0|0|0|0|0|0|1|1|0|0|1|1"  
                                        defaults="|||||||||||||"  
                                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                        widths="0|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
                                        styles="width:100%; height:100%" 
								        acceptNullDate="T"
                                        sorting="T"
                                        /> 
                                     </td>
                                 </tr>
                             </table>
                             
                        </td>
                    </tr>
                    
                
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtEmp_PK" styles="display:none"/>
<gw:textbox id="txtTimes" styles="display:none"/>
</html>
