<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>MBO Plan checking</title>
    <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
</head>

<script>
var data;
var v_language = "<%=Session("SESSION_LANG")%>";
var no_master=0;
var rpt_no;
var org_cal;
//var c_sel=0;
<!---------------------------------->
var g_organization  = 0,
	g_eva_group = 1,
	g_eva_type = 2,
	g_emp_id = 3,
	g_full_name = 4,
	g_Eva_Status=5,
	g_self_satus = 6,
	g_manager_l1 =7,
	g_l1_status = 8,
	g_l1_score =9,
	g_manager_l2 =10,
	g_l2_status =11,
	g_l2_score =12,
	g_manager_l3 =13,
	g_l3_status =14,
	g_l3_score  =15,
	g_final_score =16,
	g_eva_emp_pk = 17;
<!------------------------------------->
var g2_eva_emp_pk 	=	0,
g2_organization = 	1,
g2_work_group 	=	2,
g2_eva_period	 =	3,
g2_eva_group 	=	4,
g2_emp_id		=	5,
g2_full_name	=	6,
g2_eva_status	=	7,
g2_eva_factor	=	8,
g2_eva_weight	=9,
g2_standard_score	=	10,
g2_manager_l1	=	11,
g2_l1_status	=	12,
g2_l1_score 	=	13,
g2_l1_opinion 	=	14,
g2_manager_l2	=	15,
g2_l2_status	=	16,
g2_l2_score	=	17,
g2_l2_opinion	=	18,
g2_manager_l3	=	19,
g2_l3_status	=	20,
g2_l3_score	=	21, 
g2_l3_opinion =  22,
g2_final =23
;

	
	
var check_init=0;


function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
		idGridDetail.GetGridControl().FrozenCols = g2_standard_score+1;
        idGridDetail.GetGridControl().ScrollTrack = true;
		onBindData();
		onMergGridDetail()
		datchemchecklevel.Call();

}

function onBindData() 
{
   
    data = "<%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where del_if=0 order by 2 desc")%>";    
    lstEvaMaster.SetDataText(data);
    lstEvaMasterDetail.SetDataText(data);
	txtEvaMastertmp.text = lstEvaMasterDetail.value;
	
	
	data = "<%=ESysLib.SetListDataSQL("select code,code||'-'||CODE_NM from vhr_hr_code where id='HR0103' order by seq")%>";    
	lstEvaStatus.SetDataText(data+"|ALL|Select All");
	lstEvaStatus.value="ALL";
	
	data = "<%=ESysLib.SetListDataSQL("select code,code||'-'||CODE_NM from vhr_hr_code where id='HR0103' order by seq")%>";    
	lstEvaStatusDetail.SetDataText(data+"|ALL|Select All");
	lstEvaStatusDetail.value="ALL";
}

function OnShowPopup(m)
{     
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {  
			org_cal = m;
			if(m==1)
			{
			    lstOrg_Code.value = obj;
            
			}else
            {
			    lstOrg_CodeDetail.value = obj;
           
			}
           
			
        }
}

function OnSearch(obj)
{
	if(obj==1)
	{
	datchem00340_v2.Call("SELECT");
   }else{
	datchem00340_detail_v2.Call("SELECT");
   }
}

