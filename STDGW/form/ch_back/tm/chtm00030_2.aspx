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


function BodyInit()
{
    txtcompany_pk.text="<%=Session("COMPANY_PK")%>";
    
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("CODEADMIN_YN")%>";
   
txtCodeAdmin.text= "<%=session("HR_LEVEL")%>";
txtKey.text="<%=Request.querystring("p_key")%>";
txtTerCode.text="<%=Request.querystring("p_code")%>";
txtTerID.text="<%=Request.querystring("p_id")%>";

   
   
   txtTerID.SetEnable(false);
   
   

   
   if (txtCodeAdmin.text=="N")
    {	var ls_data        = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0  AND ACTIVE_YN='Y' and pk='" + session("COMPANY_PK") + "' ")%>";
		lstCompany.SetDataText(ls_data);
		lstCompany.value=txtcompany_pk.text;
		
		datGetBranch.Call("SELECT");
		//datGetTerminalUser.Call("SELECT");
	}
	
   datGetBranch.Call("SELECT");
   //datGetTerminalUser.Call("SELECT");
   
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
			
			datAccessGroup.Call();
			
		
    }
	
	 if (obj.id=="datAccessGroup")
    {
		
		
			datGetTer.Call();
			
		
		
    }
	
	if (obj.id=="datGetTer")
    {
			lstTer.SetDataText(txtResult.text);
			if(innit==false)
			{
			//alert("dsfdfs");
			datGetTerminalUser.Call("SELECT");
			}
    }
	if (obj.id=="datGetServerUser")
    {
		fillColor();
		auto_resize_column( idGriServerdEmp ,0,idGriServerdEmp.cols-1,0);
		if(innit==false)
			innit=true;
			
		idRecord.text=idGriServerdEmp.rows-1 +("(rows)."); 	
	}
	if (obj.id=="datGetTerminalUser")
    {
		auto_resize_column( idGridTerEmp ,0,idGridTerEmp.cols-1,0);
		idRecord2.text=idGridTerEmp.rows-1+("(rows)."); 
		
	}
	if(obj.id=="datDeleteUser")
	{ 
	datUpload.Call("SELECT");
	}
	if(obj.id=="datDownloadUser")
	{ 
		datUpload.Call("SELECT");
	}
	if(obj.id=="datUpload")
	{ 	
		if(first_time==false)
		{	first_time=true;
			clear_Interval();
			tr1.style.display="none";
			tr2.style.display="";
			set_Interval(time_deplay);
		}
		else
		{
			var temp=0;
			for(var i=1 ;i<=idGridProcess.rows-1;i++)
			{  if(idGridProcess.GetGridData(i,5)==2)
				{temp=1;
				 //break;
				}
			}
			if(temp==0)
			{	alert("Process is complete.")
				tr1.style.display="";
				tr2.style.display="none";
				clear_Interval();
			}
		}
	}
	

 
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}


var startTime,interval_time
function set_Interval(x) 
{
 startTime = new Date().valueOf();
 
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",100);
}
function clock(start,x) 
{
 var d = new Date();
 
  if(Math.round((d.valueOf()-startTime)/100)+""!=idInterval.text)
	{//alert("alsdhdfshgldf  gl fdl");
	idInterval.text=Math.round((d.valueOf()-start)/100);
	}
	if(Math.round((d.valueOf()-startTime))>x)
	{
	//alert("dfgdfg");
	//if(chkAuto.value=='T')
		{
		startTime=new Date().valueOf();
		//alert("sdfdsf");
		/*if(idGridTer2.rows>1)
			txtmax_pk.text=idGridTer2.GetGridData(1,7)+"";*/
			//alert(txtmax_pk.text);
		datUpload.Call('SELECT');
		
		}
	/*else
		{clear_Interval();}	*/
	
	}
	
}
function clear_Interval()
{	idInterval.text="";
	clearInterval(interval_time);
	
}

function ClearGrid()
{
  idGridRT.ClearData();
  
}





function fillColor()
{ for(var i=1; i<= idGriServerdEmp.rows-1;i++)
    { if(idGriServerdEmp.GetGridData(i,8)=='2')
		{idGriServerdEmp.SetCellBgColor(i, 0, i, idGriServerdEmp.cols-1, 0x0000ff );
		}
	  if(idGriServerdEmp.GetGridData(i,8)=='1')
		{idGriServerdEmp.SetCellBgColor(i, 0, i, idGriServerdEmp.cols-1, 0x00ffff );
		}	
	}
}


function OnSearch(n)
{
 if(n==1)
	{datGetServerUser.Call("SELECT");}
 else
	{datGetTerminalUser.Call("SELECT");}
}
//------------------------------------------------

