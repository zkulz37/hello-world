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
var process_flag=0;
var root_temp="";



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
	idBtnProcess_M.SetEnable(0);
	table_M1.style.display="none";
	table_M2.style.display="none";
	//idEmp_id.SetEnable(0);
	
	
	
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
	//alert(iduser_pk.text);
    //alert(txtHr_level.text);
	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        //lst_wg1.ClearData();
        //lst_wg2.ClearData();  
        datUser_info.Call();     	    
	}
    else
        onChange_org();
	
	
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
					
					var url = root_temp+file_name+"?date=" + dt + "&fact=" + lst_location.value + "&nm=hr&pd=hr2&hr3="+ t;
					//alert(url);
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
					set_Interval(100);
					process_1.Call();
					idBtnProcess.SetEnable(0)
					break;	
				case '3': //delete original data 
					if(confirm("Do you want to delete? \n Bạn thực sự muốn xóa?"))
					{
					    process_flag=1;
					    set_Interval(100);
					    process_del.Call();
					    idBtnProcess.SetEnable(0)
					}    
					break;	
			    case '4': //delete original data 
					if(confirm("Do you want to process full time?"))
					{
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
        case "datUser_info":
            //alert(txtFact_pk.text);
            lstCompany.SetDataText(txtFact_pk.text);
            onChange_org();
		    break;
        case "datWorkGroup_info":
            lst_wg1.SetDataText(txtwg_tmp.text+"|ALL|Select All");
            lst_wg2.SetDataText(txtwg_tmp.text+"|ALL|Select All");
            lst_wg3.SetDataText(txtwg_tmp.text+"|ALL|Select All");
            lst_wg1.value='ALL';
            lst_wg2.value='ALL';
            lst_wg3.value='ALL';
            break;
		case "process_1":
            if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    alert("Step 1 success, Step 2 will continous...\n Bước 1 thành công, bước 2 được tiếp tục... ");
			    set_Interval(100);
			    process_2.Call();
		    }
		    else
		    {
		        alert("Step 1 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
		        idBtnProcess.SetEnable(1)
		        process_flag=0;
		    }
		    break;    
		case "process_2": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    alert("Step 2 success, Step 3 will continous...\n Bước 2 thành công, bước 3 được tiếp tục... ");
			    set_Interval(100);
			    process_3.Call();
		    }   
		     else
		    {
		        alert("Step 2 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
		        idBtnProcess.SetEnable(1)
		        process_flag=0;
		    }
		    break;
	    case "process_3": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    alert("Step 3 success, Step 4 will continous...\n Bước 3 thành công, bước 4 được tiếp tục... ");
			    set_Interval(100);
			    process_4.Call();
		    }   
		     else
		    {
		        alert("Step 3 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
		        idBtnProcess.SetEnable(1)
		        process_flag=0;
		    }
		    break;
		case "process_4": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval);
			    alert("Step 4 success, Step 5 will continous...\n Bước 4 thành công, bước 5 được tiếp tục... ");
			    set_Interval(100);
			    process_5.Call();
		    }   
		     else
		    {
		        alert("Step 4 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval);
		    }
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
		     else if(txtResult.text=="-1")//success
		    {
		        alert("This month is closed.\Tháng này đã đóng.");
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
			    alert("Step 1 success, Step 2 will continous...\n Bước 1 thành công, bước 2 được tiếp tục... ");
			    set_Interval2(100);
			    process_M2.Call();
		    }
		    else
		    {
		        alert("Step 1 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval_M);
		        idBtnProcess_M.SetEnable(1)
		        process_flag=0;
		    }
		    break;
		case "process_M2": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval_M);
			    alert("Step 2 success, Step 3 will continous...\n Bước 2 thành công, bước 3 được tiếp tục... ");
			    set_Interval2(100);
			    process_M3.Call();
		    }   
		     else
		    {
		        alert("Step 2 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval_M);
		        idBtnProcess_M.SetEnable(1)
		        process_flag=0;
		    }
		    break;
	    case "process_M3": 
		    if(txtResult.text=="0")//success
		    {
			    txtResult.text=="";
			    clear_Interval(idInterval_M);
			    alert("Step 3 success, Step 4 will continous...\n Bước 3 thành công, bước 4 được tiếp tục... ");
			    set_Interval2(100);
			    process_M4.Call();
		    }   
		     else
		    {
		        alert("Step 3 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval_M);
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
		    }   
		     else
		    {
		        alert("Step 4 error, process unsucessfull...\n Có lỗi xãy ra, Tiến trình không thành công... ");
		        clear_Interval(idInterval_M);
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
        if(document.form1.imgMaster.status == "expand")
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
            
        }
  
}

function OnShowPopup()
{
    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
    var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
	if (obj!=null)
	    idEmp_id.text=obj[1];
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

<gw:data id="process_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_1" > 
                <input>
                    <input bind="idWorkDT" />
                     <input bind="lst_wg1" />
                     <input bind="lstCompany" />                     
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_2" > 
                <input>
                    <input bind="idWorkDT" />
                     <input bind="lst_wg1" />
                     <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_3" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_3" > 
                <input>
                    <input bind="idWorkDT" />
                     <input bind="lst_wg1" />
                     <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_4" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_4" > 
                <input>
                    <input bind="idWorkDT" />
                     <input bind="lst_wg1" />
                     <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="process_5" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_5" > 
                <input>
                    <input bind="idWorkDT" />
                     <input bind="lst_wg1" />                     
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="process_del" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_del" > 
                <input>
                    <input bind="idWorkDT" />
                    <input bind="lst_wg2" />
                    <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="process_M" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_M" > 
                <input>
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="idEmp_id" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="process_M2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_M2" > 
                <input>
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="idEmp_id" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_M3" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_M3" > 
                <input>
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="idEmp_id" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_M4" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_M4" > 
                <input>
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="idEmp_id" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_M_del" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_M_del" > 
                <input>
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="idEmp_id" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_ft_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_FT_1" > 
                <input>
                    <input bind="idWorkDT" />
                     <input bind="lst_wg3" />
                     <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_ft_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_FT_2" > 
                <input>
                    <input bind="idWorkDT" />
                     <input bind="lst_wg3" />
                     <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_M_ft_1" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_M_ft_1" > 
                <input>
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="idEmp_id" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="process_M_ft_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_pro_10020001_pro_M_ft_2" > 
                <input>
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="idEmp_id" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datWorkGroup_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sel_10020001_wg_role"  > 
                <input>
                    <input bind="lstCompany" />
                </input> 
                <output>
                    <output bind="txtwg_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<form name="Time Control" id="form1">
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="center" border="0" >
<tr>
	<td width="100%">
		<table class="itable"  style="width:50%;height:6%" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >
				<tr style="width:40%;height:4%">
					<td class="topleft" width="30%" align="right" colspan="3">Server System Date</td>
					<td class="top" width="20%" align="left" colspan="2"style="color=#FF00CC"><gw:label id="idSdt" styles="width:100%" ></gw:label></td>
					<td class="top" width="30%" align="right"  colspan="3" >Local System Date</td>
					<td class="topright" width="20%" colspan="2"style="color=#FF00CC" align="left"><gw:label id="idLdt" styles="width:100%" ></gw:label></td>
				</tr>	
		</table>
		<table  style="width:50%;height:6%" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >	
			<tr >
				<td class="topleft" width="20%" align="right">Work Date</td>
				<td class="top" width="20%"><gw:datebox id="idWorkDT" lang="<%=Session("Lang")%>" styles="width:50%" onchange=""></gw:datebox></td>	
                <td class="top" width="20%" align=right >Company</td>		
				<td class="topright" width="40%">
                    <gw:list  id="lstCompany" styles='width:100%' onchange="onChange_org()" >
                        <data>
                            <%= ESysLib.SetListDataSQL("SELECT a.pk,A.PARTNER_NAME FROM tco_company a where a.del_if=0 and nvl(a.active_yn,'N')='Y' order by A.PARTNER_ID")%>
                        </data>
                    </gw:list>
                </td>
			</tr>
		</table>
		<table style="width:50%;height:30%" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >	
            
			<tr  >
				<td class="topleft" width="10%" align="left">&nbsp;</td>
				<td class="top" width="50%" align="left"><input type="radio" name="option_P" value="1" onclick="onClickOption(1)" style="color=Black"><font size=2>Download data from time machine</font></td>
				<td class="topright" width="40%"><gw:list  id="lst_location"  styles='width:100%' onchange="onChange_location()" >
                            <data><%=ESysLib.SetListDataSQL("SELECT CODE,CODE_NM||'-'||CHAR_1 FROM VHR_HR_CODE WHERE ID='HR0032'")%></data></gw:list></td>
			</tr>
            
            
			<tr >
				<td class="left" width="10%" align="left">&nbsp;</td>
				<td   width="50%" align="left" style="color=Black"><input type="radio" name="option_P" value="2"  onclick="onClickOption(1)"><font size=2>Process data</font></td>
				<td class="right" width="40%"><gw:list  id="lst_wg1"  value="ALL" styles='width:100%' onchange="onChange_location()" >
                            <data><%=ESysLib.SetListDataSQL("SELECT PK,WORKGROUP_NM FROM thr_work_group WHERE DEL_IF=0 ORDER BY WORKGROUP_NM")%>|ALL|Select All</data></gw:list></td>
			</tr>	
			<tr >
				<td class="left" width="10%" align="left">&nbsp;</td>
				<td width="50%" align="left" style="color=Black"><input type="radio" name="option_P" value="3"  onclick="onClickOption(1)"><font size=2>Delete data</font></td>
				<td class="right" width="40%"><gw:list  id="lst_wg2"  value="ALL" styles='width:100%' onchange="onChange_location()" >
                            <data><%=ESysLib.SetListDataSQL("SELECT PK,WORKGROUP_NM FROM thr_work_group WHERE DEL_IF=0 ORDER BY WORKGROUP_NM")%>|ALL|Select All</data></gw:list></td>
			</tr>	
			<tr >
				<td class="left" width="10%" align="left">&nbsp;</td>
				<td width="50%" align="left" style="color=Black"><input type="radio" name="option_P" value="4"  onclick="onClickOption(1)"><font size=2>Full Time</font></td>
				<td class="right" width="40%"><gw:list  id="lst_wg3"  value="ALL" styles='width:100%' onchange="onChange_location()" >
                            <data><%=ESysLib.SetListDataSQL("SELECT PK,WORKGROUP_NM FROM thr_work_group WHERE DEL_IF=0 ORDER BY WORKGROUP_NM")%>|ALL|Select All</data></gw:list></td>
			</tr>	
			<tr >
				<td class="bottomleft" width="10%" align="left" valign=bottom><img status="expand" id="imgMaster" alt="Close detail" src="../../../system/images/iconmaximize.gif" style="cursor:hand" onclick="OnToggle()"  /></td>			
				<td class="bottom" align="center" style="width:30%"><gw:icon id="idBtnProcess" img="in" text="Process" onclick="on_Process();return false;" /></td>
				<td class="bottomright"  style="width:60%" align="right"style="color=#FF3300"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></td>
			</tr>
	
		</table>
		<table id="table_M1"  style="width:50%;height:6%" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >	
			<tr >
				<td class="bottomleft" width="20%" align="right">Work From</td>
				<td class="bottom" width="20%"><gw:datebox id="idFrom" lang="<%=Session("Lang")%>" styles="width:50%" onchange=""></gw:datebox></td>			
				<td class="bottom" width="5%" align="center"><b>~</b></td>			
				<td class="bottom" width="20%"><gw:datebox id="idTo" lang="<%=Session("Lang")%>" styles="width:50%" onchange=""></gw:datebox></td>			
				<td class="bottom" width="15%" align=right><a title="Click here to choose" onclick="OnShowPopup()" href="#tips" >Emp ID:</a></td>		
				<td class="bottomright" width="20%"><gw:textbox id="idEmp_id" styles="width:95%" /></td>
					
			</tr>
		</table>
		<table id="table_M2" style="width:50%;height:18%" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >	
			<tr >
				<td class="left" width="30%" align="left">&nbsp;</td>
				<td class="right" colspan="2" width="70%" align="left"><input type="radio" name="option_P2" value="1" style="color=Black" onclick="onClickOption(2)"><font size=2>Process data</font></td>
			</tr>	
			<tr >
				<td class="left" width="30%" align="left">&nbsp;</td>
				<td class="right" colspan="2" width="70%" align="left"><input type="radio" name="option_P2" value="2" style="color=Black" onclick="onClickOption(2)"><font size=2>Delete data</font></td>
			</tr>	
			<tr >
				<td class="left" width="30%" align="left">&nbsp;</td>
				<td class="right" colspan="2" width="70%" align="left"><input type="radio" name="option_P2" value="3" style="color=Black" onclick="onClickOption(2)"><font size=2>Full Time</font></td>
			</tr>	
			<tr >
				<td class="bottomleft" align="right">&nbsp;</td>			
				<td class="bottom" align="center" style="width:30%"><gw:icon id="idBtnProcess_M" img="in" text="Process" onclick="on_Process_M();return false;" /></td>
				<td class="bottomright"  style="width:40%" style="color=#FF3300" align="right"><gw:label id="idInterval_M" text="" styles="width:100%" ></gw:label></td>
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
<gw:list  id="lst_file_name" styles="display:none">
                            <data><%=ESysLib.SetListDataSQL("SELECT CODE,CHAR_2 FROM VHR_HR_CODE WHERE ID='HR0032'")%></data></gw:list>
<gw:list  id="lst_temp" styles="display:none">
                            <data><%=ESysLib.SetListDataSQL("SELECT NUM_1,NUM_1 FROM VHR_HR_CODE WHERE ID='HR0031'")%></data></gw:list>                            

</html>