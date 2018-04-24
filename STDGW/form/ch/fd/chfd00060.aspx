<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>
<head runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var irow,icol;
var binit=true;
var icResponse_L1=14;
var icResponse_L2=15;
var icStatus=17;
var icStatus_Text=5;
var icTemp_PK=13;
var icBiz_Trip_PK=19;
var icApp_Level=16;
var icApp_Type=18;
var icReq_Flag=21;
var icApp_Level_Text=20;
function BodyInit()
{ 	
    grdEmployee.GetGridControl().ScrollTrack=true;
    grdEmployee.GetGridControl().FrozenCols =4;
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
     txtManager_PK.text="<%=session("EMPLOYEE_PK")%>";
     txtCompany_pk.text="<%=session("COMPANY_PK")%>";
    grdEmployee.GetGridControl().ColFormat(10) = "(###,###,###.##)"; 
    txtManagerLevel.text="<%=ESysLib.SetDataSQL("SELECT a.manager_kind from COMM.tco_ORG a where a.del_if=0 and a.manager_pk=" & session("EMPLOYEE_PK") & "and a.manager_kind is not null and rownum=1" )%>";
   
    if (txtManagerLevel.text =="01")
    {
        alert("You must have an authority as GA Manager!");
        ibtnSearch.SetEnable(false);
        ibtnRegis_Res.SetEnable(false);
        icnApprove.SetEnable(false);
        icnReject.SetEnable(false);
        icnRequest.SetEnable(false);
        txtTemp.SetEnable(false);
    }    
    txtaResponse.SetEnable(false);
    idtxtbudget.SetEnable(false);
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        datUser_info.Call();
}
function OnSearch()
{
    txtTemp_PK.text="";
    txtaResponse.text="";
    txtaResponse_L2.text="";
    datApproval_Biz_Trip.Call("SELECT");
}

//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
       if (obj.id=="datUser_info")
       {
            datGroupData.Call();
       } 
	   else if (obj.id=="datApproval_Biz_Trip")
	   {
	        lblRecord.text=grdEmployee.rows-1 + " record(s)";
	        if (grdEmployee.rows>1)
	            grdEmployee.SetCellBgColor(1,icStatus,grdEmployee.rows -1 ,icStatus,0xCC99FF);
	    }
	    else if (obj.id=="datProApproval")
	    {
	        if (txtResult.text=="1")
	        {
	            alert("This action is sucessful!");
    	        grdEmployee.SetGridText(irow,icResponse_L2,txtaResponse_L2.GetData());
	            grdEmployee.SetGridText(irow,icStatus,txtStatus.text);
	            grdEmployee.SetGridText(irow,icStatus_Text,txtStatus_Text.text);
	            grdEmployee.SetGridText(irow,icApp_Level,txtApprove_Level.text);
	            grdEmployee.SetGridText(irow,icApp_Level_Text,txtApprove_Level_Text.text);
	            SetEnable_B(false);
	        }
	        else
	            alert("This action is failed!");
	    }
	    
	    
}     
//------------------------------------------------------------------------------------
function OnChangeDept()
{
    //txtDept.text=lstDept_Code.value;
    datGroupData.Call();
}
//-------------------------------------------------
function SetEnable_B(data)
{
    icnApprove.SetEnable(data);
    icnReject.SetEnable(data);
    icnRequest.SetEnable(data);
    txtaResponse_L2.SetEnable(data);
}
//------------------------------------------------
function Display_Res_2(data)
{
    if (data==true)
    {
        idRes1.style.display="";
        idRes2.style.display="";
        idRes.style.height="40%";
        idGrid.style.height="60%";
    }
    else
    {
        idRes1.style.display="none";
        idRes2.style.display="none";
        idRes.style.height="30%";
        idGrid.style.height="70%";
    }
}
//-----------------------------------------------------------
function OnSelect()
{
    irow=event.row;
    icol=event.col;
    var iapp_level,req_flag;
    if (irow>=1)
    {
    
        txtTemp_PK.text=grdEmployee.GetGridData(irow,icTemp_PK);
        txtBiz_Trip_PK.text=grdEmployee.GetGridData(irow,icBiz_Trip_PK);
        txtaResponse.SetDataText(grdEmployee.GetGridData(irow,icResponse_L1));
        txtaResponse_L2.SetDataText(grdEmployee.GetGridData(irow,icResponse_L2));
        txtStatus.text=grdEmployee.GetGridData(irow,icStatus);
        txtApp_Type.text=grdEmployee.GetGridData(irow,icApp_Type);
        iapp_level=grdEmployee.GetGridData(irow,icApp_Level);
        ireq_flag=grdEmployee.GetGridData(irow,icReq_Flag);
        
        txtPl_pk.text=grdEmployee.GetGridData(irow,22);//pl_pk
        txtPl_Year.text=grdEmployee.GetGridData(irow,5);//pl_pk
        
        if (iapp_level=="02")
            Display_Res_2(true);
        else
            Display_Res_2(false);
        if ((iapp_level=="02" && txtStatus.text=="06") || txtStatus.text=="10" ) // dang o cap do level 1
        {
            
            if (idRes2.style.display=="")
            {
                SetEnable_B(true);
                ibtnRegis_Res.SetEnable(true);
            }    
            else
            {
                ibtnRegis_Res.SetEnable(true);
                SetEnable_B(false);
            }
        }
        else
            SetEnable_B(false);        
        datBudget_unused.Call();
                
    }
}
//-------------------------------------
function OnApprove(objaction)
{
    var saction;
    txtResult.text="0";
    switch (objaction)
    {
        case 1:
            saction="approve";
            break;
        case 2:
            saction="reject";
            break;
        case 3:
            saction="request information";
            break;
    }
    if (txtTemp_PK.text!="")
    {
        txtAction.text=objaction;
        if (confirm("Do you want to " + saction + " this applicant"))
            datProApproval.Call();
    }
    else
        alert("Please select employee \n Vui lòng chọn nhân viên");
}

