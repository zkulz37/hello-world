<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var emp_pk_list;
var check_init=0;
var innit=false;
var time_deplay=10000;
var first_time=false;
var first_active= true;
var MenuID11="";
var MenuTitle="10070003 Terminal Command";
var stop_interval=false;

	
function tabUnActive(npos, menu_id, menu_cd, title, ltitle, ftitle){
                              //alert('hide' + menu_id);
							  stop_interval=true;
               }
function tabActive(npos, menu_id, menu_cd, title, ltitle, ftitle){
                            //  alert('Show' + menu_id);
							  stop_interval=false;
               }
	


function BodyInit()
{
    txtcompany_pk.text="<%=Session("COMPANY_PK")%>";
    
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("CODEADMIN_YN")%>";
   
txtCodeAdmin.text= "<%=session("HR_LEVEL")%>";
   txtEmpID.SetEnable(false);
   txtTerID.SetEnable(false);
   txtStatus.SetEnable(false);
   txtGroup.SetEnable(false);
   FromDT.SetEnable(false);
	ToDT.SetEnable(false);
   //txtEmpID.SetEnable(false);
   ActiveButton(false);
   
   
   if (txtCodeAdmin.text=="N")
    {	var ls_data        = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0  AND ACTIVE_YN='Y' and pk='" + session("COMPANY_PK") + "' ")%>";
		lstCompany.SetDataText(ls_data);
		lstCompany.value=txtcompany_pk.text;
		 innit=true;
		datGetBranch.Call("SELECT");
	}
	else
	{
	set_Interval(time_deplay); 
	datGetBranch.Call("SELECT");
	//datGetTerminal.Call('SELECT');
	}
   
   
}

//-----------------------------------------------

 function ChangeColorItem(lstctl) 
 {
    }

//-------------------------------

function OnDataReceive(obj)
{
//alert("gfgffgdfg");
    if (obj.id=="datGetBranch")
    {
		
		//lstBranch.SetDataText(txtResult.text);
	txtTerID.text="";
    txtGroup.text="";
	txtStatus.text="";
		//lstBranch.SetDataText("");
		
		datAccessGroup.Call();
    }
	if (obj.id=="datAccessGroup")
	{
	
	ClearGrid();
         if(innit==true)
			{set_Interval(time_deplay); 
			innit=false;
			datGetTerminal.Call('SELECT');		
			}
			else
			{
			
	datGetTerminal.Call('SELECT');		
			
		}
		first_time=false;
	
	}
	
	if (obj.id=="datGetTerminal")
    {
		//lstBranch.SetDataText(txtResult.text+"|ALL|Select ALL");
        
        //datGetTerminal.Call();
		//if(innit==true)
		
		
		for(var i=1;i<=idGridTer.rows-1;i++ )
			{ //alert(idGridTer.GetGridData(i,6));
				if(idGridTer.GetGridData(i,6)=="")
					{	idGridTer.SetCellBgColor(i, 0, i, idGridTer.cols-1, 0x00ff00 );
					}
				else
					{idGridTer.SetCellBgColor(i, 0, i, idGridTer.cols-1, 0x0000ff );
					}
				if(idGridTer.GetGridData(i,2)==txtTerID.text)
				{
					txtTerID.text=idGridTer.GetGridData(i,2);
					txtGroup.text=idGridTer.GetGridData(i,7);
					txtStatus.text=(idGridTer.GetGridData(i,6)!="")?"Disconnected":"Connected";
					//ActiveButton((idGridTer.GetGridData(i,6)!="")?false:true);
				
				}
				
					
			}
			//alert(txtProcess.text +" aaaaaaaaaa");
			if(txtProcess.text!="" )
			{
			 datCheck.Call();
			}
			
		
		auto_resize_column(idGridTer,0,idGridTer.cols-1,0);    
		
			
    }
	if (obj.id=="datDelete")
    {
	txtProcess.text="5";// delete all user 
	set_Interval(time_deplay); 
	}
	if (obj.id=="datCheck")
    {
	
		if(txtStatus_cmd.text!="1" && txtStatus_cmd.text!="")
		{//txtProcess.text="";
		//txtResult.text="";
		//lbDelete.text="";
		 	if(txtStatus_cmd.text=="0")
			{	alert("Process error.");
			}	
			else
			{
				alert("Process complete.");
			}
			
			if(txtProcess.text=="6"||txtProcess.text=="4")
			{
				txtProcess.text="";
				OnShowPopup(2);
			}
			txtProcess.text="";
		}
		
	
	}
	if(obj.id=="datGetLog")
	{set_Interval(time_deplay); 
	  if(lstKind.value=="0")
	  txtProcess.text="9";// down load newlog
	  if(lstKind.value=="1")
	  txtProcess.text="10";// down load 0ld log
	  if(lstKind.value=="3")
	  txtProcess.text="7";// down load period log
			if(lstKind.value=="2")
	  txtProcess.text="11";// down load ALL log
	}
	if(obj.id=="datGetUserInfo")
	{   set_Interval(time_deplay); 
	if(txtEmpID.text=="")
		txtProcess.text="6";// down load log
		else
		txtProcess.text="4";// down load log
	}

 
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}


