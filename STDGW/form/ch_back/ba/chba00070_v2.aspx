<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var flag=0;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var startTime,interval_time
var report=0;
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";
   idGrid.GetGridControl().FrozenCols =11;
   idGrid.GetGridControl().ScrollTrack=true;
   user= "<%=session("USER_ID")%>";
   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
              {
              datUser_info.Call();   
              }
   datCheck_year.Call();           
    
}
//-------------------------------
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}
//------------------------------
function clock(start,x) 
{
 var d = new Date()
 idInterval.text= Math.round((d.valueOf()-start)/x);

}
//-------------------------------
function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}
//--------------------------------------------------------------------------------
function do_Enable()
{
    idBtnUpdate.SetEnable(1);  
   // idGrid.SetColEdit(4,1);
    //idGrid.SetColEdit(5,1);
     idBtnOpen.SetEnable(0);
     
     idBtnClose.SetEnable(1);
}
//------------------------------------------------------------------------------------
function do_DisEnable()
{
   
    idBtnUpdate.SetEnable(0);   
    if(txtMonthClose.text!='1')
     idBtnOpen.SetEnable(1);
     idBtnClose.SetEnable(0);
}
function action()
{   if(txtMonthClose.text=='1' )
        {idBtnUpdate.SetEnable(0);   
         idBtnClose.SetEnable(0);
         idBtnOpen.SetEnable(0);
        }
     else if(txtCheckYear.text=="1")
        { idBtnUpdate.SetEnable(0);   
          idBtnOpen.SetEnable(1);
          idBtnClose.SetEnable(0);
          }
     if(txtCheckYear.text!="1" && txtMonthClose.text!='1')
     {  idBtnOpen.SetEnable(0);
        idBtnUpdate.SetEnable(1);   
        idBtnClose.SetEnable(1);   
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
//-------------------------------------------------------------------------------
function OnDataReceive(obj)
{if (obj.id=="dat_Check_Option_Kind2")
            {//alert(txtOption.text);
                if(txtOption.text=='10'||txtOption.text=='11')
                      { //idGrid.GetGridControl().ColHidden(11)=1;
                        //idGrid.GetGridControl().ColHidden(12)=1;
                        idGrid2.GetGridControl().ColHidden(13)=1;
                        idGrid2.GetGridControl().ColHidden(12)=1;
                           
                        
                      }
                else if (txtOption.text=='20'||txtOption.text=='21')
                     {   idGrid2.GetGridControl().ColHidden(13)=0;
                         idGrid2.GetGridControl().ColHidden(12)=0;
                     }
                 dat_Annual_year_amt.Call("SELECT");                                    
                }     

                 if (obj.id=="dat_Check_Option_Kind")
                    {//alert(txtOption.text);
                        if(txtOption.text=='10'||txtOption.text=='11')
                             { idGrid.GetGridControl().ColHidden(11)=1;
                                idGrid.GetGridControl().ColHidden(12)=1;
                                //idGrid2.GetGridControl().ColHidden(13)=1;
                                //idGrid2.GetGridControl().ColHidden(12)=1;
                           if(txtOption.text=='11')
                            {   idGrid.GetGridControl().ColHidden(10)=0; 
                            }
                            else
                            {   idGrid.GetGridControl().ColHidden(10)=1;
                             
                            }
                        
                      }
                else if (txtOption.text=='20'||txtOption.text=='21')
                     {   idGrid.GetGridControl().ColHidden(11)=0;
                         idGrid.GetGridControl().ColHidden(12)=0;
                         //idGrid2.GetGridControl().ColHidden(13)=0;
                         //idGrid2.GetGridControl().ColHidden(12)=0;
                        
                           if(txtOption.text=='21')
                            {   idGrid.GetGridControl().ColHidden(12)=0;
                                idGrid.GetGridControl().ColHidden(10)=0;
                            }
                            else
                            {   idGrid.GetGridControl().ColHidden(12)=1;
                                idGrid.GetGridControl().ColHidden(10)=1;
                            }
                     }
                                 
                       
                           if(txtCheckYear.text=="1")
                                dat_Annual_leave_2.Call("SELECT");
                            else
                               dat_Annual_leave_1.Call("SELECT");
                               
                                                
                              
                  }
       if (obj.id=="datDeptData")
       {
            txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            
            switch (tabMain.GetCurrentPageNo())
            {
                case 0:
                {
                    lstOrg_Code.SetDataText(txtDeptData.text);
                    txtDept.text=lstOrg_Code.value;
                    break;
                }
                case 1:
                {
                    lstOrg_Code2.SetDataText(txtDeptData.text);
                    txtDept.text=lstOrg_Code2.value;
                    break;
                }
            }  
            datGroupData.Call();
       }
       else if (obj.id=="datGroupData")
       {
        
            switch (tabMain.GetCurrentPageNo())
            {
                case 0:
                {
                    ChoseList_box(lstWGrp_Code,txtGroupData.text);
                    if(flag==0)
			        {
			            flag=1;
			             
			        }    
                    break;
                }
                case 1:
                {
                    ChoseList_box(lstWGrp_Code2,txtGroupData.text);
                    break;
                }
            }  
               datCheck_year.Call(); 
       }
       else if (obj.id=="datCheck_year")
       {   action();                
         
       }	
       else if ((obj.id=="dat_Annual_leave_1")||(obj.id=="dat_Annual_leave_2"))
       {
            idrecord.text=idGrid.rows-1+" Records found.";  
            auto_resize_column(idGrid,0,idGrid.cols-1,0);  
                
       }	
       else if (obj.id=="dat_Open_Close")
       {
            if(txtResult.text=="1")
            {
                alert(txtFLAG.text+" Successfull.\n"+txtFLAG.text+" Thành công.");
                if(txtFLAG.text=="OPEN")
                {   idBtnUpdate.SetEnable(0);
                    idBtnOpen.SetEnable(0);
                    idBtnClose.SetEnable(1);            
                    txtCheckYear.text="0";
                    do_Enable();
                    dat_Annual_leave_1.Call("SELECT");
                }    
                else    
                {   idBtnUpdate.SetEnable(1);
                    idBtnOpen.SetEnable(1);
                    idBtnClose.SetEnable(0);            
                    txtCheckYear.text="1";
                    //do_DisEnable();
                     dat_Annual_leave_2.Call("SELECT");
                }    
                
            }
            else
                alert("There is error occur.\nCó Lỗi xảy ra");
                
       }
       else if (obj.id=="datUser_info")
       {
            lstOrg_Code.SetDataText(txtdept_temp.text);            
            lstOrg_Code2.SetDataText(txtdept_temp.text);
            txtDept.text=lstOrg_Code.value;
            datGroupData.Call();
           
       }
       else if (obj.id=="datFind_Report")
       {
            
        var sql;
          if (report=='0')
          {  
            if(txtCheckYear.text=="1")
                sql=2;
             else 
                sql=1;        
                    var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_tco_org_pk=' + lstOrg_Code.value + '&p_thr_group_pk=' + lstWGrp_Code.value + '&p_status=' + lstStatus.value + '&p_lday=' + idLeaveDays.value + '&p_ale=' + id_Ale.text +  '&p_month=' + idMonth.value + '&p_search=' + idSearch.value + '&p_input=' + id_Input.text + '&sql=' + sql;
                    window.open(url);
           }
              else
          {var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_tco_org_pk=' + lstOrg_Code2.value + '&p_thr_group_pk=' + lstWGrp_Code2.value + '&p_status=' + lstStatus.value + '&p_lday=' + idLeaveDays.value + '&p_ale=' + id_Ale.text +  '&p_month=' + dtYear.value + '&p_search=' + idSearch2.value + '&p_input=' + id_Input2.text + '&sql=3';
            window.open(url);
          }
          
       }
       else if (obj.id=="dat_ale_lending")
       {
          if(txtResult.text=="1")
          {
            alert("Last year not yet close.\Năm trước chưa đóng, bạn phải đóng năm trước rùi hãy thực hiện bước này")
            clear_Interval(idInterval);
            idInterval.text="Last year not yet close."            
          }
          else if(txtResult.text=="0")
          {
             alert("Successful.\Đã hoàn thành")
             clear_Interval(idInterval);
             idInterval.text="Successful";  
          }
       }
       else if (obj.id=="dat_Annual_year_amt")
       {    
            idrecord2.text=idGrid2.rows-1+" Records.";  
            auto_resize_column(idGrid2,0,idGrid2.cols-1,0);  
       }
       else if(obj.id=="datCheck_Process_year")
       {    if(txtClose.text=='1')   
            { idBtnUpdatePay.SetEnable(0);
              icoProcess.SetEnable(0);
             // idBtnOpen.SetEnable(0);
            }
            else
            { idBtnUpdatePay.SetEnable(1);
              icoProcess.SetEnable(1);
              //idBtnOpen.SetEnable(1);
            } 
       }
       
      
	   
}    
function OnChangeDate()
{
datCheck_year.Call();
}
function OnChangeYear()
{datCheck_Process_year.Call();
}
//---------------------------------------------------
function OnSearch1()
{ txtOption.text='';
   dat_Check_Option_Kind.Call();   	    
       
        
}
function OnSearch2()
{txtOption.text='year';    
dat_Check_Option_Kind2.Call();   	    

        
}

function OnUpdate()
{
    if(confirm("Are you sure to save?\nBạn đã chắc chắn lưu?"))
        dat_Annual_leave_1.Call();
}
//---------------------------------------------------
function OnUpdatePay()
{
    if(confirm("Are you sure to save?\nBạn đã chắc chắn lưu?"))
       dat_Annual_year_amt.Call();
}
//---------------------------------------------------
function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:60;dialogTop:200;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
             txtUpperDept.text=obj;
             datDeptData.Call();
        }
}

