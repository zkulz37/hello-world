
<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var flag;
var strcodereturn;
var binit=true;
var tab2=false;
var flag2=false;
var startTime,interval_time;
var ic_manager_pk=1;

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    txtFrom.text="<%=ESysLib.SetDataSQL("select char_1 from vhr_hr_code where id='HR0165' and char_3='chba00190'")%>";
    txtaSubject.SetDataText("<%=ESysLib.SetDataSQL("select char_2 from vhr_hr_code where id='HR0165' and char_3='chba00190'")%>");
    txtFrom.SetEnable(false);
    txtaSubject.SetEnable(false);
    grdSum.GetGridControl().FrozenCols =4;
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	else
	    datCheck_Non_Lately.Call();
}
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}
function clock(start,x) 
{
 var d = new Date()
 idInterval.text= Math.round((d.valueOf()-start)/x);

}

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
//----------------------------------
function InitButton(flag)
{
    ibtnSave.SetEnable(flag);
   
}
//----------------------------------
function OnShowPopup()
{
     var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
                lstOrg.value=obj;
        }    
}

//----------------------------------------------
function OnDataReceive(obj)
{
   if (obj.id=="datDeptData")
   {
        if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
          lstOrg.SetDataText(txtDeptData.text);
          txtDept.text=lstOrg.value;
          
   }
    else if (obj.id=="datUser_info")
   {
        datCheck_Non_Lately.Call();       
        
   }
    else if (obj.id=="datCheck_Non_Lately")
   {
        if (txtFlag.text=="1")
        {
            lbldata.text="Existed";
            ibtnSend.SetEnable(true);
            ibtnSearch.SetEnable(true);
            datGet_List_Manager.Call();
        }
        else
        {
            lbldata.text="No Data";
            ibtnSend.SetEnable(false);
            ibtnSearch.SetEnable(false);
            lstManager.SetDataText("");
        }
        
        
   }
    else if (obj.id=="datPro_Non_Lately")
   {
        clear_Interval(idInterval);
        if (txtResult.text=="0")
        {
            alert("Processing is fail");
            idInterval.text="Error!";
        }
        else if (txtResult.text=="-1")
		{
			alert("Working Attendance is not processed full!");
            idInterval.text="Error!";
		}else

        {
            alert("Processing is completed");
            lbldata.text="Existed";
            idInterval.text="Completed!";
            datCheck_Non_Lately.Call();
        }
        
   }
   else if (obj.id=="datSel_Non_Lately_Sum")
   {
        lblRecord_S.text=grdSum.rows-1 + " record(s)";
        
   }
   else if (obj.id=="datSel_Non_Lately_Detail")
   {
        lblRecord_D.text=grdDetail.rows-1 + " record(s)";
        
   }else if (obj.id=="datGet_List_Manager")
   {
        lstManager.value="ALL";
        
   }
   else if (obj.id=="datFind_Report")
   {
        var url=System.RootURL;
        if(imgMaster.status == "expand")
            url=url + '/reports/ch/ba/'+txtReport_tmp.text+'?p_manager_pk=' + lstManager.value + '&p_date=' + dtDate.value  + '&p_send_flag=' + lstSend_Flag.value;
        else
            url=url + '/reports/ch/ba/'+txtReport_tmp.text+'?p_manager_pk=' + lstManager.value + '&p_date=' + dtDate.value  + '&p_send_flag=' + lstSend_Flag.value + '&p_search_by=' + lstTemp.value +  '&p_search_temp=' + txtTemp.text + '&p_thr_wg_pk=' + lstWGroup.value + '&P_TCO_ORG_PK=' + lstOrg.value;
        window.open(url); 
   }
}
function OnProcess()
{
    var s_confirm;
    if (txtFlag.text=="1")
        s_confirm="Data is existed.Do you want to process again?"
          
    else
        s_confirm="Do you want to process?"
    if (confirm(s_confirm))
    {
        set_Interval(1000)
        datPro_Non_Lately.Call();
    }
}
//--------------
function OnChangeDate()
{
    grdSum.ClearData();
    grdDetail.ClearData();
    datCheck_Non_Lately.Call();
}
//----------------------------------------------

