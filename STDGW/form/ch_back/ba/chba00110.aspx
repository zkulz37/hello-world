<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var sun_day=new Array();
var mon_day=new Array();
var sun_col=new Array();
var dem_sun,dem_mon,dem_sun_col;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var rpt_no=0;
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    //lstWeek.SetEnable(0);
   
     iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    user= "<%=session("USER_ID")%>";
    //idPrint2.SetEnable(0);
    idGrid1.GetGridControl().ScrollTrack=true;
    idGrid2.GetGridControl().ScrollTrack=true;
    //idGrid3.GetGridControl().ScrollTrack=true;
	/*if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}*/
	  

}

//-------------------------------------------------
function OnDataReceive(obj)
{
    var obj_lst;
       if (obj.id=="datCheck_meal_1")
       {
           idRecord.text=idGrid1.rows-1+" Records."; 
           //auto_resize_column(idGrid1,0,idGrid1.cols-1,0)
       }
       else if (obj.id=="datCheck_summary2")
       {
           idRecord2.text=idGrid2.rows-1+" Records."; 
           //GroupTotal_B();
       }
    /*   else if (obj.id=="datTime_summary3")
       {
           idRecord3.text=idGrid3.rows-1+" Records."; 
       } /**/
       else if (obj.id=="datFind_Report")
       {
           var url;
    
            if (rpt_no==1)
                url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_group_pk=' + lstWGroup.value + '&p_search=' + idSearch.value + '&p_input=' + idtxtTmp.text + '&p_tco_org_pk=' + lstOrg.value  + '&p_from=' +  FromDT.value +'&p_to=' + ToDT.value + '&p_nation=' + lstNation.value+ '&p_emp_type=' + lstEmpType.value;
            else if (rpt_no==2)
            {
                url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_group_pk=' + lstWGroup2.value + '&p_tco_org_pk=' + lstOrg2.value   + '&p_from=' +  FromDT2.value + '&p_to=' + ToDT2.value + '&p_nation=' + lstNation2.value + '&p_emp_type=' +lstEmpType2.value ;
            }
           /* else
                url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_thr_work_group_pk=' + lstWGroup3.value + '&p_search_by=' + idSearch3.value + '&p_search_temp=' + idtxtTmp3.text + '&p_tco_org_pk=' + lstOrg3.value  + '&p_year=' +  idYear3.value + '&p_search_ot=' + idLstOT3.value + '&p_ot=' + idtxtOT3.text ;
                /**/
            window.open(url);
       }
}   

//-------------------------------------------------
function OnShowPopup(n)
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:270;edge:sunken;scroll:no;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(n==1)
                lstOrg.value=obj
            else    
                lstOrg2.value=obj
        }
}
//-------------------------------------------------
function show_detail()
{
        var fpath = System.RootURL + "/form/ch/ba/chba00110_01.aspx?group_pk=" + idGrid2.GetGridData(event.row,0) + "&dt1=" +idGrid2.GetGridData(event.row,3)
        + "&dt2=" +idGrid2.GetGridData(event.row,4)+ "&nation="+lstNation2.value + "&org="+ idGrid2.GetGridData(event.row,6);
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:40;dialogLeft:50;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
}
//------------------------------------------------------------  
function OnSearch(obj)
{
    obj.Call("SELECT");
}

