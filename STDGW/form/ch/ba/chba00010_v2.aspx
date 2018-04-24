<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var startTime,interval_time
var ajax_test;
var v_fac=0;
var process_flag=1;
var root_temp="";
var flag_daily=1;


var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
    

    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    txtCompany_pk.text="<%=Session("COMPANY_PK")%>";
    if(txtHr_level.text=="")
    {
        alert("Your session is time out, login again please!\nPhiên làm việc đã bị ngắt, vui lòng đăng nhập lại!")
    }    
    
	idLdt.text=getSysDate()
	idSdt.text="<%=Day(Now())&"/"&Month(Now())&"/"&Year(Now())%>";
	if(idLdt.text!=idSdt.text)
	{
		alert("Your computer date is not correct \n Ngày tháng trong máy của bạn không chính xác.");
	}
	idBtnProcess.SetEnable(0);
	
	//table_M1.style.display="none";
	//table_M2.style.display="none";
	idEmp_id.SetEnable(0);
    form1.option_Q[0].checked=true;
	
	if(lst_temp.value=='0')//tap trung
	{
	      lst_location.SetEnable(0);
	      var t=lst_location.GetText().search("-");
	      t=lst_location.GetText().substring(t+1,lst_location.GetText().length);
	      
	      if(t=="LOCAL")
                root_temp=System.RootURL + "/form/ch/ba/";
          else
		        root_temp="http://" + t+"/";    
	}
	else
	{
	    var lst_obj=lst_location.GetControl();
		  lst_location.SetEnable(1);//phan tan 
		  var t=lst_location.GetText().search("-");
		  
		  t=lst_location.GetText().substring(t+1,lst_location.GetText().length);
		  root_temp="http://" + t+"/";
	}
	
    menu_id.text=System.Menu.GetMenuID();

    ChangeColorItem(lstOrg1.GetControl());
    ChangeColorItem(lstOrg2.GetControl());
    ChangeColorItem(lstOrg3.GetControl());

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
//-----------------------------------------------
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
 var d = new Date()
 idInterval_M.text= Math.round((d.valueOf()-start)/x);

}

function getSysDate()
{
	var sysDate,t1,t2,t3
		sysDate = new Date();
		t1=sysDate.getDate()
		t2=(sysDate.getMonth() + 1)
		t3 = sysDate.getFullYear() 
		fullDate = t1 + "/" + t2 + "/" + t3
		return fullDate
	
}