var startTime,interval_time,time_count;
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",100);
}
function clock(start,x) 
{

if(stop_interval)
	{
	//clear_Interval();
	//alert("dung");
	return;
	}

 var d = new Date();
   	if( txtProcess.text!="" )
		{
			{  if(time_count==""||time_count== null)
					time_count=new Date().valueOf();
			  if(Math.round((d.valueOf()-time_count)/100)+""!=idInterval.text )
				{//alert("alsdhdfshgldf  gl fdl");
					
					idInterval.text=Math.round((d.valueOf()-time_count)/100)+"";
					
				}
			}
			
		}
		else
			{
				idInterval.text="" ;
				 time_count="";
			}
	if(Math.round((d.valueOf()-startTime)) > x )
	{	//alert(Math.round((d.valueOf()-start)));
	   startTime=new Date().valueOf();
	   //alert(Math.round((d.valueOf()-start)));
		datGetTerminal.Call('SELECT');
	}
	
}
function clear_Interval()
{    idInterval.text="";
	clearInterval(interval_time);
	
}

function ClearGrid()
{
  //idGridRT.ClearData();
  
}
function AutoLoad()
{//startTime = new Date().valueOf();
//alert("sdfsdafd" +startTime);
 if(chkAuto.value=='T')
 {//clear_Interval();
 
 clear_Interval();
 //idGridRT2.ClearData();
 //first_time=false;
 set_Interval(time_deplay); 
 //first_time=false;
 }
 else
 {clear_Interval();
 }
}

function ChangeTer()
{
	
	txtTerID.text=idGridTer.GetGridData(idGridTer.row,2);
    txtGroup.text=idGridTer.GetGridData(idGridTer.row,7);
	txtStatus.text=(idGridTer.GetGridData(idGridTer.row,6)!="")?"Disconnected":"Connected";
	txt_ter_code.text=idGridTer.GetGridData(idGridTer.row,0);
	txt_ter_id.text=idGridTer.GetGridData(idGridTer.row,2);
	//ActiveButton((idGridTer.GetGridData(idGridTer.row,6)!="")?false:true);
    
}

function ActiveButton (obj)
{
 btnDelete.SetEnable(obj);
 btnGetLog.SetEnable(obj);
 btnGetUser.SetEnable(obj);
 btnGetUserL.SetEnable(obj);
 
}

function ChangeActiveButton (val)
{
	if(val==1)
	{  	ActiveButton(false);
		btnGetUserL.SetEnable(true);
		btnGetUser.SetEnable(true);
	}
	
	if(val==2)
	{  	ActiveButton(false);
		btnGetLog.SetEnable(true);
	}
	
	if(val==3)
	{  	ActiveButton(false);
		btnDelete.SetEnable(true);
	}
 
}

