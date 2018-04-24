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

var v_language = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
   idemp_pk.text = "<%=session("USER_PK")%>";
   txtHr_level.text= "<%=session("HR_LEVEL")%>"; 
   lstTimesPeriod.SetEnable(false);
   if((Trim(idemp_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
         datGet_Location_dept.Call(); 
   else                 
        datGet_salary_kind.Call();
        	
}


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
function ChangSalary()
{
 if(lstProcessSalary.value=='01')
        {
        lstTimesPeriod.SetEnable(false);
        idSAL_KIND.text="";
        lstTimesPeriod.value='ALL';
        datGet_salary_kind.Call();
        
        }
        else
        {lstTimesPeriod.SetEnable(true);
          idSAL_KIND.text="Resign Salary";
         Change_Times();
          
        }
}
function clear_Interval(obj)
{
	clearInterval(interval_time);
	obj.text="";
}

function onchange_month()
{
    txtResult.text="";
	if(lstProcessSalary.value=="01") 
	    datGet_from_to.Call();
	else if(lstTimesPeriod.value!="")
	   {
	   datGet_from_to.Call();
	   }
}
function Change_Times()
{
    if(lstTimesPeriod.value!='')
    {
        txtResult.text="";
    	datGet_from_to.Call();
    }	
}
function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datGet_Location_dept":
               if (lstProcessSalary.value=='01')
               {datGet_salary_kind.Call();
               }
               break;
        case "datGet_salary_kind":
            datGet_from_to.Call();
		    break;
		case "datGet_from_to":
		       if(txtResult.text=="")
		      {
		        idInterval.text="This Month Not Register."
		        idBtnProcess.SetEnable(0);
		        idBtnDelete.SetEnable(0);
		      }
		      else
		      {
		        idBtnProcess.SetEnable(1);
		        idBtnDelete.SetEnable(1);
		        txtAllow_count.text="";
		        idInterval.text="";
		        datCount_Allowance.Call();
		      }  
		    break;     
		 case "datProcess_WT":  
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 1(Working Month) completed? Continous?\n Bước 1(Bảng Công) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            set_Interval(1000);
		            datProcess_OT.Call();
		        }
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		        }
		    }
		    else
		    {
		        alert("Error:Step 1(Working Month) Uncomplete.\n Lỗi: Bảng công tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
		  case "datProcess_OT":  
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 2(Extra Month) completed? Continous?\n Bước 2(Bảng T.Ca) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            set_Interval(1000);
		            datProcess_ABS.Call();
		        }    
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		        }
		    }
		    else
		    {
		        alert("Error:Step 2(Extra Month) Uncomplete.\n Lỗi: Bảng T.Ca tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
			case "datProcess_WT_resign":  
		    if(txtResult.text=='0')
		    {
		        if(confirm("Resign Step 1(Working Month )  completed? Continous?\n Bước 1(Bảng Công) nghỉ việc đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            set_Interval(1000);
		            datProcess_OT_resign.Call();
		        }
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
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
		        if(confirm("Resign Step 2 (Extra Month ) completed? Continous?\n Bước 2(Bảng T.Ca nghỉ việc) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            set_Interval(1000);
		            datProcess_ABS_resign.Call();
		        }    
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
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
		        if(confirm("Resign Step 3(Absence Month ) completed? Continous?\n Bước 3(Bảng Vắng nghỉ việc) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            set_Interval(1000);
		            datMonth_summary_resign.Call();
		        }    
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
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
		        if(confirm("Step 3(Absence Month) completed? Continous?\n Bước 3(Bảng Vắng) đã hoàn thành, tiếp tục?"))   
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		            set_Interval
		            (1000);
		            datMonth_summary.Call();
		        }    
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		        }
		    }
		    else
		    {
		        alert("Error:Step 3(Absence Month) Uncomplete.\n Lỗi: Bảng vắng tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
		case "datMonth_summary":  
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 4(Month Summary) completed? Continous?\n Bước 4(Bảng tóm tắt) đã hoàn thành, tiếp tục?"))   
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
		                    set_Interval(1000);
		                    datProcess_Allowance.Call();
		                }   
		                
		            }
		            else
	                {
	                    if(confirm("Salary process will start, Do you want to continous?\nHệ thống tính lương bắt đầu, Bạn muốn tiếp tục?"))
                        {
                                set_Interval(1000);
                                datProcess_Sal_s1.Call();
                        }    
	                }
		                
		        }
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
		        }    
		    }
		    else
		    {
		        alert("Error:Step 4(Month Summary) Uncomplete.\n Lỗi: Bảng tóm tắt tháng tháng không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;    
		case "datMonth_summary_resign":  
		    if(txtResult.text=='0')
		    {
		        if(confirm("Step 4(Resign Month Summary ) completed? Continous?\n Bước 4(Bảng tóm tắt nghỉ việc) đã hoàn thành, tiếp tục?"))   
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
		                    set_Interval(1000);
		                    datProcess_Allowance_resign.Call();
		                }   
		                
		            }
		            else
	                {
	                    if(confirm("Resign Salary process will start, Do you want to continous?\nHệ thống tính lương nghỉ việc bắt đầu, Bạn muốn tiếp tục?"))
                        {
                                set_Interval(1000);
                                datProcess_Sal_s1_resign.Call();
                        }    
	                }
		                
		        }
		        else    
		        {
		            txtResult.text='';
		            clear_Interval(idInterval);
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
		            if(confirm("Allowance kind "+count_flag+" completed? Continous?\n Phụ cấp loại "+count_flag+" đã hoàn thành, tiếp tục?"))   
		            {
		                txtResult.text='';
		                clear_Interval(idInterval);
    		            
	                    count_flag+=1;
	                    if(count_flag<=Number(txtAllow_count.text))    
	                    {
	                        txt_allowance_kind.text="0"+""+count_flag;
	                        set_Interval(1000);
	                        datProcess_Allowance.Call();
	                    }   
	                    else
	                    {
	                        if(confirm("Salary process will start, Do you want to continous?\nHệ thống tính lương bắt đầu, Bạn muốn tiếp tục?"))
	                        {
	                            clear_Interval(idInterval);
	                            set_Interval(1000);
	                            datProcess_Sal_s1.Call();
	                        }    
	                    }
		            }  
		            else    
		            {
		                txtResult.text='';
		                clear_Interval(idInterval);
		            }  
		    }
		    else
		    {
		        alert("Allowance kind "+count_flag+" uncompleted?\n Phụ cấp loại "+count_flag+" bị lỗi.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
			break; 
		    		
		case "datProcess_Allowance_resign":  
		    if(txtResult.text=='0')
		    {
		            if(confirm("Allowance kind "+count_flag+" completed? Continous?\n Phụ cấp loại "+count_flag+" đã hoàn thành, tiếp tục?"))   
		            {
		                txtResult.text='';
		                clear_Interval(idInterval);
    		            
	                    count_flag+=1;
	                    if(count_flag<=Number(txtAllow_count.text))    
	                    {
	                        txt_allowance_kind.text="0"+""+count_flag;
	                        set_Interval(1000);
	                        datProcess_Allowance_resign.Call();
	                    }   
	                    else
	                    {
	                        if(confirm("Resign salary process will start, Do you want to continous?\nHệ thống tính lương nghỉ việc bắt đầu, Bạn muốn tiếp tục?"))
	                        {
	                            clear_Interval(idInterval);
	                            set_Interval(1000);
	                            datProcess_Sal_s1_resign.Call();
	                        }    
	                    }
		            }  
		            else    
		            {
		                txtResult.text='';
		                clear_Interval(idInterval);
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
		        if(confirm("Resign salary process (Holiday define) finish, Do you want to continous?\nCông đoạn (Xác định ngày lễ) của hệ thống lương hoàn thành, Bạn muốn tiếp tục?"))
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    set_Interval(1000);
                    datProcess_WT_resign.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
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
		        if(confirm("Resign salary process step 1 finish, Do you want to continous?\nCông đoạn 1 của hệ thống lương hoàn thành, Bạn muốn tiếp tục?"))
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    set_Interval(1000);
                    datProcess_Sal_s2_resign.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
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
		        if(confirm("Resign salary process step 2 finish, Do you want to continous?\nCông đoạn 2 của hệ thống lương nghỉ việc hoàn thành, Bạn muốn tiếp tục?"))
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    set_Interval(1000);
                    datProcess_Sal_s3_resign.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
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
		        if(confirm("Salary process (Holiday define) finish, Do you want to continous?\nCông đoạn (Xác định ngày lễ) của hệ thống lương hoàn thành, Bạn muốn tiếp tục?"))
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    set_Interval(1000);
                    datProcess_WT.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                }
                   
	        }      
	        else
	        {
	            alert("There is error at step 1 of Salary process.\nĐã có lỗi xảy ra ở bước 1 Hệ thống tính lương.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step1 Error."
	        }
	        break;
	   case "datProcess_Sal_s1": 
		    if(txtResult.text=='0')
		    { 
		        if(confirm("Salary process step 1 finish, Do you want to continous?\nCông đoạn 1 của hệ thống lương hoàn thành, Bạn muốn tiếp tục?"))
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    set_Interval(1000);
                    datProcess_Sal_s2.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                }
                   
	        }      
	        else
	        {
	            alert("There is error at step 1 of Salary process.\nĐã có lỗi xảy ra ở bước 1 Hệ thống tính lương.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step1 Error."
	        }
	        break;          
	    case "datProcess_Sal_s2": 
		    if(txtResult.text=='0')
		    { 
		        if(confirm("Salary process step 2 finish, Do you want to continous?\nCông đoạn 2 của hệ thống lương hoàn thành, Bạn muốn tiếp tục?"))
                {
                    txtResult.text==''
                    clear_Interval(idInterval);
                    set_Interval(1000);
                    datProcess_Sal_s3.Call();
                }
                else
                {
                    txtResult.text='';
		            clear_Interval(idInterval);
                }
                   
	        }      
	        else
	        {
	            alert("There is error at step 2 of Salary process.\nĐã có lỗi xảy ra ở bước 2 Hệ thống tính lương.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step2 Error."
	        }
	        break;     
	    case "datProcess_Sal_s3": 
		    if(txtResult.text=='0')
		    { 
		        alert("System Salary process successful.\nHệ thống lương đã hoàn thành.")
                txtResult.text='';
	            clear_Interval(idInterval);
	            idInterval.text="Successful."
	        }      
	        else
	        {
	            alert("There is error at step 3 of Salary process.\nĐã có lỗi xảy ra ở bước 3 Hệ thống tính lương.")
	            txtResult.text='';
		        clear_Interval(idInterval);
		        idInterval.text="Salary Step3 Error."
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
    }
     
	
}
function on_Process(n)
{
    if(n==1)
    {   if(lstProcessSalary.value=='01')
            if(confirm("Salary is processing...do you want to continous?\nHệ thống tính lương bắt đầu...Bạn có muốn tiếp tục?"))
            {
                set_Interval(1000)
                datProcess_holiday.Call();
                
            }
        if(lstProcessSalary.value=='02')
        if(confirm("Resign Salary is processing...do you want to continous?\nHệ thống tính lương nghỉ việc bắt đầu...Bạn có muốn tiếp tục?"))
        {
            set_Interval(1000)
            datProcess_holiday_resign.Call();
            
        }
        
        
    }          
}
function on_Delete()
{
	if(lstProcessSalary.value=='01')
		if(confirm("Do you want to delete data for this month?\nBạn có muốn dữ liệu đã tính lương trong tháng này?"))
		{
		   datDel_salary.Call(); 
		}
	if(lstProcessSalary.value=='02')
		 if(confirm("Do you want to delete resign data for this month?\nBạn có muốn dữ liệu đã tính lương nghỉ việc trong tháng này?"))
		{
		   datDel_salary_resign.Call(); 
		}
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


<gw:data id="datGet_Location_dept" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="HR.SP_PRO_GET_DEPT_PARENT" > 
                <input>
                    <input bind="idemp_pk" /> 
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGet_salary_kind" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_sal_rule" > 
                <input>
                    <input bind="idSAL_KIND" />
                </input> 
                <output>
                    <output bind="idSAL_KIND" />
                    <output bind="idSAL_ALL" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datGet_from_to" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_from_to" > 
                <input>
                    <input bind="lstProcessSalary" />
                    <input bind="idWorkMon" />
                    <input bind="lstTimesPeriod" />
                    
                </input> 
                <output>
                    <output bind="idFrom" />
                    <output bind="idTo" />
                    <output bind="txtResult" />
					<output bind="txtProcess_YN" />					
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_holiday" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.Pro_Holiday_Manage" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_WT" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_PROCESS_MONTH_WT_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datProcess_OT" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_PROCESS_MONTH_OT_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_ABS" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_PROCESS_MONTH_ABS_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datMonth_summary" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_MONTH_SUMMARY_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datCount_Allowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_COUNT_ALLOWANCE" > 
                <input>
                    <input bind="txtAllow_count" />
                </input> 
                <output>
                    <output bind="txtAllow_count" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Allowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_MONTH_ALLOWANCE_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="txt_allowance_kind" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Sal_s1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PROCESS_SALARY_S1_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="txtExRate" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Sal_s2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PROCESS_SALARY_S2_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="txtExRate" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Sal_s3" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PROCESS_SALARY_S3_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="txtExRate" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_holiday_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR.Pro_Holiday_Manage_resign" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="lstTimesPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_WT_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_MONTH_WT_RESIGN_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="lstTimesPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datProcess_OT_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_MONTH_OT_RESIGN_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="lstTimesPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_ABS_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR.SP_PRO_MONTH_ABS_RESIGN_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="lstTimesPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datMonth_summary_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_MONTH_SUMMARY_RESIGN_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="lstTimesPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Allowance_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_MONTH_RESIGN_ALLOWANCE" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="txt_allowance_kind" />
                    <input bind="lstTimesPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Sal_s1_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR.SP_PROCESS_RESIGN_S1" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="txtExRate" />
                    <input bind="lstTimesPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Sal_s2_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR.SP_PROCESS_RESIGN_S2" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="txtExRate" />
                    <input bind="lstTimesPeriod" />                
                    
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datProcess_Sal_s3_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR.SP_PROCESS_RESIGN_S3" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="txtExRate" />
                    <input bind="lstTimesPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datDel_salary" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_DEL_SALARY_UR" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="txtExRate" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="datDel_salary_resign" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR.SP_PRO_DEL_SALARY_RESIGN" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstOrg" />
                    <input bind="txtExRate" />
                    <input bind="lstTimesPeriod" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<form name="Time Control" id="form1">
<table style="width:100%;height:90%" cellpadding="0" cellspacing="0" align="center" border="0" >
    <tr>
	    <td width="100%">
		    <table class="itable"  style="width:60%;height:60%" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >
		        <tr style="height:9%">
					<td colspan=8 class="topleftright" width="100%" align="center">
					<b style="font-size=14"><i>
					<gw:list  id="lstProcessSalary" value='01' maxlen = "100" styles='width:30%' onchange="ChangSalary()" >
                       <data><%=ESysLib.SetListDataSQL("SELECT '01','Month Salary' from dual union all select distinct '02','Reign salary' from thr_code_master a,thr_code_detail b where a.ID='HR0117' and a.pk=b.thr_code_master_pk and b.del_if=0 and a.del_if=0  ")%></data></gw:list>
					</i></b>
					</td>
				</tr>
		        <tr style="height:9%">
					<td colspan=8 class="topleftright" width="100%" align="center"><b style="font-size=14"><i>Salary Process Information</i></b></td>
				</tr>
				<tr style="height:9%">
					<td class="topleft" width="20%" align="right">Location</td>
					<td class="topleft" width="2%" align="right">&nbsp;</td>
					<td class="topright" colspan=6 width="78%" align="left" ><gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:30%' >
                            <data>|ALL|Select All</data></gw:list></td>
				</tr>	
				<tr style="height:9%">
					<td class="topleft" width="23%" align="right">Salary Kind</td>
					<td class="topleft" width="2%" align="right">&nbsp;</td>
					<td class="topright" colspan=2 width="50%" align="left" ><b ><gw:label id="idSAL_KIND" styles="width:100%" ></gw:label></b></td>
					<td class="topright" colspan=2 width="10%" align="right" ><b >Times</b></td>
					<td class="topright" colspan=2 width="40%" align="left" ><gw:list  id="lstTimesPeriod" value='ALL' maxlen = "100" styles='width:100%' onchange="Change_Times()">
                            <data><%=ESysLib.SetListDataSQL("select a.Code,a.CODE_NM from thr_code_master b,thr_code_detail a  where b.pk=a.THR_CODE_MASTER_PK and a.del_if=0 and b.del_if=0 and b.ID='HR0117'")%></data></gw:list></td>
				</tr>	
				<tr style="height:9%">
					<td class="topleft" align="right" >Allowance Include</td>
					<td class="topleft" width="2%" align="right">&nbsp;</td>
					<td class="topright" colspan=6 align="left"><b style="color=#FF00CC"><gw:label id="idSAL_ALL" styles="width:100%" ></gw:label></b></td>
				</tr>	
				<tr style="height:9%">
				    <td class="topleft" align="right">Work Month</td>
				    <td class="topleft" width="2%" align="right">&nbsp;</td>
				    <td width=15% class="top"><gw:datebox id="idWorkMon" lang="<%=Session("Lang")%>" styles="width:90%" onchange="onchange_month()" type=month></gw:datebox></td>			
				    <td width=15% class="top" align="right">From</td>
				    <td width=10% class="top" ><gw:datebox id="idFrom" lang="<%=Session("Lang")%>" styles="width:90%" nullaccept onchange=""></gw:datebox></td>			
				    <td width=15% class="top" align="right">To</td>
				    <td width=13% class="top" ><gw:datebox id="idTo" lang="<%=Session("Lang")%>" styles="width:90%" nullaccept onchange=""></gw:datebox></td>			
				    <td width=10% class="topright" align="right">&nbsp;</td>
			    </tr>
			    <tr style="height:9%">
					<td class="bottomtopleft" align="right" >&nbsp;</td>
					<td class="bottomtopleft" width="2%" align="right">&nbsp;</td>
                    <td class="bottomtop" align="right" >Ex Rate</td>
                    <td class="bottomtop" align="left" ><gw:textbox id="txtExRate"  styles='width:50%' text=""/></td>        
					<td class="bottomtop" align="center"><gw:icon id="idBtnProcess" img="in" text="Process" onclick="on_Process(1)" /></td>
					<td class="bottomtop" align="center"><gw:icon id="idBtnDelete" img="in" text="Delete" onclick="on_Delete()" /></td>
					<td colspan=2 class="bottomtopright" align="center"><b style="color=#FF3300"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></b></td>
				</tr>		        
		    </table>
		</td>
	</tr>
</table>
</form>
</body>


<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="idemp_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txt_allowance_kind" styles="display:none"/>
<gw:textbox id="txtAllow_count" styles="display:none"/>
<gw:textbox id="txtProcess_YN" styles="display:none"/> 



</html>