function OnSelectAll(obj_checkbox,obj_grd)
{	
    var ctrl=obj_grd.GetGridControl();
    var temp ="";
	if(obj_checkbox.value=="T")
	temp="-1";
	else
	temp="0";
	if(ctrl.SelectedRows>0)
		for(var i=0;i<ctrl.SelectedRows;i++)
         { 
			obj_grd.SetGridText(ctrl.SelectedRow(i),1,temp);
         }
		 else
		 {
		 for(var i=1;i<=obj_grd.rows-1;i++)
         {               obj_grd.SetGridText(i,1,temp);
         }
		 }
}

function OnCompare()
{ 

for(var i=1;i<=idGridTerEmp.rows-1;i++)
{
idGridTerEmp.SetGridText(i,1,'-1');
}

for(var i=1;i<=idGriServerdEmp.rows-1;i++)
	{ var emp_id=idGriServerdEmp.GetGridData(i,2);
		idGriServerdEmp.SetGridText(i,1,'-1');
		var tem=1;
		for(var j=1;j<=idGridTerEmp.rows-1;j++)
		{ if(emp_id==idGridTerEmp.GetGridData(j,2))
			{idGriServerdEmp.SetGridText(i,1,'0');
			 idGridTerEmp.SetGridText(j,1,'0');	
			 break;
			}
		}
	}
}

function OnProcess(n)
{ 

first_time=false;
clear_Interval();
	if(n==2)
	{  
	txtKey.text=  new Date().valueOf()  + "" +iduser_pk.text ;
	idGridProcess.ClearData();
	for(var i=1;i<= idGridTerEmp.rows-1;i++)
		{ if(idGridTerEmp.GetGridData(i,1)=='-1')
			if(idGridTerEmp.GetGridData(i,4)!="")
			{	idGridProcess.AddRow();
				idGridProcess.SetGridText (idGridProcess.rows-1,0,txtKey.text);
				idGridProcess.SetGridText(idGridProcess.rows-1,3,idGridTerEmp.GetGridData(i,4));
				idGridProcess.SetGridText(idGridProcess.rows-1,4,txtTerCode.text);
				idGridProcess.SetGridText(idGridProcess.rows-1,5,lstCompany.value);
				
			}
			else
			{ alert("User have ID Num  "+idGridTerEmp.GetGridData(i,4) +"  not register in HR system so you can Upload data");
				idGridProcess.ClearData();
				return;
			}
		
		}
		if(idGridProcess.rows==1)
		{ alert("Please select employee to upload to server");
			return;
		}
		else
		{
			
			if(confirm("Do you want to upload data to server "))
			{  txtProcess.text="3";
				datUpload.Call();
			}
		}
	
	}
	
	if(n==1)// delete user
	{
	   
	   var str="";
	   for(var i=1;i<= idGridTerEmp.rows-1;i++)
		{ 
		if(idGridTerEmp.GetGridData(i,1)=='-1')
			{
				
					str+=idGridTerEmp.GetGridData(i,4)+",";
				
			}
			
		}
		if(str=="")
			{
				alert("Please select user to delete ");
			}
			else
			{ 
			if(confirm("Do you want to delete delete user form terminal"))
			{	txtKey.text=  new Date().valueOf()  + "" +iduser_pk.text ;
				txtUserId.text=str;
				txtProcess.text="2";
				datDeleteUser.Call();	
			  }
			}
	}
	
	if(n==3)// download from server to terminal
	{
	   
	   var str="";
	   for(var i=1;i<= idGriServerdEmp.rows-1;i++)
		{ 
		if(idGriServerdEmp.GetGridData(i,1)=='-1')
			{
				
					str+=idGriServerdEmp.GetGridData(i,4)+",";
				
			}
			
		}
		if(str=="")
			{
				alert("Please select user down load user data to terminal ");
			}
			else
			{ if(confirm("Do you want to down load user data to terminal"))
				{	txtKey.text=  new Date().valueOf()  + "" +iduser_pk.text ;
					txtUserId.text=str;
					alert(txtUserId.text);
					txtProcess.text="1";
					datDownloadUser.Call();	
				}
			}
	}
}

function OnStop()
{ clear_Interval();
 tr2.style.display="none";
 tr1.style.display="";
 txtProcess.text="";
}

function onMyClose()
{ clear_Interval();
}
</script>
<body onunload="onMyClose()" >
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
                    <output bind="lstBranch" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datUpload" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_transfer_data_status" procedure="HR_GET_USER_DATA"  parameter="0,3,4,5">
                <input bind="idGridProcess" >
                   <input bind="txtKey" />
                </input>
                <output  bind="idGridProcess" />
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->
<gw:data id="datGetTer" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_pro_get_ter"  > 
                <input>
                    <input bind="lstBranch" />
					<input bind="lstGroup" />
                </input> 
                <output>
                    <output bind="txtResult" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->

