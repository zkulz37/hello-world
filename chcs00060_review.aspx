<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var startTime,interval_time
var ajax_test;
var v_fac=0;
var process_flag=0;
var root_temp="";
var count_flag=0;
var check_init=0;
var flag_stop=0;

var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
   iduser_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>"; 
   menu_id.text=System.Menu.GetMenuID();
   idBtStop.style.display='none';
   
   idFrom.SetEnable(false);
   idTo.SetEnable(false);

   grd_chk.style.display='none';

   ChangeColorItem(lstLocation_pk.GetControl());

   var data = "<%=ESysLib.SetListDataSQL("select PR.num_1,(case when PR.num_1=1 then 'NORMAL' ELSE 'RESIGNATION' END) PERIOD_NAME from (select v.num_1 from vhr_hr_code v where v.id='HR0030' group by v.num_1) PR ")%>";   
        lstSalaryType.SetDataText(data);

   datCheck_View.Call();
   
        
	
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
 idInterval.text= Math.round((d.valueOf()-start)/x);

}

function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}

function set_Interval2(x) 
{
 startTime = new Date().valueOf();
 interval_time=setInterval("clock2(" + startTime + "," + x  + ")",x);
}
function clock2(start,x) 
{
 
}


function onchange_month()
{
   
    txtResult.text="";
	if(txtProcessSalary.text=="1") 
	    datGet_from_to.Call();
	else if(lstSalaryKind.value!="")
	   {
	    datGet_from_to.Call();
	   }
}
function ChangeSalaryKind()
{  
    txtResult.text="";
  if(lstSalaryKind.value!='')
   { txtResult.text="";
	datGet_from_to.Call();
	}
}
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datCheck_View":
          if(txtFlag_View.text == 'Y')
          {
              idBtnProcess.style.display = "none";
              idBtnDelete.style.display = "none";
          }
          else
          {
               // alert(iduser_pk.text);
              if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
                     datUser_info.Call(); 
              else                 
                    datGet_period.Call();
          }
            break;
        case "datUser_info":
                ChangeColorItem(lstLocation_pk.GetControl());
               datGet_period.Call();
               break;
        case "datGet_period":
            datGet_from_to.Call();
		    break;
		case "datGet_from_to":
            //alert(txtProcess.text);
              grd_chk.style.display='none';
		      if(txtProcessSalary.text=='2')
                    idSAL_KIND.text="Resign Salary";
		      else
	    	      idSAL_KIND.text="Month Salary";
		      
		      
		      if(txtResult.text=='Y')
		      {
		        idInterval.text="This Month Closed."
		        idBtnProcess.SetEnable(0);
		        idBtnDelete.SetEnable(0);
		      }
		      else if(txtResult.text=="")
		      {
		        idInterval.text="This Month Not Register."
		        idBtnProcess.SetEnable(0);
		        idBtnDelete.SetEnable(0);
		      }
		     else if(txtProcess.text=='N')
		        {
		            idInterval.text="Month Salary haven't create"
		            idBtnProcess.SetEnable(0);
		            idBtnDelete.SetEnable(0);
		        }
            else if(txtProcess.text=='C')
		        {
		            idInterval.text="Month Salary have new data."
		            //idBtnProcess.SetEnable(0);
		            //idBtnDelete.SetEnable(0);
                    grd_chk.style.display='';
                    datShowDeatail_error.Call("SELECT");
                    return;
		        }
		      else
		      {
		        idBtnProcess.SetEnable(1);
		        idBtnDelete.SetEnable(1);
		        txtAllow_count.text="";
		        idInterval.text="";
		       
		      }  
		      datGet_allowance.Call();
		    break;    
		 case "datGet_allowance":  
		     check_init=1;   
		     break;   
		 case "datProcess_WT":  
		    if(txtResult.text=='0')
		    {
		        if(flag_stop==0)
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
                    idProcess_status.text="Task 3 is processing..."
		            set_Interval(1000);
		            datProcess_OT.Call();
		        }
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
                    idInterval.text="User cancel."
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idProcess_status.text="";
		        }
		    }
		    else
		    {
		        alert("Error:Step 1(Working Month) Uncomplete.\n Lỗi: Bảng công tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
                flag_stop=0;
                idBtStop.style.display='none';
                idProcess_status.text="";
		    }     
		    break;
		  case "datProcess_OT":  
		    if(txtResult.text=='0')
		    {
		        if(flag_stop==0)  
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
                    idProcess_status.text="Task 4 is processing..."
		            set_Interval(1000);
		            datProcess_ABS.Call();
		        }    
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
                    idInterval.text="User cancel."
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idProcess_status.text="";
		        }
		    }
		    else
		    {
		        alert("Error:Step 2(Extra Month) Uncomplete.\n Lỗi: Bảng T.Ca tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
                flag_stop=0;
                    idBtStop.style.display='none';
                    idProcess_status.text="";
		    }    
		    break;
			case "datProcess_WT_resign": 
            if(txtResult.text=='0')
		    { 
		        if(flag_stop==0)
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    idProcess_status.text="Task 2 is processing..."
                    set_Interval(1000);
                    datProcess_OT_resign.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idInterval.text="User Cancel"
                    idProcess_status.text="";
                }
                   
	        }   
		    else
		    {
		        alert("Error:Step 1(Working Month resign) Uncomplete.\n Lỗi: Bảng công tháng nghỉ việc không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
		  case "datProcess_OT_resign":  
          if(txtResult.text=='0')
		    { 
		        if(flag_stop==0)
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    idProcess_status.text="Task 3 is processing..."
                    set_Interval(1000);
                    datProcess_ABS_resign.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idInterval.text="User Cancel"
                    idProcess_status.text="";
                }
                   
	        }   
		    else
		    {
		        alert("Error:Resign Step 2(Extra Month) Uncomplete.\n Lỗi: Bảng T.Ca nghỉ việc tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
		 case "datProcess_ABS_resign":  
            if(txtResult.text=='0')
		    { 
		        if(flag_stop==0)
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    idProcess_status.text="Task 4 is processing..."
                    set_Interval(1000);
                    datMonth_summary_resign.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idInterval.text="User Cancel"
                    idProcess_status.text="";
                }
                   
	        }   
		    else
		    {
		        alert("Error:Step 3(Absence Month resign) Uncomplete.\n Lỗi: Bảng vắng tháng nghỉ việc không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
			case "datProcess_ABS":  
		    if(txtResult.text=='0')
		    {
		        if(flag_stop==0)
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
                    idProcess_status.text="Task 5 is processing..."
		            set_Interval(1000);
		            datMonth_summary.Call();
		        }    
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
                     idInterval.text="User cancel."
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idProcess_status.text="";
		        }
		    }
		    else
		    {
		        alert("Error:Step 3(Absence Month) Uncomplete.\n Lỗi: Bảng vắng tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
                flag_stop=0;
                idBtStop.style.display='none';
                idProcess_status.text="";
		    }    
		    break;
		case "datMonth_summary":  
		    if(txtResult.text=='0')
		    {
		        if(flag_stop==0)  
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            count_flag=0;
		            if(Number(txtAllow_count.text)>0)
		            {
		                count_flag+=1;
		                if(count_flag<=Number(txtAllow_count.text))    
		                {
		                    txt_allowance_kind.text="0"+""+count_flag;
                            idProcess_status.text="Task allowance " + count_flag+ " is processing..."
		                    set_Interval(1000);
		                    datProcess_Allowance.Call();
		                }   
		                
		            }
		            else
	                {
	                    
                                set_Interval(1000);
                                idProcess_status.text="Salary task 1 is processing..."
                                datProcess_Sal_s1.Call();
                        
	                }
		                
		        }
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
                    idInterval.text="User cancel."
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idProcess_status.text="";
		        }    
		    }
		    else
		    {
		        alert("Error:Step 4(Month Summary) Uncomplete.\n Lỗi: Bảng tóm tắt tháng tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idProcess_status.text="";
		    }    
		    break;  
case "datMonth_summary_resign":  
        if(txtResult.text=='0')
		    { 
		        if(flag_stop==0)
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    idProcess_status.text="Task 4 is processing..."
                    set_Interval(1000);
                    count_flag=0;
		            if(Number(txtAllow_count.text)>0)
		            {
		                count_flag+=1;
		                if(count_flag<=Number(txtAllow_count.text))    
		                {
		                   // txt_allowance_kind.text="0"+""+count_flag;
		                   txt_allowance_kind.text=grdAllowance.GetGridData(count_flag,0);
                           idProcess_status.text="Task allowance " + count_flag+ " is processing..."
		                    set_Interval(1000);
		                    datProcess_Allowance_resign.Call();
		                }   
		                
		            }
		            else
	                {
                                idProcess_status.text="Salary Task 1 is processing..."
                                txtResult.text==''
                                set_Interval(1000);
                                datProcess_Sal_s1_resign.Call();
	                }
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idInterval.text="User Cancel"
                    idProcess_status.text="";
                }
                   
	        }   
		    else
		    {
		        alert("Error:Step 4(Month Summary resign) Uncomplete.\n Lỗi: Bảng tóm tắt nghỉ việc tháng tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;    
		case "datProcess_Allowance":  
		    if(txtResult.text=='0')
		    {
		            if(flag_stop==0)
		            {
		                txtResult.text='';
		                clear_Interval(idInterval);
    		            
	                    count_flag+=1;
	                    if(count_flag<=Number(txtAllow_count.text))    
	                    {
	                       // txt_allowance_kind.text="0"+""+count_flag;
	                       txt_allowance_kind.text=grdAllowance.GetGridData(count_flag,0)
                           idProcess_status.text="Task allowance "+count_flag +" is processing...";
	                       //alert(txt_allowance_kind.text);
	                        set_Interval(1000);
	                        datProcess_Allowance.Call();
	                    }   
	                    else
	                    {
	                        clear_Interval(idInterval);
                                idProcess_status.text="Salary task 1 is processing...";
	                            set_Interval(1000);
	                            datProcess_Sal_s1.Call();
	                    }
		            }  
		            else    
		            {
		                txtResult.text='';
		                clear_Interval(idInterval);
                        idInterval.text="User Cancel."
                        flag_stop=0;
                        idBtStop.style.display='none';
                        idProcess_status.text="";
		            }  
		    }
		   else
		    {
		        alert("Allowance kind "+count_flag+" uncompleted?\n Phụ cấp loại "+count_flag+" bị lỗi.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
                flag_stop=0;
                        idBtStop.style.display='none';
                        idProcess_status.text="";
		    }    
		    break; 
	
					
		case "datProcess_Allowance_resign":  
            if(txtResult.text=='0')
		    {
		            if(flag_stop==0)
		            {
		                txtResult.text='';
		                clear_Interval(idInterval);
    		            
	                    count_flag+=1;
	                    if(count_flag<=Number(txtAllow_count.text))    
	                    {
	                       // txt_allowance_kind.text="0"+""+count_flag;
	                       txt_allowance_kind.text=grdAllowance.GetGridData(count_flag,0)
                           idProcess_status.text="Task allowance "+count_flag +" is processing...";
	                       //alert(txt_allowance_kind.text);
	                        set_Interval(1000);
	                        datProcess_Allowance_resign.Call();
	                    }   
	                    else
	                    {
	                        clear_Interval(idInterval);
                                idProcess_status.text="Salary task 1 is processing...";
	                            set_Interval(1000);
	                            datProcess_Sal_s1_resign.Call();
	                    }
		            }  
		            else    
		            {
		                txtResult.text='';
		                clear_Interval(idInterval);
                        idInterval.text="User Cancel."
                        flag_stop=0;
                        idBtStop.style.display='none';
                        idProcess_status.text="";
		            }  
		    }
		    else
		    {
		        alert("Allowance kind "+count_flag+" uncompleted?\n Phụ cấp loại "+count_flag+" bị lỗi.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break; 
		
		 case "datProcess_holiday_resign": 
		    if(txtResult.text=='0')
		    { 
		        if(flag_stop==0)
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    idProcess_status.text="Task 2 is processing..."
                    set_Interval(1000);
                    datProcess_WT_resign.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idInterval.text="User Cancel"
                    idProcess_status.text="";
                }
                   
	        }      
	        else
	        {
	            alert("There is error at step 1 of Resign Salary process.\nĐã có lỗi xảy ra ở bước 1 Hệ thống tính lương nghỉ việc .")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step1 Error."
	        }
	        break;
	   case "datProcess_Sal_s1_resign": 
            if(txtResult.text=='0')
		    { 
		        if(flag_stop==0)
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    idProcess_status.text="Salary task 2 is processing..."
                    set_Interval(1000);
                    datProcess_Sal_s2_resign.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idInterval.text="User Cancel"
                    idProcess_status.text="";
                }
                   
	        }   
	        else
	        {
	            alert("There is error at step 1 of Resign salary process.\nĐã có lỗi xảy ra ở bước 1 Hệ thống tính lương.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step1 Error."
	        }
	        break;          
	   case "datProcess_Sal_s2_resign": 
            if(txtResult.text=='0')
		    { 
		        if(flag_stop==0)
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    idProcess_status.text="Salary task 3 is processing..."
                    set_Interval(1000);
                    datProcess_Sal_s3_resign.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idInterval.text="User Cancel"
                    idProcess_status.text="";
                }
                   
	        }   
	        else
	        {
	            alert("There is error at step 2 of resign salary process.\nĐã có lỗi xảy ra ở bước 2 Hệ thống tính lương.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step2 Error."
	        }
	        break;     
	   case "datProcess_Sal_s3_resign": 
		    if(txtResult.text=='0')
		    { 
		        alert("System Resign  Salary process successful.\nHệ thống lương nghỉ việc đã hoàn thành.")
                txtResult.text='';
	            clear_Interval(idInterval);
	            idInterval.text="Successful."
                idProcess_status.text="";
	        }      
	        else
	        {
	            alert("There is error at step 3 of Resign Salary process.\nĐã có lỗi xảy ra ở bước 3 Hệ thống tính lương nghỉ việc.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step3 Error."
	        }
	        break;       
	  case "datDel_salary_resign": 
	        if(txtResult.text=='0')
		    {
		        alert("Delete successful.\nHệ thống xóa lương nghỉ việc đã hoàn thành.")
                txtResult.text='';
	            idInterval.text="Successful."  
		    }
		    else
		    {
		        alert("Error.\nĐã có lỗi xảy ra.")
                txtResult.text='';
	            idInterval.text="Unsuccessful."  
		    }
		    break;   
		    case "datProcess_holiday": 
		    if(txtResult.text=='0')
		    { 
                if(flag_stop==0)
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    idProcess_status.text="Task 2 is processing..."
                    set_Interval(1000);
                    datProcess_WT.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idInterval.text="User Cancel"
                    idProcess_status.text="";
                }
	        }      
	        else
	        {
	            alert("There is error at step 1 of Salary process.\nĐã có lỗi xảy ra ở bước 1 Hệ thống tính lương.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step1 Error."
                flag_stop=0;
                idBtStop.style.display='none';
                idProcess_status.text="";
	        }
	        break;
	   case "datProcess_Sal_s1": 
		     if(txtResult.text=='0')
		    { 
		        if(flag_stop==0)
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    idProcess_status.text="Salary task 2 is processing..."
                    set_Interval(1000);
                    datProcess_Sal_s2.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idInterval.text="User Cancel"
                    idProcess_status.text="";
                }
                   
	        }      
	        else
	        {
	            alert("There is error at step 1 of Salary process.\nĐã có lỗi xảy ra ở bước 1 Hệ thống tính lương.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step1 Error."
                flag_stop=0;
                idBtStop.style.display='none';
                idProcess_status.text="";
                    
	        }
	        break;             
	   case "datProcess_Sal_s2": 
		   if(txtResult.text=='0')
		    { 
		        if(flag_stop==0)
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    idProcess_status.text="Salary task 3 is processing..."
                    set_Interval(1000);
                    datProcess_Sal_s3.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                    flag_stop=0;
                    idBtStop.style.display='none';
                    idInterval.text="User Cancel"
                    idProcess_status.text="";
                }
                   
	        }      
	        else
	        {
	            alert("There is error at step 2 of Salary process.\nĐã có lỗi xảy ra ở bước 2 Hệ thống tính lương.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step2 Error."
                flag_stop=0;
                    idBtStop.style.display='none';
                    idProcess_status.text="";
                    
	        }
	        break;    
	   case "datProcess_Sal_s3": 
		   if(txtResult.text=='0')
		    { 
		        alert("System Salary process successful.\nHệ thống lương đã hoàn thành.")
                txtResult.text='';
	            clear_Interval(idInterval);
	            idInterval.text="Successful."
                flag_stop=0;
                    idBtStop.style.display='none';
                    idProcess_status.text="";
	        }      
	        else
	        {
	            alert("There is error at step 3 of Salary process.\nĐã có lỗi xảy ra ở bước 3 Hệ thống tính lương.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step3 Error."
                flag_stop=0;
                idBtStop.style.display='none';
                idProcess_status.text="";
	        }
	        break;       
	  case "datDel_salary": 
	        if(txtResult.text=='0')
		    {
		        alert("Delete successful.\nHệ thống xóa lương đã hoàn thành.")
                txtResult.text='';
	            idInterval.text="Successful."  
		    }
		    else
		    {
		        alert("Error.\nĐã có lỗi xảy ra.")
                txtResult.text='';
	            idInterval.text="Unsuccessful."  
		    }
		    break;   
	   
	   case "datCheck_Month_Salary":
           // alert(txtProcess.text);
            grd_chk.style.display='none';
            if(txtProcess.text=='N')
            {
                alert("Month Salary haven't create.\nSổ lương chưa được tạo");
                return;
            }
            if(txtProcess.text=='C')
            {
                if(!confirm("Month Salary has new data not yet create. Do you want to process?\n Có nhân viên chưa có trong sổ lương đã tạo. Tiếp tục?"))
                {
                    grd_chk.style.display='';
                    datShowDeatail_error.Call("SELECT");
                    return;
                }
                //return;
            }
            if(txtFlag_Cost.text == 'Y')
            {
                alert("Please check cost center data of employee.\n Bạn phải kiểm tra lại dữ liệu cost center của nhân viên.");
                return; 
            }
                if(txtProcessSalary.text=='1')
                    if(confirm("Salary is processing...do you want to continous?\nHệ thống tính lương bắt đầu...Bạn có muốn tiếp tục?"))
                    {
                        set_Interval(1000)
                        idBtStop.style.display='';
                        idProcess_status.text="Task 1 is processing..."
                        datProcess_holiday.Call();
                    }
                if(txtProcessSalary.text=='2')
                    if(confirm("Resign Salary is processing...do you want to continous?\nHệ thống tính lương nghỉ việc bắt đầu...Bạn có muốn tiếp tục?"))
                    {
                        set_Interval(1000)
                        idBtStop.style.display='';
                        idProcess_status.text="Task 1 is processing..."
                        datProcess_holiday_resign.Call();   
                    }   
              
	            
	   else
		    {
		        alert("Error.\nĐã có lỗi xảy ra.")
                txtResult.text='';
               
	            
		    }
		    break;   
	               
	        
    }

}
function on_Process()
{
    if(check_init==1)
        datCheck_Month_Salary.Call();     
   
  
}
function on_Delete()
{
if(txtProcessSalary.text=='1')
    if(confirm("Do you want to delete data for this month?\nBạn có muốn dữ liệu đã tính lương trong tháng này?"))
    {
       datDel_salary.Call(); 
    }
if(txtProcessSalary.text=='2')
	 if(confirm("Do you want to delete resign data for this month?\nBạn có muốn dữ liệu đã tính lương nghỉ việc trong tháng này?"))
    {
       datDel_salary_resign.Call(); 
    }
}

//----------------------------------
function OnShowPopup(n)
{
    
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:30;dialogLeft:280;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {		lstLocation_pk.value=obj;
        }
     
        
    
}

function OnChangeLocation()
{
	datGet_period.Call();
}

function on_Stop()
{
    flag_stop=1;   
}

function ChangeSalaryType()
{
    datGet_period.Call();
}

</script>
<style>
.top { border-top:2px solid #034D72; }
.topright { border-top :2px solid #034D72;
			border-right: 2px solid #034D72;;padding-right:10px
			}
.topleft {border-left:2px solid #034D72; 
			border-top :2px solid #034D72;
			}
.topleftright { border-top:2px solid #034D72; 
				border-left:2px solid #034D72;;
				border-right:2px solid #034D72;;
			}			
.left { border-left:2px solid #034D72; }
.right { border-right:2px solid #034D72;padding-right:10px }
.bottomright { border-bottom:2px solid #034D72; 
				border-right:2px solid #034D72; padding-right:10px
				}
.bottomleft { border-bottom:2px solid #034D72; 
				border-left:2px solid #034D72;;
			}
.bottomleftright { border-bottom:2px solid #034D72; 
				border-left:2px solid #034D72;;
				border-right:2px solid #034D72;;
			}			
.bottomtopleft	{ border-bottom:2px solid #034D72; 
				border-left:2px solid #034D72;;
				border-top:2px solid #034D72;;
			}			
.bottomtopright	{ border-bottom:2px solid #034D72; 
				border-right:2px solid #034D72;;
				border-top:2px solid #034D72;;
			}						
.bottomtop	{ 	border-bottom:2px solid #034D72;
				border-top:2px solid #034D72;;
			}					
.bottom { border-bottom:2px solid #034D72; }

#up { background-color:#DFF2FF; }
#down { background-color:#EAEAEA; }



</style>
<body>
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
            <dso  type="list" procedure="hr_lst_user_role2" > 
                <input>
                    <input bind="iduser_pk" /> 
                </input> 
                <output>
                    <output bind="lstLocation_pk" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="datGet_period" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_chcs00060_01"  > 
                <input>
                    <input bind="lstLocation_pk" />
                     <input bind="lstSalaryType" />
                </input> 
                <output>
                    <output bind="lstSalaryKind" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datGet_allowance" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0" function="hr_sel_10030006_allowance" procedure=""> 
                <input bind="grdAllowance" >
                   <input bind="lstLocation_pk" /> 
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGet_from_to" onreceive="OnDataReceive(this)"  > 
        <xml> 
                    <dso  type="process" procedure="hr_sp_pro_get_from_to_by_org" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                    
                </input> 
                <output>
                    <output bind="idFrom" />
                    <output bind="idTo" />
                    <output bind="txtResult" />
                    <output bind="txtProcess" />
                    <input bind="txtProcessSalary" />
                    <output bind="idSAL_ALL" />
                    <output bind="txtAllow_count" />
                    <output bind="txtFlag_Cost" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datCheck_Month_Salary" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_get_from_to_by_org" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                    
                </input> 
                <output>
                    <output bind="idFrom" />
                    <output bind="idTo" />
                    <output bind="txtResult" />
                    <output bind="txtProcess" />
                    <input bind="txtProcessSalary" />
                    <output bind="idSAL_ALL" />
                    <output bind="txtAllow_count" />
                    <output bind="txtFlag_Cost" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_holiday" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030006_Holiday_Manage" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_WT" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_PROCESS_MONTH_WT" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_OT" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_PROCESS_MONTH_OT" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_ABS" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_PROCESS_MONTH_ABS" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datMonth_summary" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_SUMMARY" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datProcess_Allowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_ALLOWANCE" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="txt_allowance_kind" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Sal_s1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030006_SALARY_S1" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="txtExRate" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Sal_s2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10030006_SALARY_S2" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="txtExRate" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Sal_s3" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10030006_SALARY_S3" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="txtExRate" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datDel_salary" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10030006_DEL_SALARY" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="txtExRate" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_holiday_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030006_Hol_Manage_R" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_WT_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_WT_RESIGN" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datProcess_OT_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_OT_RESIGN" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_ABS_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_ABS_RESIGN" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datMonth_summary_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_SUMMARY_RESIGN" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Allowance_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_SP_PRO_MONTH_RESIGN_ALLOW" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="txt_allowance_kind" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>




<gw:data id="datProcess_Sal_s1_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030006_SAL_RESIGN_S1" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="txtExRate" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>




<gw:data id="datProcess_Sal_s2_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030006_SAL_RESIGN_S2" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="txtExRate" />
                    <input bind="lstSalaryKind" />                
                    
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="datProcess_Sal_s3_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030006_SAL_RESIGN_S3" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="txtExRate" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datDel_salary_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10030006_DEL_SAL_RESIGN" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="txtExRate" />
                    <input bind="lstSalaryKind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!--grid check -------------->
<gw:data id="datShowDeatail_error" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid" function="hr_sel_00060_error" > 
                <input bind="grdChk" >
                   <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_pk" />
                    <input bind="lstSalaryKind" />
                    <input bind="txtProcessSalary" />
                </input>
                <output  bind="grdChk" />
            </dso> 
        </xml> 
</gw:data>





<form name="Salary Process" id="form1">
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="center" border="0" >
<tr>
	<td width="100%">
		<table class="itable"  style="width:80%;height:70%;border-left:0;border-top:0" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >
		         <tr style="height:2%">
					<td colspan=10 width="100%" align="center" >&nbsp;</td>
				</tr>
		       
		        <tr style="height:12%">
					<td colspan=10 class="topleftright" width="100%" align="center"><b style="font-size=20; color:Fuchsia">Salary Process Information</b></td>
				</tr>
				<tr style="height:12%">
					<td class="topleft" width="12%" align="right"><a title="Click here to show location" onclick="OnShowPopup()" href="#tips" >Location</a></td>
					<td class="topleft" width="2%" align="right">&nbsp;</td>
					<td class="top" colspan=6 width="60%" align="left" ><gw:list  id="lstLocation_pk" value='ALL'  styles='width:100%'onchange="OnChangeLocation()"  >
                            <data><%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%></data></gw:list></td>
                    <td colspan=2 class="topright" width="26%" align="right">&nbsp;</td>
				</tr>	
				<tr style="height:12%">
					<td class="topleft" width="23%" align="right">Salary Kind</td>
					<td class="topleft" colspan=3 align="right"><gw:list  id="lstSalaryType" value='' maxlen = "100" styles='width:90%' onchange="ChangeSalaryType()"></gw:list></td>

					<td class="top" colspan=4 align="right"><gw:list  id="lstSalaryKind" value='' maxlen = "100" styles='width:90%' onchange="ChangeSalaryKind()">
                            <data><%=ESysLib.SetListDataSQL("select v.code,v.CODE_NM||' '|| v.CHAR_1||'->'||v.CHAR_2 from vhr_hr_code v where v.id='HR0030' and nvl(v.tco_company_pk,'" + session("COMPANY_PK") + "')='" + session("COMPANY_PK") + "' order by 1 ")%></data></gw:list></td>
					<td  colspan=2 class="topright" width="50%" align="right" ><b ><gw:label id="idSAL_KIND" styles="width:100%" ></gw:label></b></td>
					
					
				</tr>	value = 'Process'
				
				<tr style="height:12%">
					<td class="topleft" align="right" >Allowance Include</td>
					<td class="topleft" width="2%" align="right">&nbsp;</td>
					<td colspan=6 class="top" align="left"><b style="color=#FF00CC"><gw:label id="idSAL_ALL" styles="width:100%" ></gw:label></b></td>
                    <td colspan=2 class="topright" width="26%" align="right">&nbsp;</td>
				</tr>	
				<tr style="height:12%">
				    <td class="topleft" align="right">Work Month</td>
				    <td class="topleft" width="2%" align="right">&nbsp;</td>
				    <td width=10% class="top"><gw:datebox id="idWorkMon" lang="<%=Session("Lang")%>" styles="width:90%" onchange="onchange_month()" type=month></gw:datebox></td>			
				    <td width=10% class="top" align="right">From</td>
				    <td width=10% class="top" ><gw:datebox id="idFrom" lang="<%=Session("Lang")%>" styles="width:90%" nullaccept onchange=""></gw:datebox></td>			
				    <td width=10% class="top" align="right">To</td>
				    <td width=10% class="top" ><gw:datebox id="idTo" lang="<%=Session("Lang")%>" styles="width:90%" nullaccept onchange=""></gw:datebox></td>			
				    <td width=10% class="top" align="right">&nbsp;</td>
                    <td colspan=2 class="topright" width="26%" align="right">&nbsp;</td>
			    </tr>
			    <tr style="height:12%">
					<td class="left" align="right" >&nbsp;</td>
					<td class="left" width="2%" align="right">&nbsp;</td>
                    <td align="right" >Ex Rate</td>
                    <td align="left" ><gw:textbox id="txtExRate"  styles='width:100%' text=""/></td>        
					<td align="center"><gw:icon id="idBtnProcess" img="in" text="Process" onclick="on_Process()" /></td>
					<td align="center"><gw:icon id="idBtnDelete" img="in" text="Delete" onclick="on_Delete()" /></td>
					<td colspan=2 align="center"><b style="color=#FF3300"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></b></td>
                    <td colspan=2 class="right" width="26%" align="right">&nbsp;</td>
				</tr>
                <tr style="height:12%">
					<td class="bottomleft" align="right" >&nbsp;</td>
					<td class="bottomleft" width="2%" align="right">&nbsp;</td>
                    <td  class="bottom" align="right" >&nbsp;</td>
                    <td class="bottom" align="left" >&nbsp;</td>        
					<td class="bottom" align="center">&nbsp;</td>
					<td class="bottom" align="center">&nbsp;</td>
					<td colspan=2 class="bottom"  align="center">&nbsp;</td>
                    <td colspan=2 class="bottomright" width="26%" align="right">&nbsp;</td>
				</tr>
		        <tr style="height:8%">
					<td colspan=4 width="50%" align="center" ><gw:label id="idProcess_status" text="" styles="width:100%;color:blue;font-size:16"  ></gw:label></b></td>
                    <td colspan=4 width="50%" align="center" ><gw:icon id="idBtStop" img="in" text="Stop" onclick="on_Stop()" /></td>
                    <td colspan=2  width="26%" align="right">&nbsp;</td>
				</tr>
		       
		    </table>
            <table id="grd_chk" class="itable"  style="width:80%;height:30%;border-left:0;border-top:0" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >
		         <td colspan=10  style="width:100%;height:100%;"> 
									 <gw:grid   
										id="grdChk"  
										header="EMP ID|FULL NAME|JOIN DATE|LEFT DATE|SALARY YN"
										format="0|0|4|4|0"  
										aligns="0|2|2|1|0"  
										defaults="||||"  
										editcol="0|0|0|0|0"  
										widths="2000|3000|2000|2000|1200"  
										styles="width:100%; height:100%" 
										sorting="T" acceptNullDate   
										onafteredit=""
										/> 
				</td>
		       
		    </table>

		</td>
	</tr>
</table>
</form>
</body>


<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtProcess" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txt_allowance_kind" styles="display:none"/>
<gw:textbox id="txtAllow_count" styles="display:none"/>
<gw:textbox id="txtProcessSalary" styles="display:none"/>
<gw:textbox id="txtFlag_Cost" styles="display:none"/>
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />

<gw:grid   
    id="grdAllowance"  
    header="Code|Code Name"
    format="0|0"  
    aligns="0|2"  
    defaults="|"  
    editcol="0|0"  
    widths="0|1500"  
    styles="display:none" 
    sorting="T"    
/> 


</html>

