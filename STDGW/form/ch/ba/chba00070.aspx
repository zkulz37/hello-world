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
var init=0;
var check_init=0;
var flag2=0;
var tab_flag2=0;
var p_row=1;
var tap3_temp=0; 
//--tab 3
//"pk|thr_emp_pk|Organization|Emp_ID|Name|D.O.J|AL Last Year|AL in Year|AL Plus|AL Real|Used|Unused|Unused in Year|Ale Pay|Salary|Ale Pay Amount|Description"   
var c3_pk=0,c3_thr_emp_pk=1, c3_Organization=2, c3_Emp_ID=3, c3_Name=4,
 c3_DOJ=5, c3_AL_Last_Year=6, c3_AL_in_Year=7, c3_AL_Plus=8,
 c3_AL_Real=9, c3_Used=10, c3_Unused=11, c3_Unused_in_Year=12,
 c3_Ale_Pay=13, c3_Salary_14=14, c3_Ale_Pay_Amount=15,c3_By_Hand=16,c3_adj_type=17, c3_Description=18,c3_work_mon=19;

function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>";
   menu_id.text=System.Menu.GetMenuID();
   idGrid.GetGridControl().FrozenCols =4;
   idGrid.GetGridControl().ScrollTrack=true;
    idGrid2.GetGridControl().FrozenCols =5;
   idGrid2.GetGridControl().ScrollTrack=true;
 
   user= "<%=session("USER_ID")%>";

   ChangeColorItem(lstOrg_1.GetControl());
   ChangeColorItem(lstOrg_2.GetControl());
   ChangeColorItem(lstOrg_3.GetControl());
   
   dtMonth.value=dtYear1.value+"12";

   idGrid_tab_3.GetGridControl().FrozenCols =6;
   ibtnRpt_tab_3.SetEnable(0);

    var data="#1;Pay Ale|#2;Adjust";
    idGrid_tab_3.SetComboFormat(c3_adj_type,data);//unEMp yn

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