function onMergGridDetail()
{
	var ctrl = idGridDetail.GetGridControl();
			ctrl.MergeCells = 1;
			ctrl.MergeCol(g2_eva_emp_pk) = true;
			ctrl.MergeCol(g2_organization) = true;
			ctrl.MergeCol(g2_work_group) = true;
			ctrl.MergeCol(g2_eva_period) = true;
			ctrl.MergeCol(g2_eva_group) = true;
			ctrl.MergeCol(g2_emp_id) = true;
			ctrl.MergeCol(g2_full_name) = true;
			ctrl.MergeCol(g2_eva_status) = true;
			ctrl.MergeCol(g2_manager_l1) = true;
			ctrl.MergeCol(g2_l1_status) = true;
			ctrl.MergeCol(g2_l1_opinion) = true;
			
			ctrl.MergeCol(g2_manager_l2) = true;
			ctrl.MergeCol(g2_l2_status) = true;
			ctrl.MergeCol(g2_l2_opinion) = true;
			
			ctrl.MergeCol(g2_manager_l3) = true;
			ctrl.MergeCol(g2_l3_status) = true;
			ctrl.MergeCol(g2_l3_opinion) = true;
}
function OnDataReceive(obj)
{
		
    if(obj.id=="datchemchecklevel")
    {
		if(no_master==1)
		{
            var ctrl=idGrid.GetGridControl();
            var numLevel=Number(txtNumOfLevel.text);
            for(i=g_manager_l1;i<=g_l3_score;i++)
                        ctrl.ColHidden(i)=0;
            for(i=g_manager_l1+numLevel*3;i<=g_l3_score;i++)
                        ctrl.ColHidden(i)=1;
		    idGrid.ClearData();
        }
        else if(no_master==2)
        {
	  
	        var ctrl1=idGridDetail.GetGridControl();
            var numLevel2=Number(txtNumOfLevel.text);
            for(i=g2_manager_l1;i<=g2_l3_opinion;i++)
                        ctrl1.ColHidden(i)=0;
            for(i=g2_manager_l1+numLevel2*4;i<=g2_l3_opinion;i++)
                        ctrl1.ColHidden(i)=1;
		    idGridDetail.ClearData();
	  
	    }
        else if(no_master==0)
        {
		
	        var ctrl=idGrid.GetGridControl();
            var numLevel=Number(txtNumOfLevel.text);
            for(i=g_manager_l1;i<=g_l3_score;i++)
                        ctrl.ColHidden(i)=0;
            for(i=g_manager_l1+numLevel*3;i<=g_l3_score;i++)
                        ctrl.ColHidden(i)=1;
					
		    var ctrl1=idGridDetail.GetGridControl();
            var numLevel2=Number(txtNumOfLevel.text);
            for(i=g2_manager_l1;i<=g2_l3_opinion;i++)
                        ctrl1.ColHidden(i)=0;
            for(i=g2_manager_l1+numLevel2*4;i<=g2_l3_opinion;i++)
                        ctrl1.ColHidden(i)=1;
	     }
	  
        datchem00310_evagrp.Call();
    }
	 if(obj.id=="datchem00310_evagrp")
    {
		if(no_master==0)
		{
			lstEvaGroup.SetDataText(txtEvaGrp.text+"|ALL|Select All");
			lstEvaGroup.value="ALL";
			lstEvaGroupDetail.SetDataText(txtEvaGrp.text+"|ALL|Select All");
			lstEvaGroupDetail.value="ALL";
		}else if(no_master==1){
			lstEvaGroup.SetDataText(txtEvaGrp.text+"|ALL|Select All");
			lstEvaGroup.value="ALL";
		}
		else if(no_master==2){
			lstEvaGroupDetail.SetDataText(txtEvaGrp.text+"|ALL|Select All");
			lstEvaGroupDetail.value="ALL";
		}
		
    }
    if(obj.id=="datchem00340_v2")
    {
       // lblRecord.text=idGrid.rows-1 +"(s)";
        auto_resize_column(idGrid,0,g_eva_emp_pk,8);
    } 
	if(obj.id=="datchem00340_detail_v2")
	{
		auto_resize_column(idGridDetail,0,g2_l3_score,8);
		 idGridDetail.Subtotal( 0, 2, 0, '10!13!17!21!23');
	}
	
}


function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}


function OnReport(objrp)
{
	var url=System.RootURL;
	
	switch (objrp)
	{
							
		case 1:
		{
			url=url + '/reports/ch/em/'+ lstReportType.value+'?p_Org_Code=' + lstOrg_Code.value + '&p_Grp_Code=' + lstGrp_Code.value + '&p_Searchby=' + lstEmp.value + '&p_Search=' + txtEmp.text + '&p_Status='+ lstEvaStatus.value +'&p_EvaMaster=' + lstEvaMaster.value + '&p_Eva_Group=' + lstEvaGroup.value + '&p_lstManager=' + lstManager.value + '&p_lstMan_Search_by=' + lstMan_Search_by.value + '&p_txtMsearchtmpDetail=' + txtMsearchtmpDetail.text + '&p_txtNumOfLevel='+txtNumOfLevel.text;
						break;
		}
		case 2:
		{
			url=url + '/reports/ch/em/'+ lstReportType2.value+'?p_Org_Code=' + lstOrg_CodeDetail.value + '&p_Grp_Code=' + lstGrp_CodeDetail.value + '&p_Searchby=' + lstEmpDetail.value + '&p_Search=' + txtEmpDetail.text + '&p_Status=' + lstEvaStatusDetail.value + '&p_EvaMaster=' + lstEvaMasterDetail.value + '&p_Eva_Group=' + lstEvaGroupDetail.value + '&p_lstManager=' + lstManagerDetail.value + '&p_lstMan_Search_by=' + lstM_SearchbyDetail.value + '&p_txtMsearchtmpDetail=' + txtman_search_detail.text + '&p_txtNumOfLevel='+txtNumOfLevel.text ;
						break;
		}

         
	}

    window.open(url);        
}  


function OnChangeEvaPeriod(obj)
{
	no_master = obj;
	txtEvaMastertmp.text=(obj==1?lstEvaMaster.value:lstEvaMasterDetail.value);
    datchemchecklevel.Call();
}


</script>

<body>