//----------------------------------------
function OnRegis_Res()
{
    var iapp_level;
    if (irow>=1)
    { 
        iapp_level=grdEmployee.GetGridData(irow,icApp_Level);
        if ( (iapp_level=="02" && txtStatus.text=="06" ) ||txtStatus.text=="10" ) // dang o cap do level 1
        {
            Display_Res_2(true);
            SetEnable_B(true);
            txtaResponse_L2.GetControl().focus();
        }
        
    }
}
//------------------------------------------
function Popup()
{
    var ctrl=grdEmployee.GetGridControl();
    var trip_pk=grdEmployee.GetGridData(ctrl.row,icBiz_Trip_PK);
    var app_type=grdEmployee.GetGridData(ctrl.row,icApp_Type);
    if(app_type=='01')//biz trip
    {
        var fpath = System.RootURL + "/form/ch/fd/chfd00050_popup_biz.aspx?p_biz_trip_pk="+trip_pk;
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:60;dialogHeight:60;dialogLeft:30;dialogTop:200;edge:sunken;scroll:no;unadorned:yes;help:no');
        
    }
    else if(app_type=='02')//settle trip
    {
        var fpath = System.RootURL + "/form/ch/fd/chfd00050_popup_settle.aspx?p_biz_trip_pk="+trip_pk;
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:60;dialogHeight:60;dialogLeft:30;dialogTop:200;edge:sunken;scroll:no;unadorned:yes;help:no');
    }
}
//---------------------------------
function OnShowBudget()
{
    System.Menu.NewWindow( "form/ag/io/agio0050.aspx", "C&Center Budget Entry", "C&Center Budget Entry", "C&Center Budget Entry" );
}    

</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstDept" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!----------------------------------->
<gw:data id="datProApproval" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_approval" > 
                <input>                    
                   <input bind="txtTemp_PK" />
                   <input bind="txtaResponse" />
                   <input bind="txtaResponse_L2" />
                   <input bind="txtAction" />
                   <input bind="txtManagerLevel" />
                   <input bind="txtApp_Type" />
                   <input bind="txtManager_PK" />
                </input> 
                <output>    
                    <output bind="txtStatus" />
                    <output bind="txtResult" />
                    <output bind="txtApprove_Level" />
                    <output bind="txtStatus_Text" />
                    <output bind="txtApprove_Level_text" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datApproval_Biz_Trip" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_approval_biz_trip " > 
            <input> 
                <input bind="lstDept" /> 
                <input bind="lstGroup" /> 
                <input bind="chkTemp" /> 
                <input bind="txtTemp" /> 
                <input bind="dtFrom" /> 
                <input bind="dtTo" />
                <input bind="dtFromSumDt" /> 
                <input bind="dtToSumDt" />
                <input bind="lstApp_Type" /> 
                <input bind="lstStatus" />  
                <input bind="txtManager_PK" />
                <input bind="txtManagerLevel" />
            </input> 
            <output bind="grdEmployee" /> 
        </dso> 
   </xml> 