function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            imgMaster.status = "collapse";
			tblsum.style.display="none";
            tblsum.style.width="0%";
            tbldetail.style.width="100%";
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Open Summary";
			txtManager_PK.text="ALL";
			grdSum.ClearData();	
			ibtnSend.SetEnable(false);
        }
        else
        {
            imgMaster.status = "expand";
            tblsum.style.display="";
            tblsum.style.width="40%";
            tbldetail.style.width="60%";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Close Summary";
			txtManager_PK.text="";
		    grdDetail.ClearData();	
			ibtnSend.SetEnable(true);
        }
  
}
//--------------------------------
function OnSearch()
{
    if(imgMaster.status == "expand")
        datSel_Non_Lately_Sum.Call("SELECT");
    else
        datSel_Non_Lately_Detail.Call("SELECT");
}
//------------------------
function OnClickGrid()
{
    if (grdSum.row>0)
    {
        txtManager_PK.text=grdSum.GetGridData(grdSum.row,ic_manager_pk);
        datSel_Non_Lately_Detail.Call("SELECT");
    }
}
//------------------------------------------------------------------------------------
function OnSetGrid(obj_checkbox,obj_grd,obj_col)
{	
    var tmp;
    if( obj_checkbox.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
    var ctrl = obj_grd.GetGridControl();
    
    if (ctrl.SelectedRows>1)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    obj_grd.SetGridText(row,obj_col,tmp);
			    }
		    }
	}
	else
	{
	    for ( var i =  1 ; i < ctrl.rows ; i++ )
				    obj_grd.SetGridText(i,obj_col,tmp);
	}
}
//------------------------
function OnSendMail()
{
    
    var bsend=0;
    for (var i=1;i<grdSum.rows;i++)
    {
        if (grdSum.GetGridData(i,0)=="-1")
        {
            grdSum.SetRowStatus(i,16);
            bsend=1;
        }
        else
            grdSum.SetRowStatus(i,0);
            
    }
    if (bsend)
        datSel_Non_Lately_Sum.Call();
}

//----------------------
//-----------------------------------------------
function OnReport()
{
    var url=System.RootURL;
    if(imgMaster.status == "expand")
        txtReport_tmp.text="rpt_mail_manager_list.aspx";
    else
        txtReport_tmp.text="rpt_mail_employee_list.aspx";
    datFind_Report.Call();
}
function OnShowWg()
{
    var strcom;
        var fpath = System.RootURL + "/form/ch/ba/chba00190_01.aspx?dt="+dtDate.value;
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:50;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    
}
</script>
<body >
<!-------------------data control----------------------->
<!------------------------------------------>
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
<!------------------------------------------>
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
<!------------------------------------------>
<gw:data id="datPro_Non_Lately" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_NON_LATELY" > 
                <input>
                    <input bind="dtDate" /> 
                </input> 
                <output>
                     <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datCheck_Non_Lately" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_check_non_lately" > 
                <input>
                    <input bind="dtDate" /> 
                </input> 
                <output>
                     <output bind="txtFlag" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datGet_List_Manager" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_get_list_manager" > 
                <input>
                    <input bind="dtDate" /> 
                </input> 
                <output>
                     <output bind="lstManager" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!---------------------------------------------->
<gw:data id="datSel_Non_Lately_Sum" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"  parameter="1,11" function="hr.sp_sel_non_lately_sum" procedure="hr.sp_send_mail_lately"> 
                <input bind="grdSum" >
                    <input bind="lstManager" />
                    <input bind="dtDate" /> 
                    <input bind="lstSend_Flag" /> 
                </input>
                <output  bind="grdSum" />
            </dso> 
        </xml> 