//-------------------------------------------------
function OnChangeDept(depObj)
{
    txtDept.text=depObj.value;
    datGroupData.Call();
}
//------------------------------------------------------------------------------------
function Numbers(e) 
{ 
  //  var ctrl=idTEL.GetControl(); 
    var keynum; 
    var keychar; 
    var numcheck; 
    keynum =event.keyCode; 
        
    if(window.event) // IE 
    { 
      keynum = e.keyCode; 
    } 
    else if(e.which) // Netscape/Firefox/Opera 
    { 
      keynum = e.which; 
    } 
    keychar = String.fromCharCode(keynum); 
    numcheck = /\d/; 
    return numcheck.test(keychar); 
}
function Open_Close(flag)
{
    if(confirm("Do you want to "+flag+"?"))
    {
        txtFLAG.text=flag;
        txtResult.text=="";
        dat_Open_Close.Call();
     }   
}
//---------------------------------------------------------------------------
function Popup()
{

  var fpath = System.RootURL + "/form/ch/ba/chba00070_01.aspx?emp_pk=" + idGrid.GetGridData(event.row,0) + "&mon=" +idMonth.value+"&flag="+txtCheckYear.text;
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:32;dialogHeight:25;dialogLeft:100;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');

}
//---------------------------------------
function OnReport(obj)
{
    txtReport_tmp.text="rpt_annual_leave_v2.aspx";
   report=obj;
    datFind_Report.Call();
    
     
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}
function on_Process()
{
    if(confirm("Do you want to process?\nBạn đã chắc chắn?"))
    {
        txtResult.text="";
        set_Interval(1000)
        dat_ale_lending.Call();
    }    
}