<gw:data id="datGetServerUser" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_10070003_server_user" > 
                <input bind="idGriServerdEmp" >
                    <input bind="lstCompany" />
                    <input bind="lstBranch" />
					<input bind="lstGroup" />
                    <input bind="lstTer" />
					<input bind="chkTemp" />
					<input bind="txtTemp" />
                </input>
                <output  bind="idGriServerdEmp" />
            </dso> 
        </xml> 
</gw:data>


<gw:data id="datGetTerminalUser" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_10070003_ter_user" > 
                <input bind="idGridTerEmp" >
					<input bind="lstCompany" />
                    <input bind="txtTerCode" />
                    <input bind="txtKey" />
                    <input bind="chkTemp2" />
					<input bind="txtTemp2" />
                </input>
                <output  bind="idGridTerEmp" />
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datDeleteUser" onreceive="OnDataReceive(this)"  > 
        <xml> 
                    <dso  type="process" procedure="hr_pro_Delete_user" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="txtTerCode" />
                    <input bind="txtUserId" />
					<input bind="txtKey" />
                    
                </input> 
                <output>
                     <output bind="txtResult" />
                  </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datDownloadUser" onreceive="OnDataReceive(this)"  > 
        <xml> 
                    <dso  type="process" procedure="hr_pro_Dowload_user" > 
                <input>
                    <input bind="lstCompany" />
                    <input bind="txtTerCode" />
                    <input bind="txtUserId" />
					<input bind="txtKey" />
                    
                </input> 
                <output>
                     <output bind="txtResult" />
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
<!----------------------------------->


<table  border="1" width="100%" height="99%" >
<tr style="height:0%;">
<td  style="width:55%" ></td>
<td  style="width:45%" ></td>
</tr >
<tr id="tr1" style="height:50%;">
<td style="height:50%;"  >
<table  border="0" width="100%" style="height:100%;"   >
<tr  style="height:5%;" >
<td align="center" colspan=3 style="font-size:18pt;;color:red">Server Users</td>
</tr>
<tr  style="height:5%;" >
<td style="width:30%;" align="right" >Company</td>
<td colspan="2" style="width:65%"><gw:list  id="lstCompany"  maxlen = "100" value="<%=session("COMPANY_PK")%>" styles='width:100%' onchange="datGetBranch.Call()" >
                <data>
                    <%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0  AND ACTIVE_YN='Y'  ")%>
                </data>
            </gw:list></td>

</tr>

<tr style="height:5%;">
<td style="width:30%;" align="right">Branch</td>
<td colspan="2" >
<gw:list  id="lstBranch"  maxlen = "100"  styles='width:100%' onchange="datAccessGroup.Call();"  >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0217' ")%>|ALL|Branch- ALL
                </data>
            </gw:list>
</td>
<td style="width:5%"></td>
</tr>

<tr style="height:5%;">
<td style="width:30%;" align="right">Access group</td>
<td colspan="2" >
<gw:list  id="lstGroup"  maxlen = "100" value='ALL' styles='width:100%' onchange="datGetTer.Call();"   >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0216' ")%>|ALL|Access Group- ALL
                </data>
            </gw:list>
</td>
<td style="width:5%"></td>
</tr>


<tr style="height:5%;">
<td style="width:30%;" align="right">Terminal list</td>
<td colspan="2" >
<gw:list  id="lstTer"  maxlen = "100"  styles='width:100%'  >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0215' ")%>
                </data>
            </gw:list>
</td>
<td style="width:5%"></td>

</tr>



<tr style="height:5%;">
<td colspan="1" align="right" ><gw:list  id="chkTemp" value="2" styles="color:blue;width:100%" onchange=""> 
					            <data> LIST|1|Full Name|2|Emp ID|3|Card ID|4|Person ID</data> 
			            </gw:list></td>
<td colspan="1" style="width:5%" ><gw:textbox id="txtTemp" styles="color:blue;width:100%"  onenterkey ="OnSearch(1)"  /></td>
<td colspan="1" > <gw:imgBtn id="ibtnSearch"  alt="Search"  img="search" text="Search"  onclick="OnSearch(1)" /></td>
</tr>




<tr style="height:5%;">
<td style="width:5%" align="left"><gw:checkbox id="chkSelect" value="T" onclick="OnSelectAll(chkSelect,idGriServerdEmp)" >Select</gw:checkbox ></td>
<td style="width:65%;" align="right">
<table>
<tr>
<td>
<gw:icon id="btnCompare"   text="Compare" onclick="OnCompare()" />
</td>
<td>
<gw:icon id="btnDownLoad"   text="Download" onclick="OnProcess(3)" />
</td>
</tr>
</table


</td>