//---------------------------------------------------------------------------
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
{
    if(obj.id == "datCheck_View")
       {
            if(txtFlag_View.text == 'Y')
            {
                idBtnUpdate.style.display = "none";
                idBtnUpdatePay.style.display = "none";

                idBtnOpen.style.display = "none";
                idBtnClose.style.display = "none";
                icoProcess.style.display = "none";
                icoProcess2.style.display = "none";
				idBtnOpen2.style.display = "none";
                idBtnClose2.style.display = "none";
            }
        
            if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
            {
                      datUser_info.Call();   
            }
            else
                datCheck_year.Call();           
            
       }
    else if (obj.id=="dat_Check_Option_Kind2")
            {//alert(txtOption.text);
                if(txtOption.text=='10'||txtOption.text=='11')
                      { //idGrid.GetGridControl().ColHidden(11)=1;
                        //idGrid.GetGridControl().ColHidden(12)=1;
                        idGrid2.GetGridControl().ColHidden(15)=1;
                        idGrid2.GetGridControl().ColHidden(14)=1;
                           
                        
                      }
                else if (txtOption.text=='20'||txtOption.text=='21')
                     {   idGrid2.GetGridControl().ColHidden(15)=0;
                         idGrid2.GetGridControl().ColHidden(14)=0;
                     }
                 dat_Annual_year_amt.Call("SELECT");                                    
                }     

       else if (obj.id=="datCheck_year")
       {    action();                
            onChange_org();      
       }
       else if (obj.id=="datWorkGroup_info")
       {
            if(init!=0 && tabMain.GetCurrentPageNo()==0)
            {
                              
                    lstWG_1.SetDataText(txtwg_tmp.text+'|ALL|Select All');
                    lstWG_1.value='ALL';
              
            }
            if(init!=0 && tabMain.GetCurrentPageNo()==1)
            {                
                    lstWG_2.SetDataText(txtwg_tmp.text+'|ALL|Select All');
                    lstWG_2.value='ALL';
              
            }
            
            if(init==0)
            {       lstWG_2.SetDataText(txtwg_tmp.text+'|ALL|Select All');
                    lstWG_2.value='ALL';
                    lstWG_1.SetDataText(txtwg_tmp.text+'|ALL|Select All');
                    lstWG_1.value='ALL';
              init=1;
              
            }
			check_init=1;
            
       }
       else if ((obj.id=="dat_Annual_leave_1")||(obj.id=="dat_Annual_leave_2"))
       {
            idrecord.text=idGrid.rows-1+" Records";  
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
            lstOrg_1.SetDataText(txtOrg_temp.text);            
            lstOrg_2.SetDataText(txtOrg_temp.text);
            txtOrg.text=lstOrg_1.value;

            ChangeColorItem(lstOrg_1.GetControl());
            ChangeColorItem(lstOrg_2.GetControl());
            ChangeColorItem(lstOrg_3.GetControl());

            datCheck_year.Call();  
            
           
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
                    var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_tco_org_pk=' + lstOrg_1.value + '&p_thr_group_pk=' + lstWG_1.value + '&p_status=' + lstStatus.value + '&p_lday=' + idLeaveDays.value + '&p_ale=' + id_Ale.text +  '&p_month=' + idMonth.value + '&p_search=' + idSearch.value + '&p_input=' + id_Input.text + '&sql=' + sql +'&p_nation='+lstNation.value + '&p_from='+dtFrom_DOJ.value +'&p_to='+dtTo_DOJ.value+ '&p_left_from='+dtFrom_Left.value +'&p_left_to='+dtTo_Left.value;
                    window.open(url);
           }
              else
          {
            var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_tco_org_pk=' + lstOrg_2.value + '&p_thr_group_pk=' + lstWG_2.value + '&p_status=' + lst_Status2.value + '&p_lday=' + idLeaveDays.value + '&p_ale=' + id_Ale.text +  '&p_month=' + dtYear.value + '&p_search=' + idSearch2.value + '&p_input=' + id_Input2.text + '&sql=3' +'&p_nation='+lstNation2.value+ '&p_from='+dtFrom_DOJ.value +'&p_to='+dtTo_DOJ.value+ '&p_left_from='+dtFrom_Left.value +'&p_left_to='+dtTo_Left.value;
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
       else if (obj.id=="dat_ale_cancel")
       {
          if(txtResult.text!="0")
          {
            alert("Error.\Có lỗi xảy ra")
            clear_Interval(idInterval);
            idInterval.text="Error."            
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
            idrecord2.text=idGrid2.rows-1+" rec";  
            auto_resize_column(idGrid2,0,idGrid2.cols-1,0); 
            for(var i=1;i<= idGrid2.rows-1;i++)
            idGrid2.SetCellBgColor(i,17,i,18,0xFFCC00); 
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
			if(txtExist_ale.text=='0')  //ko tồn tai du lieu annual leave
			{
				idBtnOpen2.SetEnable(0);
				idBtnClose2.SetEnable(0);
				icoProcess2.SetEnable(0);
			}
			else //tồn tai du lieu annual leave
			{
				if(txtClose_ale.text=='1')  // annual leave close tach close ra vì check process liên quan đến 2 phần(tháng thanh toán annual leave và tồn tại annual leave).
				{
					idBtnOpen2.SetEnable(1);
					idBtnClose2.SetEnable(0);
					icoProcess2.SetEnable(0);
				}
				else // annual leave open
				{
					idBtnOpen2.SetEnable(0);
					idBtnClose2.SetEnable(1);
					icoProcess2.SetEnable(1);
				}
			}
       }
	   else if(obj.id=="dat_Open_Close2")
       { 
			//alert(txtFLAG2.text);
			if(txtFLAG2.text=="OPEN")
			{
				idBtnOpen2.SetEnable(0);
				idBtnClose2.SetEnable(1);
			}
			else
			{
				idBtnOpen2.SetEnable(1);
				idBtnClose2.SetEnable(0);
			}
	   }
       else if(obj.id=="dat_ale_pay_tab3")
       { 
			idrecord_tab_3.text=idGrid_tab_3.rows-1+" records";  
            auto_resize_column(idGrid_tab_3,0,idGrid_tab_3.cols-1,0); 
            if(idGrid_tab_3.rows-1>0)
                idGrid_tab_3.SetCellBgColor(1,c3_Ale_Pay,idGrid_tab_3.rows-1,c3_Ale_Pay,0x99ffff); 
	   }


       
	                	  
}    
function OnChangeDate()
{
datCheck_year.Call();
}
function OnChangeMonth()
{
	var temp_year_1=dtMonth.value.substr(0,4);
	var temp_year_2=dtMonth.value.substr(0,4)-1 +"" ;
	var temp_month=dtMonth.value.substr(4,5);
	if(temp_month==12)
	{
		dtYear1.value=temp_year_1;			
	}
	else
	{		
		dtYear1.value=temp_year_2;		
	}
    datCheck_Process_year.Call();   
}
function OnChangeYear()
{	
	var temp=dtYear1.value+"12";	
	dtMonth.value=temp;
	OnChangeMonth();
}
//---------------------------------------------------
function OnSearch1()
{  	    
	if(check_init==1)
	{
		if(txtCheckYear.text=="1")  // tồn tại annual leave
			dat_Annual_leave_2.Call("SELECT");
		else
		   dat_Annual_leave_1.Call("SELECT");   // ko tồn tại annual leave
	}   
}
function OnSearch2()
{
		txtOption.text='year';    
		dat_Check_Option_Kind2.Call();   	    

        
}

function OnUpdate()
{
	if(check_init==1)
	{
		if(confirm("Are you sure to save?\nBạn đã chắc chắn lưu?"))
			dat_Annual_leave_1.Call();
	}		
}
//---------------------------------------------------
function OnUpdatePay()
{
    if(confirm("Are you sure to save?\nBạn đã chắc chắn lưu?"))
       dat_Annual_year_amt.Call();
}
//---------------------------------------------------
function OnShowPopup(n)
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:60;dialogTop:200;edge:sunken;scroll:no;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(n==1)
			{
                lstOrg_1.value=obj
				datCheck_year.Call();
			}
            else if(n==2)
                lstOrg_2.value=obj
			else	
				lstOrg_3.value=obj
                    
             //txtUpperOrg.text=obj;
             onChange_org();
        }
}

