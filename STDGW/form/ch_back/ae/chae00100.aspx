<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var dis_pk="";
var G1_Emp_PK = 1;
G1_Date = 6;
G1_Level = 7;
G1_Create = 8;
G1_Reason = 9
G1_Period = 10;
G1_Start_Dt = 11;
G1_End_Dt = 12;
G1_Treat = 13;
G1_Times = 14;
G1_Remark = 15;
G1_PK = 16;
    

function BodyInit()
{
    txtOrg_tmp_pk.text="<%=Session("COMPANY_PK")%>";
    grdDiscipline.GetGridControl().ScrollTrack=true;
    grdDiscipline.GetGridControl().FrozenCols =5;
    if (v_language!="ENG")
        System.Translate(document);
    <%=ESysLib.SetGridColumnComboFormat( "grdDiscipline" , 7 ,  "select code,CODE_NM from vhr_hr_code where id='HR0025' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdDiscipline" , 13 ,  "select code,CODE_NM from vhr_hr_code where id='HR0149' order by code_nm") %>;
    
    <%=ESysLib.SetGridColumnComboFormat( "grdDiscipline_old" , 4 ,  "select code,CODE_NM from vhr_hr_code where id='HR0025' order by code_nm") %>; 
    <%=ESysLib.SetGridColumnComboFormat( "grdDiscipline_old" , 10 ,  "select code,CODE_NM from vhr_hr_code where id='HR0149' order by code_nm") %>;
    
   ibtnUnDelete.SetEnable(false);
   ibtnDelete.SetEnable(false);
   ibtnSave.SetEnable(false);
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";
   user="<%=session("USER_ID")%>";
   menu_id.text=System.Menu.GetMenuID();

   ChangeColorItem(lstOrg_Code.GetControl());

   datCheck_View.Call();
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

//-------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        txtUpperDept.text=obj;
        lstOrg_Code.value=obj;
        
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
   if(obj.id == "datCheck_View")
   {
        if(txtFlag_View.text == 'Y')
        {
            ibtnSave.style.display = "none";
            ibtnDelete.style.display = "none";
            ibtnUnDelete.style.display = "none";
        }
        if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	    {
            datUser_info.Call();     	    
	    }
    
   }
   else if (obj.id=="datDiscipline")
   {
       lblRecord.text=grdDiscipline.rows-1 + " record(s)";
       if (grdDiscipline.rows>1)
       {
           ibtnUnDelete.SetEnable(false);
           ibtnDelete.SetEnable(true);
           ibtnSave.SetEnable(true);
       }
       else
       {
           ibtnUnDelete.SetEnable(false);
           ibtnDelete.SetEnable(false);
           ibtnSave.SetEnable(false);
       }   
   }
   
   else if (obj.id=="datFind_Report")
   {
        var url =System.RootURL + '/reports/ch/ae/' + txtReport_tmp.text + '?p_user=' + user + '&dis_pk=' + dis_pk;
        window.open(url);
   }
}