function OnToggle()
{
    
            if(img2.status == "show")
            {
                img2.status = "hide";
                img2.src = "../../../system/images/close_popup.gif";
			    img2.alt="Hide annual leave lending information";
			    tr_month.style.display='';
			    tr_month.style.height="6%";
			    tr_month2.style.height="6%";
			    tr_month3.style.height="88%";
            }
            else 
            {
                img2.status = "show";
                img2.src = "../../../system/images/iconmaximize.gif";
			    img2.alt="Show annual leave lending information";
			    tr_month.style.display="none";
			    tr_month.style.height="0%";
			    tr_month2.style.height="6%";
			    tr_month3.style.height="94%";
            }
  
}
function OnSetToGrid()
{
if(txtDay.text!='' &&  isNaN( txtDay.text)==false)
{    var condition=0;
     var txtday= Number(txtDay.text);
    if(txtCon.text!='' &&  isNaN( txtCon.text)==false)
        condition=Number(txtCon.text);   
    for(var i=1;i<idGrid2.rows;i++)
        { if(idGrid2.GetGridData(i,1)=='Y')
                { if(lstCon.value=='1')
                    {   if(lstPay.value=='1')
                            {if(idGrid2.GetGridData(i,15)>condition)
                                idGrid2.SetGridText(i,15,txtDay.text);
                            }
                         else
                            {if(idGrid2.GetGridData(i,16)>condition)
                                idGrid2.SetGridText(i,16,txtDay.text);
                            }
                            
                    }
                    if(lstCon.value=='2')
                    {   if(lstPay.value=='1')
                            {if(idGrid2.GetGridData(i,15)<condition)
                                idGrid2.SetGridText(i,15,txtday);
                            }
                         else
                            {if(idGrid2.GetGridData(i,16)<condition)
                                idGrid2.SetGridText(i,16,txtday);
                            }
                            
                    }
                    if(lstCon.value=='3')
                    {   if(lstPay.value=='1')
                            {if(idGrid2.GetGridData(i,15)==condition)
                                idGrid2.SetGridText(i,15,txtday);
                            }
                         else
                            {if(idGrid2.GetGridData(i,16)==condition)
                                idGrid2.SetGridText(i,16,txtday);
                            }
                            
                    }
                    if(lstCon.value=='4')
                    {   if(lstPay.value=='1')
                        idGrid2.SetGridText(i,15,txtday);
                        else                          
                        idGrid2.SetGridText(i,16,txtday);                        
                    }

                    
                }            
        }
 }
}
function OnSetGrid()
{ var v='';
if(chkCheck.value=='F')
        v='0';
 else
        v='-1';       
    
       for(var i=1;i<idGrid.rows;i++)
            {idGrid.SetGridText(i,1,v);
            }
    
}
function ChangeTab()
{datCheck_Process_year.Call();
}
</script>
<body style="margin-top:0;margin-bottom:0">
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtdept_temp" />
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
<gw:data id="datGroupData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="hr.sp_pro_group_data_all" > 
                <input>
                   <input bind="txtDept" />
                </input> 
                <output>
                    <output bind="txtGroupData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datCheck_year" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_CHECK_YEAR" > 
                <input>
                    <input bind="idMonth" /> 
                </input> 
                <output>
                    <output bind="txtCheckYear" />
                    <output bind="txtMonthClose" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datCheck_Process_year" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_CHECK_Procces" > 
                <input>
                    <input bind="dtMonth" /> 
                </input> 
                <output>
                     <output bind="txtClose" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_Open_Close" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR.sp_pro_annual_leave_v2" > 
                <input>
                    <input bind="idMonth" /> 
                    <input bind="txtFLAG" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_Annual_leave_1" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1" function="HR.sp_sel_annual_leave_v2" procedure="HR.sp_upd_Al_pay"> 
                <input bind="idGrid" >
                    <input bind="lstOrg_Code" />
                    <input bind="lstWGrp_Code" />
                    <input bind="lstStatus" />
                    <input bind="idLeaveDays" />
                    <input bind="id_Ale" />
                    <input bind="idMonth" />
                    <input bind="idSearch" />
                    <input bind="id_Input" />
                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dat_Annual_leave_2" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"   function="HR.sp_sel_annual_leave_exist" > 
                <input bind="idGrid" >
                    <input bind="lstOrg_Code" />
                    <input bind="lstWGrp_Code" />
                    <input bind="lstStatus" />
                    <input bind="idLeaveDays" />
                    <input bind="id_Ale" />
                    <input bind="idMonth" />
                    <input bind="idSearch" />
                    <input bind="id_Input" />
                </input>
                <output  bind="idGrid" />
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
<gw:data id="dat_Check_Option_Kind" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_find_option_ale" > 
                <input>
                    <input bind="idMonth" /> 
                    <input bind="txtOption" /> 
                </input> 
                <output>
                    <output bind="txtOption" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dat_Check_Option_Kind2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_find_option_ale" > 
                <input>
                   <input bind="dtMonth" /> 
                    <input bind="txtOption" /> 
                </input> 
                <output>
                    <output bind="txtOption" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_ale_lending" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR.sp_pro_ale_lending_v2" > 
                <input>
                    <input bind="dtMonth" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_Annual_year_amt" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,15,16,21" function="HR.sp_sel_ale_year_amt_v2" procedure="hr.sp_updt_annual_leave_pay"> 
                <input bind="idGrid2" >
                    <input bind="lstOrg_Code2" />
                    <input bind="lstWGrp_Code2" />
                    <input bind="dtYear" />
                    <input bind="idSearch2" />
                    <input bind="id_Input2" />
                </input>
                <output  bind="idGrid2" />
            </dso> 
        </xml> 
