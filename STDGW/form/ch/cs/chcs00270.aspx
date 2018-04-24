<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var check_init=1;
var flag;
var strcodereturn;
var binit=true;
var startTime,interval_time
var v_language = "<%=Session("SESSION_LANG")%>";
var rowselect=0;
var c_sal_l1=5;
var c_sal_l2=6;
var c_time=7;
var c_wt=8;
var c_abs=9;
var c_ot=10;
var c_nt=11;
var c_st=12;
var c_ht=13;
var c_tt_wt=14;
var c_tt_ot=15;
var c_net=16;
var c_att_type=17;
var c_remark=18;
function BodyInit()
{
	var t1;
	
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
     txtCompany.text="<%=session("COMPANY_PK")%>";
     menu_id.text=System.Menu.GetMenuID();
   grdSalary.GetGridControl().FrozenCols =4;
   grdSalary.GetGridControl().ScrollTrack=true;
  
}


//----------------------------------
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

//----------------------------------------------

function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}

function clock(start,x) 
{
 var d = new Date()
 lbldata2.text= Math.round((d.valueOf()-start)/x);

}

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}

//----------------------------------
function OnShowPopup(n)
{
    if(check_init==1)
    {
         var strcom;
        if(n==1||n==3||n==4)
        {
            var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
            var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:30;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
            if (obj!=null)
            {
                if(n==1)
			    {
                    lstOrg.value=obj;
				   // onChange_org(1,lstOrg);
			    }	
                else if(n==3)    
			    {
                    lstOrg2.value=obj;
				   // onChange_org(2,lstOrg2);	
			    }	
			    else	
				    lstLocation_dept.value=obj;
            }    
         }
     }     
     
        
    
}
//------------------------------------
function OnChangeMonth(n)
{
    if(n==1)
        datCheck_Month.Call();
    else if(n==2)
    {
        grdSalary2.ClearData();
        dtMonth_close.value=dtMonth2.value;
        OnChangeMonth(1);
        
    }    
}
//----------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value)    ;
    obj=obj_list.GetControl();
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//----------------------------------------------
function OnDataReceive(obj)
{  
   if (obj.id=="datDailyProcess")
   {
        if (txtResult.text=="0")
            alert("Processing is complete!")
        else
            alert("Processing is error!")
        
   }
   else if (obj.id=="datDailySalary")
   {
        lblRecord.text=grdSalary.rows-1;
        var obj_grd;
        obj_grd=grdSalary.GetGridControl();
        obj_grd.OutlineBar =2 ;
        for (var j=c_sal_l1;j<c_net;j++)
        {
            if (j!=c_time)
                obj_grd.SubTotal(2,0, j,'',0x99FFFF,0x000000,'1','TT-%s','',true);
            
        }
     //   auto_resize_column(grdSalary,1,grdSalary.rows-1,0);
   }
   else if (obj.id=="datFind_Report")
   {
        var url=System.RootURL;
		
        url=url + '/reports/ch/cs/'+txtReport_tmp.text+'?P_TCO_ORG_PK=' + lstOrg.value + '&P_THR_WG_PK=' + lstWGroup.value + '&P_STATUS=' + lstStatus.value + '&P_EMPLOYEE_TYPE=' + lstEmp_Type.value + '&P_SEARCH_BY=' + lstTemp.value + '&P_SEARCH_TEMP=' + txtTemp.text		 + '&P_FROM_DT=' + dtFrom_Date_1.value + '&P_TO_DT=' + dtTo_Date_1.value + '&P_COST_GROUP=' + lstCostGroup_1.value + '&P_COST_KIND=' + lstCostGroupKind_1.value + '&P_TAC_ABPL_PK=' + lstCostCenter_1.value
		;
		
		window.open(url); 
   }
}
//-------------------
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

//------------------------------------------------------

//----------------------------------------------------
function OnSearch(n)
{
	
    datCurrent_Salary.Call("SELECT");
	
}


//------------------------------------------