//-------------------------------------------------
function OnChangeOrg(depObj)
{
    txtOrg.text=depObj.value;
    //datGroupData.Call();
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
    var ctrl=idGrid.GetGridControl();
if(ctrl.row>=1)
{
if (ctrl.col >= 15)
  {
    if(idGrid.GetGridData(ctrl.row,ctrl.col)=="")
        return;
     var  col=Number(ctrl.col)-14;
         var fpath = System.RootURL + "/form/ch/ba/chba00070_01.aspx?emp_pk=" + idGrid.GetGridData(ctrl.row,0) + "&mon=" +idMonth.value+"&flag="+col;
            var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:32;dialogHeight:25;dialogLeft:100;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
   }
    else
    {  var fpath = System.RootURL + "/form/ch/ba/chba00070_01.aspx?emp_pk=" + idGrid.GetGridData(ctrl.row,0) + "&mon=" +idMonth.value+"&flag=0";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:32;dialogHeight:25;dialogLeft:100;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');}
        
    }
        
}

//---------------------------------------
function OnReport(obj)
{
    if(obj==0)
        txtReport_tmp.text="rpt_annual_leave.aspx";
    else    
        txtReport_tmp.text="rpt_annual_leave_payment.aspx";
        
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

function on_Cancel()
{
    if(confirm("Do you want to CANCEL annual leave "+dtYear1.value+" ?\nBạn đã chắc chắn?"))
    {
        txtResult.text="";
        set_Interval(1000)
        dat_ale_cancel.Call();
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
			    tr_month2.style.height="12%";
			    tr_month3.style.height="82%";
            }
            else 
            {
                img2.status = "show";
                img2.src = "../../../system/images/iconmaximize.gif";
			    img2.alt="Show annual leave lending information";
			    tr_month.style.display="none";
			    tr_month.style.height="0%";
			    tr_month2.style.height="12%";
			    tr_month3.style.height="88%";
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
                            {if(idGrid2.GetGridData(i,17)>condition)
                                idGrid2.SetGridText(i,17,txtDay.text);
                            }
                         else
                            {if(idGrid2.GetGridData(i,18)>condition)
                                idGrid2.SetGridText(i,18,txtDay.text);
                            }
                            
                    }
                    if(lstCon.value=='2')
                    {   if(lstPay.value=='1')
                            {if(idGrid2.GetGridData(i,17)<condition)
                                idGrid2.SetGridText(i,17,txtday);
                            }
                         else
                            {if(idGrid2.GetGridData(i,18)<condition)
                                idGrid2.SetGridText(i,18,txtday);
                            }
                            
                    }
                    if(lstCon.value=='3')
                    {   if(lstPay.value=='1')
                            {if(idGrid2.GetGridData(i,17)==condition)
                                idGrid2.SetGridText(i,17,txtday);
                            }
                         else
                            {if(idGrid2.GetGridData(i,18)==condition)
                                idGrid2.SetGridText(i,18,txtday);
                            }
                            
                    }
                    if(lstCon.value=='4')
                    {   if(lstPay.value=='1')
                        idGrid2.SetGridText(i,17,txtday);
                        else                          
                        idGrid2.SetGridText(i,18,txtday);                        
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
{
    
    if(tabMain.GetCurrentPageNo()==1)
    {
        if(tab_flag2==0)
        {
            tab_flag2=1;
            OnToggle();
            datCheck_Process_year.Call();
        }
    }

}

function OnShowPopUp2()
{if(event.row>=1)
{
  if (event.col>=19)
   {var fpath = System.RootURL + "/form/ch/ba/chba00070_02.aspx?emp_pk=" + idGrid2.GetGridData(event.row,0) + "&year=" +dtYear.value;
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:32;dialogHeight:25;dialogLeft:100;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');
   }
    if (event.col==11)
    { var fpath = System.RootURL + "/form/ch/ba/chba00070_01.aspx?emp_pk=" + idGrid2.GetGridData(event.row,0) + "&mon=" +dtYear.value+"&flag="+'0';
      var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:32;dialogHeight:25;dialogLeft:100;dialogTop:100;edge:sunken;scroll:yes;unadorned:yes;help:no');

    }
    }
}

function onChange_org()
{
    if(tabMain.GetCurrentPageNo()==0) 
        txtOrg_tmp.text=lstOrg_1.value;
    if(tabMain.GetCurrentPageNo()==1) 
        txtOrg_tmp.text=lstOrg_2.value;
    datWorkGroup_info.Call();
}

function Open_Close2(flag2)
{
    if(confirm("Do you want to "+flag2+" annual leave " + dtYear1.value+ " ?"))
    {
        txtFLAG2.text=flag2;
        txtResult2.text=="";
        dat_Open_Close2.Call();
     }   
}


function OnSearch_tab3()
{
    dat_ale_pay_tab3.Call("SELECT");
}


function OnSetToGrid_tab_3(n)
{
	var gCtrl,i;
	
	var l_value,tmp_col;
	gCtrl=idGrid_tab_3.GetGridControl();		
	
    if(n==1)
    {
        if(id_SetAlePay_tab_3.text=="")
        {
            alert("Please input annual leave to set grid");
            return;
        }
        l_value=id_SetAlePay_tab_3.text;
        tmp_col=c3_Ale_Pay;
    }
    else
    {
        l_value=idadj_type_tab_3.value;
        tmp_col=c3_adj_type;
    }


	if(gCtrl.rows>1)
	{
		if(gCtrl.SelectedRows<=1)
		{
			if(confirm("Set to all row?"))
			{
					for(i=1;i<gCtrl.rows;i++)
					{		
						idGrid_tab_3.SetGridText(i,tmp_col,l_value);
					}
             }      
		}
		else
		{			
			for(i=0;i<gCtrl.SelectedRows;i++)
			{
				var tmp=gCtrl.SelectedRow(i);	
					idGrid_tab_3.SetGridText(tmp,tmp_col,l_value);
			}
		}
	}
}

function onChangeLst_Type()
{
    idGrid_tab_3.ClearData();
    if(idPaylist_tab_3.value=="01")
    {
        ibtnRpt_tab_3.SetEnable(0);
    }
    else
    {
        ibtnRpt_tab_3.SetEnable(1);
    }
}

function OnDelete_tab_3()
{
    if(idPaylist_tab_3.value=="02")
    {
        if(confirm("Do you want to delete?"))
        {
            idGrid_tab_3.DeleteRow();
            dat_ale_pay_tab3.Call();
        }
    }    
}

function OnUpdate_tab_3()
{
    if(confirm("Do you want to save?"))
        {
            
            dat_ale_pay_tab3.Call();
        }
}


function OnReport_tab_3()
{
    //return; //developing
    txtReport_tmp.text="rpt_annual_monthly_payment.aspx";
    var url =System.RootURL + '/reports/ch/ba/'+txtReport_tmp.text+'?p_user=' + user + '&p_tco_org_pk=' + lstOrg_tab_3.value + '&p_thr_group_pk=' + lstWG_tab_3.value;
    url+='&p_status=' + lstStatus_tab_3.value + '&p_lday=' + idLeaveDays_tab_3.value + '&p_ale=' + id_Ale_tab_3.text +  '&p_month=' + idMonth_tab_3.value ;
    url+= '&p_search=' + idSearch_tab_3.value + '&p_input=' + id_Input_tab_3.text+'&p_nation='+lstNation_tab_3.value + '&p_from='+dtFrom_DOJ_tab_3.value;
    url+='&p_to='+dtTo_DOJ_tab_3.value;
    window.open(url);
}
function setByHand()
{
 
    if(idGrid_tab_3.GetGridData(p_row,16)=="-1")
    {
       idGrid_tab_3.SetColEdit(15,1);
        
    }
    else 
    {
        idGrid_tab_3.SetGridText(p_row,15,tap3_temp);
    }


}
function OnClickRow()
{
   if(idGrid_tab_3.row!=idGrid_tab_3.rows-1) 
   {
        p_row=idGrid_tab_3.row;
        tap3_temp=idGrid_tab_3.GetGridData(p_row,15);
        
   }
}

</script>
<body style="margin-top:0;margin-bottom:0">
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
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtOrg_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datCheck_year" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_PRO_10020007_CHECK_YEAR" > 
                <input>
                    <input bind="idMonth" /> 
					<input bind="lstOrg_1" />
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
            <dso  type="process" procedure="hr_PRO_10020007_CHECK_Pro" > 
                <input>
                    <input bind="dtYear1" /> 
					<input bind="dtMonth" /> 
					<input bind="lstOrg_1" />
                </input> 
                <output>
                     <output bind="txtClose" />
					 <output bind="txtExist_ale" />
					 <output bind="txtClose_ale" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_Open_Close" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_10020007_ale" > 
                <input>
                    <input bind="idMonth" /> 
					<input bind="lstOrg_1" />
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
            <dso  type="grid"  parameter="0,1,7,8" function="HR_sel_10020007_ale" procedure="HR_upd_10020007_Ale"> 
                <input bind="idGrid" >
                    <input bind="lstOrg_1" />
                    <input bind="lstWG_1" />
                    <input bind="lstStatus" />
                    <input bind="idLeaveDays" />
                    <input bind="id_Ale" />
                    <input bind="idMonth" />
                    <input bind="idSearch" />
                    <input bind="id_Input" />
                    <input bind="lstNation" />
                    <input bind="dtFrom_DOJ" />
                    <input bind="dtTo_DOJ" />
                    <input bind="dtFrom_Left" />
                    <input bind="dtTo_Left" />
                    
                </input>
                <output  bind="idGrid" />
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dat_Annual_leave_2" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"   function="HR_sel_10020007_ale_exist" > 
                <input bind="idGrid" >
                    <input bind="lstOrg_1" />
                    <input bind="lstWG_1" />
                    <input bind="lstStatus" />
                    <input bind="idLeaveDays" />
                    <input bind="id_Ale" />
                    <input bind="idMonth" />
                    <input bind="idSearch" />
                    <input bind="id_Input" />
                    <input bind="lstNation" />
                    <input bind="dtFrom_DOJ" />
                    <input bind="dtTo_DOJ" />
                    <input bind="dtFrom_Left" />
                    <input bind="dtTo_Left" />
                </input>
                <output  bind="idGrid" />
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

<gw:data id="dat_Check_Option_Kind2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10020007_find_option" > 
                <input>
                   <input bind="dtYear1" /> 				   
                   <input bind="txtOption" />
                   <input bind="lstOrg_3" />  
                </input> 
                <output>
                    <output bind="txtOption" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_ale_lending" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_10020007_ale_lending" > 
                <input>
					<input bind="dtYear1" /> 
                    <input bind="dtMonth" /> 
					<input bind="lstOrg_3" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_ale_cancel" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_pro_10020007_del_lending" > 
                <input>
					<input bind="dtYear1" /> 
                    <input bind="dtMonth" /> 
					<input bind="lstOrg_3" /> 
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_Annual_year_amt" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,17,18,23" function="HR_sel_10020007_ale_year_amt" procedure="hr_upd_10020007_ale_year_amt"> 
                <input bind="idGrid2" >
                    <input bind="lstOrg_2" />
                    <input bind="lstWG_2" />
                    <input bind="dtYear" />
                    <input bind="idSearch2" />
                    <input bind="id_Input2" />
                    <input bind="lst_Status2" />
                    <input bind="lstNation2" />
                    
                </input>
                <output  bind="idGrid2" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_wg_role"  > 
                <input>
                    <input bind="txtOrg_tmp" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_Open_Close2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10020007_open_close_2" > 
                <input>
                    <input bind="dtYear1" /> 
                    <input bind="dtMonth" /> 
					<input bind="lstOrg_3" /> 
                    <input bind="txtFLAG2" /> 
                </input> 
                <output>
                    <output bind="txtResult2" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_ale_pay_tab3" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19" function="HR_sel_10020007_ale_tab3" procedure="HR_upd_10020007_ale_tab3"> 
                <input bind="idGrid_tab_3" >
                    <input bind="lstOrg_tab_3" />
                    <input bind="lstWG_tab_3" />
                    <input bind="lstStatus_tab_3" />
                    <input bind="idLeaveDays_tab_3" />
                    <input bind="id_Ale_tab_3" />
                    <input bind="idMonth_tab_3" />
                    <input bind="idSearch_tab_3" />
                    <input bind="id_Input_tab_3" />
                    <input bind="lstNation_tab_3" />
                    <input bind="dtFrom_DOJ_tab_3" />
                    <input bind="dtTo_DOJ_tab_3" />
                    <input bind="idPaylist_tab_3" />
                </input>
                <output  bind="idGrid_tab_3" />
            </dso> 
        </xml> 
</gw:data>

<!--------------------------------------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate="ChangeTab()"  > 

   <table name="Annual Leave" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
        <tr>
            <td>
            
	<table style="width:100%;height:20%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
        
	    <tr style="height:5%;border:1">	
		    <td colspan=2 align=right style="width:10%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup(1)" href="#tips" >Organization</a></td>
		    <td colspan=3 align=right style="width:12%;border:1" ><gw:list  id="lstOrg_1"  value="ALL" styles='width:100%' onchange="datCheck_year.Call()" >
                <data>
                    <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                    </data>
                </gw:list>
            </td>
		    <td align=right style="width:5%;border:1" >Status</td>
		    <td colspan=2 align=right style="width:10%;border:1" ><gw:list  id="lstStatus" value='A' styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0022' ORDER BY B.CODE")%>|ALL|Select All</data></gw:list>
             </td>
             <td  colspan=2 align=right style="width:8%;border:1" >Search by</td>
		     <td align=right style="width:7%;border:1" ><gw:list id="idSearch" styles="color:black" value="1" styles='width:100%'> 
		        <data>List|1|Emp ID|2|Card ID|3|Name</data></gw:list ></td>
		    <td colspan=2 align=right style="width:10%;border:1" ><gw:textbox id="id_Input"	styles="width:100%" onenterkey="OnSearch1()" /></td>
		    <td colspan=1 align=right style="width:6%;border:1" >Join Date</td>
		    <td colspan=1 align=right style="width:8%;border:1" ><gw:datebox id="dtFrom_DOJ" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
		    <td colspan=1 align=center style="width:3%;border:1" >~</td>
		    <td colspan=1 align=right style="width:8%;border:1" ><gw:datebox id="dtTo_DOJ" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
		    <td align=right style="width:4%;border:1" ><gw:imgBtn id="idBtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch1()" /></td>
		    <td align=right style="width:5%;border:1" ><gw:imgBtn id="idBtnUpdate" alt="Save" img="Save" text="Save" onclick="OnUpdate()" /></td>
		    <td align=right style="width:5%;border:1" ><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport(0)" /></td>
        </tr>	
        <tr style="height:5%;border:1">	
		     <td colspan=2 align=right style="width:5%;border:1" >Work Group</td>
		    <td colspan=3 align=right style="width:15%;border:1" ><gw:list  id="lstWG_1" value="ALL"  styles='width:100%' >
                            <data>
                                <%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0") %>|ALL|Select All
                            </data></gw:list></td>
		    
		    <td align=right style="width:5%;border:1" >Nation</td>
		    <td colspan=2 align=right style="width:10%;border:1" ><gw:list  id="lstNation" value='01' styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0009' ORDER BY B.CODE")%>|ALL|Select All</data></gw:list></td>
		     <td colspan=2 align=right style="width:10%;border:1" >ALE Unused</td>
		    <td align=right style="width:7%;border:1" ><gw:list id="idLeaveDays" styles="color:black" value="1" styles='width:100%'> 
		        <data>List|1|>=|2|=|3|<=</data></gw:list >
			</td>
		    <td colspan=2 align=right style="width:3%;border:1" ><gw:textbox id="id_Ale"	maxlen = "2" styles="width:100%" onkeypress="return Numbers(event)" onenterkey="OnSearch1()"/></td>
		    <td colspan=1 align=right style="width:6%;border:1" >Left Date</td>
		    <td colspan=1 align=right style="width:8%;border:1" ><gw:datebox id="dtFrom_Left" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
		    <td colspan=1 align=center style="width:3%;border:1" >~</td>
		    <td colspan=1 align=right style="width:8%;border:1" ><gw:datebox id="dtTo_Left" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
		    
		   
        </tr>	
        
        <tr style="height:5%;border:1">	
		    <td align=left colspan=2 style="width:5%;border:1" >ALL<gw:checkbox id="chkCheck" value="F" onclick="OnSetGrid()" ></gw:checkbox ></td>
		    <td colspan=1 align=right style="width:5%;border:0" >Month</td>
		    <td colspan=2 align=right style="width:15%;border:1;white-space:nowrap" ><gw:datebox id="idMonth"  maxlen = "10" text="" styles='width:50%'lang="<%=Session("Lang")%>" type=month onchange="OnChangeDate()" /></td>
		    <td align=right style="width:5%;border:1" ></td>
		    <td align=right style="width:5%;border:1" ><gw:icon id="idBtnOpen" img="in" text="Open" onclick="Open_Close('OPEN')" /></td>
		    <td align=right style="width:5%;border:1" ><gw:icon id="idBtnClose" img="in" text="Close" onclick="Open_Close('CLOSE')" /></td>
		    
		    <td colspan=4 align=center style="width:30%;border:1" ><gw:label id="idrecord" styles="width:100%;color:red"></gw:label></td>
        </tr>
	</table>
	<table id="tbl" style="width:100%;height:80%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
		<tr style="height:100%">
			<td id="master" width="100%">
				    <!--0_pk|1Pay|2Group|3Emp_ID|4Name|5D.O.J|6AL Last Year|7AL in Year|8AL Real|9Last Year Lend ABS|10In Year Lend ABS|11Last Year AL Option2|12In Year AL Option2|13Used|14Unused|15Unused in Year|16Pay |17Unpay|18JAN|19FEB|20MAR|21APR|22MAY|23JUN|24JUL|25AUG|26SEP|27OCT|28NOV|29DEC-->
				<gw:grid   
				id="idGrid"  
				header="_pk|Pay|Organization|Emp_ID|Name|D.O.J|AL Last Year|AL in Year|AL Paid|AL Total|Used|Unused|Unused in Year|Pay |Unpay|JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC"   
               	format="0|3|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
				aligns="2|2|2|2|2|2|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"  
				defaults="|||||||||||||||||||||||||||"  
			    editcol="0|0|0|0|0|0|0|1|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    widths="0|500|1500|1000|2500|1500|1500|1200|1200|1200|1500|1000|1000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
				styles="width:100%; height:100%"   
				sorting="T"   
				oncelldblclick = "Popup()"/> 
			</td>
		</tr>	
	</table>
	</td>
        </tr>
</table>
<table name="Yearly Payment" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1"    >
        <tr style="width:100%;height:100%" >
            <td>
	             <table id="tr_month" cellpadding="0" style="width:100%;height:6%" cellspacing="0" width="100%"  border="0" >
                    <tr >
						<td align=right style="width:8%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup(3)" href="#tips" >Organization</a></td>
						<td  align=right style="width:15%;border:1" ><gw:list  id="lstOrg_3"  styles='width:100%' onchange="" >
							<data>
								<%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
								</data>
							</gw:list>
						</td>
						<td width="10%"  align="right" valign="middle"  class="bottom"><gw:datebox id="dtYear1"  text="" maxlen = "4" type="year" lang="<%=Session("Lang")%>"onchange="OnChangeYear()"/> </td>
                        <td width="20%"  align="right" valign="middle" class="bottomleft" style="font-size:3"><font>Calculate until month</font></td>
                        <td width="10%"  align="left" valign="middle"  class="bottom"><gw:datebox id="dtMonth"  text="" maxlen = "10" type="month" lang="<%=Session("Lang")%>"onchange="OnChangeMonth()"/> </td>
                        <td width="8%" align="right" valign="middle"  class="bottomright"><gw:icon id="icoProcess" img="in" text="Process" onclick="on_Process()" /></td>
                        <td width="10%" align="center" valign="middle"  class="bottomright"><gw:icon id="icoProcess2" img="in" text="Cancel" onclick="on_Cancel()" /></td>
						<td align=right style="width:5%;border:1" ><gw:icon id="idBtnOpen2" img="in" text="Open" onclick="Open_Close2('OPEN')" /></td>
						<td align=right style="width:5%;border:1" ><gw:icon id="idBtnClose2" img="in" text="Close" onclick="Open_Close2('CLOSE')" /></td>						
                        <td width="10%"  align="right" valign="middle" class="bottom"style="color=#FF3300"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
                        
                    </tr>
                </table>
              <table id="tr_month2" style="width:100%;height:12%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
                    <tr style="height:6%;border:1">	
                        <td width="1%" style="border:0;" align="right" ><img status="hide" id="img2" alt="Show month salary information" src="../../../system/images/close_popup.gif" style="cursor:hand" onclick="OnToggle()"  /></td>
                        <td align=right style="width:5%;border:1" ><b>Year</b></td>
                        <td colspan=2 align=right style="width:10%;border:1" ><gw:datebox id="dtYear"  text="" maxlen = "10" type="year" lang="<%=Session("Lang")%>"  /></td>
	                    <td colspan=2 align=right style="width:10%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup(2)" href="#tips" >Organization</a></td>
	                    <td colspan=3 align=right style="width:15%;border:1" ><gw:list  id="lstOrg_2"  value="ALL" styles='width:100%' onchange="onChange_org()" >
                            <data>
                                 <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                             </data>
                            </gw:list>
                        </td>
	                    <td align=right style="width:10%;border:1" >Work Group</td>
	                    <td colspan=3 align=right style="width:15%;border:1" ><gw:list  id="lstWG_2" value="ALL"  styles='width:100%' >
                                        <data> <%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0") %>|ALL|Select All
                                        </data></gw:list></td>
                        <td colspan=1 align=right style="width:5%;border:1" >Search</td>
		                <td align=right colspan=2 style="width:8%;border:1" ><gw:list id="idSearch2" styles="color:black" value="1" styles='width:100%'> 
		                                        <data>List|1|Emp ID|2|Card ID|3|Name</data></gw:list ></td>
		                <td colspan=2 align=right style="width:7%;border:1" ><gw:textbox id="id_Input2"	styles="width:100%" onenterkey="OnSearch2()" /></td>                        
	                    <td align=right style="width:3%;border:1" ><gw:imgBtn id="idBtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch2()" /></td>
	                    <td align=right style="width:3%;border:1" > <gw:imgBtn id="idBtnUpdatePay" alt="Save" img="Save" text="Save" onclick="OnUpdatePay()" /></td>
	                    <td align=right style="width:3%;border:1" ><gw:imgBtn id="ibtnRpt" alt="Report" img="excel" text="Report" onclick="OnReport(2)" /></td>
	                    
                    </tr>	
                    <tr style="height:6%;border:1">	
                        <td align=left  style="width:5%;border:1" >Status</td>
                        <td align=left colspan=1 style="width:11%;border:1" >
                        <gw:list  id="lst_Status2" value="A"  styles='width:100%' >
                                        <data>List|A|Active|R|Resign_L|Y|Resign_I|ALL|Select All
                                        </data></gw:list>
	                    
                        </td>
                        <td align=left  style="border:1" >Nation</td>
                        <td align=left colspan=1 style="width:10%;border:1" >
                      <gw:list  id="lstNation2" value='01' styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0009' ORDER BY B.CODE")%>|ALL|Select All</data></gw:list>
	                    
                        </td>
                        
                        <td align=left colspan=2 style="width:5%;border:1" ><gw:label id="idrecord2" styles="width:100%;color:red"></gw:label></td>                 
	                     
                        <td colspan=3 align=right style="width:10%;border:1" ><gw:list  id="lstPay" value="ALL"  styles='width:100%' >
                                        <data>|1|Company Pay|2|Employee Pay</data></gw:list></td>
	                    <td align=right colspan=1  style="width:5%;border:1" >Condition</td>
	                                       
	                    
	                    <td colspan=2 align=right style="width:5%;border:0" ><gw:list  id="lstCon" value="4"  styles='width:100%' >
                                        <data>|1|>|2|<|3|=|4|ALL</data></gw:list></td>
	                    <td colspan=1 align=left style="width:5%;border:1" ><gw:textbox id="txtCon"  styles='width:100%'/></td>
	                    <td align=right colspan=3 style="border:1" >Set Value</td>
	                    <td colspan=2 align=right style="border:1" > <gw:textbox id="txtDay"  styles='width:100%'/></td>
                        <td colspan=1 align=left style="width:10%;border:1" ><gw:imgBtn id="ibtnSet" alt="Set Grid" img="set" text="" onclick="OnSetToGrid()" /></td>
		                <td align=right style="width:5%;border:1" ></td>
		                <td colspan=3 align=right style="width:10%;border:1" ></td>                        
	                  
                    </tr>
            </table>
            <table id="tr_month3" style="width:100%;height:80%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	            <tr style="height:80%">
		            <td id="Td1" width="100%">
			            <!--_PK0|1Pay|2Organization|3Group|4Emp_ID|5Name|6D.O.J|7AL Last|8al in year|9al plus|8AL Real|9AL Used|10LastY Lend AL ABS|11Lend AL ABS|12LastY AL Option2|13Lend AL Option2|14Unused|15Company Pay|16Emp pay|17Salary|18_EmpPayAMT|19Total Amount|20Unpay|_year-->				
			            <gw:grid   
			            id="idGrid2"  
			            header="_PK|Pay|Organization|Group|Emp_ID|Name|D.O.J|AL Last|AL In Year|AL Paid|AL Total|AL Used|LastY Lend|In Year Lend|LastY AL Option2|In Year AL Option2|Unused|Company Pay|Emp pay|Salary|_EmpPayAMT|Total Amount|Unpay|_year"   
			            format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|1|0|0"  
			            aligns="2|2|2|2|2|2|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1"  
			            defaults="|||||||||||||||||||||||"  
			            editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|1|1|0|0|0|0|0"  
			            widths="0|500|1000|3000|1000|1200|1200|1200|1200|1200|1200|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|1000|0"  
			            styles="width:100%; height:100%"   
			            sorting="T"   
			            oncelldblclick = "OnShowPopUp2()"/> 
		            </td>
	            </tr>	
            </table>
	        </td>
        </tr>
</table>
<table name="Monthly Payment" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1"    >
        <tr style="width:100%;height:100%" >
            <td>
	             <table id="Table1" cellpadding="0" style="width:100%;height:100%" cellspacing="0" width="100%"  border="0" >
                    <tr style="height:1%;border:1">	
						<td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                        <td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td><td width="1%">&nbsp;</td>
                    </tr>
	                <tr style="height:5%;border:1">	
		                <td colspan=10 align=right style="width:10%;border:0" ><a title="Click here to show organization" onclick="OnShowPopup(3)" href="#tips" >Organization</a></td>
		                <td colspan=20 align=right style="width:12%;border:1" ><gw:list  id="lstOrg_tab_3"  value="ALL" styles='width:100%' onchange="" >
                            <data>
                                <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                </data>
                            </gw:list>
                        </td>
		                <td colspan=10 align=right style="width:5%;border:1" >Status</td>
		                <td colspan=10 align=right style="width:10%;border:1" ><gw:list  id="lstStatus_tab_3" value='A' styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0022' ORDER BY B.CODE")%>|ALL|Select All</data></gw:list>
                         </td>
		                <td colspan=10 align=right style="width:6%;border:1" >Join Date</td>
		                <td colspan=10 align=right style="width:8%;border:1" ><gw:datebox id="dtFrom_DOJ_tab_3" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
		                <td colspan=1 align=center style="width:3%;border:1" >~</td>
		                <td colspan=10 align=right style="width:8%;border:1" ><gw:datebox id="dtTo_DOJ_tab_3" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
                        <td colspan=1 align=right style="width:5%;border:1" >&nbsp;</td>
                        <td colspan=5 align=right style="width:4%;border:1" ><gw:imgBtn id="idBtnSearch_tab_3" alt="Search" img="Search" text="Search" onclick="OnSearch_tab3()" /></td>
		                <td colspan=5 align=right style="width:5%;border:1" ><gw:imgBtn id="idBtnUpdate_tab_3" alt="Save" img="Save" text="Save" onclick="OnUpdate_tab_3()" /></td>
                        <td colspan=5 align=right style="width:5%;border:1" ><gw:imgBtn id="idBtnDelete_tab_3" alt="delete" img="Delete" onclick="OnDelete_tab_3()" /></td>
		                <td colspan=5 align=right style="width:5%;border:1" ><gw:imgBtn id="ibtnRpt_tab_3" alt="Report" img="excel" text="Report" onclick="OnReport_tab_3()" /></td>
                    </tr>	
                    <tr style="height:5%;border:1">	
		                <td colspan=10 align=right style="width:5%;border:1" >Work Group</td>
		                <td colspan=20 align=right style="width:15%;border:1" ><gw:list  id="lstWG_tab_3" value="ALL"  styles='width:100%' >
                                        <data>
                                            <%=ESysLib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0") %>|ALL|Select All
                                        </data></gw:list></td>
		    
		                <td colspan=10 align=right style="width:5%;border:1" >Nation</td>
		                <td colspan=10 align=right style="width:10%;border:1" ><gw:list  id="lstNation_tab_3" value='01' styles='width:100%' >
                                        <data><%=ESysLib.SetListDataSQL("SELECT B.CODE,B.CODE_NM FROM VHR_HR_CODE B WHERE B.ID='HR0009' ORDER BY B.CODE")%>|ALL|Select All</data></gw:list>
                                   </td>
                        <td colspan=10 align=right style="width:5%;border:1" >Search By</td>
		                <td colspan=10 align=right style="width:7%;border:1" ><gw:list id="idSearch_tab_3" styles="color:black" value="1" styles='width:100%'> 
		                    <data>List|1|Emp ID|2|Card ID|3|Name</data></gw:list ></td>
		                <td colspan=10 align=right style="width:10%;border:1" ><gw:textbox id="id_Input_tab_3"	styles="width:100%" onenterkey="OnSearch_tab3()" /></td>
                        <td colspan=20 align=center style="width:30%;border:1" ><gw:label id="idrecord_tab_3" styles="width:100%;color:red"></gw:label></td>
		                
                    </tr>	
        
                    <tr style="height:5%;border:1">	
		                <td colspan=10 align=right style="width:5%;border:0" >Month</td>
		                <td colspan=10 align=right style="width:15%;border:1;white-space:nowrap" ><gw:datebox id="idMonth_tab_3"  maxlen = "10" text="" styles='width:50%'lang="<%=Session("Lang")%>" type=month onchange="" /></td>

                         <td colspan=10 align=right style="width:7%;border:1" ><gw:list id="idPaylist_tab_3" styles="color:black" onchange="onChangeLst_Type()" value="1" styles='width:100%'> 
		                    <data>List|01|New List|02|Paid List</data></gw:list >
                         </td>

		                <td colspan=10 align=right style="width:5%;border:0" >Set Annual Pay</td>
                        <td colspan=10 align=right style="width:3%;border:1" ><gw:textbox id="id_SetAlePay_tab_3"	maxlen = "4" styles="width:100%" /></td>
                        <td colspan=5 align=left style="width:10%;border:1" ><gw:imgBtn id="ibtnSet_tab_3" alt="Set Grid" img="set" text="" onclick="OnSetToGrid_tab_3(1)" /></td>

                        <td colspan=5 align=right style="width:5%;border:0" >Type</td>
                        <td colspan=10 align=right style="width:7%;border:1" ><gw:list id="idadj_type_tab_3" styles="color:black" onchange="" value="1" styles='width:100%'> 
		                    <data>List|1|Pay Ale|2|Adjust</data></gw:list >
                         </td>
                        <td colspan=5 align=left style="width:10%;border:1" ><gw:imgBtn id="ibtnSetType_tab_3" alt="Set Grid" img="set" text="" onclick="OnSetToGrid_tab_3(2)" /></td>

                        <td colspan=10 align=right style="width:10%;border:1" >Unused(In Year)</td>
		                <td colspan=5 align=right style="width:7%;border:1" ><gw:list id="idLeaveDays_tab_3" styles="color:black" value="1" styles='width:100%'> 
		                    <data>List|1|>=|2|=|3|<=</data></gw:list >
			            </td>
		                <td colspan=10 align=right style="width:3%;border:1" ><gw:textbox id="id_Ale_tab_3"	maxlen = "4" styles="width:100%"  onenterkey="OnSearch_tab3()"/></td>
		                
                    </tr>
                    <tr style="height:84%">
			            <td colspan=100 id="Td2" width="100%">
				                <!--0_pk|1Pay|2Group|3Emp_ID|4Name|5D.O.J|6AL Last Year|7AL in Year|8AL Real|9Last Year Lend ABS|10In Year Lend ABS|11Last Year AL Option2|12In Year AL Option2|13Used|14Unused|15Unused in Year|16Pay |17Unpay|18JAN|19FEB|20MAR|21APR|22MAY|23JUN|24JUL|25AUG|26SEP|27OCT|28NOV|29DEC-->
				            <gw:grid   
				            id="idGrid_tab_3"  
				            header="_pk|_thr_emp_pk|Organization|Emp_ID|Name|D.O.J|AL Last Year|AL in Year|AL Paid|AL Total|Used|Unused|Unused in Year|Ale Pay|Salary|Ale Pay Amount|By Hand|Adjust Type|Description|_work_mon"   
               	            format="0|0|0|0|0|4|0|0|0|0|0|0|0|-2|-0|-0|3|0|0|0"  
				            aligns="2|2|2|2|2|2|1|1|1|1|1|1|1|1|1|1|1|1|1|1"  
				            defaults="||||||||||||||||||||"  
			                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|1|0|0|1|1|1|0"     
			                widths="1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"  
				            styles="width:100%; height:100%"   
				            sorting="T"   
				            oncelldblclick="OnClickRow()"  onafteredit="setByHand()"/> 
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
    <gw:textbox id="txtOrgData" styles="display:none"/>
    <gw:textbox id="txtUpperOrg" styles="display:none"/>
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>
    <gw:textbox id="txtOrg_temp" styles="display:none"/>
    <gw:textbox id="txtOrg" styles="display:none"/>
    <gw:textbox id="txtMonthClose" styles="display:none"/>
	<gw:textbox id="txtClose" styles="display:none"/>
	<gw:textbox id="txtExist_ale" styles="display:none"/>
    <gw:textbox id="txtClose_ale" styles="display:none"/>
    <gw:textbox id="txtOption" styles="display:none"/>
    <gw:textbox id="txtwg_tmp" styles="display:none"/>    
    <gw:textbox id="txtOrg_tmp" styles="display:none"/>    
    <gw:textbox id="menu_id" text="" styles="display:none"  />
    <gw:textbox id="txtFlag_View" text="" styles="display:none"  />
	<gw:textbox id="txtFLAG2" styles="display:none"/>
	<gw:textbox id="txtResult2" styles="display:none"/>
</body>
</html>