function OnProcess(obj)
{    
	
	if(txtTerID.text=="")
	{ alert("Please select terminal");
		return;
	}
	if(txtStatus.text=="Disconnected")
	{
		 alert("Terminal is disconnectted . So you can use this function");
		return;
	}
	lbResult.text="";
	lbStatus.text="";
	if(obj==3)
	if(confirm("Do you want to dellete all user in terminal"))
		{
			txtKey.text=  new Date().valueOf()  + "" +iduser_pk.text ;
			lbStatus.text="Status delete all user:";
		clear_Interval();	
		datDelete.Call();	
		}
	if(obj==2)
	if(confirm("Do you want to down load logfile"))
		{	lbStatus.text="Status download all access log:";
			txtKey.text=  new Date().valueOf()  + "" +iduser_pk.text ;
		clear_Interval();
		datGetLog.Call();	
		}
	if(obj==1)
	{
	
		if(confirm("Do you want to load user infomation from terminal"))
		{	lbStatus.text="Status load user infomation:";
			txtKey.text=  new Date().valueOf()  + "" +iduser_pk.text ;
			
			clear_Interval();
			txtAccessCode.text = idGridTer.GetGridData(idGridTer.row, 8);
			//alert(txtKey.text);
			datGetUserInfo.Call();	
		}	
	
	}
	
}

function OnShowPopup(n)
{
    if(n==1)
	{
		var url = "/form/ch/ba/chba00080_popup.aspx";
		var str="";
		str = System.OpenModal( System.RootURL+ url , 900 , 600 , 'resizable:yes;status:yes') ;
		if ( str != null )
		{ 
			txtEmpID.text=str+",";
		}
	} 	
	
	if(n==2)
	{
		
		clear_Interval();
		var url = "/form/ch/tm/chtm00030_2.aspx?p_key="+txtKey.text+"&p_code="+txt_ter_code.text+"&p_id="+txt_ter_id.text;
		var str="";
		
		
		str = System.OpenModal( System.RootURL+ url , 1000 , 800 , 'resizable:yes;status:yes') ;
		
		set_Interval(time_deplay); 
	}
	
	
	
	if(n==3)
	{
		if(txtTerID.text=="")
		{ alert("Please select terminal");
			return;
		}
		if(txtStatus.text=="Disconnected")
		{
			 alert("Terminal is disconnectted . So you can use this function");
			return;
		}
		clear_Interval();
		txtKey.text="";
		var url = "/form/ch/tm/chtm00030_2.aspx?p_key="+txtKey.text+"&p_code="+txt_ter_code.text+"&p_id="+txt_ter_id.text;
		var str="";
		
		
		str = System.OpenModal( System.RootURL+ url , 1000 , 800 , 'resizable:yes;status:yes') ;
		
		set_Interval(time_deplay); 
	}
	
	if(n==4)
	{
		
		clear_Interval();
		var url = "/form/ch/tm/chtm00030_3.aspx?p_key="+txtKey.text+"&p_code="+txt_ter_code.text+"&p_id="+txt_ter_id.text;
		var str="";
		
		
		str = System.OpenModal( System.RootURL+ url , 1000 , 800 , 'resizable:yes;status:yes') ;
		
		set_Interval(time_deplay); 
	}
}

//------------------------------------------------
function ChangeKind()
{ if(lstKind.value=="3")
	{
	FromDT.SetEnable(true);
	ToDT.SetEnable(true);
	}
	else
	{
	FromDT.SetEnable(false);
	ToDT.SetEnable(false);
	}
}
</script>
<body >
<!-------------------data control----------------------->
<!-------------------data control----------------------->
<gw:data id="datGetBranch" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_pro_get_branch"  > 
                <input>
                    <input bind="lstCompany" />
					<input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datGetTerminal" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_10070003_Ter_status" > 
                <input bind="idGridTer" >
                    <input bind="lstCompany" />
                    <input bind="lstBranch" />
					<input bind="lstGroup" />
                    
                </input>
                <output  bind="idGridTer" />
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datDelete" onreceive="OnDataReceive(this)"  > 
        <xml> 
                    <dso  type="process" procedure="hr_pro_del_ter_user" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="lstBranch" />
                    <input bind="txtTerID" />
					<input bind="txtKey" />
                    
                </input> 
                <output>
                     <output bind="lbResult" />
                  </output>
            </dso> 
        </xml> 
</gw:data>