</gw:data>
<!--------------------------------------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate="ChangeTab()"  > 

   <table name="Annual Leave" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
        <tr>
            <td>
            
	<table style="width:100%;height:10%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	    <tr style="height:100%;border:1">	
		    <td colspan=2 align=right style="width:10%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
		    <td colspan=3 align=right style="width:15%;border:1" ><gw:list  id="lstOrg_Code"  value="ALL" styles='width:100%' onchange="" >
                <data>
                    <%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM COMM.TCO_ORG A WHERE A.DEL_IF=0 CONNECT BY PRIOR  A.PK=A.P_PK START WITH NVL(A.P_PK,0)=0")%>|ALL|Select All
                    </data>
                </gw:list>
            </td>
		    <td align=right style="width:5%;border:1" >Work Group</td>
		    <td colspan=3 align=right style="width:15%;border:1" ><gw:list  id="lstWGrp_Code" value="ALL"  styles='width:100%' >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0") %>|ALL|Select All
                            </data></gw:list></td>
		     <td align=right style="width:5%;border:1" >Status</td>
		    <td colspan=2 align=right style="width:10%;border:1" ><gw:list  id="lstStatus"  styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0022' ORDER BY B.CODE")%>|ALL|Select All</data></gw:list>
             </td>
		    <td colspan=2 align=right style="width:10%;border:1" >ALE Unused</td>
		    <td align=right style="width:5%;border:1" ><gw:list id="idLeaveDays" styles="color:black" value="1" styles='width:100%'> 
		        <data>List|1|>=|2|=|3|<=</data></gw:list >
			</td>
		    <td align=right style="width:5%;border:1" ><gw:textbox id="id_Ale"	maxlen = "2" styles="width:100%" onkeypress="return Numbers(event)" onenterkey="OnSearch1()"/></td>
		    <td align=right style="width:5%;border:1" ></td>
		    <td align=right style="width:5%;border:1" ></td>
		    <td align=right style="width:1%;border:1" ></td>
		    <td align=right style="width:3%;border:1" ><gw:imgBtn id="idBtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch1()" /></td>
		    <td align=right style="width:3%;border:1" ><gw:imgBtn id="idBtnUpdate" alt="Save" img="Save" text="Save" onclick="OnUpdate()" /></td>
		    <td align=right style="width:3%;border:1" ><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport(0)" /></td>
        </tr>	
        <tr style="height:100%;border:1">	
		    <td align=left colspan=2 style="width:5%;border:1" >ALL<gw:checkbox id="chkCheck" value="F" onclick="OnSetGrid()" ></gw:checkbox ></td>
		    <td colspan=1 align=right style="width:10%;border:0" >Month</td>
		    <td colspan=2 align=right style="width:10%;border:1" ><gw:datebox id="idMonth"  maxlen = "10" text="" styles='width:50%'lang="<%=Session("Lang")%>" type=month onchange="OnChangeDate()" /></td>
		    <td align=right style="width:5%;border:1" ></td>
		    <td align=right style="width:5%;border:1" ><gw:icon id="idBtnOpen" img="in" text="Open" onclick="Open_Close('OPEN')" /></td>
		    <td align=right style="width:5%;border:1" ><gw:icon id="idBtnClose" img="in" text="Close" onclick="Open_Close('CLOSE')" /></td>
		    <td  colspan=2 align=right style="width:10%;border:1" >Search by</td>
		     <td align=right style="width:5%;border:1" ><gw:list id="idSearch" styles="color:black" value="1" styles='width:100%'> 
		        <data>List|1|Emp ID|2|Card ID|3|Name</data></gw:list ></td>
		    <td colspan=3 align=right style="width:15%;border:1" ><gw:textbox id="id_Input"	styles="width:100%" onenterkey="OnSearch1()" /></td>
		    <td colspan=6 align=right style="width:30%;border:1" ><gw:label id="idrecord" styles="width:100%;color:red"></gw:label></td>
        </tr>
	</table>
	<table id="tbl" style="width:100%;height:90%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				    <!--0_pk|1Pay|2Group|3Emp_ID|4Name|5D.O.J|6AL Last Year|7AL in Year|8AL Real|9Last Year Lend ABS|10In Year Lend ABS|11Last Year AL Option2|12In Year AL Option2|13Used|14Unused|15Unused in Year|16Pay |17Unpay|18JAN|19FEB|20MAR|21APR|22MAY|23JUN|24JUL|25AUG|26SEP|27OCT|28NOV|29DEC-->
				<gw:grid   
				id="idGrid"  
				header="_pk|Pay|Group|Emp_ID|Name|D.O.J|AL Last Year|AL in Year|AL Real|Last Year Lend|In Year Lend|Last Year AL Option2|In Year AL Option2|Used|Unused|Unused in Year|Pay |Unpay|JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC"   
               	format="0|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				aligns="3|1|3|2|1|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3|3"  
				defaults="||||||||||||||||||||||||||||||"  
			    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    widths="0|500|1500|1000|2500|1500|1500|1200|1200|1500|1000|1000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
				styles="width:100%; height:100%"   
				sorting="T"   
				oncelldblclick = "Popup()"/> 
			</td>
		</tr>	
	</table>
	</td>
        </tr>
