<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser("hr")%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn; //return data of common code popup to check whether you change data of common code.
var strdata; //data of common code popup
var user;
var obj_list_code; //temp list of common code list
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
    grdTrain.GetGridControl().FrozenCols =5;
    grdTrain_old.GetGridControl().FrozenCols =5;
    if (v_language!="ENG")
        System.Translate(document);
    var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0170' order by code ")%>";
       grdTrain.SetComboFormat(g1_train_type ,t1);
        t1 = "<%=ESysLib.SetGridColumnDataSQL("select 'Y','Yes' from dual union all select 'N','No' from dual  union all select '',' ' from dual ")%>";
           grdTrain.SetComboFormat(g1_pass_yn,t1);

   
   ibtnDelete.SetEnable(false);
   ibtnSave.SetEnable(false);
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";
   user="<%=session("USER_ID")%>";
   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
}
//----------------------------------
function OnShowPopup(strtemp,objlist)
{
    if(strtemp==1)
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
    else
    {
        var strcom;
        obj_list_code=objlist;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_com_code.aspx?code=" +  strtemp ;
        var strid = strtemp;
        
	    var obj  = System.OpenModal(  fpath , 800 , 600 , 'resizable:yes;status:yes');
	    if (obj!=null)
	    {
	        strcodereturn=obj[1];
	        txtComCodeID.text= strtemp;
	       // alert(strcodereturn);
	        if (obj[0]==1 )  //modify common code
	            datGetNewCode.Call("SELECT");
	        
	        else if (strcodereturn!=0)
	        {
	            
                obj_list_code.value=strcodereturn;
	        }
	        
	    }
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
       grdTrain.SetCellBgColor(1,g1_train_type,grdTrain.rows -1 ,g1_description,0xFFEEFF);
       for(var i=1; i<grdTrain.rows ;i++)
       {
            if(grdTrain.GetGridData(i, g1_times) != "0")
            {
                grdTrain.SetCellBgColor(i,g1_times,i ,g1_times,0x3366FF);
            }
       }
       
       if (grdTrain.rows>1)
       {
           
           ibtnDelete.SetEnable(true);
           ibtnSave.SetEnable(true);
       }
       else
       {
           
           ibtnDelete.SetEnable(false);
           ibtnSave.SetEnable(false);
       }   
       
   }
   else if (obj.id=="datTrain_old")
   {
        if(grdTrain_old.rows >= 2)
        {
            auto_resize_column(grdTrain_old,0,grdTrain_old.cols-1,10);
            grdTrain_old.SetCellBgColor(1,g2_times,grdTrain_old.rows -1 ,g2_times,0x3366FF);
        }
   }
   else if (obj.id=="datFind_Report")
   {
        var url =System.RootURL + '/reports/ch/ae/' + txtReport_tmp.text + '?p_user=' + user + '&dis_pk=' + dis_pk;
        window.open(url);
   }
   else if (obj.id=="datGetNewCode")
   {
         var strcom;
         var ctllist;
        if (obj_list_code.value!="")
            strcom=obj_list_code.value;
        obj_list_code.SetDataText(txtCodeTemp.text);
        if (strcodereturn!=0)
            obj_list_code.value=strcodereturn;
        else
            obj_list_code.value=strcom;
        
        
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
            if(lstHaveTrain.value !="Y")
            {
                alert("You have choose have train is Yes.\nBạn phải chọn have train là Yes.");
                return ;
            }
            else
            {
                url=url + '/reports/ch/kr/rpt_internal_training_summary.aspx?p_tco_org_pk=' + lstOrg_Code.value + '&p_wg_pk=' + lstWorkGroup.value + '&p_position=' + lstPosition.value + '&p_nation=' + lstNation.value ;
                url=url + '&p_status=' + lstStatus.value + '&p_from_join_dt=' +dtFrom_JoinDate.value + '&p_to_join_dt=' + dtTo_JoinDate.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text ;
                url=url + '&p_train_type=' + lstTrainType.value  +'&p_from_start_dt=' + dtFromStart.value  + '&p_to_start_dt=' + dtToStart.value  +'&p_have_train=' + lstHaveTrain.value   ;
                url=url + '&p_from_end_dt=' + dtFromEnd.value  + '&p_to_end_dt=' + dtToEnd.value  ;
            }
        }
        else if(obj==2)   
        {   
            if(lstHaveTrain.value !="Y")
            {
                alert("You have choose have train is Yes.\nBạn phải chọn have train là Yes.");
                return ;
            }
            else
            {
               url=url + '/reports/ch/kr/rpt_internal_training_detail.aspx?p_tco_org_pk=' + lstOrg_Code.value + '&p_wg_pk=' + lstWorkGroup.value + '&p_position=' + lstPosition.value + '&p_nation=' + lstNation.value ;
                    url=url + '&p_status=' + lstStatus.value + '&p_from_join_dt=' +dtFrom_JoinDate.value + '&p_to_join_dt=' + dtTo_JoinDate.value + '&p_search_by=' + lstTemp.value + '&p_search_temp=' + txtTemp.text ;
                    url=url + '&p_train_type=' + lstTrainType.value  +'&p_from_start_dt=' + dtFromStart.value  + '&p_to_start_dt=' + dtToStart.value  +'&p_have_train=' + lstHaveTrain.value   ;
                    url=url + '&p_from_end_dt=' + dtFromEnd.value  + '&p_to_end_dt=' + dtToEnd.value  ;
            }
        }
        else if(obj==3)
        {
             
           
        }
    window.open(url); 
}
//-----------------------------------------------
function OnSave()
{
    if (confirm("Do you want to save?"))
       datTrain.Call();
}