<gw:data id="datchemchecklevel" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_chem00001_V2" > 
                <input>
                    <input bind="txtEvaMastertmp"/>  
                </input> 
                <output>
                    <output bind="txtNumOfLevel" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datchem00310_evagrp" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR_pro_chem00000_v2_grp" > 
                <input>
                    <input bind="txtEvaMastertmp"/> 
                </input> 
                <output>
                    <output bind="txtEvaGrp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datchem00340_v2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid"  function="hr_sel_chem00340_v2">  
                <input bind="idGrid">  
                    <input bind="lstOrg_Code" />
                    <input bind="lstGrp_Code" />
                    <input bind="lstEmp" />  
                    <input bind="txtEmp" /> 
                    <input bind="lstEvaMaster" />
                    <input bind="lstEvaGroup" />
                    <input bind="lstEvaStatus" />
                    <input bind="lstManager" />
                    <input bind="lstMan_Search_by" />
                    <input bind="txtMsearchtmpDetail" />
                </input> 
                <output bind="idGrid" /> 
            </dso> 
        </xml> 
    </gw:data>
<gw:data id="datchem00340_detail_v2" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso type="grid"  function="hr_sel_chem00340_detail_v2">  
                <input bind="idGridDetail">  
                    <input bind="lstOrg_CodeDetail" />
                    <input bind="lstGrp_CodeDetail" />
                    <input bind="lstEmpDetail" />  
                    <input bind="txtEmpDetail" /> 
                    <input bind="lstEvaMasterDetail" />
                    <input bind="lstEvaGroupDetail" />
                    <input bind="lstEvaStatusDetail" />
                    <input bind="lstManagerDetail" />
                    <input bind="lstM_SearchbyDetail" />
                    <input bind="txtman_search_detail" />
                </input> 
                <output bind="idGridDetail" /> 
            </dso> 
        </xml> 
    </gw:data>