function return_result()
{
	var t=GetRequestState(ajax_test);
	
	if(GetRequestState(ajax_test))
		{
			
			var result= ajax_test.responseText;
			
			if(result.substring(0,5)=="ERROR")
			{
				alert(result);
				clear_Interval(idInterval);
				idInterval.text="Not Complete!"
			}	
			else if(result=="1")
			{
				idInterval.text=""
				alert("Load data complete ! ")
				clear_Interval(idInterval)
				
			}
			else
			{
				alert(result)
				alert("Load data Error!")
				clear_Interval(idInterval)
				idInterval.text="Not Complete!"
			}		
			idBtnProcess.SetEnable(1);
			process_flag=0;
		}			
}
function onClickOption(n)
{
    if(n==1)
	    idBtnProcess.SetEnable(1)
	else    
	    idBtnProcess_M.SetEnable(1)
}
function on_Process()
{
	var dt,len,opt;
	len = document.form1.option_P.length;
	opt = document.form1.option_P;
    //alert(process_flag);
	
	for(i = 0; i< len; i++)
	{
		
		if (opt[i].checked)
		{			
			if(process_flag==1)
			{
			    alert("Other task is processing.\nTiến trình khác đang thực hiện");
			    return;
			}
			switch (opt[i].value)
			{
				case '1': //download from time machine
				   process_flag=1;
					if(!confirm("It take several seconds, Press Ok to continous...\n Tiến trình bắt đầu, bấm OK để tiếp tục... "))
					{
					    process_flag=0;
					    return;
					}    
					set_Interval(100);
					dt=idWorkDT.GetData();
					var t=new Date();
					//var url = System.RootURL+ "/form/ch/ba/frm_get_data.asp?date=" + dt + "&nm=hr&pd=hr2&hr3="+ t;
					lst_file_name.value=lst_location.value
					var file_name=lst_file_name.GetText();
					if (lstOrg.value=="1" )
                        root_temp="http://192.168.102.5/";
                    else if (lstOrg.value=="2" )
                        root_temp="http://192.168.102.7/";
                    else
                        root_temp="http://192.168.102.197/";
                    file_name="frm_getdata_nb.asp";
					var url = root_temp+file_name+"?date=" + dt + "&fact=" + lst_location.value + "&nm=nobland&pd=nobland2&hr3="+ t;
					
					ajax_test = null;
					ajax_test = GetXmlHttpRequest(return_result);
					
					ajax_test.open("GET", url , true);
					ajax_test.send(null);
					idBtnProcess.SetEnable(0)
					break;
				case '2': //process original data 
				    process_flag=1;
					if(!confirm("It take several seconds, Press Ok to continous...\n Tiến trình bắt đầu, bấm OK để tiếp tục... "))
					{
					    process_flag=0;
					    return;
					}    

                    if(flag_daily==1)
                        txdt_tmp.text=idWorkDT.value;
                    else
                        txdt_tmp.text=idWorkFrom.value;

					set_Interval(100);
					idStaus1.text="Task 1 is processing...";
                    idStaus2.text="Date: " + txdt_tmp.text.substr(6,2)+"/"+txdt_tmp.text.substr(4,2)+"/"+txdt_tmp.text.substr(0,4);
					process_1.Call();
					idBtnProcess.SetEnable(0)
					break;	
				case '3': //delete original data 
					if(confirm("Do you want to delete? \n Bạn thực sự muốn xóa?"))
					{
                        if(flag_daily==2)
                        {
                            idWorkFrom_tmp.text=idWorkFrom.value;
                            idWorkTo_tmp.text=idWorkTo.value;
                        }
                        else
                        {
                            idWorkFrom_tmp.text=idWorkDT.value;
                            idWorkTo_tmp.text=idWorkDT.value;
                        }
					    process_flag=1;
					    set_Interval(100);
					    process_del.Call();
					    idBtnProcess.SetEnable(0)
					}    
					break;	
			    case '4': //full time 
					if(confirm("Do you want to process full time?"))
					{
                        if(flag_daily==2)
                        {
                            idWorkFrom_tmp.text=idWorkFrom.value;
                            idWorkTo_tmp.text=idWorkTo.value;
                        }
                        else
                        {
                            idWorkFrom_tmp.text=idWorkDT.value;
                            idWorkTo_tmp.text=idWorkDT.value;
                        }
					    process_flag=1;
					    set_Interval(100);
					    process_ft_1.Call();
					    idBtnProcess.SetEnable(0)
					}
					break;		
			}
		}
	}				
}
//monthly 
function on_Process_M()
{
	var dt,len,opt;
	len = document.form1.option_P2.length;
	opt = document.form1.option_P2;
	
	for(i = 0; i< len; i++)
	{
		
		if (opt[i].checked)
		{			
			if(process_flag==1)
			{
			    alert("Other task is processing.\nTiến trình khác đang thực hiện");
			    return;
			}
			switch (opt[i].value)
			{
				case '1': //process original data
				    if(isEmpty(idEmp_id.text)) 
				    {
				        alert("choose employee please.\nBạn phải chọn nhân viên");
				        return;
				    }
				    process_flag=1;
					alert("Step 1 Start, Please wait...\nBước 1 thực hiện, xin chờ trong giây lát... ");
					set_Interval2(100);
					process_M.Call();
					idBtnProcess_M.SetEnable(0)
					break;	
				case '2': //delete original data 
					if(confirm("Do you want to delete? \n Bạn thực sự muốn xóa?"))
					{
					    process_flag=1;
					    set_Interval2(100);
					    process_M_del.Call();
					    idBtnProcess.SetEnable(0)
					}
					break;
				case '3': //delete original data 
					if(confirm("Do you want to process full time?"))
					{
					    process_flag=1;
					    set_Interval2(100);
					    process_M_ft_1.Call();
					    idBtnProcess.SetEnable(0)
					}    
					break;		
			}
		}
	}				
}