</gw:data> 

<!----------------------------------->
<gw:data id="datBudget_unused" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_SEL_UNUSED_BUDGET" > 
                <input>
                    <input bind="txtCompany_pk" />
                    <input bind="txtPl_pk" />
                    <input bind="txtPl_Year" />
                </input>
                <output>
                    <output bind="idtxtbudget" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------table------------------------------->
<table style='margin-left:10px' align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
	<tr style="height:10%"> 
	    <td  align = top colspan=2>
		    <table align = top  width="100%" CELLSPACING="0" CELLPADDING="0" >
		        <tr>
			        <td align="Left">
				        <table   border="0" CELLSPACING="0" CELLPADDING="0" style="height:inherit" >
					        <tr>   
						        <td width="11%" align="right"><font color="black"><b >Organization</b></td>
						        <td width="25%" colspan=3 ><gw:list id="lstDept" styles="color:black;width:100%" value="ALL" onchange=""> 
	                                           <data><%=ESysLib.SetListDataSQL("SELECT PK,ORG_NM FROM comm.TCO_ORG WHERE DEL_IF = 0 and org_type='06' order by ORG_ID")%>|ALL|Select All</data>
	                                           </gw:list > 
						        </td>
						        <td width="15%" colspan=2><gw:list id="lstGroup" styles="color:black;width:100%;display:none;" value="ALL" onchange=""> 
	                                            <data><%=Esyslib.SetListDataSQL("SELECT PK,WORKGroup_NM FROM Thr_WORK_Group WHERE DEL_IF = 0 order by WORKGROUP_ID" )%>|ALL|Select All</data>
	                                            </gw:list > 
						        </td>
						        <td width="13%" align="right" colspan=2><font color="black"><b>Application Type &nbsp;</b>
						        </td>
						        <td width="10%">
							        <gw:list  id="lstApp_Type" value="ALL" styles='width:100%' onchange=""> 
									         <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0058' order by code")%>|ALL|Select All</data>
	                                                  </gw:list>
						        </td>
        						<td width="7%" align="right" ><font color="black"><b>Status &nbsp;</b>
						        </td>
						        <td width="11%">
							        <gw:list  id="lstStatus" value="ALL" styles='width:100%' onchange=""> 
									         <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0069' and code in('02','03','04','05','06','10') order by code")%>|ALL|Select All</data>
							        </gw:list>
						        </td>
						        <td width="2%" ></td>
						        <td width="3%" align="left">
							        <gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" />
						        </td>
						        <td width="3%" align="right">
							       <gw:imgBtn id="ibtnRegis_Res" alt="Register Response" img="registration" text="Search" onclick="OnRegis_Res()" />
						        </td>
					        </tr>
					         <tr>   
						        <td align="right" valign="middle">Submitted Date &nbsp;</td>
						        <td align="left" valign="middle" width="10%"><gw:datebox id="dtFromSumDt"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="center" width="5%"><font color="black"><b >~</b></td>
						        <td align="left" valign="middle" ><gw:datebox id="dtToSumDt"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="right"  width="5%"><font color="black"><b >Period &nbsp;</b></td>
						        <td  align="left" width="10%"><font color="black"><gw:datebox id="dtFrom"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="center" width="3%"><font color="black"><b >~</b></td>
						        <td  align="left" width="10%" ><font color="black"><gw:datebox id="dtTo"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="right" >Applicant</td>
						        <td  align="left" ><gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data> 
							        </gw:list></td>
							    <td  align=right> 
							        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
						        <td  align="center" colspan=3><i><gw:label id="lblRecord" text="0 record(s)" styles="width:100%" ></gw:label></i></td>
						        <td align="right" > </td>
					         </tr>
					        
				        </table>
			        </td>
		        </tr>
		    </table>
	    </td> 
	</tr>		   
	
    <tr align = top style="height:80%" > 
        <td  id="tblMaster"  width=100% >
        
            <table id="idGrid" align = top  width="100%" style="height:70%" CELLSPACING="0" CELLPADDING="0">
                <tr align = top style="height:100%"> 
	                <td colspan=3 align = top  width="100%"  >
  		                <gw:grid   
			                id="grdEmployee"  
                                header='Application No|Applicant ID|Applicant Name|Organization|_Group|Status|From|To|Biz Type|Biz Object|Total Expenses|Summitted DT|App Type|_PK|_Response1|_Response2|_Approve_Level|_Status_Code|_App_Type_Code|_Biz_Trip_PK|Approval Level|_Request_Flag|_pl_pk|_account_cost'
                                format='0|0|0|0|0|0|4|4|0|0|0|4|0|0|0|0|0|0|0|0|0|0'
                                aligns='0|1|0|0|0|0|1|1|0|0|3|1|0|0|0|0|0|0|0|0|0|0'
                                defaults='|||||||||||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='1300|1185|2280|1380|1350|1500|1185|1215|1275|1245|1455|1725|1935|0|0|0|0|0|0|0|0|0'
                                sorting='T'
                                oncellclick ="OnSelect()" 
                                oncelldblclick = "Popup()"
                                styles='width:100%; height:100%'
                                />
  	                </td>
                </tr>
            </table>
            <table id="idRes" align = top  width="100%" style="height:30%" CELLSPACING="0" CELLPADDING="0">
                <tr style="height:10%">
                    <td colspan=5 align = top  width="100%"  >
  		        GA Staff Response
  	                </td>
                </tr>
                <tr style="height:35%">
                    <td colspan=5  align = top   width="100%" >
  		            <gw:textarea id="txtaResponse" styles="width:100%;height:96%;font-size:15"/>
  	                </td>
                </tr>
                <tr id="idRes1" style="height:10%;display:none">
                    <td colspan=5 align = top  width="100%"  >
  		        GA MAnager Response
  	                </td>
                </tr>
                <tr id="idRes2" style="height:35%;display:none">
                    <td colspan=5  align = top   width="100%" >
  		            <gw:textarea id="txtaResponse_L2"  styles="width:100%;height:96%;font-size:15"/>
  	                </td>
                </tr>
                <tr style="height:10%">
                    <td align=center width="10%"><a title="Click here to show budget info" onclick="OnShowBudget()" href="#tips" style="text-decoration :none;color=#0000FF;font-size:13">Unused Budget</a></td>
                    <td align=left width="15%"><gw:textbox id="idtxtbudget" type="number" format="#,###,###,###.##R" styles="width:100%;font-size:18"/></td>
                    <td align = right  width="55%" ><gw:icon id="icnApprove" img="in" text="Approve" onclick="OnApprove(1)" /></td>
                    <td align = center width="10%" ><gw:icon id="icnReject" img="in" text="Reject" onclick="OnApprove(2)" /></td>
                    <td align = right  width="10%" ><gw:icon id="icnRequest" img="in" text="Request Infor" onclick="OnApprove(3)" /></td>
                </tr>
            </table>
	    </td>
	   
    </tr>
    
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtManager_PK" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtTemp_PK" styles="display:none"/>
    <gw:textbox id="txtBiz_Trip_PK" styles="display:none"/>
    <gw:textbox id="txtStatus" styles="display:none"/>
    <gw:textbox id="txtAction" styles="display:none"/>
    <gw:textbox id="txtResult" text="0" styles="display:none"/>
    <gw:textbox id="txtManagerLevel" text="0" styles="display:none"/>
    <gw:textbox id="txtApprove_Level" text="0" styles="display:none"/>
    <gw:textbox id="txtStatus_Text" text="0" styles="display:none"/>
    <gw:textbox id="txtApp_Type" text="0" styles="display:none"/>
    <gw:textbox id="txtApprove_Level_Text" text="0" styles="display:none"/>
    <gw:textbox id="txtCompany_pk" text="0" styles="display:none"/>
    <gw:textbox id="txtPl_pk" text="0" styles="display:none"/>
    <gw:textbox id="txtPl_Year" text="0" styles="display:none"/>
</body>
</html>

				
