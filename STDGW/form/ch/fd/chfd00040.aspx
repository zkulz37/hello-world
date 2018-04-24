<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var irow,icol;
var binit=true;
var icResponse_L1=15;
var icResponse_C=16;
var icStatus=18;
var icStatus_Text=6;
var icTemp_PK=14;
var icBiz_Trip_PK=20;
var icApp_Level=17;
var icApp_Type=19;
var icSettle=21;
var irow=0;
var icApp_No=1;
var irow_sel=-1;
function BodyInit()
{ 	
    grdEmployee.GetGridControl().ScrollTrack=true;
    grdEmployee.GetGridControl().FrozenCols =4;
    if (v_language!="ENG")
        System.Translate(document);
    txtEmp_PK.text="<%=session("EMPLOYEE_PK")%>";
    txtEmp_ID.text="<%=ESysLib.SetDataSQL("select emp_id from hr.thr_employee where del_if=0 and pk=" & session("EMPLOYEE_PK") )%>";
    txtFull_Name.text="<%=ESysLib.SetDataSQL("select full_name from hr.thr_employee where del_if=0 and pk=" & session("EMPLOYEE_PK") )%>";
    grdEmployee.GetGridControl().ColFormat(11) = "(###,###,###.##)"; 
    txtaResponse.SetEnable(false);
    txtEmp_ID.SetEnable(false);
    txtFull_Name.SetEnable(false);
    
}
function OnSearch()
{
    txtTemp_PK.text="";
    txtaResponse.text="";
    datBiz_Trip_List.Call("SELECT");
}