function OnToggle()
{
     if(img2.status == "show")
            {
                img2.status = "hide";
                img2.src = "../../../system/images/close_popup.gif";
			    img2.alt="Hide month salary information";
			    tr_month.style.display='';
            }
            else 
            {
                img2.status = "show";
                img2.src = "../../../system/images/iconmaximize.gif";
			    img2.alt="Show month salary information";
			    tr_month.style.display="none";
            }
      
}

function OnChangeLocation()
{
	datGet_period.Call();
}

function OnReport()
{
    txtReport_tmp.text=lstReport_Type.value;
    datFind_Report.Call();
}
//----------------------------------
function OnProcess()
{
    if (confirm("Do you want to process?"))
    {
        datDailyProcess.Call();
    }
}

//----------------------------------

function OnSearch()
{
    datDailySalary.Call("SELECT");
}
</script>
<body >
<!------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_FIND_REPORT_2" > 
                <input>
                    <input bind="txtReport_tmp" />
                    <input bind="lstOrg" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!-------------------------------------------->
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
            <dso  type="list" procedure="hr_lst_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtdept_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>
<gw:data id="datDailyProcess" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="HR_PRO_10030027_SALARY"  > 
                <input>
                    <input bind="lstCostGroup" />
                    <input bind="lstCostGroupKind" />
                    <input bind="lstCostCenter" />
                    <input bind="txtCompany" />
                    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------>

