<!-- #include file="../../../system/lib/form.inc"  -->
<% ESysLib.SetUser(Session("APP_DBUSER"))%>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";

function BodyInit()
{ 	
    grdEmployee.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";   
	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}

}
function OnSearch()
{
    datEmployeePopup.Call("SELECT");
}
function OnSelect()
{
    OnExit();
}
function OnExit()
{
    var obj= Array();
    var irow;
    irow=grdEmployee.row;
    if (irow>0) 
    {
    
        obj[0]=grdEmployee.GetGridData(irow,0); //pk
        obj[1]=grdEmployee.GetGridData(irow,1); //org
        obj[2]=grdEmployee.GetGridData(irow,2); //wg
        obj[3]=grdEmployee.GetGridData(irow,3); //emp id
        obj[4]=grdEmployee.GetGridData(irow,4); //full name
        obj[5]=grdEmployee.GetGridData(irow,5); //personal id
        obj[6]=grdEmployee.GetGridData(irow,6); //join dt
        obj[7]=grdEmployee.GetGridData(irow,7); //social old
        obj[8]=grdEmployee.GetGridData(irow,8); //social
        obj[9]=grdEmployee.GetGridData(irow,9); //health
        obj[10]=grdEmployee.GetGridData(irow,10); //birth day
        obj[11]=grdEmployee.GetGridData(irow,11); //sex
        obj[12]=grdEmployee.GetGridData(irow,12); //telephone
        obj[13]=grdEmployee.GetGridData(irow,13); //sysdate

        
    }    
    else 
    {
        obj=null;
    }
	window.returnValue = obj; 
	window.close();
}
function EXITOnClick()
{
	OnExit();
}
//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
       if(obj.id == "datEmployeePopup")
       {
            lblRecord.text = grdEmployee.rows-1+" Record(s)";
       }
       
	   
}     
function OnChangeDept()
{
    //txtDept.text=lstOrg.value;
    
}
function OnShowPopup()
{
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:200;dialogTop:200;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
             lstOrg.value=obj;
             
        }
}
</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmployeePopup"  onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid" function="HR_SEL_10040009_POP"> 
            <input> 
                <input bind="lstOrg" /> 
                <input bind="lstWG" /> 
                <input bind="chkTemp" /> 
                <input bind="txtTemp" />  
				<input bind="dtWorkMon" /> 				
                <input bind="lstStatus" /> 				
            </input> 
            <output bind="grdEmployee" /> 
        </dso> 
   </xml> 
</gw:data> 
<table style='margin-left:10px' align = top class="itable" cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
	<tr> 
	    <td  align = top >
		    <table align = top  width="100%" style="height:7%">
		        <tr>
			        <td align="Left">
				        <table   border="0" CELLSPACING="0" CELLPADDING="0" style="height:inherit" >
							<tr width="100%">
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
								<td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td><td width="2%"></td>
							</tr>
					        <tr>   
						        <td colspan="7" align="right"><font color="black"><b ><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Organization</a></b></td>
						        <td colspan="15"><gw:list id="lstOrg" styles="color:black;width:100%" value="ALL" onchange=""> 
									   <data>
											<%= ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a where a.del_if=0 and a.org_type='06' order by a.seq")%>|ALL|Select All
										</data>
								   </gw:list > 
						        </td>
						        <td colspan="7" align="right"><font color="black"><b>Work-Group </b>
						        </td>
						        <td colspan="15" > <gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                                             <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
                                             </td>
						        <td colspan= "" ></td>
						        <td colspan="2" align="left">
							        <gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" />
						        </td>
						        <td colspan="2" ></td>
						        <td colspan="2" align="right">
							       <gw:imgBtn id="ibtnExit" alt="Exit" img="Cancel" text="Exit" onclick="OnExit()" />
						        </td>
					        </tr>
							<tr>   
						        <td colspan="7" align="right"><font color="black"><b >Ins Month </b></td>
						        <td colspan="5">
								   <gw:datebox id="dtWorkMon" lang="<%=Session("Lang")%>"   type=month nullaccept ></gw:datebox>
						        </td>
								<td colspan="3" align="right">Status</td>
                                <td colspan="7">
                                    <gw:list  id="lstStatus"  value="A" styles='width:100%' >
                                        <data>|A|Active|R|Resign|ALL|Select All</data>
                                    </gw:list>
                                </td>
						        <td colspan="7" align="right"><font color="black"><b>Search by </b>
						        </td>
						        <td colspan="5">
							        <gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data> 
							        </gw:list>
						        </td>
        						
						        <td colspan="7"> 
							        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
						        <td colspan="6" align="center" >
                                    <gw:label id="lblRecord" text="0 Records" styles="color:red;width:100%;font-weight: bold;font-size:12" ></gw:label>
                                </td>
					        </tr>
					        <tr>   
						        <td colspan="50" align="left" valign="middle"><font color="black"><b style="color=#FF00CC; font-size:14">Double click on row to select</b></td>
					        </tr>
				        </table>
			        </td>
		        </tr>
		    </table>
	    </td> 
	</tr>		   
	<tr align = top> 
	    <td align = top style="width:100%;height:93%" >
  		    <gw:grid   
			    id="grdEmployee"  
			    header="_PK|Organization|Work Group|Emp ID|Full Name|Personal ID|Join Date|Social No Old|Social No|Health No|Birthday|Sex|Telephone|_SYSDATE|"   
			    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    aligns="0|0|0|1|1|0|1|1|1|1|1|0|0|0"  
			    defaults="|||||||||||||"  
			    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    widths="0|2000|1500|1500|1000|2500|1500|1500|2000|1500|1500|1500|1500|0"  
			    styles="width:100%; height:100%"   
			    sorting="T"   
			    autosize="true"
			    oncelldblclick ="OnSelect()" /> 
    	
  	    </td>
    </tr>
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtWorkMon" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
</body>
</html>

				