//------------------------------------------------
//----------------------------------------------------
function OnSearch()
{
    datDiscipline.Call("SELECT");
}
//-------------------------------------------------------------
function OnReport(obj)
{
        if(obj==1)
        {   
            dis_pk="";
            for (var i=1;i<=grdDiscipline.rows-1;i++)
            {
                if (grdDiscipline.GetGridData(i,0)!="0")      
                    if (grdDiscipline.GetGridData(i,14)!="")
                        dis_pk = dis_pk + grdDiscipline.GetGridData(i,G1_PK) + ",";  
            }
            if (dis_pk!="")
            {   
                txtReport_tmp.text="rpt_disciplinary.aspx";
				txtOrg_tmp_pk.text=lstOrg_Code.value; 
                datFind_Report.Call();
            }
            else
            {
                alert("Please select employees to report! \n Vui lòng chọn nhân viên để in!");
            }
        }
        else if(obj==2)   
        {   
            if (dtFrom_DisDate.value !="" && dtTo_DisDate.value!="")
            {
                var url =System.RootURL + '/reports/ch/ae/rpt_employee_discipline.aspx?p_user=' ;
                url+= user + '&p_from_join_dt=' + dtFrom_JoinDate.value + '&p_to_join_dt=' ;
                url+= dtTo_JoinDate.value + '&p_thr_group_pk=' + lstWorkGroup.value + '&p_search_by=' ;
                url+= lstTemp.value + '&p_search_temp=' + txtTemp.text +  '&p_status=' + lstStatus.value ;
                url+= '&p_tco_dept_pk=' + lstOrg_Code.value + '&p_level=' + lstLevel.value ;
                url+= '&p_from_disdate=' +  dtFrom_DisDate.value +'&p_to_disdate=' + dtTo_DisDate.value ;
                url+= '&p_from_disdate_text=' +  dtFrom_DisDate.text +'&p_to_disdate_text=' + dtTo_DisDate.text;
				url+= '&p_Nation=' +  lstNation.value +'&p_contract=' + lstContract_type.value;
                window.open(url); 
            }
            else
                alert("Please input period of disciplined date!");
        }
        else if(obj==3)
        {
             if (dtFrom_DisDate.value !="" && dtTo_DisDate.value!="")
            {
                var url =System.RootURL + '/reports/ch/ae/rpt_employee_discipline_detail.aspx?p_user=' ;
                url+= user + '&p_from_join_dt=' + dtFrom_JoinDate.value + '&p_to_join_dt=' ;
                url+= dtTo_JoinDate.value + '&p_thr_group_pk=' + lstWorkGroup.value + '&p_search_by=' ;
                url+= lstTemp.value + '&p_search_temp=' + txtTemp.text +  '&p_status=' + lstStatus.value ;
                url+= '&p_tco_dept_pk=' + lstOrg_Code.value + '&p_level=' + lstLevel.value ;
                url+= '&p_from_disdate=' +  dtFrom_DisDate.value +'&p_to_disdate=' + dtTo_DisDate.value ;
                url+= '&p_from_disdate_text=' +  dtFrom_DisDate.text +'&p_to_disdate_text=' + dtTo_DisDate.text;
				url+= '&p_Nation=' +  lstNation.value +'&p_contract=' + lstContract_type.value;
                window.open(url); 
            }
            else
                alert("Please input period of disciplined date!");
        }
    
}
//-----------------------------------------------
function OnSave()
{
    if (CheckUpdate() && confirm("Do you want to save?"))
       datDiscipline.Call();
}
//-------------------------------------------------
function CheckUpdate()
{
    for (var i=1;i<=grdDiscipline.rows-1;i++)
    {
        if (grdDiscipline.GetRowStatus(i)==16 && grdDiscipline.GetGridData(i,G1_Date)=="" && grdDiscipline.GetGridData(i,G1_Level)=="")
            grdDiscipline.SetRowStatus(i,0);
        if (grdDiscipline.GetRowStatus(i)==16)
        {
            if (grdDiscipline.GetGridData(i,G1_Date)=="" )
            {
                alert("You have to input disciplined date at row " + i );
                return false;
            }
            if (grdDiscipline.GetGridData(i,G1_Level)=="")
            {
                alert("You have to input disciplined level at row " + i );
                return false;
            }
            if (grdDiscipline.GetGridData(i,G1_PK)=="" && grdDiscipline.GetGridData(i,G1_Create)=="0")
                grdDiscipline.SetGridText(i,G1_Create,"-1");
        }
    }
    return true;
}
//------------------------------------------
function OnDelete()
{
    if(confirm("Do you want to delete?"))
    {
       grdDiscipline.DeleteRow();
       ibtnDelete.SetEnable(false);
       ibtnUnDelete.SetEnable(true);
    }
}
//-----------------------------------------
function OnUnDelete()
{
    if (confirm("Do you want to undelete?"))
    {
        grdDiscipline.UnDeleteRow();
        ibtnDelete.SetEnable(true);
        ibtnUnDelete.SetEnable(false);
    }
}
//------------------------------------------
function CheckButton()
{
    var ctrl 	= grdDiscipline.GetGridControl();
    var rownum 	= ctrl.Row;
    var rownums 	= ctrl.Rows;
    
    if(rownum > 0 && rownums>1)
    {
        if(grdDiscipline.GetRowStatus(rownum) >= 64)
        {
            ibtnDelete.SetEnable(false);
            ibtnUnDelete.SetEnable(true);
        }
        else
        {
            ibtnDelete.SetEnable(true);
            ibtnUnDelete.SetEnable(false);
        }
    }
    
    if(ctrl.col == G1_Create)
    {
        if(grdDiscipline.GetGridData(ctrl.row,G1_Create)=="-1")
        {
            grdDiscipline.SetGridText(ctrl.row,G1_Date,"");
            grdDiscipline.SetGridText(ctrl.row,G1_Period,"");
            grdDiscipline.SetGridText(ctrl.row,G1_Start_Dt,"");
            grdDiscipline.SetGridText(ctrl.row,G1_End_Dt,"");
            grdDiscipline.SetGridText(ctrl.row, G1_Reason, "");
            grdDiscipline.SetGridText(ctrl.row, G1_Level, "");
            grdDiscipline.SetGridText(ctrl.row, G1_Treat, "");
            grdDiscipline.SetGridText(ctrl.row, G1_Remark, "");
        }
    }
}
//---------------------------------------------

