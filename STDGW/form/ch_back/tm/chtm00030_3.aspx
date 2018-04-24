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
		/*	lstTer.SetDataText(txtResult.text+"|ALL|Select ALL");
			lstTer.value='ALL';*/
			
    }
	
	if (obj.id=="datRealTimedata")
    {
			for(var i=1;i<=idGridRT.rows-1;i++)
			{ 
			if(idGridRT.GetGridData(i,0)+""=="-1")
			idGridRT.SetCellFontColor(i, 0, i, idGridRT.cols-1, 0x0000ff );
			}
			auto_resize_column(idGridRT,0,idGridRT.cols-1,0);    
    }
	

 
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}




function OnSearch()
{
datRealTimedata.Call("SELECT");
}
//------------------------------------------------

</script>
<body  >
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
<gw:data id="datGetTer" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_pro_get_ter"  > 
                <input>
                    <input bind="lstBranch" />
					<input bind="lstGroup" />
                </input> 
                <output>
                    <output bind="lstTer" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->

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
<!----------------------------------->
<gw:data id="datRealTimedata" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_Accesslog_data" > 
                <input bind="idGridRT" >
                    <input bind="lstCompany" />
                    <input bind="lstBranch" />
					<input bind="lstGroup" />
					<input bind="lstTer" />
					<input bind="dtFrom" />
					<input bind="dtTo" />
					<input bind="chkTemp" />
					<input bind="txtTemp" />
					
                    
                </input>
                <output  bind="idGridRT" />
            </dso> 
        </xml> 
</gw:data>


<table  border="0" width="100%" height="100%" cellpadding="0" cellspacing="0" >

<tr    style="border:0;height:5%" >
<td  style="width:10%;" align="right" >Company</td>
<td colspan="4" style="width:40%"><gw:list  id="lstCompany"  maxlen = "100" value="<%=session("COMPANY_PK")%>" styles='width:100%' onchange="datGetBranch.Call()" >
                <data>
                    <%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0  AND ACTIVE_YN='Y'  ")%>
                </data>
            </gw:list></td>
<td style="width:10%;" align="right">Branch</td>
<td colspan="4" style="width:40%;">
<gw:list  id="lstBranch"  maxlen = "100"  styles='width:100%' onchange="datAccessGroup.Call();"  >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0217' ")%>|ALL|Branch- ALL
                </data>
            </gw:list>
</td>			

</tr>

<tr    style="border:0;height:5%"  >
<td align="right">Access group</td>
<td colspan="4" >
<gw:list  id="lstGroup"  maxlen = "100" value='ALL' styles='width:100%' onchange="datGetTer.Call();"   >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0216' ")%>|ALL|Access Group- ALL
                </data>
            </gw:list>
</td>
<td align="right">Terminal list</td>
<td colspan="4" >
<gw:list  id="lstTer"  maxlen = "100"  styles='width:100%'  >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0215' ")%>
                </data>
            </gw:list>
</td>

</tr>





<tr style="height:5%;">
<td  style="border:0" align="right">Work DT</td>
				    <td colspan=1 style="border:0" ><gw:datebox id="dtFrom"  styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				    <td >~</td>
				    <td   ><gw:datebox id="dtTo"  styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				    
<td colspan="3" align="right" ><gw:list  id="chkTemp" value="2" styles="color:blue;width:100%" onchange=""> 
					            <data> LIST|1|Full Name|2|Emp ID|3|Card ID|4|Person ID</data> 
			            </gw:list></td>
<td colspan="2"  style="width:20%" ><gw:textbox id="txtTemp" styles="color:blue;width:100%"  onenterkey ="OnSearch()"  /></td>
<td  colspan="1"  style="width:10%" align="right"> <gw:imgBtn id="ibtnSearch"  alt="Search"  img="search" text="Search"  onclick="OnSearch()" /></td>
</tr>

<tr >
<td colspan="10">
				<gw:grid
					id="idGridRT"
					header="User ID|User Name|Employee ID|Organization|Terminal ID|Event|Date|Time "
					format="0|0|0|0|0|0|4|0 "
					aligns="0|0|0|0|0|0|0|0 "
					defaults="0|0|0|0|0|0|0|0 "
					editcol="0|0|0|0|0|0|0|0 "
					widths="1000|1000|1000|1000|1000|1000|1000|1000"
					styles="width:100%;height:100%"
					sorting="T"
					acceptNullDate="T"
					oncelldblclick = ""
			/>

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
<gw:textbox id="txtTerID" styles="display:none"/>


</body>
</html>