//--------------------------------------------
function OnReport(obj)
{
    rpt_no=obj;
    var url;
    
    if (obj==1)
        txtReport_tmp.text="rpt_checking_time_detail.aspx";
    else if (obj==2)
    {
        if(lstRpt.value=='01')
            txtReport_tmp.text="rpt_checking_time_summary.aspx";
        else    
            txtReport_tmp.text="rpt_request_meal.aspx";
    }
    
    datFind_Report.Call();
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

//-------------------------------------------------------------------------------------------
</script>
<body>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtdept_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datCheck_meal_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR_SEL_chba00110_TIME_DETAIL" procedure="" parameter="1"> 
                <input bind="idGrid1"> 
                    <input bind="lstOrg" /> 
                    <input bind="lstWGroup" /> 
                    <input bind="FromDT" /> 
                    <input bind="ToDT" /> 
                    <input bind="lstNation" /> 
                    <input bind="idSearch" />
                    <input bind="idtxtTmp" />
                    <input bind="lstEmpType" />
                </input> 
                <output bind="idGrid1"/>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datCheck_summary2" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR_SEL_chba00110_TIME_SUM" procedure="" parameter="1"> 
                <input bind="idGrid2"> 
                    <input bind="lstOrg2" /> 
                    <input bind="lstWGroup2" /> 
                    <input bind="FromDT2" /> 
                    <input bind="ToDT2" /> 
                    <input bind="lstNation2" /> 
                    <input bind="lstEmpType2" /> 
                </input> 
                <output bind="idGrid2"/>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------------>
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
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate=""  > 
    <table name="Detail" id="timesummary" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
     <tr style="width:100%;height:100%" valign="top">
        <td>
            <table width="100%;height:12%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                    <td colspan=5 align=right style="width:10%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup(1)" href="#tips" >Organization</a></td>
		            <td colspan=14 align=right style="width:28%;border:0"><gw:list  id="lstOrg" value="ALL"  maxlen = "100" styles='width:100%' onchange="" >
                        <data>
                            <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All
                        </data>
                        </gw:list>
                    </td>
                    <td colspan=5 align=right style="width:10%;border:0">WGroup</td>
		            <td colspan=8 align=right style="width:16%;border:0"><gw:list  id="lstWGroup" value="ALL"  maxlen = "100" styles='width:100%' >
                                <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM thr_work_group WHERE DEL_IF = 0 order by workgroup_id")%>|ALL|Select All</data></gw:list>
                    </td>
                    <td colspan=4 style="width:8%" align="right">Work DT</td>
                    <td colspan=5 align=right style="width:10%;border:0"><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td align=right style="width:2%;border:0"><b>~</b></td>
		            <td colspan=5 align=right style="width:10%;border:0"><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" /></td>
		            <td width="2%" align="right"></td>
                    <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="Search" onclick="OnSearch(datCheck_meal_1)" /></td>
                    
                    <td align=right style="width:2%;border:0"><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport(1)" /></td>
              </tr>
              <tr>
                    <td colspan=5 style="border:0;" align="right" >Emp Type</td>
                    <td colspan=5 style="border:0;" align="left" >
                     <gw:list  id="lstEmpType" value='ALL'  styles='width:100%' >
                        <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code" )%>|ALL|Select All</data></gw:list>
                    </td>
                    <td colspan=5 style="border:0;" align="right" >Nation</td>
                    <td colspan=5 style="border:0;" align="left" >
                     <gw:list  id="lstNation" value='01'  styles='width:100%' >
                        <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' and code in('01','02') order by code" )%>|ALL|Select All</data></gw:list>
                    </td>
                    <td colspan=4 align=right >Search</td>
		            <td colspan=5 align=right ><gw:list  id="idSearch" value="1" styles="width:100%" onChange="">
                            <data>|1|Emp ID|2|Card ID|3|Name</data></gw:list></td>
                    <td align=right style="width:2%;border:0"></td>
		            <td colspan=6 align=right ><gw:textbox id="idtxtTmp" maxlen = "20" styles="width:100%" onenterkey="OnSearch(datCheck_meal_1)" /></td>
		            <td colspan=14 align=right style="color=#FF00CC"><gw:label id="idRecord" text="0 record(s)" styles="width:100%" ></gw:label></td>
              </tr>
            </table>
            <table cellspacing=0 cellpadding=0 style="height:83%" width=100% border=1>
                    <tr style="border:1;height:100%" valign="top">
                        <td  style="width:100%"> 
                            <gw:grid   
	                            id="idGrid1"  
	                            header="Organization|Work Group|Date|Emp ID|Name|Time|Employee Type"   
	                            format="0|0|4|0|0|0|0"  
	                            aligns="0|0|1|1|0|1|1"  
	                            defaults="||||||"  
	                            editcol="0|0|0|0|0|0"  
	                            widths="3000|2500|1500|1500|3000|1000|2000"  
	                            styles="width:100%; height:100%"   
	                            sorting="T"   
	                            /> 
                        </td>
                        
                    </tr>
               </table> 
        </td>
     </tr>
    </table>
    
    <table name="Summary" id="wt_ot" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
        <tr style="width:100%;height:100%" valign="top">
        <td>
            <table width="100%;height:12%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                    <td colspan=5 align=right style="width:10%;border:0" ><a title="Click here to show department" onclick="OnShowPopup(2)" href="#tips" >Organization</a></td>
		            <td colspan=10 align=right style="width:20%;border:0"><gw:list  id="lstOrg2" value="ALL"  maxlen = "100" styles='width:100%' onchange="" >
                        <data>
                            <%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select All
                        </data>
                        </gw:list>
                    </td>
                    <td colspan=5 align=right style="width:10%;border:0">WGroup</td>
		            <td colspan=7 align=left style="width:14%;border:0"><gw:list  id="lstWGroup2" value="ALL"  maxlen = "100" styles='width:100%' >
                                <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM thr_work_group WHERE DEL_IF = 0 order by workgroup_id")%>|ALL|Select All</data></gw:list>
                    </td>
                    <td colspan=3 style="width=6%" align = "right">From</td>
				    <td colspan=3 style="width=6%"><gw:datebox id="FromDT2" styles="width:80%" lang="<%=Session("Lang")%>"/></td>	
				    <td colspan=1 style="width=1%" align="center"><b>~</b></td>
				    <td colspan=3 style="width=6%"><gw:datebox id="ToDT2" styles="width:80%" lang="<%=Session("Lang")%>"/></td>
		            <td colspan=8 align=right style="width:16%"></td>
		            <td colspan=1 align=right style="width:2%;border:0"><gw:imgBtn id="ibtnSearch2" alt="Search" img="search" text="Search" onclick="OnSearch(datCheck_summary2)" /></td>
		            <td colspan=3 align=left style="width:6%"><gw:list  id="lstRpt" value="01"  maxlen = "100" styles='width:100%' >
                                <data>|01|Summary|02|Request Meal</data></gw:list></td>
                    <td colspan=1 align=right style="width:2%"><gw:imgBtn id="idPrint2" alt="Report" img="excel" text="Report" onclick="OnReport(2)" /></td>
              </tr>
             <tr>            
                    <td colspan=5 style="border:0;" align="right" >Emp Type</td>
                    <td colspan=5 style="border:0;" align="left" >
                     <gw:list  id="lstEmpType2" value='ALL'  styles='width:100%' >
                        <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code" )%>|ALL|Select All</data></gw:list>
                    </td>
                    <td colspan=5 style="border:0;" align="right" ></td>
                    <td colspan=5 style="border:0;" align="right" >Nation</td>
                    <td colspan=5 style="border:0;" align="left" >
                     <gw:list  id="lstNation2" value='01' maxlen = "100" styles='width:100%' >
                        <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' and code in('01','02') order by code" )%>|ALL|Select All</data></gw:list>
                    </td>                                   
		            <td colspan=25 align=right><b style="color=#FF00CC"><gw:label id="idRecord2" text="0 record(s)" styles="width:100%" ></gw:label></b></td>
              </tr>
            </table>
            <table cellspacing=0 cellpadding=0 style="height:88%" width=100% border=1>
                    <tr style="border:1;height:100%" valign="top">
                        <td  style="width:100%"> 
                            <gw:grid   
	                            id="idGrid2"  
	                            header="_pk|Organization|Work Group|From Date|To Date|Number|_Org_pk|Employee Type"   
	                            format="0|00||4|4|1|1"  
	                            aligns="0|0|0|1|1|0|0"  
	                            defaults="||||||"  
	                            editcol="0|0|0|0|0|0|0"  
	                            widths="0|3000|3000|2000|2000|1500|2000"  
	                            styles="width:100%; height:100%"   
	                            sorting="T" oncelldblclick = "show_detail()" /> 
                        </td>
                        
                    </tr>
               </table> 
        </td>
     </tr>
    </table>
  
    </gw:tab>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDept" styles="display:none"/>	
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtdept_temp" styles="display:none"/>  
    <gw:textbox id="txtReport_tmp" styles="display:none"/>  
</body>

   
</html>
