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
   
   ChangeColorItem(lstLocation_pk.GetControl());

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

function OnDataReceive(obj)
{
    switch (obj.id)
    {
        case "datCheck_View":
          if(txtFlag_View.text == 'Y')
          {
              idBtnProcess.style.display = "none";
              idBtnClose.style.display = "none";
          }
          else
          {
               // alert(iduser_pk.text);
              if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
                     datUser_info.Call(); 
              else
                    check_init=1;
          }
            break;
        case "datUser_info":
                ChangeColorItem(lstLocation_pk.GetControl());
                check_init=1;
               break;
	   case "datDailyProcess": 
	        if(txtResult.text=="0")//success
	        {
	            if(flag_stop==1) //user stop
	            {
	                clear_Interval(idInterval);
                    idProcess_status.text="User stoped";
                    idBtnProcess.SetEnable(1);
                    idBtnClose.SetEnable(1);
                     check_init=1;
                    return;
	            }
	        
		         if(txtDT_tmp.text!=idTo.value) //month
                 {
                        txtDT_tmp.text=next_day(txtDT_tmp.text); //yyyymmdd
                        clear_Interval(idInterval);
        				
                        idProcess_status.text="System is processing for "+ txtDT_tmp.text.substr(6,2)+"/"+txtDT_tmp.text.substr(4,2)+"/"+txtDT_tmp.text.substr(0,4);
                         set_Interval(100);
                        datDailyProcess.Call();
                 }
                 else
                    {

			             clear_Interval(idInterval);
                         idProcess_status.text="All Task Finish...";
			             alert("Sucessful... ");
			             idBtnProcess.SetEnable(1);
                         idBtnClose.SetEnable(1);
			             idBtStop.style.display='none';
			             check_init=1;
                    }
            }
            else if(txtResult.text=="1")//CLOSED
            {
                 clear_Interval(idInterval);
                 idProcess_status.text="Data Closed, can not process";
                 idBtnProcess.SetEnable(1);
                 idBtnClose.SetEnable(1);
                 check_init=1;
	             alert("Data Closed, can not process");
            }
           else 
            {
                 clear_Interval(idInterval);
                 idProcess_status.text="Data Error";
                 idBtnProcess.SetEnable(1);
                 idBtnClose.SetEnable(1);
	             alert("Data Error... ");
	             check_init=1;
            }
	        break;             
    }

}
function on_Process(flag)
{
    if(check_init==1)
    {
       if(confirm("Do you want to " + flag + " daily cost?\nBạn muốn " + flag +" dữ liệu?"))
        {
            txtDT_tmp.text=idFrom.value;
            txtFlag_process.text=flag;
            set_Interval(1000)
            idBtStop.style.display='';
            idProcess_status.text="System is processing for "+ txtDT_tmp.text.substr(6,2)+"/"+txtDT_tmp.text.substr(4,2)+"/"+txtDT_tmp.text.substr(0,4);
            check_init=0;
            datDailyProcess.Call(); 
        }
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
    idBtStop.style.display='none';
}

function add_zero(n) {
    if(Number(n)<=9)
        return '0'+n;
    else 
        return n;
}

function daysInMonth(month, year) {
    return new Date(year, month, 0).getDate();
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


<gw:data id="datDailyProcess" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_10030027_SALARY_V2" > 
                <input>
                    <input bind="txtDT_tmp" />
                    <input bind="lstLocation_pk" />
                    <input bind="txtExRate" />
                    <input bind="txtFlag_process" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>



<form name="Salary Process" id="form1">
<table style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="center" border="0" >
<tr>
	<td width="100%">
		<table class="itable"  style="width:80%;height:50%;border-left:0;border-top:0" cellpadding="0" cellspacing="0" valign="center" align="center" border="0" >
		         <tr style="height:2%">
					<td colspan=10 width="100%" align="center" >&nbsp;</td>
				</tr>
		       
		        <tr style="height:12%">
					<td colspan=10 class="topleftright" width="100%" align="center"><b style="font-size=20; color:Fuchsia">DAILY LABOR COST</b></td>
				</tr>
				<tr style="height:12%">
					<td class="topleft" width="12%" align="right"><a title="Click here to show location" onclick="OnShowPopup()" href="#tips" >Location</a></td>
					<td class="topleft" width="2%" align="right">&nbsp;</td>
					<td class="top" colspan=6 width="60%" align="left" ><gw:list  id="lstLocation_pk" value='ALL'  styles='width:100%'onchange=""  >
                            <data><%= ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + Session("COMPANY_PK") + "',a.tco_company_pk) or '" + Session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%></data></gw:list></td>
                    <td colspan=2 class="topright" width="26%" align="right">&nbsp;</td>
				</tr>	
				<tr style="height:12%">
					<td class="topleft" width="23%" align="right">Salary Kind</td>
					<td class="topleft" width="2%" align="right">&nbsp;</td>
					<td class="top" colspan=4 align="left"><b>Daily Labor Cost</b></td>
					<td  colspan=2 class="top" width="50%" align="right" >&nbsp;</td>
					
					<td colspan=2 class="topright" width="26%" align="right">&nbsp;</td>
				</tr>	
				
				<tr style="height:12%">
				    <td class="topleft" align="right">Work Date</td>
				    <td class="topleft" width="2%" align="right">&nbsp;</td>
				    <td width=10% class="top" align="right">From</td>
				    <td width=10% class="top" ><gw:datebox id="idFrom" lang="<%=Session("Lang")%>" styles="width:90%"  onchange=""></gw:datebox></td>			
				    <td width=10% class="top" align="right">To</td>
				    <td width=10% class="top" ><gw:datebox id="idTo" lang="<%=Session("Lang")%>" styles="width:90%"  onchange=""></gw:datebox></td>			
				    <td width=10% class="top" align="right">&nbsp;</td>
				     <td width=10% class="top">&nbsp;</td>		
                    <td colspan=2 class="topright" width="26%" align="right">&nbsp;</td>
			    </tr>
			    <tr style="height:12%">
					<td class="left" align="right" >&nbsp;</td>
					<td class="left" width="2%" align="right">&nbsp;</td>
                    <td align="right" >Ex Rate</td>
                    <td align="left" ><gw:textbox id="txtExRate"  styles='width:100%' text=""/></td>        
					<td align="center"><gw:icon id="idBtnProcess" img="in" text="Process" onclick="on_Process('PROCESS')" /></td>
					<td align="center"><gw:icon id="idBtnClose" img="in" text="Close" onclick="on_Process('CLOSE')" /></td>
					<td align="center"><gw:icon id="idBtnOpen" img="in" text="Open" onclick="on_Process('OPEN')" /></td>
					<td colspan=2 align="center"><b style="color=#FF3300"><gw:label id="idInterval" text="" styles="width:100%" ></gw:label></b></td>
                    <td colspan=1 class="right" width="26%" align="right">&nbsp;</td>
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
<gw:textbox id="txtDT_tmp" text="" styles="display:none"  />
<gw:textbox id="txtFlag_process" text="" styles="display:none"  />




</html>

