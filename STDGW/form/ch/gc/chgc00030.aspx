<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser("hr")%>

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
   if((Trim(idemp_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
         datGet_Location_dept.Call(); 
   else
        datGet_from_to.Call();
	
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


function onchange_month()
{
    txtResult.text="";
	datGet_from_to.Call();
}

function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datGet_Location_dept":
               datGet_from_to.Call();
               break;
        case "datGet_from_to":
		      if(txtResult.text=='Y')
		      {
		        idInterval.text="This Month Closed.";
		        idBtnProcess.SetEnable(0);
		      }
		      else if(txtResult.text=="")
		      {
		        idInterval.text="This Month Not Register."
		        idBtnProcess.SetEnable(0);
		      }
		      else
		      {
		        idBtnProcess.SetEnable(1);
		      }  
		    break;     
		
		 case "datProd_Salary":  
		    if(txtResult.text=='0')
		    {
	            alert("Production Salary completed! \n Lương sản phẩm đã hoàn thành!");
	            txtResult.text='';
	            clear_Interval(idInterval);
		    }
		    else
		    {
		        alert("Error:Production Salary Uncomplete.\n Lỗi: Lương sản phẩm không thực hiện thành công.")
		        clear_Interval(idInterval);
		        idInterval.text="Uncomplete."
		    }    
		    break;
    }
     
	
}
function on_Process()
{
    if(confirm("Salary is processing...do you want to continous?\nHệ thống tính lương bắt đầu...Bạn có muốn tiếp tục?"))
    {
        set_Interval(1000)
        datProd_Salary.Call();
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
                    <output bind="lstLocation_dept" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datGet_from_to" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.sp_pro_get_from_to" > 
                <input>
                    <input bind="idWorkMon" />
                </input> 
                <output>
                    <output bind="idFrom" />
                    <output bind="idTo" />
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!--------------------DATA CONTROL--------------------->
<gw:data id="datProd_Salary" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr.SP_PRO_MONTH_PROD_SALARY" > 
                <input>
                    <input bind="idWorkMon" />
                    <input bind="idFrom" />
                    <input bind="idTo" />
                    <input bind="lstLocation_dept" />
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
		<table class="itable"  style="width:60%;height:30%" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >
				<tr style="height:20%">
					<td class="topleft" width="20%" align="right">Location</td>
					<td class="topleft" width="2%" align="right">&nbsp;</td>
					<td class="topright" colspan=6 width="78%" align="left" ><gw:list  id="lstLocation_dept" value='ALL' maxlen = "100" styles='width:30%' >
                            <data>|ALL|Select All</data></gw:list></td>
				</tr>	
				<tr style="height:20%">
				    <td class="topleft" align="right">Work Month</td>
				    <td class="topleft" width="2%" align="right">&nbsp;</td>
				    <td width=15% class="top"><gw:datebox id="idWorkMon" lang="<%=Session("Lang")%>" styles="width:90%" onchange="onchange_month()" type=month></gw:datebox></td>			
				    <td width=15% class="top" align="right">From</td>
				    <td width=10% class="top" ><gw:datebox id="idFrom" lang="<%=Session("Lang")%>" styles="width:90%" nullaccept onchange=""></gw:datebox></td>			
				    <td width=15% class="top" align="right">To</td>
				    <td width=13% class="top" ><gw:datebox id="idTo" lang="<%=Session("Lang")%>" styles="width:90%" nullaccept onchange=""></gw:datebox></td>			
				    <td width=10% class="topright" align="right">&nbsp;</td>
			    </tr>
			    <tr style="height:20%">
					<td class="bottomtopleft" align="right" >&nbsp;</td>
					<td class="bottomtopleft" width="2%" align="right">&nbsp;</td>
					<td class="bottomtop" align="right" >&nbsp;</td>
                    <td class="bottomtop" align="right" >&nbsp;</td>
                    <td class="bottomtop" align="left" >&nbsp;</td>        
					<td class="bottomtop" align="center"><gw:icon id="idBtnProcess" img="in" text="Process" onclick="on_Process()" /></td>
					<td class="bottomtop" align="center">&nbsp;</td>
					<td class="bottomtopright" align="center"><b style="color=#FF3300"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></b></td>
				</tr>	
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




</html>