<gw:data id="datGetLog" onreceive="OnDataReceive(this)"  > 
        <xml> 
                    <dso  type="process" procedure="hr_pro_get_log" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="lstBranch" />
                    <input bind="txtTerID" />
					<input bind="lstKind" />
					<input bind="FromDT" />
					<input bind="ToDT" />
					
					<input bind="txtKey" />
                    
                </input> 
                <output>
                     <output bind="lbResult" />
                  </output>
            </dso> 
        </xml> 
</gw:data>




<gw:data id="datGetUserInfo" onreceive="OnDataReceive(this)"  > 
        <xml> 
                    <dso  type="process" procedure="hr_pro_get_user_info" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="lstBranch" />
                    <input bind="txtAccessCode" />
                    <input bind="txtTerID" />
					<input bind="txtEmpID" />
					<input bind="txtKey" />
                    
                </input> 
                <output>
                     <output bind="lbResult" />
                  </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datCheck" onreceive="OnDataReceive(this)"  > 
        <xml> 
                    <dso  type="process" procedure="hr_pro_Check_command_status" > 
                <input>
                    <input bind="txtKey" />
					<input bind="txtProcess" />
				   </input> 
                <output>
                     <output bind="txtStatus_cmd" />
					 <output bind="lbResult" />
                  </output>
            </dso> 
        </xml> 
</gw:data>


<!-------------------data control----------------------->
<gw:data id="datAccessGroup" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_pro_get_AccessGroup"  > 
                <input>
                    <input bind="lstCompany" />
					<input bind="lstBranch" />
					<input bind="iduser_pk" />
					
                </input> 
                <output>
                    <output bind="lstGroup" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<table  border="1" width="100%" height="90%" >
<tr style="height:0%;">
<td  style="width:35%" ></td>
<td  style="width:65%" ></td>
</tr >
<tr style="height:100%;">
<td style="height:100%;"  >
<table  border="0" width="100%" style="height:100%;"   >
<tr  style="height:5%;" >
<td style="width:30%;" align="right" >Company</td>
<td colspan="2" style="width:65%"><gw:list  id="lstCompany"  maxlen = "100" value="<%=session("COMPANY_PK")%>" styles='width:100%' onchange="datGetBranch.Call();" >
                <data>
                    <%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0  AND ACTIVE_YN='Y'  ")%>
                </data>
            </gw:list></td>

</tr>

<tr style="height:5%;">
<td style="width:30%;" align="right">Branch</td>
<td colspan="2" >
<gw:list  id="lstBranch"  maxlen = "100"  styles='width:100%' onchange="datAccessGroup.Call();" >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0217' ")%>|ALL|Access Group- ALL
                </data>
            </gw:list>
</td>
<td style="width:5%"></td>
</tr>

<tr style="height:5%;">
<td style="width:30%;" align="right">Group</td>
<td colspan="2" >
<gw:list  id="lstGroup"  maxlen = "100" value='ALL' styles='width:100%' onchange="datGetTerminal.Call('SELECT')"   >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0216' ")%>|ALL|Access Group- ALL
                </data>
            </gw:list>
</td>
<td style="width:5%"></td>
</tr>


	

<tr style="height:5%;">
<td style="width:5%" align="left"><gw:checkbox id="chkAuto" value="T" onclick="AutoLoad()" >Auto load</gw:checkbox ></td>
<td style="width:65%;" align="right"></td>

<td style="width:5%" align="right"></td>
</tr>
<tr style="width:100%">
<td colspan="3"  >
					<gw:grid
					id="idGridTer"
					header="Code|Code Name|ID|Terminal IP|Terminal Verson|Users|Last time online|_Access Group|_Access Group Code"
					format="0|0|0|0|0|-1|0|0|0"
					aligns="0|0|0|0|0|0|0|0|0"
					defaults="0|0|0|0|0|0|0|0|0"
					editcol="0|0|0|0|0|0|0|0|0"
					widths="1000|1000|1000|1000|1000|1000|1000|0|0"
					styles="width:100%;height:100%"
					sorting="T"
					acceptNullDate="T"
					oncelldblclick = "ChangeTer()"			/>

</td>
</tr>

</table>
</td>
<td border="1">

<table  border="0" width="100%"  height="40%"   cellpadding="0" cellspacing="0" >
<tr  height="8%" >
<td  style="width:15%; color: red" align="right" colspan=2>Terminal ID</td>
<td  style="width:20%" align="right"colspan=2 ><gw:textbox id="txtTerID"  styles='width:100%;color: red' /></td>