<gw:data id="datDailySalary" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="" function="hr_sel_10030027" procedure=""> 
                <input bind="grdSalary" >
                    <input bind="lstOrg" />
                    <input bind="lstWGroup" />
                    <input bind="lstStatus" />
                    <input bind="lstEmp_Type" />
                    <input bind="lstTemp" />
                    <input bind="txtTemp" />
                    <input bind="dtFrom_Date_1" />
                    <input bind="dtTo_Date_1" />
                    <input bind="lstCostGroup_1" />
                    <input bind="lstCostGroupKind_1" />
                    <input bind="lstCostCenter_1" />
                </input>
                <output  bind="grdSalary" />
                
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->

    <table name="Month Sal" id="MonthSal" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
		<tr style="width:100%;height:100%" border=1 valign="top">
			<td>
				<table cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
							<tr id="tr_temp" style="border:0;width:100%;height:1%" valign="center" >
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
								<td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td><td width="2%" style="border:0;">&nbsp;</td>
							</tr>   
						
							<tr id="tr_month" style="width:100%;height:5%;display:none"  >
								<td colspan=4 style="border:0;" align="right" >Date</td>
								<td colspan=3  style="border:0;" align="left" ><gw:datebox id="dtFrom_Date"  tyles="width:100%" lang="<%=Session("Lang")%>" /></td>
								<td colspan=2 style="border:0;" align="center" ><b>~</b></td>
								<td colspan=3 style="border:0;"  align="left" >
								 <gw:datebox id="dtTo_Date"  styles="width:100%" lang="<%=Session("Lang")%>" />
								</td>
								<td colspan=4 style="border:0;" align="right" >Cost Group</td>
								<td colspan=5 style="border:0;" align="center"  > <gw:list  id="lstCostGroup" value="ALL" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0092' order by code_nm")%>|ALL|Select All
                            </data>
                            </gw:list ></td>
								<td colspan=4 style="border:0;" align="right" >Cost Group Kind</td>
								<td colspan=6 style="border:0;" align="center"  > <gw:list  id="lstCostGroupKind" value="ALL" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0093' order by code_nm")%>|ALL|Select ALL
                            </data>
                            </gw:list ></td>
								<td colspan=4  style="border:0;" align="right" >Cost Center</td>
								<td colspan=9 style="border:0;" align="center" ><gw:list id="lstCostCenter"   styles='width:100%'>
								                                                 <data>
                                <%=ESysLib.SetListDataSQL("select tac_abplcenter_pk,pl_cd || ' : ' || pl_nm from V_ABPLCENTER  order by 2")%>|ALL|Select All
                                 </data> </gw:list> </td>
								<td colspan=3 style="border:0" align="right"><gw:icon img="in" id="ibtnProcess" text="Process" onclick="OnProcess()"/></td>
								<td colspan=1 style="border:0"   align="right" valign="middle">&nbsp;</td>
								<td colspan=3 style="border:0" align="right"><gw:icon img="in" id="ibtnClose"    text="Close"  onclick="OnClose()"/></td>
							</tr>
								  
							<tr style="border:0;width:100%;height:5%" valign="center" >
								<td colspan=1  style="border:0;" align="right" ><img status="show" id="img2" alt="Show month salary information" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle()"  /></td>
								<td colspan=3 style="border:0;" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(3)" href="#tips" >Organization</a>                  
								</td>
								<td colspan=8  style="border:0;" align="left" >
								 <gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%' onchange="" >
									<data>
										<%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
									</data>
								</gw:list>
								</td>
								<td colspan=4 style="border:0;" align="right" >Work Group</td>
								<td colspan=5 style="border:0;" align="left" >
								 <gw:list  id="lstWGroup" value='ALL' maxlen = "100" styles='width:100%' >
									<data><%=Esyslib.SetListDataSQL("SELECT a.pk,a.workGroup_NM FROM Thr_work_Group a WHERE a.DEL_IF = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6') order by a.workgroup_id" )%>|ALL|W-Group All</data></gw:list>
								</td>
								<td colspan=4 style="border:0;" align="right" >Status</td>
								<td colspan=6 style="border:0;" align="left" >
								 <gw:list  id="lstStatus" value='ALL' maxlen = "100" styles='width:100%' >
								   <data>
										<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0022' order by code")%>|ALL|Select All
									</data></gw:list>
								</td>
								<td colspan=4 style="border:0;" align="right" >Emp Type</td>
								<td  colspan=4 style="border:0"  align="right" valign="middle"> <gw:list  id="lstEmp_Type" value='ALL' maxlen = "100" styles='width:100%' >
								   <data>
										<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code")%>|ALL|Select All
									</data></gw:list></td>
						
								<td colspan=2 style="border:0;" align="right" >Search</td>
								<td colspan=3 align=center style="border:0" > 
								   <gw:list  id="lstTemp" value="2" styles='width:97%' onchange=""> 
											<data>LIST|1|Name|2|Emp ID</data> 
									</gw:list>
								</td>
								  <td colspan=3 style="border:0" align="right">
									<gw:textbox id="txtTemp" onenterkey   ="OnSearch(2)" styles='width:100%'/>
								</td>
								<td colspan=1 style="border:0;" align="right"  >
								 <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
								</td>
								<td colspan=1 style="border:0" align="right">
								 <gw:imgBtn img="excel" id="ibtnReport"    alt="Report"  onclick="OnReport()"/>
								</td>
								
							</tr>
							<tr style="border:1;width:100%;height:5%" valign="center" >
								<td colspan=4 style="border:0;" align="Right">Date</td>
								<td colspan=3 style="border:0;" align="left" >
								 <gw:datebox id="dtFrom_Date_1" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
								</td>
								<td colspan=2 style="border:0;" align="center" ><b>~</b></td>
								<td colspan=3 style="border:0;"  align="left" >
								 <gw:datebox id="dtTo_Date_1" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
								</td>
									<td colspan=4 style="border:0;" align="right" >Cost Group</td>
								<td colspan=5 style="border:0;" align="center"  > <gw:list  id="lstCostGroup_1" value="ALL" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0092' order by code_nm")%>|ALL|Select All
                            </data>
                            </gw:list ></td>
								<td colspan=4 style="border:0;" align="right" >Cost Group Kind</td>
								<td colspan=6 style="border:0;" align="center"  > <gw:list  id="lstCostGroupKind_1" value="ALL" styles='width:100%' onChange="">
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0093' order by code_nm")%>|ALL|Select ALL
                            </data>
                            </gw:list ></td>
                          <td colspan=4  style="border:0;" align="right" >Cost Center</td>
							<td colspan=9 style="border:0;" align="center" >  <gw:list id="lstCostCenter_1" value = "ALL"  styles='width:100%'>
								                                                 <data>
                                <%=ESysLib.SetListDataSQL("select tac_abplcenter_pk,pl_cd || ' : ' || pl_nm from V_ABPLCENTER  order by 2")%>|ALL|Select ALL
                                 </data> </gw:list></td>
							
							<td  colspan=3  style="border:0;" align="right" ><gw:list  id="lstReport_Type" styles="color:blue;width:100%" onchange=""> 
					             <data><%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chcs00270' order by seq")%></data>
							</gw:list>
                        </td>
							<td align="right" colspan=2 style="border:0;" ><gw:label id="lblRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" />
							
                        </td>	
						</tr>
							
							<tr style="border:1;width:100%;height:100%" valign="top">
								<td colspan=51  style="width:100%;height:90%;"> 
									 <gw:grid id='grdSalary'
                                    header='WORK DT|DEPARTMENT|GROUP|EMP ID|FULL NAME|SALARY LEVEL1|SALARY LEVEL2|TIME IN-TIME OUT|WT (H)|ABS (H)|OT (H)|NT (H)|ST (H)|HT (H)|TOTAL WT|TOTAL OT|NET AMT|ATTEND TYPE|REMARK|_PK'
                                    format='4|0|0|0|0|-0|-0|0|0|0|0|0|0|0|-0|-0|-0|0|0|0'
                                    aligns='0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0'
                                    check='|||||||||||||||||||'
                                    editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|1|0'
                                    widths='1700|1275|1620|1140|2880|1605|1530|1815|795|885|780|765|660|675|1170|1035|1035|1260|2000|0'
                                    sorting='T'
                                    styles='width:100%; height:100%'
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
<gw:textbox id="dtEndDate" styles="display:none" />
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtDept" styles="display:none"/>
<gw:textbox id="txtdept_temp" styles="display:none"/>
<gw:textbox id="txtFlag" styles="display:none"/>
<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtMonth_flag" styles="display:none"/>
<gw:textbox id="txtorg_tmp" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/> 


 <!------------------------------------------------->