</table>
<table name="Annual Lending" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1"    >
        <tr>
            <td>
	             <table id="tr_month" cellpadding="0" style="width:100%;height:6%" cellspacing="0" width="100%"  border="0" >
                    <tr >
                        <td width="54%"  align="right" valign="middle" class="bottomleft" style="font-size:3"><font>Annual leave Lending and calculate until month</font></td>
                        <td width="10%"  align="left" valign="middle"  class="bottom"><gw:datebox id="dtMonth"  text="" maxlen = "10" type="month" lang="<%=Session("Lang")%>"onchange="OnChangeYear()"/> </td>
                        <td width="10%" align="right" valign="middle"  class="bottomright"><gw:icon id="icoProcess" img="in" text="Process" onclick="on_Process()" /></td>
                        <td width="10%"  align="right" valign="middle" class="bottom"style="color=#FF3300"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
                        <td style="width:15%"></td>
                    </tr>
                </table>
              <table id="tr_month2" style="width:100%;height:6%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
                    <tr style="height:100%;border:1">	
                        <td width="1%" style="border:0;" align="right" ><img status="hide" id="img2" alt="Show month salary information" src="../../../system/images/close_popup.gif" style="cursor:hand" onclick="OnToggle()"  /></td>
                        <td align=right style="width:5%;border:1" ><b>Year</b></td>
                        <td colspan=2 align=right style="width:10%;border:1" ><gw:datebox id="dtYear"  text="" maxlen = "10" type="year" lang="<%=Session("Lang")%>"  /></td>
	                    <td colspan=2 align=right style="width:10%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
	                    <td colspan=3 align=right style="width:15%;border:1" ><gw:list  id="lstOrg_Code2"  value="ALL" styles='width:100%' onchange="" >
                            <data>
                                 <%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM COMM.TCO_ORG A WHERE A.DEL_IF=0 CONNECT BY PRIOR  A.PK=A.P_PK START WITH NVL(A.P_PK,0)=0")%>|ALL|Select All                               
                             </data>
                            </gw:list>
                        </td>
	                    <td align=right style="width:5%;border:1" >Work Group</td>
	                    <td colspan=3 align=right style="width:15%;border:1" ><gw:list  id="lstWGrp_Code2" value="ALL"  styles='width:100%' >
                                        <data> <%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0") %>|ALL|Select All
                                        </data></gw:list></td>
                        <td colspan=2 align=right style="width:10%;border:1" >Search by</td>
		                <td align=right colspan=2 style="width:5%;border:1" ><gw:list id="idSearch2" styles="color:black" value="1" styles='width:100%'> 
		                                        <data>List|1|Emp ID|2|Card ID|3|Name</data></gw:list ></td>
		                <td colspan=2 align=right style="width:10%;border:1" ><gw:textbox id="id_Input2"	styles="width:100%" onenterkey="OnSearch2()" /></td>                        
	                    <td align=right style="width:3%;border:1" ><gw:imgBtn id="idBtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch2()" /></td>
	                    <td align=right style="width:3%;border:1" > <gw:imgBtn id="idBtnUpdatePay" alt="Save" img="Save" text="Save" onclick="OnUpdatePay()" /></td>
	                    <td align=right style="width:3%;border:1" ><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport(2)" /></td>
	                    
                    </tr>	
                    <tr style="height:100%;border:1">	
                        <td align=left colspan=4 style="width:5%;border:1" ><gw:label id="idrecord2" styles="width:100%;color:red"></gw:label></td>                 
	                    <td align=right style="width:3%;border:1" ></td>
	                    <td align=right style="width:8%;border:1" ></td>  
                        <td colspan=3 align=right style="width:10%;border:1" ><gw:list  id="lstPay" value="ALL"  styles='width:100%' >
                                        <data>|1|Company Pay|2|Employee Pay</data></gw:list></td>
	                    <td align=right colspan=2  style="width:5%;border:1" >Condition</td>
	                                       
	                    
	                    <td colspan=1 align=right style="width:10%;border:0" ><gw:list  id="lstCon" value="4"  styles='width:100%' >
                                        <data>|1|>|2|<|3|=|4|ALL</data></gw:list></td>
	                    <td colspan=1 align=left style="width:15%;border:1" ><gw:textbox id="txtCon"  styles='width:100%'/></td>
	                    <td align=right colspan=2 style="width:5%;border:1" >Set value</td>
	                    <td colspan=3 align=right style="width:15%;border:1" > <gw:textbox id="txtDay"  styles='width:100%'/></td>
                        <td colspan=1 align=left style="width:10%;border:1" ><gw:imgBtn id="ibtnSet" alt="Set Grid" img="set" text="" onclick="OnSetToGrid()" /></td>
		                <td align=right style="width:5%;border:1" ></td>
		                <td colspan=3 align=right style="width:10%;border:1" ></td>                        
	                  
                    </tr>
            </table>
            <table id="tr_month3" style="width:100%;height:88%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	            <tr style="height:100%">
		            <td id="Td1" width="100%">
			            <!--_PK0|1Pay|2Organization|3Group|4Emp_ID|5Name|6D.O.J|7AL Last|8AL Real|9AL Used|10LastY Lend AL ABS|11Lend AL ABS|12LastY AL Option2|13Lend AL Option2|14Unused|15Company Pay|16Emp pay|17Salary|18_EmpPayAMT|19Total Amount|20Unpay|_year-->				
			            <gw:grid   
			            id="idGrid2"  
			            header="_PK|Pay|Organization|Group|Emp_ID|Name|D.O.J|AL Last|AL Real|AL Used|LastY Lend|In Year Lend|LastY AL Option2|In Year AL Option2|Unused|Company Pay|Emp pay|Salary|_EmpPayAMT|Total Amount|Unpay|_year"   
			            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0"  
			            aligns="2|2|2|2|3|3|3|3|3|3|1|1|1|1|1|1|1|1|1|1|1|1"  
			            defaults="|||||||||||||||||||||"  
			            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|0|0|0|0|0"  
			            widths="0|500|1000|3000|1000|1200|1200|1200|1200|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0"  
			            styles="width:100%; height:100%"   
			            sorting="T"   
			            oncelldblclick = ""/> 
		            </td>
	            </tr>	
            </table>
	        </td>
        </tr>
</table>
</gw:tab>
    <gw:textbox id="txtResult" styles="display:none"/>
    <gw:textbox id="txtCheckYear" styles="display:none"/>
    <gw:textbox id="txtFLAG" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>
    <gw:textbox id="txtdept_temp" styles="display:none"/>
    <gw:textbox id="txtDept" styles="display:none"/>
    <gw:textbox id="txtMonthClose" styles="display:none"/>
    <gw:textbox id="txtClose" styles="display:none"/>
    <gw:textbox id="txtOption" styles="display:none"/>
</body>
</html>