<td style="width:20%;color: red" align="right" >Access Group</td>
<td style="width:15%" align="right"><gw:textbox id="txtGroup"  styles='width:100%;color: red' /></td>

<td style="width:15%;color: red" align="right">Status</td>
<td style="width:15%" align="right"><gw:textbox id="txtStatus"  styles='width:100%;color: red' /></td>

</tr>

<tr  height="8%">
<td align="right" colspan=4 ><gw:label id="lbStatus" styles="width:100%; color: blue" /> </td>
<td align="left" colspan=3  ><gw:label id="lbResult" styles="width:100%; color: blue" /></td>
<td align="left" colspan=1  ><gw:label id="idInterval" styles="font-size:15pt;width:100%; color: blue" /></td>
<td>
</tr>

<tr  height="8%">
<td style="width:5%">
	<input type="radio" name="optCmd" value="1" onclick="ChangeActiveButton(1)">
</td>
<td  align="left" colspan=1 >Get User Info </td>
<td align="right" ><a title="Click here to choice Employee" onclick="OnShowPopup(1)" href="#tips" >Emp ID</a></td>
<td align="right"  style="width:40%"colspan=2><gw:textbox id="txtEmpID"  styles='width:100%' /></td>
<td align="right" ><gw:imgBtn id="ibtnResetE" alt="Reset" img="Reset" text="Reset" onclick="txtEmpID.text='';" /></td>
<td align="right" colspan=1 ><gw:icon id="btnGetUser"   text="Get User infomation" onclick="OnProcess(1)" /></td>
<td align="right" ><gw:icon id="btnGetUserL"   text="Last Time Request" onclick="OnShowPopup(3)" /></td>
</tr>
<tr  height="8%">
<td >
	<input type="radio" name="optCmd" value="2" onclick="ChangeActiveButton(2)">
</td>

<td colspan=2 ><gw:list  id="lstKind"  maxlen = "100" value='0' styles='width:100%' onchange="ChangeKind()" >
                <data>
                |0|Get Acess log- NEW|1|Get Acess log- OLD|2|Get Acess log- ALL|3|Get Acess log- PERIOD
                </data>
            </gw:list></td>
<td align="right" ><gw:datebox id="FromDT"  maxlen = "10" text="" styles='width:100%'lang="1" /></td>

<td align="center" > ~ </td>
<td align="left" ><gw:datebox id="ToDT"  maxlen = "10" text="" styles='width:100%'lang="1" /></td>


<td align="right" colspan=1><gw:icon id="btnGetLog"   text="Get Access Log" onclick="OnProcess(2)" /></td>
<td align="right" colspan=1><gw:icon id="btnQueryLog"   text="Query Access Log" onclick="OnShowPopup(4)" /></td>
</tr>

<tr  height="8%">
<td >
	<input type="radio" name="optCmd" value="3" onclick="ChangeActiveButton(3)">
</td>
<td align="left" colspan="2">Delete All User</td>
<td colspan=2>&nbsp;</td>

<td align="right" colspan=2><gw:icon id="btnDelete"   text="Delete All User" onclick="OnProcess(3)" /></td>

</tr>





</table>

</td>

</tr>


</table>
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor:hand;position:absolute;left:0;top:0;display:none" onclick="OnToggle()"  /> 
<gw:textbox id="txtEmpPK" styles="display:none"/>
<gw:textbox id="txtOrg" styles="display:none"/>	
<gw:textbox id="txtCodeAdmin" styles="display:none"/>
<gw:textbox id="txtUpperOrg" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtPhoto_PK" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txt_sal_security" styles="display:none"/>

<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtStatus_cmd" styles="display:none"/>
<gw:textbox id="txtKey" styles="display:none"/>
<gw:textbox id="txtProcess" text="" styles="display:none"/>
<gw:textbox id="txtcompany_pk" styles="display:none"/>
<gw:textbox id="txt_ter_code" styles="display:none"/>
<gw:textbox id="txt_ter_id" styles="display:none"/>
<gw:textbox id="txtAccessCode" styles="display:none"/>


</body>
</html>