</gw:data>
<!---------------------------------------------->
<gw:data id="datSel_Non_Lately_Detail" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid"   function="hr.sp_sel_non_lately_detail" > 
                <input bind="grdDetail" >
                    <input bind="txtManager_PK" />
                    <input bind="dtDate" /> 
                    <input bind="lstSend_Flag" /> 
                    <input bind="lstOrg" /> 
                    <input bind="lstWGroup" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" /> 
                </input>
                <output  bind="grdDetail" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->
    <table name="Month Sal" id="MonthSal" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="Table2" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                     <tr id="tr_month" style="border:0;width:100%;height:7%" valign="center" >
                        <td colspan="20">
                            <table style="width:100%;height:100%">
                                <tr style="width:100%;height:50%"  >
                                <td width="15%" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowWg()" href="#tips" >WorkGroup Process Status</a></td>
                                    <td width="20%" style="border:0;" align="right" >Date</td>
                                    <td width="10%" style="border:0;" align="center"  ><gw:datebox id="dtDate"  onchange="OnChangeDate()" tyles="width:100%" type="date" lang="<%=Session("Lang")%>" /></td>
                                    <td width="10%"  style="border:0;" align="right" >Data</td>
                                    <td width="10%" style="border:0;" align="center" ><gw:label id="lbldata"  text="status 1" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                                    <td width="10%" style="border:0;" align="center" ><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
                                    <td width="35%" style="border:0" align="left"><gw:imgBtn img="process" id="ibtnProcess" alt="Process" onclick="OnProcess()"/></td>
                                </tr>
                             </table>
                        </td>
                  </tr>
                  <tr id="tr1" style="border:1;width:100%;height:93%" valign="center" >
                        <td colspan="20">
                            <table style="width:100%;height:100%;border:1" cellpadding="0" cellspacing="0">
                                <tr style="width:100%;height:7%"  >
                                    <td width="3%"><img status="expand" id="imgMaster" alt="Close Summary" src="../../../system/images/close_popup.gif" style="cursor:hand" onclick="OnToggle()"  /> </td>
					                <td  align="center" width="3%"><gw:checkbox id="chkCheckReport" value="F" onclick="OnSetGrid(chkCheckReport,grdSum,0)" ></gw:checkbox ></td>
                                    <td width="6%" style="border:0;" align="right" >From Mail</td>
                                    <td  style="border:0"  width="14%"  align="right" valign="middle"><gw:textbox id="txtFrom" styles='width:100%'/></td>
                                   
                                    <td width="6%" style="border:0;" align="right" >Manager</td>
                                    <td  style="border:0"  width="29%"  align="right" valign="middle"> <gw:list  id="lstManager" value='ALL' maxlen = "100" styles='width:100%' >
                                       </gw:list></td>
                                      <td width="6%" style="border:0;" align="right" ></td>
                                    <td  style="border:0"  width="12%"  align="right" valign="middle"></td>  
                                    <td width="8%" style="border:0;" align="right" >Sending Flag</td>
                                    <td  style="border:0"  width="10%"  align="right" valign="middle"> <gw:list  id="lstSend_Flag" value='ALL' maxlen = "100" styles='width:100%' >
                                       <data>|1|Send OK|0|Not Send|-1|Send Fail|ALL|Select All</data></gw:list></td>
                                    <td width="3%" style="border:0;" align="center"  >
                                     <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                                    </td>
                                    <td width="3%" style="border:0;" align="left"  >
                                     <gw:imgBtn img="mail" id="ibtnSend"   alt="Send Mail"  onclick="OnSendMail()"/>
                                    </td>
                                    <td width="3%" style="border:0;" align="left"  >
                                     <gw:imgBtn img="excel" id="ibtnReport"   alt="Report"  onclick="OnReport()"/>
                                    </td>
                                </tr>
                                <tr style="width:100%;height:5%"  >
                                    <td colspan=3 style="border:0;" align="right" >Subject</td>
                                    <td colspan=3 style="border:0"  align="right" valign="middle"><gw:textbox id="txtaSubject" styles='width:100%'/></td>
                                    <td colspan=14 align=right style="border:0"><gw:label id="lblRecord_S"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                                </tr>
                                <tr style="width:100%;height:93%"  >
                                    <td colspan=13 style="width:100%;height:100%;border:1"  >
                                        <table style="width:100%;height:100%"  border=1 cellpadding="0" cellspacing="0" >
                                            <tr style="width:100%;height:100%"  >
                                                <td style="width:50%;height:100%" id="tblsum">
                                                    <gw:grid   
                                                        id="grdSum"  
                                                        header="Select|_Manager_PK|Manager ID|Manager Name|Plant|Department|Section|Manager Mail|Emp|Send Flag|Time|_Work Date"
                                                        format="3|0|0|0|0|0|0|0|0|0|0|0"  
                                                        aligns="0|0|0|0|0|0|0|0|0|0|0|0"  
                                                        defaults="|||||||||||"  
                                                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                                        widths="600|0|1100|2200|2200|2200|2200|2500|1100|1700|1200|0"  
                                                        styles="width:100%; height:100%" 
                                                        sorting="T" acceptNullDate   
                                                        oncellclick="OnClickGrid()"
                                                        /> 
                                                </td>
                                                 <td style="width:50%;height:100%"  id="tbldetail" >
                                                    <table style="width:100%;height:100%" cellpadding="0" cellspacing="0" border=1>
                                                        <tr style="width:100%;height:7%">
                                                           <td width="10%" style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(3)" href="#tips" >Organization</a>                  
                                                            </td>
                                                            <td width="16%" style="border:0;" align="left" >
                                                             <gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%' onchange="" >
                                                                <data>
                                                                    <%=ESysLib.SetListDataSQL("select pk,org_nm from comm.tco_org a where del_if=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All
                                                                </data>
                                                            </gw:list>
                                                            </td>
                                                            <td width="6%" style="border:0;" align="right"  >W-Group</td>
                                                            <td width="16%" style="border:0;" align="left">
                                                             <gw:list  id="lstWGroup" value='ALL' maxlen = "100" styles='width:100%' >
                                                                <data><%=Esyslib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                                                            </td>
                                                           
                                                            <td width="8%" align=center style="border:0" > 
					                                           <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							                                            <data>LIST|1|Name|2|Emp ID</data> 
					                                            </gw:list>
				                                            </td>
				                                              <td width="7%" style="border:0" align="right">
                                                                <gw:textbox id="txtTemp" onenterkey   ="OnSearch(2)" styles='width:100%'/>
                                                            </td>
                                                         </tr>   
                                                          <tr style="width:100%;height:5%">
                                                            <td colspan=6 align=right style="border:0"><gw:label id="lblRecord_D"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
                                                           
                                                         </tr>   
                                                         
                                                         <tr style="border:1;width:100%;height:93%" valign="top">
                                                            <td colspan=6  style="width:100%;height:100%" border=1> 
                                                                 <gw:grid id='grdDetail'
                                                                    header='ORG_NM|WORKGROUP_NM|EMP_ID|FULL_NAME|NOTE|LATELY|REMARK|MANAGER_ID|MANAGER_NAME|MANAGER_MAIL'
                                                                    format='0|0|0|0|0|0|0|0|0|0'
                                                                    aligns='0|0|0|0|0|0|0|0|0|0'
                                                                    check='|||||||||'
                                                                    editcol='0|0|0|0|0|0|0|0|0|0'
                                                                    widths='1000|1000|1000|1000|1000|1000|1000|1000|1000|1000'
                                                                    sorting='T'
                                                                    autosize='T' 
                                                                    styles='width:100%; height:100%'
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
        </tr>
    </table>
</body>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtFlag" styles="display:none">
</gw:textbox>
<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtManager_PK" styles="display:none">
</gw:textbox>
<gw:textbox id="txtReport_tmp" styles="display:none"/>

</html>
