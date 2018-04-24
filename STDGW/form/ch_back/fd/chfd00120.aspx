<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser("hr")%>
<head runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var irow,icol;
var binit=true;
function BodyInit()
{ 	
    grdEmployee.GetGridControl().ScrollTrack=true;
    grdEmployee.GetGridControl().FrozenCols =4;
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
    SetGridHeader(grdSchedule);
    grdTrans_Exp.GetGridControl().ColFormat(3) = "(###,###,###.##)";   
    grdOther_Exp.GetGridControl().ColFormat(2) = "(###,###,###.##)"; 
    grdEmployee.GetGridControl().ColFormat(8) = "(###,###,###.##)"; 
    <%=ESysLib.SetGridColumnComboFormat("grdCompanion",0,"select code,CODE_NM from vhr_hr_code where id='HR0061' order by code_nm") %>
    <%=ESysLib.SetGridColumnComboFormat("grdOther_Exp",0,"select code,CODE_NM from vhr_hr_code where id='HR0062' order by code_nm") %>
    <%=ESysLib.SetGridColumnComboFormat("grdTrans_Exp",2,"select code,CODE_NM from vhr_hr_code where id='HR0063' order by code_nm") %>   
    <%=ESysLib.SetGridColumnComboFormat("grdTrans_Exp",4,"select code,CODE_NM from vhr_hr_code where id='HR0040' order by code_nm") %>   
    <%=ESysLib.SetGridColumnComboFormat("grdOther_Exp",3,"select code,CODE_NM from vhr_hr_code where id='HR0040' order by code_nm") %>  
      
	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}

}
function OnSearch()
{
    txtBiz_Trip_PK.text="";
    datApproval_Biz_Trip.Call("SELECT");
}