function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datCheck_View":
        {
            if(txtFlag_View.text == 'Y')
            {
               idBtnProcess.style.display = "none";
               idBtnProcess_M.style.display = "none";
            }
        
            if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	        {
                datUser_info.Call();     	    
	        }
            else
                process_flag=0;
            
            
        }
        break;

        case "datUser_info":
            //alert(txtFact_pk.text);
            lstCompany.SetDataText(txtFact_pk.text);
            datGetOrg.Call();
		    break;

        case "datGetOrg":
            lstOrg1.SetDataText(txt_tmp.text);
            lstOrg2.SetDataText(txt_tmp.text);
            lstOrg3.SetDataText(txt_tmp.text);

            ChangeColorItem(lstOrg1.GetControl());
            ChangeColorItem(lstOrg2.GetControl());
            ChangeColorItem(lstOrg3.GetControl());

            process_flag=0;
		    break;
        case "export_txt":
            if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    //alert("Step 1 success, Step 2 will continous...\n Bước 1 thành công, bước 2 được tiếp tục... ");
				idStaus1.text="file exported ";
			    idBtnProcess.SetEnable(1)
		        process_flag=0;
		    }
		    else
		    {
		        alert("Error, export unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
				 idStaus1.text="Export file Error";
		        idBtnProcess.SetEnable(1)
		        process_flag=0;
		    }
		    break; 

		case "process_1":
            if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    //alert("Step 1 success, Step 2 will continous...\n Bước 1 thành công, bước 2 được tiếp tục... ");
				idStaus1.text="Task 2 is processing...";
			    set_Interval(100);
			    process_2.Call();
		    }
		    else if(txtResult.text=="1")//da dong du lieu
		    {
		        alert("This date closed already.\nDữ liệu đã đóng, không thể thực hiện");
		        clear_Interval(idInterval);
				 idStaus1.text="Data closed.";
		        idBtnProcess.SetEnable(1)
		        process_flag=0;
		    }
            else
            {
                alert("Step 1 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
				 idStaus1.text="There is error on task 1...";
		        idBtnProcess.SetEnable(1)
		        process_flag=0;
            }
		    break;    
		case "process_2": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			   // alert("Step 2 success, Step 3 will continous...\n Bước 2 thành công, bước 3 được tiếp tục... ");
			   idStaus1.text="Task 3 is processing...";
			    set_Interval(100);
			    process_3.Call();
		    }   
		     else
		    {
		        alert("Step 2 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
				idStaus1.text="There is error on task 2...";
		        idBtnProcess.SetEnable(1)
		        process_flag=0;
		    }
		    break;
	    case "process_3": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    //alert("Step 3 success, Step 4 will continous...\n Bước 3 thành công, bước 4 được tiếp tục... ");
				idStaus1.text="Task 4 is processing...";
			    set_Interval(100);
			    process_4.Call();
		    }   
		     else
		    {
		        alert("Step 3 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
				idStaus1.text="There is error on task 3...";
		        idBtnProcess.SetEnable(1)
		        process_flag=0;
		    }
		    break;
		case "process_4": 
		    if(txtResult.text=="0")//success
		    {
                if(flag_daily==2 && txdt_tmp.text!=idWorkTo.value) //month
                {
                    idStaus1.text=txdt_tmp.text.substr(6,2)+"/"+txdt_tmp.text.substr(4,2)+"/"+txdt_tmp.text.substr(0,4)+ " Process Finish...";

                    txdt_tmp.text=next_day(txdt_tmp.text); //yyyymmdd
                    clear_Interval(idInterval);
    				
                    idStaus2.text="Date:" + txdt_tmp.text.substr(6,2)+"/"+txdt_tmp.text.substr(4,2)+"/"+txdt_tmp.text.substr(0,4);
                     set_Interval(100);
                    process_1.Call();
                }
                else
                {

			        txtResult.text=="";
			       /* clear_Interval(idInterval);
			        alert("Step 4 success, Step 5 will continous...\n Bước 4 thành công, bước 5 được tiếp tục... ");
			        set_Interval(100);
			        process_5.Call();*/
			         clear_Interval(idInterval);
                     idStaus1.text="All Finish...";
			        alert("Sucessful... ");
				   
                }
		    }   
		     else
		    {
		        alert("Step 4 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
		    }
		    idBtnProcess.SetEnable(1)
		    process_flag=0;
		    break;    
		case "process_5": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    alert("Sucessful... ");
		    }   
		     else
		    {
		        alert("Step 5 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
		    }
		    idBtnProcess.SetEnable(1)
		    process_flag=0;
		    break;        
		case "process_del": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    alert("delete success...\n Đã xóa thành công ");
		    }   
		     else 
		    {
		        alert("delete error.\Có lỗi xảy ra.");
		        clear_Interval(idInterval);
		    }
		    idBtnProcess.SetEnable(1)
		     process_flag=0;
		    break;      
		case "process_M":
            if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval_M);
			    //alert("Step 1 success, Step 2 will continous...\n Bước 1 thành công, bước 2 được tiếp tục... ");
				idStaus_M.text="Task 2 is processing...";
			    set_Interval2(100);
			    process_M2.Call();
		    }
		    else
		    {
		        alert("Step 1 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval_M);
				idStaus_M.text="Task 1 error...";
		        idBtnProcess_M.SetEnable(1)
		        process_flag=0;
		    }
		    break;
		case "process_M2": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval_M);
			    //alert("Step 2 success, Step 3 will continous...\n Bước 2 thành công, bước 3 được tiếp tục... ");
				idStaus_M.text="Task 3 is processing...";
			    set_Interval2(100);
			    process_M3.Call();
		    }   
		     else
		    {
		        alert("Step 2 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval_M);
				idStaus_M.text="Task 2 error...";
		        idBtnProcess_M.SetEnable(1)
		        process_flag=0;
		    }
		    break;
	    case "process_M3": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval_M);
			    //alert("Step 3 success, Step 4 will continous...\n Bước 3 thành công, bước 4 được tiếp tục... ");
				idStaus_M.text="Task 4 is processing...";
			    set_Interval2(100);
			    process_M4.Call();
		    }   
		     else
		    {
		        alert("Step 3 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval_M);
				idStaus_M.text="Task 3 error...";
		        idBtnProcess_M.SetEnable(1)
		        process_flag=0;
		    }
		    break;
		case "process_M4": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval_M);
			    alert("Process success...\n Tiến trình đã thực hiện thành công ");
				idStaus_M.text="All Task Finish...";
		    }   
		     else
		    {
		        alert("Step 4 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval_M);
				idStaus_M.text="Task 4 error...";
		    }
	        process_flag=0;
	        idBtnProcess_M.SetEnable(1)
		    break;    
		case "process_M_del": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval_M);
			    alert("delete success...\n Đã xóa thành công ");
		    }   
		    else
		    {
		        alert("There is error\n Có lỗi xãy ra");
		        clear_Interval(idInterval_M);
		    }
		    idBtnProcess_M.SetEnable(1)
		    process_flag=0;
		    break;   
		case "process_ft_1":
            if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    alert("Step 1 success, Step 2 will continous...\n Bước 1 thành công, bước 2 được tiếp tục... ");
			    set_Interval(100);
			    process_ft_2.Call();
		    }
		    else
		    {
		        alert("Step 1 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
		        idBtnProcess.SetEnable(1)
		        process_flag=0;
		    }
		    break;    
		case "process_ft_2": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    alert("Sucessful...");
			    process_flag=0;
		    }   
		     else
		    {
		        alert("Step 2 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
		    }
		    break; 
	    case "process_M_ft_1":
	    {
            if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval_M);
			    alert("Step 1 success, Step 2 will continous...\n Bước 1 thành công, bước 2 được tiếp tục... ");
			    set_Interval(100);
			    process_M_ft_2.Call();
		    }
		    else
		    {
		        alert("Step 1 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval_M);
		        idBtnProcess.SetEnable(1)
		        process_flag=0;
		    }
		    break;    
		}
		case "process_M_ft_2": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval_M);
			    alert("Sucessful...");
			    process_flag=0;
		    }   
		     else
		    {
		        alert("Step 2 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval_M);
		        process_flag=0;
		    }
		    break; 
    }
	
}
function OnToggle()
{
       
       return;
       /* if(document.form1.imgMaster.status == "expand")
        {
            table_M1.style.display="";
	        table_M2.style.display="";
            document.form1.imgMaster.status = "collapse";
            document.form1.imgMaster.src = "../../../system/images/close_popup.gif";
			document.form1.imgMaster.alt="Expand Monthly"
        }
        else
        {
             table_M1.style.display="none";
	        table_M2.style.display="none";
            document.form1.imgMaster.status = "expand";
            document.form1.imgMaster.src = "../../../system/images/iconmaximize.gif";
			document.form1.imgMaster.alt="Close Expand"
            
        }*/
  
}