//------------------------------------------
function OnDelete()
{
    if(confirm("Do you want to delete?"))
    {
       grdTrain.DeleteRow();
       ibtnDelete.SetEnable(false);
    }
}

//------------------------------------------
function CheckButton()
{
    var ctrl 	= grdTrain.GetGridControl();
    var rownum 	= ctrl.Row;
    var rownums 	= ctrl.Rows;
    
    if(rownum > 0 && rownums>1)
    {
        if(grdTrain.GetRowStatus(rownum) >= 64)
        {
            ibtnDelete.SetEnable(false);
        }
        else
        {
            ibtnDelete.SetEnable(true);
            ibtnUnDelete.SetEnable(false);
        }
    }
    
    if(ctrl.col == G1_Create)
    {
        if(grdTrain.GetGridData(ctrl.row,G1_Create)=="-1")
        {
            grdTrain.SetGridText(ctrl.row,G1_Date,"");
            grdTrain.SetGridText(ctrl.row,G1_Period,"");
            grdTrain.SetGridText(ctrl.row,G1_Start_Dt,"");
            grdTrain.SetGridText(ctrl.row,G1_End_Dt,"");
            grdTrain.SetGridText(ctrl.row,G1_Reason,"");
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
			imgMaster.alt="Show old Training";
			
        }
        else
        {
            imgMaster.status = "expand";
            tblDetail.style.display="";
            tblDetail.style.height="30%";
            tblMaster.style.height="70%";
            imgMaster.src = "../../../system/images/close_popup.gif";
			imgMaster.alt="Close old Training";
			OnShowOld();
			
        }
  
}
//------------------------------------------
function OnShowOld()
{
    if (imgMaster.status=="expand")
    {
        var irow=grdTrain.row;
        if (irow>=1)
        {
            txtEmp_PK.text=grdTrain.GetGridData(irow,g1_pk);
            txtTimes.text = grdTrain.GetGridData(irow,g1_times);
            datTrain_old.Call("SELECT");
        }
        else
        {
            //datTrain_old.ClearData();
        }
    }
}
//----------------------------------------------
function OnChangeSetBy()
{
    OnResetList();
    if(lstSetBy.value =="1" || lstSetBy.value == "8") //Y/N
    {
        td1.style.display ="block" ; // show
        td2.style.display="none" ;   // not show    
        td3.style.display="none" ;
        td4.style.display="none" ;
    }
    else if(lstSetBy.value == "2") // train Type
    {
        td2.style.display ="block" ; // show
        td1.style.display="none" ;   // not show    
        td3.style.display="none" ;
        td4.style.display="none" ;
    }
    else if(lstSetBy.value == "3" || lstSetBy.value == "6" || lstSetBy.value == "7") // text
    {
        td3.style.display ="block" ; // show
        td1.style.display="none" ;   // not show    
        td2.style.display="none" ;
        td4.style.display="none" ;
    }
    else if(lstSetBy.value == "4" || lstSetBy.value == "5") // Date
    {
        td4.style.display ="block" ; // show
        td1.style.display="none" ;   // not show    
        td2.style.display="none" ;
        td3.style.display="none" ;
    }
}
function OnResetList()
{
    lstValueYN.value=="";
    lstValueTrainType.value ="";
    txtValue.text = "";
    dtValue.value ="";
}
function OnSetGrid()
{
    if(lstSetBy.value =="" )
    {
        alert("Please choose value to set\nBạn phải chọn giá trị để set.");
        return;
    }
    else 
    {
        var ctrl=grdTrain.GetGridControl();
        for(var i=1;i<=ctrl.SelectedRows;i++)
        {
            if(lstSetBy.value == "1") //create new
            {   
                var value;
                if(lstValueYN.value == "Y")
                {
                    value ="-1";
                    grdTrain.SetGridText(ctrl.SelectedRow(i-1),g1_create_new ,value );
                   
                }
                else if(lstValueYN.value == "N")
                {
                    value = "0";

                    grdTrain.SetGridText(ctrl.SelectedRow(i-1),g1_create_new ,value );
                }
                
            }
            else if(lstSetBy.value =="2") //Train Type
            {
                grdTrain.SetGridText(ctrl.SelectedRow(i-1),g1_train_type ,lstValueTrainType.value );
            }
            else if(lstSetBy.value =="3") //Train Name
            {
                grdTrain.SetGridText(ctrl.SelectedRow(i-1),g1_train_name ,txtValue.text );
            }
            else if(lstSetBy.value =="4") //Start Date
            {
                grdTrain.SetGridText(ctrl.SelectedRow(i-1),g1_start_dt ,dtValue.value );
            }
            else if(lstSetBy.value =="5" ) //End Date
            {
                
                grdTrain.SetGridText(ctrl.SelectedRow(i-1),g1_end_dt ,dtValue.value );
            }
            else if(lstSetBy.value =="6") //Location
            {
                    grdTrain.SetGridText(ctrl.SelectedRow(i-1),g1_location ,txtValue.text );
            }
            else if(lstSetBy.value =="7") //Institude
            {
                grdTrain.SetGridText(ctrl.SelectedRow(i-1),g1_institude ,txtValue.text );
            }
            else if(lstSetBy.value =="8") //Pass YN
            {
                grdTrain.SetGridText(ctrl.SelectedRow(i-1),g1_pass_yn ,lstValueYN.value );
            }
            
        }
        
    }
}
function ResetField()
{
    if(grdTrain.col == g1_create_new && grdTrain.GetGridData(grdTrain.row, g1_create_new)=="-1")
    {
        for(var i = g1_train_type ; i<g1_times; i++)
            grdTrain.SetGridText(grdTrain.row, i, "");
    }
}

</script>
<body >
<!-------------------data control----------------------->
<!-------------------------------------------->
<gw:data id="datGetNewCode" onreceive="OnDataReceive(this)"> 
    <xml> 
        <dso type="list" procedure="hr.sp_list_new_code" > 
            <input> 
                <input bind="txtComCodeID" />
            </input>
	       <output>
	            <output bind="txtCodeTemp" /> 
	       </output>
        </dso> 
    </xml> 
</gw:data>
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
            <dso  type="grid"  parameter="1,8,9,10,11,12,13,14,15,16,17,18" function="HR.SP_SEL_INTER_TRAIN" procedure="HR.SP_UPD_INTER_TRAIN"> 
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
                    <input bind="lstTrainType" />
					<input bind="dtFromStart" />
                    <input bind="dtToStart" />
                    <input bind="lstHaveTrain" />
                    <input bind="dtFromEnd" />
                    <input bind="dtToEnd" />
                </input>
                <output  bind="grdTrain" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
<gw:data id="datTrain_old" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  function="HR.SP_SEL_INTER_TRAIN_OLD" > 
                <input bind="grdTrain" >
                    <input bind="txtEmp_PK" /> 
                    <input bind="txtTimes" />
                </input>
                <output  bind="grdTrain_old" />
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
                         <gw:imgBtn img="save" id="ibtnSave"    alt="Save"  onclick="OnSave()"/>
                        </td>
                        <td colspan="1" style="border:0;" align="right" >
                            <gw:imgBtn img="delete" id="ibtnDelete"    alt="Delete"  onclick="OnDelete()"/>
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
                        
                         <td colspan="5" scolspan="5" tyle="border:0;" align="right" ><a title="Click here to show Train Type" onclick="OnShowPopup('HR0170',lstTrainType)" href="#tips" >
                         Train Type</a></td>
				        <td  colspan="10" style="border:0;">
                            <gw:list  id="lstTrainType" value='ALL' maxlen = "100" styles='width:100%' >
                           <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0170' order by code_nm")%>|ALL|Select All
                            </data></gw:list>
                        </td>
                        <td  colspan="5" style="border:0;" align="right">Start Date</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtFromStart" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  colspan="1" style="border:0;" align="center">~</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtToStart" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=2 style="border:0" align="right"></td>
                        <td colspan="1" style="border:0" align="right">                           
                           
                        </td>
                        <td colspan="1" style="border:0" align="right">
                            
                        </td>
                        <td>
                            
                        </td>
                        <td align="right" style="border:0" valign="bottom"></td>
                        
                    </tr>
                    
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td colspan="1" style="border:0" align="right" valign="middle">
                        
                        </td>
						<td colspan="4" align="right"><font color="FF3399">Set by</td>
					    <td colspan="5" style="border:0">
					        <gw:list  id="lstSetBy" value="0" styles='width:100%' onchange="OnChangeSetBy()"> 
							        <data>LIST|1|Create New|2|Train Type|3|Train Name|4|Start Date|5|End Date|6|Location|7|Institude|8|Pass Y/N|0|</data> 
					        </gw:list>
				        </td>
                        <td id="td1" colspan=5  style="border:0"> 
					        <gw:list  id="lstValueYN" value=" " styles='width:100%' onchange=""> 
							        <data>LIST|Y|Yes|N|No||</data> 
					        </gw:list>
				        </td>
                        <td id="td2" colspan=5  style="border:0;display:none"> 
					        <gw:list  id="lstValueTrainType" value="" styles='width:100%' onchange=""> 
							<data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0170' order by code_nm")%>|ALL|Select All
                            </data> 
					        </gw:list>
				        </td>
                        <td id="td3" colspan=5  style="border:0;display:none"> 
					        <gw:textbox id="txtValue" onenterkey   ="" styles='width:100%'/>
				        </td>
                        <td id="td4" colspan=5  style="border:0;display:none"> 
					        <gw:datebox id="dtValue" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" />
				        </td>

                        <td colspan="2" tyle="border:0;" align="left" ><gw:imgBtn id="ibtnSet" alt="Set Grid" img="set" text="Set Grid" onclick="OnSetGrid()" /></td>
                         <td colspan="3" tyle="border:0;" align="right" >Have Train</td>
                        
						<td colspan="10">
                            <gw:list  id="lstHaveTrain" value="ALL" styles='width:100%' onchange=""> 
							        <data>LIST|Y|Yes|N|No|ALL|Select All</data> 
					        </gw:list>
                        </td>
                        <td  colspan="5" style="border:0;" align="right">End Date</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtFromEnd" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  colspan="1" style="border:0;" align="center">~</td>
				        <td  colspan="4" style="border:0;"><gw:datebox id="dtToEnd" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=2 style="border:0" align="right"></td>
                        <td colspan="1" style="border:0" align="right">                           
                           <gw:imgBtn img="excel" id="ibtnReport1"    alt="Report Internal Training"  onclick="OnReport(1)"/>
                        </td>
                        <td colspan="1" style="border:0" align="right">
                            <gw:imgBtn img="excel" id="ibtnReport2"    alt="Report Discipline Summary"  onclick="OnReport(2)"/>
                        </td>
                        <td>
                            
                        </td>
                        <td align="right" style="border:0" valign="bottom"><img status="collapse" id="imgMaster" alt="Show old Training" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle()"  /></td>
                        
                    </tr>
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=50 style="width:100%;height:100%;"> 
                            <table width="100%" id="tblMaster" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%;height:100%" valign="top">
                                    <td>
                                     <gw:grid   
                                        id="grdTrain"  
                                        header="_Select|_PK|Organization|Emp ID|Full Name|Work Group|Position|Join Date|Create New|Train Type|Train Name|Start Date|End Date|Location|Institude|Pass Y/N|Description|Times|_TRAIN_PK"   
                                        format="3|0|0|0|0|0|0|0|3|2|0|4|4|2|0|0|2|0|0"  
                                        aligns="0|0|0|0|0|0|0|0|1|0|0|1|1|0|0|1|0|1|0"  
                                        defaults="||||||||||||||||||"  
                                        editcol="1|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|0|0"  
                                        widths="700|0|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
                                        styles="width:100%; height:100%" 
								        acceptNullDate="T"
                                        sorting="T"    oncellclick="OnShowOld()" 
                                        onafteredit="ResetField()"
                                        /> 
                                     </td>
                                 </tr>
                             </table>
                             <table width="100%" id="tblDetail" style="height:30%;display:none" border=1 cellpadding="0" cellspacing="0">
                                <tr style="border:1;width:100%" valign="top">
                                    <td > 
                                         <gw:grid   
                                         id="grdTrain_old"  
                                        header="_Select|_PK|Organization|Emp ID|Full Name|Work Group|Position|Join Date|_Create New|Train Type|Train Name|Start Date|End Date|Location|Institude|Pass Y/N|Description|Times|_TRAIN_PK"   
                                        format="3|0|0|0|0|0|0|0|3|2|0|4|4|2|0|0|2|0|0"  
                                        aligns="0|0|0|0|0|0|0|0|1|0|0|1|1|0|0|1|0|1|0"  
                                        defaults="||||||||||||||||||"  
                                        editcol="1|0|0|0|0|0|0|0|1|1|1|1|1|1|1|1|1|0|0"  
                                        widths="700|0|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
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
<gw:textbox id="txtComCodeID" styles="display:none"/>	
 <gw:textbox id="txtCodeTemp" styles="display:none" />
</html>