<td style="width:5%" align="right"><gw:label id='idRecord' text="" styles="width:100%; color: red;font-size:11pt;" /></td>
</tr>
<tr style="width:100%">
<td colspan="3"  >
					<gw:grid
					id="idGriServerdEmp"
					header="_pk|Check|Emp ID|Full name|ID Num|Finger Count|Access group|Status|_status"
					format="0|3|0|0|0|0|0|0|0"
					aligns="0|3|0|0|0|0|0|0|0"
					defaults="0|0|0|0|0|0|0|0|0"
					editcol="0|0|0|0|0|0|0|0|0|0"
					widths="0|1000|1000|1000|1000|1000|1000|1000|0"
					styles="width:100%;height:100%"
					sorting="T"
					acceptNullDate="T"
					oncelldblclick ="" />

</td>
</tr>

</table>
</td>
<td border="1">

<table  border="0" width="100%"  height="100%"   cellpadding="0" cellspacing="0" >
<tr  height="8%" >
<td align="center" colspan=7 style="font-size:18pt;;color:red">Terminal Users</td>
</tr>
<tr  height="8%" >
<td  style="width:20%; color: red" align="right" colspan=2>Terminal ID</td>
<td  style="width:20%" align="right"colspan=2 ><gw:textbox id="txtTerID"  styles='width:100%;color: red' /></td>

<td style="width:20%;color:red" align="right" ><gw:list  id="chkTemp2" value="2" styles="color:blue;width:100%" onchange=""> 
					            <data> LIST|1|Full Name|2|Emp ID|3|Card ID|4|Person ID</data> 
			            </gw:list> </td>
<td style="width:30%" align="right"><gw:textbox id="txtTemp2" styles="color:blue;width:100%"  onenterkey ="OnSearch(2)"  /></td>


<td style="width:10%" align="right"><gw:imgBtn id="ibtnSearch"  alt="Search"  img="search" text="Search"  onclick="OnSearch(2)" /></td>

</tr>

<tr  height="8%">
<td align="left" colspan=1 ><gw:checkbox id="chkSelect2" value="F" onclick="OnSelectAll(chkSelect2,idGridTerEmp)">Select</gw:checkbox ></td>
<td align="right" colspan=2 ><gw:label id='idRecord2' text="" styles="width:100%; color: red;font-size:11pt;" /> </td>
<td align="right" colspan=2  ><gw:icon id="btnDelete"   text="Delete" onclick="OnProcess(1)" /></td>
<td align="right" colspan=2  ><gw:icon id="btnUpload"   text="Upload to server" onclick="OnProcess(2)" /></td>
<td>
</tr>
<tr>
<td colspan=7>
<gw:grid
					id="idGridTerEmp"
					header="_pk|Check|Emp ID|Full name|ID Num|Finger Count|Status|_status"
					format="0|3|0|0|0|0|0|0"
					aligns="0|3|0|0|0|0|0|0"
					defaults="|||||||"
					editcol="0|1|0|0|0|0|0|0"
					widths="0|1000|1000|1000|1000|1000|1000|0"
					styles="width:100%;height:100%"
					sorting="T"
					acceptNullDate="T"
					oncelldblclick ="" />
</td>
</tr>


					

</table>

</td>

</tr>
<tr id="tr2" style="height:50%;display:none">
<td colspan="2">
<table  border="0" width="100%"  height="100%"   cellpadding="0" cellspacing="0" >
<tr  height="10%"  >
<td width="60%" align="center" style="font-size:18pt;;color:red">Terminal processing.....</td>
<td width="20%" align="center" style="font-size:18pt;;color:red"><gw:label id='idInterval' text="" styles="width:100%; color: blue;font-size:15pt;" />  </td>
<td width="20%" align="center" style="font-size:18pt;;color:red"><gw:icon id="btnStop"   text="Stop view Processing." onclick="OnStop()" /></td>
</tr>

<tr>
<td colspan=3>
<gw:grid
					id="idGridProcess"
					header="_key|Emp ID|Full name|ID Num|Status|_status"
					format="0|0|0|0|0|0"
					aligns="0|0|0|0|0|0"
					defaults="0|0|0|0|0|0"
					editcol="0|1|0|0|0|0|0|0"
					widths="0|1000|1000|1000|1000|1000|1000|0"
					styles="width:100%;height:100%"
					sorting="T"
					acceptNullDate="T"
					oncelldblclick ="" />

</td>
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
<gw:textbox id="txtTerCode" styles="display:none"/>
<gw:textbox id="txt_sal_security" styles="display:none"/>

<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtStatus_cmd" styles="display:none"/>
<gw:textbox id="txtKey" styles="display:none"/>
<gw:textbox id="txtUserId" styles="display:none"/>
<gw:textbox id="txtProcess" styles="display:none"/>
<gw:textbox id="txtcompany_pk" styles="display:none"/>


</body>
</html>