//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
       if (obj.id=="datUser_info")
       {
            datGroupData.Call();
       } 
       else if (obj.id=="datGroupData")
       {
            lstGroup.SetDataText(txtGroupData.text);
               
            var obj=lstGroup.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj.options.selectedIndex=obj.options.length-1;
       }
	   else if (obj.id=="datApproval_Biz_Trip")
	   {
	        lblRecord.text=grdEmployee.rows-1 + " record(s)";
	        grdEmployee.SetCellBgColor(1,10,grdEmployee.rows -1 ,10,0xCC99FF);
	    }
	    else if (obj.id=="datProApproval")
	    {
	        if (txtResult.text=="1")
	        {
	            alert("This action is sucessful!");
    	        grdEmployee.SetGridText(irow,13,txtaResponse.GetData());
	            grdEmployee.SetGridText(irow,10,txtStatus.text);
	        }
	        else
	            alert("This action is failed!");
	    }
	    else if (obj.id=="datBiz_Trip_Detail")
	        datCompanion.Call("SELECT");
	    else if (obj.id=="datCompanion")
	        datSchedule.Call("SELECT");
	    else if (obj.id=="datSchedule")
	    {
	        SetGridHeader(grdSchedule);
	        datTrans_Exp.Call("SELECT");      
	        
	    }
	    else if (obj.id=="datTrans_Exp")
	        datOther_Exp.Call("SELECT");           
	    
}     
//------------------------------------------------------------------------------------
function OnChangeDept()
{
    //txtDept.text=lstDept_Code.value;
    datGroupData.Call();
}
//-----------------------------------------------------------
function OnSelect()
{
    irow=event.row;
    icol=event.col;
    if (irow>1)
    {
    
        txtBiz_Trip_PK.text=grdEmployee.GetGridData(irow,12);
        txtaResponse.SetDataText(grdEmployee.GetGridData(irow,13));
        if (imgArrow.status == "expand")
        {
            datBiz_Trip_Detail.Call();
        }
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
    if (txtBiz_Trip_PK.text!="")
    {
        txtAction.text=objaction;
        if (confirm("Do you want to " + saction + " this applicant"))
            datProApproval.Call();
    }
    else
        alert("Please select employee \n Vui lòng chọn nhân viên");
}
//-------------------------------------
function SetGridHeader(obj)
{
    var stt;
    var fg=obj.GetGridControl(); 
    if (binit==true)
        fg.rows=fg.rows+1;
    fg.FixedRows = 2;
    fg.FixCols=1;
    fg.MergeCells =5 ;
    stt=0;//num column
    fg.MergeCol(stt) =true ;
    fg.Cell(0, 0, stt, 1, stt) = "From"; //fg.Cell(0,row, from_col, row, to_col) 
    fg.MergeCol(stt+1) =true ;
    fg.Cell(0, 0, stt+1, 1, stt+1) = "To"; 
    fg.MergeRow(0) =true ;
    fg.Cell(0, 0, 2, 0, 3) = "Departure";
    fg.Cell(0, 1, 2, 1, 2) = "Country";
    fg.Cell(0, 1, 3, 1, 3) = "City";
    fg.Cell(0, 0, 4, 0, 5) = "Arrival";
    fg.Cell(0, 1, 4, 1, 4) = "Country";
    fg.Cell(0, 1, 5, 1, 5) = "City";
    fg.MergeCol(6) =true ;
    fg.Cell(0, 0,6, 1, 6) = "Plan"; 
    obj.SetCellBold(1,0,1,6,true);
    binit=false
}
//------------------------------------------------
function OnToggle()
{
    
    if(imgArrow.status == "expand")
    {
        tblDetail.style.display="none";
        imgArrow.status = "collapse";
        imgArrow.alt="Show Detail";
        imgArrow.src = "../../../system/images/iconmaximize.gif";
        tblMaster.style.width="100%";
        tblDetail.style.width="0%";
    }
    else
    {
        tblDetail.style.display="";
        imgArrow.status = "expand";
        imgArrow.alt="Close Detail";
        imgArrow.src = "../../../system/images/close_popup.gif";
        tblMaster.style.width="50%";
        tblDetail.style.width="50%";
        if (txtBiz_Trip_PK.text!="")
        {
            datBiz_Trip_Detail.Call();
        }
    }
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
<!--------------------------------------------->
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
<!--------------------------------------------->
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                    <input bind="lstDept" /> 
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datProApproval" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_approval" > 
                <input>                    
                   <input bind="txtBiz_Trip_PK" />
                   <input bind="txtaResponse" />
                   <input bind="txtAction" />
                </input> 
                <output>    
                    <output bind="txtStatus" />
                    <output bind="txtResult" />
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
                <input bind="chkTemp1" /> 
                <input bind="txtTemp1" />  
            </input> 
            <output bind="grdEmployee" /> 
        </dso> 
   </xml> 
</gw:data> 
<!----------------------------------->
<gw:data id="datBiz_Trip_Detail" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_Biz_Trip_Detail" > 
                <input>
                    <input bind="txtBiz_Trip_PK" />
                </input>
                <output>
                    <output bind="txtDescription" />
                    <output bind="txtVisiting_Place" />
                    <output bind="txtCostCenter" />
                    <output bind="txtCostType" />
                    <output bind="txtTrans_Sum" />
                    <output bind="txtOther_Sum" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datCompanion" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_biz_companion" > 
                <input>
                    <input bind="txtBiz_Trip_PK" />
                </input>
                <output  bind="grdCompanion" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datSchedule" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_biz_schedule" > 
                <input>
                    <input bind="txtBiz_Trip_PK" />
                </input>
                <output  bind="grdSchedule" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datTrans_Exp" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_biz_Trans_Exp" > 
                <input>
                    <input bind="txtBiz_Trip_PK" />
                </input>
                <output  bind="grdTrans_Exp" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datOther_Exp" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr.sp_sel_biz_Other_Exp" > 
                <input>
                    <input bind="txtBiz_Trip_PK" />
                </input>
                <output  bind="grdOther_Exp" />
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
						        <td width="14%" align="right"><font color="black"><b >Department &nbsp;</b></td>
						        <td width="15%" colspan=2 ><gw:list id="lstDept" styles="color:black;width:100%" value="ALL" onchange="OnChangeDept()"> 
	                                           <data><%=ESysLib.SetListDataSQL("SELECT PK,DEPT_NM FROM comm.TCO_DEPT WHERE DEL_IF = 0 order by DEPT_ID, DEPT_NM")%>|ALL|Select All</data>
	                                           </gw:list > 
						        </td>
						        <td width="10%" align="right"><font color="black"><b >Group &nbsp;</b></td>
						        <td width="15%" colspan=2><gw:list id="lstGroup" styles="color:black;width:100%" value="ALL" onchange=""> 
	                                            <data><%=Esyslib.SetListDataSQL("SELECT PK,Group_NM FROM Thr_Group WHERE DEL_IF = 0 order by seq, Group_NM" )%>|ALL|Select All</data>
	                                            </gw:list > 
						        </td>
						        <td width="13%" align="right" colspan=2><font color="black"><b>Applicant &nbsp;</b>
						        </td>
						        <td width="10%">
							        <gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data> 
							        </gw:list>
						        </td>
        						
						        <td width="15%" colspan=2> 
							        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
						        <td width="2%" ></td>
						        <td width="3%" align="left">
							        <gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" />
						        </td>
						        <td width="3%" align="right">
							       
						        </td>
					        </tr>
					         <tr>   
						        <td align="right" valign="middle">Summitted Date &nbsp;</td>
						        <td align="left" valign="middle" width="10%"><gw:datebox id="dtFromSumDt"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="center" width="5%"><font color="black"><b >~</b></td>
						        <td align="left" valign="middle" ><gw:datebox id="dtToSumDt"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="right"  width="5%"><font color="black"><b >Period &nbsp;</b></td>
						        <td  align="left" width="10%"><font color="black"><gw:datebox id="dtFrom"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="center" width="3%"><font color="black"><b >~</b></td>
						        <td  align="left" width="10%" ><font color="black"><gw:datebox id="dtTo"  text="" styles='width:100%' lang="<%=Session("Lang")%>" nullaccept /></td>
						        <td  align="right" >Approver</td>
						        <td width="7%" align="left" ><gw:list  id="chkTemp1" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data> 
							        </gw:list></td>
							    <td width="8%" align=right> 
							        <gw:textbox id="txtTemp1" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
						        <td  align="center" colspan=3><i><gw:label id="lblRecord" text="0 record(s)" styles="width:100%" ></gw:label></i></td>
						        <td align="right" > <img status="collapse" id="imgArrow" src="../../../system/images/iconmaximize.gif" alt="Show Detail"  style="cursor:hand" onclick="OnToggle()"  /> </td>
					         </tr>
					        
				        </table>
			        </td>
		        </tr>
		    </table>
	    </td> 
	</tr>		   
	
    <tr align = top style="height:80%" > 
        <td  id="tblMaster"  width=100% >
        
            <table align = top  width="100%" style="height:100%" CELLSPACING="0" CELLPADDING="0">
            <tr align = top style="height:70%"> 
	            <td colspan=3 align = top  width="100%"  >
  		            <gw:grid   
			            id="grdEmployee"  
                            header='Applicant ID|Applicant Name|Department|Group|From|To|Type|Object|Total Expenses|Summitted Time|Status|_Information|_PK|_Response'
                            format='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            aligns='1|0|0|0|1|1|0|0|3|1|0|1|0|0'
                            defaults='|||||||||||||'
                            editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                            widths='1185|2280|1380|1350|1185|1215|1275|1245|1455|1725|1935|1000|0|0'
                            sorting='T'
                            oncellclick ="OnSelect()" 
                            styles='width:100%; height:100%'
                            />
  	            </td>
            </tr>
                <tr style="height:5%">
                    <td colspan=3 align = top  width="100%"  >
  		        Response
  	                </td>
                </tr>
                <tr style="height:20%">
                    <td colspan=3  align = top   width="100%" >
  		            <gw:textarea id="txtaResponse" styles="width:100%;height:96%;font-size:15"/>
  	                </td>
                </tr>
                <tr style="height:5%">
                    <td align = right  width="80%" ><gw:icon id="icnApprove" img="in" text="Approve" onclick="OnApprove(1)" /></td>
                    <td align = center width="10%" ><gw:icon id="icnReject" img="in" text="Reject" onclick="OnApprove(2)" /></td>
                    <td align = right  width="10%" ><gw:icon id="icnRequest" img="in" text="Request Infor" onclick="OnApprove(3)" /></td>
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
                          Cost Center &nbsp; </td>
                        <td  width="30%"align=right>
                           <gw:textbox id="txtCostCenter"  text="" 	styles='width:100%;'  />
                        </td>
                        <td  align=right width="20%">
                          Cost Type &nbsp; </td>
                        <td  width="30%"align=right>
                           <gw:textbox id="txtCostType"  text="" 	styles='width:100%;'  />
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
		                                                        format="0|0|2|0|2|1|0|0"
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
		                                                        format="2|0|1|2|0|0|0"
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
	                        </gw:tab>
                        </td>
                    </tr>
                </table>
	    </td>
    </tr>
    
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="txtBiz_Trip_PK" styles="display:none"/>
    <gw:textbox id="txtStatus" styles="display:none"/>
    <gw:textbox id="txtAction" styles="display:none"/>
    <gw:textbox id="txtResult" text="0" styles="display:none"/>
</body>
</html>

				