//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
 	   if (obj.id=="datBiz_Trip_List")
	   {
	        lblRecord.text=grdEmployee.rows-1 + " record(s)";
	        if (grdEmployee.rows>1)
	            grdEmployee.SetCellBgColor(1,icStatus,grdEmployee.rows -1 ,icStatus,0xCC99FF);
	    }
	   else if (obj.id=="datCancelApp")
	    {
	        if (txtResult.text=="07")
	        {
	            alert("This action is sucessful!");
	            alert(txtaResponse_Cancel.GetData());
    	        grdEmployee.SetGridText(irow,icResponse_C,txtaResponse_Cancel.GetData());
	            grdEmployee.SetGridText(irow,icStatus,txtResult.text);
	            grdEmployee.SetGridText(irow,icStatus_Text,txtStatus_Text.text);
	        }
	        else
	            alert("This action is failed!");
	    }
	    else if (obj.id=="datDeleteApp")
	    {
	        if (txtResult.text=="1")
	        {
	            alert("This action is sucessful!");
	            datBiz_Trip_List.Call("SELECT");
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
function Display_Res_2(data)
{
    if (data==true)
    {
        idRes1.style.display="";
        idRes2.style.display="";
        idRes3.style.display="";
        idRes.style.height="40%";
        idGrid.style.height="60%";
    }
    else
    {
        idRes1.style.display="none";
        idRes2.style.display="none";
        idRes3.style.display="none";
        idRes.style.height="20%";
        idGrid.style.height="80%";
    }
}
//-----------------------------------------------------------
function SetEnable_B(data)
{
    txtaResponse_Cancel.SetEnable(data);
    icnCancel.SetEnable(data);
}
//-----------------------------------------------------------
function OnSelect()
{
    irow=event.row;
    icol=event.col;
    var iapp_level;
    if (irow>=1)
    {
    
        txtTemp_PK.text=grdEmployee.GetGridData(irow,icTemp_PK);
        txtBiz_Trip_PK.text=grdEmployee.GetGridData(irow,icBiz_Trip_PK);
        txtaResponse.SetDataText(grdEmployee.GetGridData(irow,icResponse_L1));
        txtaResponse_Cancel.SetDataText(grdEmployee.GetGridData(irow,icResponse_C));
        txtStatus.text=grdEmployee.GetGridData(irow,icStatus);
        txtApp_Type.text=grdEmployee.GetGridData(irow,icApp_Type);
        iapp_level=grdEmployee.GetGridData(irow,icApp_Level);
        txtApp_No_Tmp.text=grdEmployee.GetGridData(irow,icApp_No);
        //kiem tra quyen cancel
        if (txtApp_Type.text=="01" && txtStatus.text != "09" )
        {
            SetEnable_B(true);
        }
        else
        {
            SetEnable_B(false);        
            Display_Res_2(false);
        }
        //kiem tra quyen delete
        if (txtApp_Type.text=="01" && txtStatus.text == "01" )
            icnDelete.SetEnable(true);
        else
            icnDelete.SetEnable(false);
        //kiem tra ve settle va Modi
        if (txtStatus.text=="01" || txtStatus.text=="05") //save or request infor
        {
            if (txtApp_Type.text=="01") // New
            {
                icnSettle.SetEnable(false);
                icnModify.SetEnable(true);
            }
            else  //Settle 
            {
                icnSettle.SetEnable(true);
                icnModify.SetEnable(false);
            }
        }
        else
        {
            icnSettle.SetEnable(false);
            icnModify.SetEnable(false);
        }
        //kiem tra ve replicate
        if (txtApp_Type.text=="01")
            icnReplicate.SetEnable(true);
        else
            icnReplicate.SetEnable(false);
        
        var ctrl=grdEmployee.GetGridControl();
        var tmp=grdEmployee.GetGridData(ctrl.row,0);
        if (ctrl.col==0)
        {
            if (tmp=="-1")
            {
                if (irow_sel!=-1 && irow_sel!=ctrl.row)
                    grdEmployee.SetGridText(irow_sel,0,0);
                irow_sel=ctrl.row;
            }  
            else
                if (irow_sel==ctrl.row)
                    irow_sel=-1;
        }
    }
    
}
//---------------------------------------
function OnNew()
{
    System.Menu.NewWindow( "form/ch/fd/chfd00010.aspx" , "Application for Biz Trip", "Application for Biz Trip", "Application for Biz Trip" );
}
//--------------------------------------------
function OnSettle_Exp()
{
    if (irow>=1)
        System.Menu.NewWindow( "form/ch/fd/chfd00020.aspx?p_temp_pk=" + txtApp_No_Tmp.text , "Settle Expenses", "Settle Expenses", "Settle Expenses" );
}
//-------------------------------------------
function OnReplicate()
{
    if (irow>=1)
        System.Menu.NewWindow( "form/ch/fd/chfd00010.aspx?p_biz_trip_pk=" + txtBiz_Trip_PK.text , "Application for Biz Trip", "Application for Biz Trip", "Application for Biz Trip" );
}
//----------------------------------------
function OnModify_App()
{
    if (irow>=1)
        System.Menu.NewWindow( "form/ch/fd/chfd00010.aspx?p_biz_trip_pk=" + txtBiz_Trip_PK.text  , "Application for Biz Trip", "Application for Biz Trip", "Application for Biz Trip" );
}
//---------------------------------------
function OnDelete()
{
    if (irow>1)
        if (confirm("Do you want to delete this applicant? \n Bạn muốn huỷ thông tin này không?"))
            datDeleteApp.Call();
}

//----------------------------------------
function OnCancel()
{
    var iapp_level;
    if (irow>=1)
    { 
        Display_Res_2(true);
        txtaResponse_Cancel.GetControl().focus();
    }
}
//------------------------------------
function OnSubmit()
{
    if (confirm("Do you want to cancel this applicant? \n Bạn có muốn dừng đơn này không?"))
        datCancelApp.Call();
}
//------------------------------------------
function OnShowPopup()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
    var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
    if (obj!=null)
    {
        txtEmp_PK.text=obj[0];
        txtEmp_ID.text=obj[1];
        txtFull_Name.text=obj[2];
    }
    
}
//---------------
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
//------------------------------
function OnReport(obj)
{
    if (FindSameType(grdEmployee,icApp_Type)==false)
    {
        alert("Have to print the same type of report (Payment Request or Settle Payment)!" + "\n"  + "Phải chọn báo cáo cùng kiểu!");
    }
    else 
    {
        var biz_trip_pk="";
        var report_type;
        for (var i=1;i<=grdEmployee.rows-1;i++)
        {
            if (grdEmployee.GetGridData(i,0)=="-1")
            {
                biz_trip_pk = biz_trip_pk + grdEmployee.GetGridData(i,icBiz_Trip_PK) + ",";
                report_type=grdEmployee.GetGridData(i,icApp_Type);
            }   
        }
        if (biz_trip_pk=="")
            alert("Please choose the applicant to print");
        else
        {
            biz_trip_pk=biz_trip_pk.substr(0,biz_trip_pk.length-1);
            if (obj==1)
            {
                if (report_type=='01')
                    url =System.RootURL + '/reports/ch/fd/rpt_bz_payment.aspx?p_biz_trip_pk=' + biz_trip_pk;
                else
                    url =System.RootURL + '/reports/ch/fd/rpt_bz_expense_settlement.aspx?p_biz_trip_pk=' + biz_trip_pk;
            }
            else
            {
                if (report_type=='01')
                    url =System.RootURL + '/reports/ch/fd/rpt_business_trip.aspx?p_biz_trip_pk=' + biz_trip_pk;
                else
                    url =System.RootURL + '/reports/ch/fd/rpt_settle_business.aspx?p_biz_trip_pk=' + biz_trip_pk;
            }
            window.open(url);    
        }
    }
}
//-------------------------------------------------------------------------------------
function FindSameType(obj_grid,col) //check report of grid just one labour contract type
{
    var irow;
    irow=0;
    for (var i=1;i<=obj_grid.rows-1;i++)
    {
        if (obj_grid.GetGridData(i,0)=="-1")
        {
            if (obj_grid.GetGridData(i,col) !=obj_grid.GetGridData(irow,col) && irow !=0)
                return false;
            irow=i;
            
        }
    }
    return true;
    
}

</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->
<!----------------------------------->
<gw:data id="datBiz_Trip_List" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso  type="grid" function="hr.sp_sel_biz_trip_list " > 
            <input> 
                <input bind="txtEmp_PK" />
                <input bind="txtEmp_ID" />
                <input bind="txtFull_Name" />
                <input bind="dtFromModDt" />
                <input bind="dtToModDt" />
                <input bind="txtApp_No" />
            </input> 
            <output bind="grdEmployee" /> 
        </dso> 
   </xml> 
</gw:data> 

<!----------------------------------->
<gw:data id="datDeleteApp" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_del_biz_trip" > 
                <input>
                    <input bind="txtBiz_Trip_PK" />
                </input>
                <output>
                    <output bind="txtResult" />
                    
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datCancelApp" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_cancel_biz_trip" > 
                <input>
                    <input bind="txtBiz_Trip_PK" />
                    <input bind="txtaResponse_Cancel" />
                </input>
                <output>
                    <output bind="txtResult" />
                    <output bind="txtStatus_Text" />
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
						        <td align="right" valign="middle" width="12%">Applicant &nbsp;</td>
						        <td align="left" valign="middle" width="10%"><gw:textbox id="txtEmp_ID"  text="" 	styles='width:100%;' csstype="mandatory"  onenterkey="OnEnterEmp()" /></td>
						        <td  align="center" width="15%" colspan=2><gw:textbox id="txtFull_Name"  text="" 	styles='width:100%;' csstype="mandatory"  onenterkey="OnEnterEmp()" /></td>
						        <td align="right" valign="middle" width="15%">Last Modified Date &nbsp;</td>
						        <td align="left" valign="middle" width="10%"><gw:datebox id="dtFromModDt"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="center" width="5%"><font color="black"><b >~</b></td>
						        <td align="left" valign="middle" width="10%"><gw:datebox id="dtToModDt"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td width="5%" align="center">
							        <gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" />
						        </td>
						        <td width="4%" style="border:0;" align="right" ><gw:imgBtn img="excel" id="ibtnReport"    alt="Advance Report"  onclick="OnReport(1)"/></td>
						        <td width="4%" style="border:0;" align="right" ><gw:imgBtn img="excel" id="ibtnReport"    alt="Content Report"  onclick="OnReport(2)"/></td>
						        <td  align="right" width="15%"><i><gw:label id="lblRecord" text="0 record(s)" styles="width:100%" ></gw:label></i></td>
						        
					         </tr>
					         <tr>   
						        <td  align="right"  ><font color="black"><b >Application No &nbsp;</b></td>
						        <td  align="left" colspan=2><font color="black"><gw:textbox id="txtApp_No" onenterkey   ="OnSearch()" styles='width:100%'/></td>
						        <td  align="center" colspan=8>
						            <table align = top  width="100%" CELLSPACING="0" CELLPADDING="0">
						                <tr width="100%">
						                    <td align=right width=25%">
						                        <gw:icon id="icnNew" img="in" text="New" onclick="OnNew()" />
						                    </td>
						                    <td align=center  width="20%" >
						                        <gw:icon id="icnReplicate" img="in" text="Replicate" onclick="OnReplicate()" />
						                    </td>
						                    <td align=center  width="20%">
						                        <gw:icon id="icnSettle" img="in" text="Settle Expense" onclick="OnSettle_Exp()" />
						                    </td>
						                    <td align=center  width="15%">
						                        <gw:icon id="icnModify" img="in" text="Modify App" onclick="OnModify_App()" />
						                    </td>
						                    <td align=center  width="15%">
						                        <gw:icon id="icnCancel" img="in" text="Cancel" onclick="OnCancel()" />
						                    </td>
                                            <td align=center  width="15%">
						                        <gw:icon id="icnDelete" img="in" text="Delete" onclick="OnDelete()" />
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
	
    <tr align = top style="height:80%" > 
        <td  id="tblMaster"  width=100% >
        
            <table id="idGrid" align = top  width="100%" style="height:70%" CELLSPACING="0" CELLPADDING="0">
                <tr align = top style="height:100%"> 
	                <td colspan=3 align = top  width="100%"  >
  		                <gw:grid   
			                id="grdEmployee"  
                                header='Select|Application No|Applicant ID|Applicant Name|Organization|_Group|Status|From|To|Biz Type|Biz Object|Total Expenses|Summitted Time|App Type|_PK|_Response1|_Response2|_Approve_Level|_Status_Code|_App_Type_Code|_Biz_Trip_PK|_Settle|Approval Level'
                                format='3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                aligns='0|0|1|0|0|0|0|1|1|0|0|3|1|0|0|0|0|0|0|0|0'
                                defaults='||||||||||||||||||||'
                                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                                widths='1000|1300|1185|2280|1380|1350|1000|1185|1215|1275|1245|1455|1725|1935|0|0|0|0|0|0|0'
                                sorting='T'
                                styles="width:100%; height:100%" 
                                oncellclick ="OnSelect()" 
                                oncelldblclick = "Popup()"
                                /> 
                                />
  	                </td>
                </tr>
            </table>
            <table id="idRes" align = top  width="100%" style="height:40%" CELLSPACING="0" CELLPADDING="0">
                <tr style="height:5%">
                    <td colspan=3 align = top  width="100%"  >
  		        Response
  	                </td>
                </tr>
                <tr  style="height:30%">
                    <td colspan=3  align = top   width="100%" >
  		            <gw:textarea id="txtaResponse" styles="width:100%;height:96%;font-size:15"/>
  	                </td>
                </tr>
                <tr id="idRes1" style="height:10%;display:none" >
                    <td colspan=3 align = top  width="100%"  >
  		        Response for Cancel
  	                </td>
                </tr>
                <tr id="idRes2" style="height:35%;display:none">
                    <td colspan=3  align = top   width="100%" >
  		            <gw:textarea id="txtaResponse_Cancel" styles="width:100%;height:96%;font-size:15"/>
  	                </td>
                </tr >
                <tr id="idRes3" style="height:10%;display:none">
                    <td align = right  colspan=3 ><gw:icon id="icnSubmit" img="in" text="Submit" onclick="OnSubmit()" /></td>
                </tr>
            </table>
	    </td>
	    <td id="tblDetail" width=50% style="display:none">
        
             <table  width="100%" style="height:100%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="height:5%" width="100%">
                        <td  align=right width="20%">
                           Description &nbsp; </td>
                        <td  width="80%" align=right colspan=3>
                           <gw:textbox id="txtDescription"  text="" 	styles='width:100%;'  />
                        </td>
                    </tr>
                    <tr style="height:5%">
                        <td  align=right >
                           Visiting Place &nbsp; </td>
                        <td   colspan=3 align=right>
                            <gw:textbox id="txtVisiting_Place"  text="" styles='width:100%;'  />
                        </td>
                    </tr>
                    <tr style="height:5%">
                        <td  align=right >
                          Cost Account &nbsp; </td>
                        <td  width="30%"align=right><gw:textbox id="txtCostType"  text="" 	styles='width:100%;'  />
                           
                        </td>
                        <td  align=right width="20%">
                          Cost Center &nbsp; </td>
                        <td  width="30%"align=right>
                           <gw:textbox id="txtCostCenter"  text="" 	styles='width:100%;'  />
                        </td>
                    </tr>
                    <tr style="height:90%">
                        <td colspan=4>
                              <gw:tab id="idTab" >
	                            <table name="Companion" width=100% cellpadding=0 cellspacing=1 border=1 id="tblexp" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                            <table name="Companion" width=100% cellpadding=0 cellspacing=1 border=1 id="Table2" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="91%"  align="center" valign="center">
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=4 style="width:100%" border=1> 
                                                         <gw:grid   
                                                            id="grdCompanion"  
                                                            header="Type|Department|Group|Emp ID|Full Name|Position|Remark|_Emp_Pk|_PK|_Dep_PK|_Grp_PK|_Pos_Type|_App_PK"   
                                                            format="2|0|0|0|0|0|0|0|0|0|0|0|0"  
                                                            aligns="0|0|0|1|0|0|0|0|0|0|0|0|0"  
                                                            defaults="|||||||||||"  
                                                            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                                            widths="1700|2000|2000|1200|2500|1500|2000|0|0|0|0|0|0"  
                                                            styles="width:100%; height:100%"   
                                                            sorting="T"   
                                                            /> 
                                                    </td>

                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table> 
	                            <table name="Schedule" width=100% cellpadding=0 cellspacing=1 border=1 id="Table3" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                             <table  width=100% cellpadding=0 cellspacing=1 border=1 id="Table4" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="91%"  align="center" valign="center">
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=4 style="width:100%" border=1> 
                                                         <gw:grid   
                                                                id="grdSchedule"  
                                                                header="From|To|Departure_Co|Departure_Ci|Arrival_Co|Arrival_Ci|Plan|_PK|_App_PK"
			                                                    format="4|4|0|0|0|0|0|0|0"
			                                                    aligns="1|1|0|0|0|0|0|0|0"
			                                                    defaults="|||||||||"
			                                                    editcol="0|0|0|0|0|0|0|0|0"
			                                                    widths="1500|1500|2000|2000|2000|2000|1500|0|0"
			                                                    styles="width:100%;height:100%"
			                                                    sorting="F"
			                                                    onafteredit=""
			                                                    oncellclick = ""
			                                                    acceptNullDate="T"
			                                                    oncelldblclick = ""/>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table> 
                                <table name="Transportation Expenses" width=100% cellpadding=0 cellspacing=1 border=1 id="Table5" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                             <table  width=100% cellpadding=0 cellspacing=1 border=1 id="Table6" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="41%" style="border:0;"  align="right" valign="center">Sum= &nbsp;
                                                    </td>
                                                    <td width="49%" style="border:0;"  align="left" valign="center"><gw:textbox format="#,###,###,###.##" type="number" id="txtTrans_Sum"  text="" 	styles='width:60%;'  />
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=5 style="width:100%" border=1> 
                                                         <gw:grid   
                                                                id="grdTrans_Exp"  
                                                                header="Departure|Arrival|Transportation by|Amount|Currency|Remark|_PK|_App_PK"
		                                                        format="0|0|2|0|0|0|0|0"
			                                                    aligns="0|0|0|3|1|0|1|0"
			                                                    defaults="||||||||"
			                                                    editcol="0|0|0|0|0|0|0|0"
			                                                    widths="2000|2000|2000|1500|1000|1300|2500|0"
			                                                    styles="width:100%;height:100%"
			                                                    sorting="F"
			                                                    onafteredit="CheckCurrency(grdTrans_Exp,3)"
			                                                    oncellclick = ""
			                                                    onKeyPressEdit    = "on_edit_before(grdTrans_Exp)"
			                                                    acceptNullDate="T"
			                                                    oncelldblclick = ""/>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table> 
                                <table name="Other Expenses" width=100% cellpadding=0 cellspacing=1 border=1 id="Table7" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                             <table  width=100% cellpadding=0 cellspacing=1 border=1 id="Table8" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="41%" style="border:0;"  align="right" valign="center">Sum= &nbsp; 
                                                    </td>
                                                    <td width="49%" style="border:0;"  align="left" valign="center"><gw:textbox format="#,###,###,###.##" type="number" id="txtOther_Sum"  text="0"  styles='width:60%;'  />
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                    </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                      </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=5 style="width:100%" border=1> 
                                                         <gw:grid   
                                                                id="grdOther_Exp"  
                                                                header="Type|Description|Amount|Currency|Remark|_PK|_App_PK"
		                                                        format="2|0|1|0|0|0|0"
			                                                    aligns="0|0|3|1|0|1|0"
			                                                    defaults="|||||||"
			                                                    editcol="0|0|0|0|0|0|0"
			                                                    widths="2000|2500|2000|1500|1000|2500|0"
			                                                    styles="width:100%;height:100%"
			                                                    sorting="F"
			                                                    onafteredit="CheckCurrency(grdOther_Exp,2)"
			                                                    oncellclick = ""
			                                                    onKeyPressEdit    = "on_edit_before(grdOther_Exp)"
			                                                    acceptNullDate="T"
			                                                    oncelldblclick = ""/>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table>
                                <table name="Settle Trans" width=100% cellpadding=0 cellspacing=1 border=1 id="Table14" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                             <table  width=100% cellpadding=0 cellspacing=1 border=1 id="Table15" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="41%" style="border:0;"  align="right" valign="center">Sum= &nbsp; 
                                                    </td>
                                                    <td width="49%" style="border:0;"  align="left" valign="center"><gw:textbox format="#,###,###,###.##" type="number" id="txtSettle_Trans_Sum"  text="0"  styles='width:60%;'  />
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                    </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                      </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=5 style="width:100%" border=1> 
                                                         <gw:grid   
                                                                id="grdSettle_Trans"  
                                                                header="_PK|_SETTLE_PK|Departure|Arrival|Transportation|Applied Amt|Currency|Actual Amt|Currency|Reason|Remark|_Biz_trans_pk"   
                                                                format="0|0|0|0|0|1|0|1|0|0|0|0"  
                                                                aligns="0|0|0|0|0|0|0|0|0|0|0|0"    
                                                                defaults="|||||||||||"    
                                                                editcol="0|0|1|1|1|0|0|1|1|1|1|0"  
                                                                widths="0|0|2000|2000|1500|1500|1000|1500|1000|3000|2000|0"  
                                                                styles="width:100%;height:100%"
			                                                    sorting="F"
			                                                    onafteredit="CheckCurrency(grdOther_Exp,2)"
			                                                    oncellclick = ""
			                                                    onKeyPressEdit    = "on_edit_before(grdOther_Exp)"
			                                                    acceptNullDate="T"
			                                                    oncelldblclick = ""/>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table>
                                <table name="Settle Other" width=100% cellpadding=0 cellspacing=1 border=1 id="Table12" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                             <table  width=100% cellpadding=0 cellspacing=1 border=1 id="Table13" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="41%" style="border:0;"  align="right" valign="center">Sum= &nbsp; 
                                                    </td>
                                                    <td width="49%" style="border:0;"  align="left" valign="center"><gw:textbox format="#,###,###,###.##" type="number" id="txtSettle_Other_Sum"  text="0"  styles='width:60%;'  />
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                    </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                      </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=5 style="width:100%" border=1> 
                                                         <gw:grid   
                                                                id="grdSettle_Other"  
                                                                header="_PK|_SETTLE_PK|Type|Description|Amount|Currency|Actual Amt|Currency|Reason|_biz_other_pk"   
                                                                format="0|0|0|0|1|0|1|0|0|0"  
                                                                aligns="0|0|0|0|0|0|0|0"    
                                                                defaults="|||||||"    
                                                                editcol="0|0|1|1|0|0|1|1|1|0"  
                                                                widths="0|0|1500|2500|1500|1500|1500|1500|3000|0"  
                                                                styles="width:100%;height:100%"
			                                                    sorting="F"
			                                                    onafteredit="CheckCurrency(grdOther_Exp,2)"
			                                                    oncellclick = ""
			                                                    onKeyPressEdit    = "on_edit_before(grdOther_Exp)"
			                                                    acceptNullDate="T"
			                                                    oncelldblclick = ""/>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table>
                                <table name="Meal" width=100% cellpadding=0 cellspacing=1 border=1 id="Table1" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                             <table  width=100% cellpadding=0 cellspacing=1 border=1 id="Table9" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="41%" style="border:0;"  align="right" valign="center">Sum= &nbsp; 
                                                    </td>
                                                    <td width="49%" style="border:0;"  align="left" valign="center"><gw:textbox format="#,###,###,###.##" type="number" id="txtSettle_Meal_Sum"  text="0"  styles='width:60%;'  />
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                    </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                      </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=5 style="width:100%" border=1> 
                                                         <gw:grid   
                                                                id="grdMeal"  
                                                                header="_PK|_SETTLE_PK|From|To|Amount|Currency|Remark"   
                                                                format="0|0|4|4|1|0|0"  
                                                                aligns="0|0|0|0|0|0|0"    
                                                                defaults="||||||"    
                                                                editcol="0|0|1|1|1|1|1"  
                                                                widths="0|0|1500|1500|1500|1200|5000"  
                                                                styles="width:100%;height:100%"
			                                                    sorting="F"
			                                                    onafteredit="CheckCurrency(grdOther_Exp,2)"
			                                                    oncellclick = ""
			                                                    onKeyPressEdit    = "on_edit_before(grdOther_Exp)"
			                                                    acceptNullDate="T"
			                                                    oncelldblclick = ""/>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table>  
                                <table name="Lodging" width=100% cellpadding=0 cellspacing=1 border=1 id="Table10" style="height:100%" >
                                    <tr style="width:100%;height:5%" valign="top"  >
                                        <td>
                                             <table  width=100% cellpadding=0 cellspacing=1 border=1 id="Table11" style="height:100%" >
                                                <tr style="width:100%;height:5%" valign="top"  >
                                                    <td width="41%" style="border:0;"  align="right" valign="center">Sum= &nbsp; 
                                                    </td>
                                                    <td width="49%" style="border:0;"  align="left" valign="center"><gw:textbox format="#,###,###,###.##" type="number" id="txtSettle_Lodging_Sum"  text="0"  styles='width:60%;'  />
                                                    </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                    </td>
                                                     <td width="3%" style="border:0;" align="right" >
                                                     </td>
                                                    <td width="3%" style="border:0;" align="right" >
                                                      </td>
                                                </tr>
                                                <tr style=";width:100%;height:90%" valign="top">
                                                    <td colspan=5 style="width:100%" border=1> 
                                                         <gw:grid   
                                                                id="grdLodging"  
                                                                header="_PK|_SETTLE_PK|From|To|Country|City|Name|Amount|Currency|Remark"   
                                                                format="0|0|4|4|0|0|0|1|0|0"  
                                                                aligns="0|0|0|0|0|0|0|0|0|0"    
                                                                defaults="|||||||||"    
                                                                editcol="0|0|1|1|1|1|1|1|1|1"  
                                                                widths="0|0|2500|1500|1500|1500|1500|3000|1500|2500"  
                                                                styles="width:100%;height:100%"
			                                                    sorting="F"
			                                                    onafteredit="CheckCurrency(grdOther_Exp,2)"
			                                                    oncellclick = ""
			                                                    onKeyPressEdit    = "on_edit_before(grdOther_Exp)"
			                                                    acceptNullDate="T"
			                                                    oncelldblclick = ""/>
                                                    </td>
                                                </tr>
                                            </table> 
                                        </td>
                                    </tr>
                                </table>  
	                        </gw:tab>
                        </td>
                    </tr>
                </table>
	    </td>
    </tr>
    
</table>
<gw:textbox id="txtEmp_PK" styles="display:none"/>
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
    <gw:textbox id="txtApp_No_Tmp" text="0" styles="display:none"/>
    
</body>
</html>

				