function OnShowPopup()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
    var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	if (obj!=null)
    {
        txt_emp_pk.text=obj[0];
	    idEmp_id.text=obj[1];
    }
    else
    {
         idEmp_id.text="";
        txt_emp_pk.text="";
    }
}
function onChange_location()
{
     var t=lst_location.GetText().search("-");
		  
		  t=lst_location.GetText().substring(t+1,lst_location.GetText().length);
		  root_temp="http://" + t+"/";
		 
}

function onChange_org()
{
    //if(lstCompany.value!='ALL')
    
    datWorkGroup_info.Call();
}

function daysInMonth(month, year) {
    return new Date(year, month, 0).getDate();
}

function onClickOptionQ(n)
{
    flag_daily=n;
}

function add_zero(n) {
    if(Number(n)<=9)
        return '0'+n;
    else 
        return n;
}

function next_day(dt) //yyyymmdd
{
    var ng,th,nam,tmp;
    nam=dt.substr(0,4);
    th=dt.substr(4,2);
    ng=dt.substr(6,2);

    tmp=add_zero(Number(ng)+1);
   // alert(daysInMonth(th,nam));
    if(tmp>daysInMonth(th,nam))
    {
        ng="01";
        th=add_zero(Number(th)+1);
        if(th>12)
        {
            th="01";
            nam= Number(nam)+1;
        }
        
    }
    else
        ng=tmp;
    return nam+""+th+""+ng;

}