function OnSetGrid(obj_checkbox,obj_grd,obj_col)
{	
    var tmp;
    if( obj_checkbox.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
    var ctrl = obj_grd.GetGridControl();
    
    if (ctrl.SelectedRows>0)
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

function OnToggle()
{
        if(imgMaster.status == "expand")
        {
            imgMaster.status = "collapse";
			tblDetail.style.display="none";
			tblDetail.style.height="0%";
			tblMaster.style.height="100%";
            imgMaster.src = "../../../system/images/iconmaximize.gif";
			imgMaster.alt="Show old Discipline";
			
        }
        else
        {
            imgMaster.status = "expand";
            tblDetail.style.display="";
            tblDetail.style.height="30%";
            tblMaster.style.height="70%";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Close old Discipline";
			OnShowOld();
			
        }
  
}
//------------------------------------------
function OnShowOld()
{
    if (imgMaster.status=="expand")
    {
        var irow=grdDiscipline.row;
        if (irow>=1)
        {
            txtEmp_PK.text=grdDiscipline.GetGridData(irow,G1_Emp_PK);
            txtTimes.text = grdDiscipline.GetGridData(irow,G1_Times);
            datDiscipline_old.Call("SELECT");
        }
        else
        {
            datDiscipline_old.ClearData();
        }
    }
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
<!------------------------------------->
<!------------------------------------------>
<gw:data id="datDiscipline" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="1,6,7,8,9,10,11,12,13,14,15,16" function="HR_SEL_10010010_DISCIPLINE" procedure="HR_UPD_10010010_DISCIPLINE"> 
                <input bind="grdDiscipline" >
                    <input bind="lstOrg_Code" /> 
                    <input bind="lstWorkGroup" />
                    <input bind="lstStatus" />
                    <input bind="dtFrom_JoinDate" />
                    <input bind="dtTo_JoinDate" />
                    <input bind="lstTemp" />
                    <input bind="txtTemp" />
                    <input bind="lstLevel" />
                    <input bind="dtFrom_DisDate" />
                    <input bind="dtTo_DisDate" />
					<input bind="lstNation" />
					<input bind="lstContract_type" />
                </input>
                <output  bind="grdDiscipline" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datDiscipline_old" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_10010010_DISCIPLINE_HIS" > 
                <input bind="grdDiscipline" >
                    <input bind="txtEmp_PK" /> 
                    <input bind="txtTimes" />
                </input>
                <output  bind="grdDiscipline_old" />
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
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td colspan="5"  style="border:0;" align="right" >Contract Type</td>
                        <td colspan="10"  style="border:0;" align="left" ><gw:list  id="lstContract_type" value='ALL' maxlen = "100" styles='width:100%' >
							<data><%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0001' order by code")%>|ALL|Select All</data>
							</gw:list></td>
                         <td colspan="5"  style="border:0;" align="right" >Work Group</td>
                        <td colspan="9"  style="border:0;" align="left" >
                         <gw:list  id="lstWorkGroup" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT PK, WORKGROUP_NM FROM THR_WORK_GROUP WHERE DEL_IF = 0")%>|ALL|Select All</data></gw:list>
                        </td>
						<td colspan="1" style="border:0;" align="right" ></td>
                        <td colspan="1" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td colspan="1" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave()"/>
                        </td>
                        <td colspan="1" style="border:0" align="right">
                         <gw:imgBtn img="delete" id="ibtnDelete"    alt="Delete"  onclick="OnDelete()"/>
                        </td>
                        <td colspan="1" style="border:0" align="right">
                         <gw:imgBtn img="udelete" id="ibtnUnDelete"    alt="UnDelete"  onclick="OnUnDelete()"/>
                        </td>
                        <td colspan="1" style="border:0;" align="right" >
                    </tr>					
                    <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td colspan="5" style="border:0;" align="right" >Nation</td>
                        <td colspan="10"  style="border:0;" align="left" ><gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
							<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list></td>
                        <td colspan="5" style="border:0;" align="right" >Status</td>
                        <td colspan="10" style="border:0;" align="left" >
                         <gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:100%' >
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
                        <gw:checkbox id="chkCheckReport" value="F" onclick="OnSetGrid(chkCheckReport,grdDiscipline,0)" ></gw:checkbox >
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
                        
                         <td colspan="5" scolspan="5" tyle="border:0;" align="right" >Level</td>
                        <td  colspan="5" style="border:0;" align="left" >
                         <gw:list  id="lstLevel" value='ALL' maxlen = "100" styles='width:100%'>
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0025' order by code_nm")%>|ALL|Select All
                            </data>
                        </gw:list></td>
						<td colspan="5"></td>
                        <td  colspan="5" style="border:0;" align="right">Discipline Date</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtFrom_DisDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  colspan="1" style="border:0;" align="center">~</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtTo_DisDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=2 style="border:0" align="right"></td>
                        <td colspan="1" style="border:0" align="right">                           
                           <gw:imgBtn img="excel" id="ibtnReport1"    alt="Report Discipline form"  onclick="OnReport(1)"/>
                        </td>
                        <td colspan="1" style="border:0" align="right">
                            <gw:imgBtn img="excel" id="ibtnReport2"    alt="Report Discipline Summary"  onclick="OnReport(2)"/>
                        </td>
                        <td>
                            <gw:imgBtn img="excel" id="ibtnReport2"    alt="Report Discipline Detail"  onclick="OnReport(3)"/>
                        </td>
                        <td align="right" style="border:0" valign="bottom"><img status="collapse" id="imgMaster" alt="Show old Discipline" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle()"  /></td>
                        
                    </tr>
                    
                  
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=50 style="width:100%;height:100%;"> 
                            <table width="100%" id="tblMaster" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%;height:100%" valign="top">
                                    <td>
                                     <gw:grid   
                                        id="grdDiscipline"  
                                        header="Select|_EMP_PK|_Department|Organization|Emp ID|Full Name|Date|Level|Create New Dis|Reason|Period|Start Date|End Date|Treat Disc|Times|Remark|_PK"   
                                        format="3|0|0|0|0|0|4|2|3|2|0|4|4|2|0|0|0"  
                                        aligns="0|0|2|2|1|0|0|1|1|2|1|0|0|0|0|1|0"  
                                        defaults="||||||||||||||||"  
                                        editcol="1|0|0|0|0|0|1|1|1|1|1|1|1|1|0|1|0"  
                                        widths="700|0|1500|1600|1000|2500|1500|1400|1500|1500|1500|1500|1500|1500|1000|1500|0"  
                                        styles="width:100%; height:100%" 
								        acceptNullDate="T"
                                        sorting="T"    oncellclick="CheckButton();OnShowOld()" 
                                        /> 
                                     </td>
                                 </tr>
                             </table>
                             <table width="100%" id="tblDetail" style="height:30%;display:none" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%" valign="top">
                                    <td > 
                                         <gw:grid   
                                            id="grdDiscipline_old"  
                                            header="Organization|Emp ID|Full Name|Date|Level|_Create New Dis|Reason|Period|Start Date|End Date|Treat Disc|Times|Remark"   
                                            format="0|0|0|4|2|3|2|0|4|4|2|0|0"  
                                            aligns="2|1|0|0|1|1|2|1|0|0|0|0|1"  
                                            defaults="||||||||||||"  
                                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                            widths="1600|1000|2500|1500|1400|1500|1500|1500|1500|1500|1500|1000|1500"  
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
<gw:textbox id="txtOrg_tmp_pk" text="" styles="display:none"  />
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  /> 
</html>