<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate=""  >   
   <table name="Eva Checking" width="100%" cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;">
        <tr style="width:100%;height:1%">
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        </tr>
        <tr style="width:100%;height:5%">
			<td colspan=10 align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Oganization</a></td> 
            <td colspan=15 align="left" style=" width=15%" >
                <gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeOrg()" >
                    <data>
                        <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk)  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                    </data>
                </gw:list>
            </td>
            <td colspan=10  align="right" >WorkGroup</td>
            <td colspan=10  align="left" style="width=10%" ><gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
                   <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data></gw:list>
            </td>
			<td colspan=7 align=right>Search by</td>
			<td colspan=8>
                <gw:list  id="lstEmp" value="1" styles='width:100%' onchange=""> 
							        <data>|1|Emp ID|2|Full Name</data></gw:list>
            </td>
            <td colspan=10 ><gw:textbox id="txtEmp" styles='width:100%' onenterkey="OnSearch(1)" /></td>
           <td colspan=10 align=right>Eva Status</td>
            <td colspan=10>
                <gw:list id="lstEvaStatus" styles='width:100%' onchange="" />
            </td>
			
             <td colspan=5 align=center><gw:icon id="ibtnSearch"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch(1)"/></td>

             <td colspan=5 align=center><gw:label id="lblRecord" styles="font-weight:bold; color:red; font-size: 11" text="" /></td>
            
        </tr>
        <tr style="width:100%;height:5%">
			<td colspan=10 align=right>Eva Period</td>
            <td colspan=15>
                <gw:list id="lstEvaMaster" onchange="OnChangeEvaPeriod(1)" styles='width:100%' />
            </td>
            <td colspan=10 align=right>Eva Group</td>
            <td colspan=10>
                <gw:list id="lstEvaGroup" styles='width:100%' onchange="" />
            </td>
			<td colspan=7 align=right>Manager</td>
            <td colspan=8>
                <gw:list id="lstManager" value="1" styles='width:100%' onchange="" >
                    <data>|1|Level 1|2|Level 2</data></gw:list>
            </td>
            <td colspan=10>
                <gw:list  id="lstMan_Search_by" value="1" styles='width:100%' onchange=""> 
							        <data>|1|Emp ID|2|Full Name</data></gw:list>
            </td>
            <td colspan=10 align=center><gw:textbox id="txtMsearchtmpDetail" styles='width:100%' onenterkey="OnSearch(1)" /></td>
            <td colspan=15 align=right><gw:list  id="lstReportType" styles="color:blue;width:100%" onchange=""> 
					             <data><%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chem00340_v2' and char_4='1' order by seq")%></data>
			            </gw:list>
            </td>

            <td colspan=5 align=right>
                <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnReport(1)" />
            </td>
        </tr>
        <tr style="height: 89%">
                <td colspan=100>
                    <gw:grid id="idGrid" 
                        header="Organization|Work Group|Eva Period|Eva Group|Emp ID|Full Name|Eva Status|Manager L1|L1 Status|L1 Score|Manager L2|L2 Status|L2 Score|Manager L3|L3 Status|L3 Score|Final Score|_Eva_emp_pk" 
                        format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="||||||||||||||||"
                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        widths="1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500" 
                        sorting='T' styles="width:100%; height:100%" />
                </td>
            </tr>
    </table>
	
 <table name="Eva Checking Detail" width="100%" cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;">
        <tr style="width:100%;height:1%">
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
        </tr>
        <tr style="width:100%;height:5%">
				<td colspan=10 align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(2)" href="#tips" >Oganization</a></td>  
            <td colspan=15 align="left" style=" width=15%" >
                <gw:list  id="lstOrg_CodeDetail" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeOrg()" >
                    <data>
                        <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk)  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                    </data>
                </gw:list>
            </td>
            <td colspan=10  align="right" >WorkGroup</td>
            <td colspan=10  align="left" style="width=10%" ><gw:list  id="lstGrp_CodeDetail" value='ALL' maxlen = "100" styles='width:100%' >
                   <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data></gw:list>
            </td>
			<td colspan=10 align=right>Search by</td>
			<td colspan=10>
                <gw:list  id="lstEmpDetail" value="1" styles='width:100%' onchange=""> 
							        <data>|1|Emp ID|2|Full Name</data></gw:list>
            </td>
            <td colspan=10 ><gw:textbox id="txtEmpDetail" styles='width:100%' onenterkey="OnSearch(2)" /></td>
           <td colspan=5 align=right>Eva&nbspStatus</td>
            <td colspan=10>
                <gw:list id="lstEvaStatusDetail" styles='width:100%' onchange="" />
            </td>
		
             <td colspan=5 align=center><gw:icon id="ibtnSearchDetail"  text="Search"  img="in"  styles="width:100%" onclick="OnSearch(2)"/></td>

             <td colspan=5 align=center><gw:label id="lblRecordDetail" styles="font-weight:bold; color:red; font-size: 11" text="" /></td>
            
        </tr>
        <tr style="width:100%;height:5%">
			<td colspan=10 align=right>Eva Period</td>
            <td colspan=15>
                <gw:list id="lstEvaMasterDetail" onchange="OnChangeEvaPeriod(2)" styles='width:100%' />
            </td>
            <td colspan=10 align=right>Eva Group</td>
            <td colspan=10>
                <gw:list id="lstEvaGroupDetail" styles='width:100%' onchange="" />
            </td>
			<td colspan=10 align=right>Manager</td>
            <td colspan=10>
                <gw:list id="lstManagerDetail" value="1" styles='width:100%' onchange="" >
                    <data>|1|Level 1|2|Level 2</data></gw:list>
            </td>
            <td colspan=10>
                <gw:list  id="lstM_SearchbyDetail" value="1" styles='width:100%' onchange=""> 
							        <data>|1|Emp ID|2|Full Name</data></gw:list>
            </td>
            <td colspan=10 align=center><gw:textbox id="txtman_search_detail" styles='width:100%' onenterkey="OnSearch(2)" /></td>
           <td colspan=10 align=right><gw:list  id="lstReportType2" styles="color:blue;width:100%" onchange=""> 
					             <data><%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chem00340_v2' and char_4='2' order by seq")%></data>
			            </gw:list></td>
            <td colspan=5 align=right>
                <gw:imgbtn id="btnPrintDetail" img="excel" alt="Print" text="Print" onclick="OnReport(2)" />
            </td>
        </tr>
        <tr style="height: 89%">
                <td colspan=100>
                    <gw:grid id="idGridDetail" 
                        header="_Eva_emp_pk|Organization|Work Group|Eva Period|Eva Group|Emp ID|Full Name|Eva Status|Eva Factor|Weight|Standard Score|Manager L1|L1 Status|L1 Score|L1 Opinion|Manager L2|L2 Status|L2 Score|L2 Opinion|Manager L3|L3 Status|L3 Score|L3 Opinion|Final Score" 
                        format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0" 
                        aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        defaults="|||||||||||||||||||||"
                        editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                        widths="1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500" 
                        sorting='T' styles="width:100%; height:100%" />
                </td>
            </tr>
    </table>

</gw:tab>
</body>
<gw:textbox id="txtEvaGrp" style="display:none" />
<gw:textbox id="txtLevel" style="display:none" />
<gw:textbox id="txtResult" style="display:none" />
<gw:textbox id="txtAction" style="display:none" />
<gw:textbox id="txtNumOfLevel" style="display:none" />
<gw:textbox id="txtEvaMastertmp" style="display:none" />
 <gw:textbox id="txtReport_tmp" styles="display:none"/>
 <gw:textbox id="txtOrgData" styles="display:none"/>
<gw:textbox id="txtUpperOrg" styles="display:none"/>
</html>