function OnchangeDT(n)
{

    if(n==1)
        form1.option_Q[0].checked=true;
    else
        form1.option_Q[1].checked=true;
    flag_daily=n;
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
            <dso  type="list" procedure="hr_sel_10020001_user_role"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtFact_pk" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGetOrg" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role3"  > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txt_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="process_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_1_v2" > 
                <input>
                    <input bind="txdt_tmp" />
                     <input bind="lstOrg1" />
                     <input bind="lstCompany" />
                     <input bind="txt_emp_pk" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_2_v2" > 
                <input>
                    <input bind="txdt_tmp" />
                     <input bind="lstOrg1" />
                     <input bind="lstCompany" />
                     <input bind="txt_emp_pk" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_3" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_3_v2" > 
                <input>
                    <input bind="txdt_tmp" />
                     <input bind="lstOrg1" />
                     <input bind="lstCompany" />
                     <input bind="txt_emp_pk" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_4" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_4_v2" > 
                <input>
                    <input bind="txdt_tmp" />
                     <input bind="lstOrg1" />
                     <input bind="lstCompany" />
                     <input bind="txt_emp_pk" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="process_5" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_5_v2" > 
                <input>
                    <input bind="txdt_tmp" />
                     <input bind="lstOrg1" />  
                     <input bind="txt_emp_pk" />                   
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="process_del" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_del_v2" > 
                <input>
                    <input bind="idWorkFrom_tmp" />
                    <input bind="idWorkTo_tmp" />
                    <input bind="lstOrg2" />
                    <input bind="lstCompany" />
                    <input bind="txt_emp_pk" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="process_ft_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_FT_1_v2" > 
                <input>
                     <input bind="idWorkFrom_tmp" />
                     <input bind="idWorkTo_tmp" />
                     <input bind="lstOrg3" />
                     <input bind="lstCompany" />
                     <input bind="txt_emp_pk" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_ft_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_FT_2_v2" > 
                <input>
                     <input bind="idWorkFrom_tmp" />
                     <input bind="idWorkTo_tmp" />
                     <input bind="lstOrg3" />
                     <input bind="lstCompany" />
                     <input bind="txt_emp_pk" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<form name="Time Control" id="form1">
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="center" border="0" >
<tr>
	<td width="100%">
		<table class="itable"  style="width:80%;height:6%" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >
				<tr style="width:40%;height:4%">
                   <td class="topleft" width="10%" align=right><a title="Click here to choose" onclick="OnShowPopup()" href="#tips" >Emp ID:</a></td>		
				    <td class="top" width="20%"><gw:textbox id="idEmp_id" styles="width:95%" /></td>
					<td class="top" width="20%" align="right" colspan="3">Server System Date</td>
					<td class="top" width="15%" align="left" colspan="2"style="color=#FF00CC"><gw:label id="idSdt" styles="width:100%" ></gw:label></td>
					<td class="top" width="20%" align="right"  colspan="3" >Local System Date</td>
					<td class="topright" width="15%" colspan="2"style="color=#FF00CC" align="left"><gw:label id="idLdt" styles="width:100%" ></gw:label></td>
				</tr>	
		</table>
		<table  style="width:80%;height:6%" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >	
			<tr >
                <td class="topleft" width="10%" align="left"><input type="radio" name="option_Q" value="1" onclick="onClickOptionQ(1)" style="color=Black"><font size=2>Date</font></td>
				<td class="top" width="10%"><gw:datebox id="idWorkDT" lang="<%=Session("Lang")%>" styles="width:50%" onchange="OnchangeDT(1)"></gw:datebox></td>	
                <td class="top" width="10%" align="right"><input type="radio" name="option_Q" value="2" onclick="onClickOptionQ(2)" style="color=Black"><font size=2>Period</font></td>
                <td class="top" width="10%"><gw:datebox id="idWorkFrom" lang="<%=Session("Lang")%>" styles="width:50%" onchange="OnchangeDT(2)"></gw:datebox></td>	
                <td class="top" width="5%" align=right >~</td>
                <td class="top" width="10%"><gw:datebox id="idWorkTo" lang="<%=Session("Lang")%>" styles="width:50%" onchange="OnchangeDT(2)"></gw:datebox></td>	
                <td class="top" width="20%" align=right >Company</td>		
				<td class="topright" width="25%">
                    <gw:list  id="lstCompany" styles='width:100%' onchange="onChange_org()" >
                        <data>
                            <%= ESysLib.SetListDataSQL("SELECT a.pk,A.PARTNER_NAME FROM tco_company a where a.del_if=0 and nvl(a.active_yn,'N')='Y' order by A.PARTNER_ID")%>
                        </data>
                    </gw:list>
                </td>
			</tr>
		</table>
		<table style="width:80%;height:30%" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >	
            
			<tr  >
				<td class="topleft" width="10%" align="left">&nbsp;</td>
				<td class="top" width="10%" align="left"><input type="radio" name="option_P" value="1" onclick="onClickOption(1)" style="color=Black"><font size=2>Download data</font></td>
				<td class="top" width="20%"><gw:list  id="lst_location"  styles='width:100%' onchange="onChange_location()" >
                            <data><%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM||'-'||CHAR_1 FROM VHR_HR_CODE WHERE ID='HR0032'")%></data></gw:list></td>
                <td class="top" width="30%" align="left">&nbsp;</td>
                <td class="topright" width="30%" align="left">&nbsp;</td>
			</tr>
            
            
			<tr >
				<td class="left" width="10%" align="left">&nbsp;</td>
				<td   align="left" style="color=Black"><input type="radio" name="option_P" value="2"  onclick="onClickOption(1)"><font size=2>Process data</font></td>
				<td colspan=3 class="right" width="40%"><gw:list  id="lstOrg1"  value="ALL" styles='width:100%' onchange="" >
                            <data>
                            <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data></gw:list>
                </td>
			</tr>	
			<tr >
				<td class="left" width="10%" align="left">&nbsp;</td>
				<td width="50%" align="left" style="color=Black"><input type="radio" name="option_P" value="3"  onclick="onClickOption(1)"><font size=2>Delete data</font></td>
				<td colspan=3 class="right" width="40%"><gw:list  id="lstOrg2"  value="ALL" styles='width:100%' onchange="" >
                            <data>
                            <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data></gw:list>
                            </td>
			</tr>	
			<tr >
				<td class="left" width="10%" align="left">&nbsp;</td>
				<td width="50%" align="left" style="color=Black"><input type="radio" name="option_P" value="4"  onclick="onClickOption(1)"><font size=2>Full Time</font></td>
				<td colspan=3 class="right" width="40%"><gw:list  id="lstOrg3"  value="ALL" styles='width:100%' onchange="" >
                            <data>
                            <%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data></gw:list>
                            </td>
			</tr>	
			<tr >
				<td class="left" width="10%" align="left" valign=bottom>&nbsp;</td>			
				<td  align="center" style="width:10%"><gw:icon id="idBtnProcess" img="in" text="Process" onclick="on_Process();return false;" /></td>
				<td  align="left"  style="width:20%" align="right"><gw:label id="idStaus2" text="" styles="width:100%;color:blue" ></gw:label></td>
                <td   style="width:30%" align="left"><gw:label id="idStaus1" text="" styles="width:100%;color:blue" ></gw:label></td>
				<td class="right"  style="width:30%" align="right"style="color=#FF3300"><gw:label id="idInterval" text="..." styles="width:100%" ></gw:label></td>
			</tr>
	        <tr >
				<td class="bottomleft" width="10%" align="left" valign=bottom>&nbsp;</td>			
				<td class="bottom" align="center" style="width:10%">&nbsp;</td>
				<td class="bottom" align="left"  style="width:20%" align="right">&nbsp;</td>
                <td class="bottom"  style="width:30%" align="left">&nbsp;</td>
				<td class="bottomright"  style="width:30%" align="right"style="color=#FF3300">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>


<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txt_check" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtFact_pk" styles="display:none"/>
<gw:textbox id="txtCompany_pk" styles="display:none"/>
<gw:textbox id="txtwg_tmp" styles="display:none"/>
<gw:textbox id="txdt_tmp" styles="display:none"/>
<gw:textbox id="idWorkFrom_tmp" styles="display:none"/>
<gw:textbox id="idWorkTo_tmp" styles="display:none"/>
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />
<gw:textbox id="txt_tmp" text="" styles="display:none"  />
<gw:textbox id="txt_emp_pk" text="" styles="display:none"  />

<gw:list  id="lst_file_name" styles="display:none">
                            <data><%=ESysLib.SetListDataSQL("SELECT CODE,CHAR_2 FROM VHR_HR_CODE WHERE ID='HR0032'")%></data></gw:list>
<gw:list  id="lst_temp" styles="display:none">
                            <data><%=ESysLib.SetListDataSQL("SELECT NUM_1,NUM_1 FROM VHR_HR_CODE WHERE ID='HR0031'")%></data></gw:list>                            

</html>