<gw:textbox id="idSAL_ALL" styles="display:none"/>  

<gw:textbox id="idALL1_NM" styles="display:none"/>
<gw:textbox id="idALL2_NM" styles="display:none"/>
<gw:textbox id="idALL3_NM" styles="display:none"/>
<gw:textbox id="idALL4_NM" styles="display:none"/>
<gw:textbox id="idALL5_NM" styles="display:none"/>
<gw:textbox id="idALL6_NM" styles="display:none"/>
<gw:textbox id="idALL7_NM" styles="display:none"/>
<gw:textbox id="idALL8_NM" styles="display:none"/>

<gw:textbox id="idALL1_USE" styles="display:none"/>
<gw:textbox id="idALL2_USE" styles="display:none"/>
<gw:textbox id="idALL3_USE" styles="display:none"/>
<gw:textbox id="idALL4_USE" styles="display:none"/>
<gw:textbox id="idALL5_USE" styles="display:none"/>
<gw:textbox id="idALL6_USE" styles="display:none"/>
<gw:textbox id="idALL7_USE" styles="display:none"/>
<gw:textbox id="idALL8_USE" styles="display:none"/>
<gw:textbox id="txtCompany" styles="display:none"/>               
 <gw:textbox id="txtReport_tmp" styles="display:none"/>    
	
 <gw:textbox id="txt_PK"  styles="display:none"/>
<gw:textbox id="txt_option"  text='2' styles="display:none"/>
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />                       
<gw:textbox id="txtSequence" text="" styles="display:none"  />
<gw:textbox id="txtCost_Center_pk_1" text="" styles="display:none"  />
<gw:textbox id="txtCost_Center_pk" text="" styles="display:none"  />

</html>
