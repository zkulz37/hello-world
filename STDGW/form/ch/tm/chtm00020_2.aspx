<!-- #include file="../../../system/lib/form.inc"  -->

 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{ 	
    
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
    txtCodeAdmin.text= "<%=session("HR_LEVEL")%>";
   
   if (txtCodeAdmin.text=="N")
    {	var ls_data        = "<%=ESysLib.SetListDataSQL("SELECT PK, PARTNER_NAME FROM TCO_COMPANY WHERE DEL_IF=0  AND ACTIVE_YN='Y' and pk='" + session("COMPANY_PK") + "' ")%>";
		lstCompany.SetDataText(ls_data);
		lstCompany.value=txtcompany_pk.text;
		 
		datGetBranch.Call("SELECT");
	}
	else
	{
	datGetBranch.Call("SELECT");
	//datGetTerminal.Call('SELECT');
	}
   
	
	}

function OnSelect()
{
    OnExit();
}
function OnExit()
{/*
    var obj= Array();
    var irow;
    irow=grdEmployee.row;
    if (irow>0) 
    {
        obj[0]=grdEmployee.GetGridData(irow,0); //pk
        obj[1]=grdEmployee.GetGridData(irow,3); //emp id
        obj[2]=grdEmployee.GetGridData(irow,5); //full name
        obj[3]=grdEmployee.GetGridData(irow,8); //join date
        obj[4]=grdEmployee.GetGridData(irow,1); //deparment
        obj[5]=grdEmployee.GetGridData(irow,9); //social no
        obj[6]=grdEmployee.GetGridData(irow,2); //group_nm
        obj[7]=grdEmployee.GetGridData(irow,10); //Tel
        obj[8]=grdEmployee.GetGridData(irow,11); //Name_VN
        obj[9]=grdEmployee.GetGridData(irow,12); //Dept_VN
        obj[10]=grdEmployee.GetGridData(irow,13); //Pos_E
        obj[11]=grdEmployee.GetGridData(irow,14); //Pos_VN
        obj[12]=grdEmployee.GetGridData(irow,15); //Pos_Code
        obj[13]=grdEmployee.GetGridData(irow,16); //Dept_pk
        obj[14]=grdEmployee.GetGridData(irow,17); //Group_pk
        obj[15]=grdEmployee.GetGridData(irow,18); //Manager_pk
        obj[16]=grdEmployee.GetGridData(irow,19); //Manager ID
        obj[17]=grdEmployee.GetGridData(irow,20); //Manager Name
        obj[18]=grdEmployee.GetGridData(irow,21); //Education
        obj[19]=grdEmployee.GetGridData(irow,22); //Married_YN
        obj[20]=grdEmployee.GetGridData(irow,23); //PerID
        obj[21]=grdEmployee.GetGridData(irow,24); //PerID
        obj[22]=grdEmployee.GetGridData(irow,25); //Manager kind
        obj[23]=grdEmployee.GetGridData(irow,26); //Manager kind name
        obj[29]=grdEmployee.GetGridData(irow,27); //Manager kind name
        obj[24]=grdEmployee.GetGridData(irow,28); //Company
        obj[25]=grdEmployee.GetGridData(irow,29); //Birthday
        obj[26]=grdEmployee.GetGridData(irow,30); //Sex Kind
        obj[27]=grdEmployee.GetGridData(irow,31); //Phone
        obj[28]=grdEmployee.GetGridData(irow,32); //FName
    }    
    else 
    {
        obj=null;
    }
	window.returnValue = obj; 
	window.close();*/
}
function EXITOnClick()
{
	OnExit();
}
function OnDataReceive(obj)
{
//alert("gfgffgdfg");
    if (obj.id=="datGetBranch")
    {
		
		datAccessGroup.Call();
    }
	 if (obj.id=="datAccessGroup")
    {
			datGetTerminal.Call('SELECT');
    }
	if (obj.id=="datGetTerminal")
    {
		for(var i=1;i<=idGridTer.rows-1;i++ )
			{ //alert(idGridTer.GetGridData(i,6));
				if(idGridTer.GetGridData(i,7)=="")
					{	idGridTer.SetCellBgColor(i, 0, i, idGridTer.cols-1, 0x00ff00 );
					}
				else
					{idGridTer.SetCellBgColor(i, 0, i, idGridTer.cols-1, 0x0000ff );
					}
			}
		
	
		auto_resize_column(idGridTer,0,idGridTer.cols-1,0);    
			
			
    }
	
	
 

 
}

function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}



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
         {               obj_grd.SetGridText(ctrl.SelectedRow(i),1,temp);
         }
		 else
		 {
		 for(var i=1;i<=obj_grd.rows-1;i++)
         {               obj_grd.SetGridText(i,1,temp);
         }
		 }
}
 function onConfirm()
 { 
 var obj= Array();
 obj[0]=lstBranch.value;
 var temp='';
	for(var i=1;i<= idGridTer.rows-1;i++)
	{ if(idGridTer.GetGridData(i,1)=='-1')
		temp+=idGridTer.GetGridData(i,0)+",";
	}
	
	if(temp=="")
	{alert("Please select terminal to send data");
	return;
	}
	if(confirm("Do you want to save and exit this popup"))
	{	obj[1]=temp;
		window.returnValue = obj; 
		window.close();
	}
 }
 function OnExit()
 {
 //window.returnValue = obj; 
	window.close();
 }
</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->
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
<!----------------------------------->
<gw:data id="datGetTerminal" onreceive="OnDataReceive(this)"> 
        <xml> 
            <dso  type="grid"   function="HR_SEL_Terminal_status_popup" > 
                <input bind="idGridTer" >
                    <input bind="lstCompany" />
                    <input bind="lstBranch" />
					<input bind="lstGroup" />
                    
                </input>
                <output  bind="idGridTer" />
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

<!-------------------data control----------------------->

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
<gw:list  id="lstBranch"  maxlen = "100"  styles='width:100%'  onchange="datAccessGroup.Call()" >
                <data>
                    <%=ESysLib.SetListDataSQL("select code,code_nm  from vhr_hr_code  a where a.id='HR0217' ")%>|ALL|Branch-ALL
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
<td style="width:5%" align="left"><gw:checkbox id="chkAuto" value="F" onclick="OnSelectAll(chkAuto,idGridTer)" >Select</gw:checkbox ></td>
<td style="width:65%;" align="left"><gw:icon id="btnEnroll"   text="Comfirm" onclick="onConfirm()" /></td>

<td style="width:5%" align="right"><gw:icon id="btnEnroll"   text="Cancle" onclick="OnExit()" /></td>
</tr>
<tr style="width:100%">
<td colspan="3"  >
					<gw:grid
					id="idGridTer"
					header="_Code|Select|Terminal Name|Terminal ID|Terminal IP|Terminal Verson|Users|Last time online|_maxPk"
					format="0|3|0|0|0|0|-1|0|0"
					aligns="0|0|0|0|0|0|0|0|0"
					defaults="0|0|0|0|0|0|0|0|0"
					editcol="0|0|0|0|0|0|0|0|0"
					widths="1000|1000|1000|1000|1000|1000|1000|1000|0"
					styles="width:100%;height:100%"
					sorting="T"
					acceptNullDate="T"
					oncelldblclick = ""			/>

</td>
</tr>

</table>
	

<gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtCodeAdmin" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
	<gw:textbox id="txtcompany_pk" styles="display:none"/>
	<gw:textbox id="txtResult" styles="display:none"/>
	
</body>
</html>

				
