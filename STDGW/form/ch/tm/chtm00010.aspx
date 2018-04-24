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
var MenuTitle="10070001 Real time Monitoring";

function tabUnActive(npos, menu_id, menu_cd, title, ltitle, ftitle){
                              //alert('hide' + menu_id);
							  stop_interval.text='1';
               }
function tabActive(npos, menu_id, menu_cd, title, ltitle, ftitle){
                            //  alert('Show' + menu_id);
							  stop_interval.text='0';
               }
	

	
function BodyInit()
{
    txtcompany_pk.text="<%=Session("COMPANY_PK")%>";
    
    if (v_language!="ENG")
        System.Translate(document);
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text=  "<%=session("HR_LEVEL")%>";
   
txtCodeAdmin.text="<%=session("CODEADMIN_YN")%>";
   
   if (txtCodeAdmin.text=="N"||( (Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")))
    {	var ls_data        = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0  AND ACTIVE_YN='Y' and pk='" + session("COMPANY_PK") + "' ")%>";
		lstCompany.SetDataText(ls_data);
		lstCompany.value=txtcompany_pk.text;
		 innit=true;
		datGetBranch.Call("SELECT");
	}
	else
	{
	set_Interval(time_deplay); 
	//datGetTerminal.Call('SELECT');
	datGetBranch.Call("SELECT");
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
		//lstBranch.SetDataText("");
		
		datAccessGroup.Call();
    }
	if (obj.id=="datAccessGroup")
	{ //alert(txtResult.text);
		//lstGroup.SetDataText(txtResult.text);
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
		
		if(idGridRT2.rows>1 )
			{txtmax_pk.text=idGridRT2.GetGridData(1,8)+"";
			}
		
		for(var i=1;i<=idGridTer.rows-1;i++ )
			{ //alert(idGridTer.GetGridData(i,6));
				if(idGridTer.GetGridData(i,6)=="")
					{	idGridTer.SetCellBgColor(i, 0, i, idGridTer.cols-1, 0x00ff00 );
					}
				else
					{idGridTer.SetCellBgColor(i, 0, i, idGridTer.cols-1, 0x0000ff );
					}
			}
		if(first_time==false)
		{txtmax_pk.text=idGridTer.GetGridData(1,7)+"";
		first_time=true;
		}
		/*else
		if(idGridRT2.rows>1)
		{txtmax_pk.text=idGridTer.GetGridData(1,8)+"";
		}*/
		
		
		
		auto_resize_column(idGridTer,0,idGridTer.cols-1,0);    
			if(idGridRT2.rows>1)
		idGridRT.SetCellBold(1,0,idGridRT2.rows-1,idGridRT.cols-1,false);
			if(stop_interval.text=="0")
			datRealTimedata.Call("SELECT");
			
    }
	if (obj.id=="datRealTimedata")
	{
	//startTime = new Date().valueOf();
	/*if(idGridRT.rows>1)
			txtmax_pk.text=idGridRT.GetGridData(1,8)+"";*/
			if(idGridRT2.rows>1)
			{for(var i=1;i<=idGridRT2.rows-1;i++)
			{ 
			if(idGridRT.rows==1)
				idGridRT.AddRow();
			else
			idGridRT.AddRowAt(1);
			idGridRT.SetCellBold(1,0,1,idGridRT.cols-1,true);
			if(idGridRT2.GetGridData(i,0)+""=="-1")
			idGridRT.SetCellFontColor(1, 0, 1, idGridRT.cols-1, 0x0000ff );
			
				for(var j=0;j<idGridRT2.cols;j++)
					{idGridRT.SetGridText(1,j,idGridRT2.GetGridData(i,j));		// department
					}
			}
			auto_resize_column(idGridRT,0,idGridRT.cols-1,0);    
			txtmax_pk.text=idGridRT2.GetGridData(1,8)+"";
			}
			if(idGridRT.rows>1000)
			{
			for(var i=1000;i<=idGridRT.rows-1;i++)
				idGridRT.RemoveRowAt(i);
			
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
 
 interval_time=setInterval("clock(" + startTime + "," + x  + ")",x);
}
function clock(start,x) 
{

if(stop_interval.text=="1")
	{
	//clear_Interval();
	
	return;
	
	}

 var d = new Date()
 //idInterval.text= Math.round((d.valueOf()-start)/x);
	if(Math.round((d.valueOf()-start))>x)
	{
	//alert("dfgdfg");
	//if(chkAuto.value=='T')
		{
		startTime=new Date().valueOf();
		//alert("sdfdsf");
		/*if(idGridTer2.rows>1)
			txtmax_pk.text=idGridTer2.GetGridData(1,7)+"";*/
			//alert(txtmax_pk.text);
		datGetTerminal.Call('SELECT');
		
		}
	/*else
		{clear_Interval();}	*/
	
	}
	
}
function clear_Interval()
{
	clearInterval(interval_time);
	
}

function ClearGrid()
{
  idGridRT.ClearData();
  idGridRT2.ClearData();
}
function AutoLoad()
{//startTime = new Date().valueOf();
//alert("sdfsdafd" +startTime);
 if(chkAuto.value=='T')
 {//clear_Interval();
 
 clear_Interval();
 idGridRT2.ClearData();
 //first_time=false;
 set_Interval(time_deplay); 
 //first_time=false;
 }
 else
 {clear_Interval();
 }
}
//------------------------------------------------

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
                    <output bind="lstBranch" />
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
<gw:data id="datGetTerminal" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_Terminal_status" > 
                <input bind="idGridTer" >
                    <input bind="lstCompany" />
                    <input bind="lstBranch" />
					<input bind="lstGroup" />
                    
                </input>
                <output  bind="idGridTer" />
            </dso> 
        </xml> 
</gw:data>


<!----------------------------------->
<gw:data id="datRealTimedata" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_Realtime_data" > 
                <input bind="idGridRT2" >
                    <input bind="lstCompany" />
                    <input bind="lstBranch" />
					<input bind="lstGroup" />
					<input bind="txtmax_pk" />
                    
                </input>
                <output  bind="idGridRT2" />
            </dso> 
        </xml> 
</gw:data>

<table  border="1" width="100%" height="99%" >
<tr style="height:0%;">
<td  style="width:35%" ></td>
<td  style="width:65%" ></td>
</tr >
<tr style="height:100%;">
<td style="height:100%;"  >
<table  border="0" width="100%" style="height:100%;"   >
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
<gw:list  id="lstBranch"  maxlen = "100" value='ALL' styles='width:100%' onchange="datAccessGroup.Call()" >
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
<gw:list  id="lstGroup"  maxlen = "100" value='ALL' styles='width:100%' onchange="datGetTerminal.Call('SELECT')"   >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0216' ")%>|ALL|Access Group- ALL
                </data>
            </gw:list>
</td>
<td style="width:5%"></td>
</tr>
<tr style="height:5%;">
<td style="width:5%" align="right"></td>
<td style="width:65%;" align="right">Auto load</td>

<td style="width:5%" align="right"><gw:checkbox id="chkAuto" value="T" onclick="AutoLoad()" ></gw:checkbox ></td>
</tr>
<tr style="width:100%">
<td colspan="3"  >
					<gw:grid
					id="idGridTer"
					header="Code|Code Name|ID|Terminal IP|Terminal Verson|Users|Last time online|_maxPk"
					format="0|0|0|0|0|-1|0|0"
					aligns="0|0|0|0|0|0|0|0"
					defaults="0|0|0|0|0|0|0|0"
					editcol="0|0|0|0|0|0|0|0"
					widths="1000|1000|1000|1000|1000|1000|1000|0"
					styles="width:100%;height:100%"
					sorting="T"
					acceptNullDate="T"
					oncelldblclick = ""			/>

</td>
</tr>

</table>
</td>
<td>
<table  border="0" width="100%"  height="100%"   >
<tr>
<td style="width:100%" align="right">
<gw:icon id="idBtnClear"  styles='width:10%' img="in"  text="Clear"  onclick="ClearGrid()"/></td>

</tr>

<tr style="width:100%;height:98%">
<td >
				<gw:grid
					id="idGridRT"
					header="User ID|User Name|Employee ID|Organization|Terminal ID|Event|Date|Time|_maxPk "
					format="0|0|0|0|0|0|4|0|0 "
					aligns="0|0|0|0|0|0|0|0|0 "
					defaults="0|0|0|0|0|0|0|0|0 "
					editcol="0|0|0|0|0|0|0|0|0 "
					widths="1000|1000|1000|1000|1000|1000|1000|1000|1000 "
					styles="width:100%;height:100%"
					sorting="F"
					acceptNullDate="T"
					oncelldblclick = ""
			/>

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
<gw:textbox id="txt_sal_security" styles="display:none"/>

<gw:textbox id="txtResult" styles="display:none"/>
<gw:textbox id="txtmax_pk" styles="display:none"/>
<gw:textbox id="txtold_max_pk" styles="display:none"/>
<gw:textbox id="txtcompany_pk" styles="display:none"/>
<gw:textbox id="stop_interval" text ="0" styles="display:none" />

<gw:grid
					id="idGridRT2"
					header="User ID|User Name|Employee ID|Organization|Terminal ID|Event|Date|Time|maxPk "
					format="0|0|0|0|0|0|0|0|0 "
					aligns="0|0|0|0|0|0|0|0|0 "
					defaults="0|0|0|0|0|0|0|0|0 "
					editcol="0|0|0|0|0|0|0|0|0 "
					widths="1000|1000|1000|1000|1000|1000|1000|1000|1000 "
					styles="width:100%;height:100%;display:none"
					sorting="T"
					acceptNullDate="T"
					oncelldblclick = ""
			/>
</body>
</html>
