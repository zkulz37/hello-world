<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser("prod")%>
<head id="Head1" runat="server">
    <title>Employee List</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{ 	
    grdEmployee.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
     
}
//------------------------------------------------------------------------------------	
function OnSearch()
{
    shab00020_3.Call("SELECT");
}
//------------------------------------------------------------------------------------	
function OnSelect()
{
    
    var code_data = new Array();       
    
    if ( grdEmployee.row > 0 )
    {
        for( j=0 ; j<grdEmployee.cols ; j++ )
        {
            code_data[j] = grdEmployee.GetGridData(grdEmployee.row , j );
        } 
    }
    else
    {
        for( j=0 ; j<grdEmployee.cols ; j++ )
        {
            code_data[j] = '';
        } 	    
    }
    //----------------------------
    window.returnValue = code_data; 
    this.close(); 	
}
//------------------------------------------------------------------------------------	
function EXITOnClick()
{
	OnSelect();
}
//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
}     
function OnChangeDept()
{
    shab00020_2.Call();
}
</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!------------------------------------------------------->
<gw:data id="shab00020_1" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="prod.sp_sel_shab00020_1"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------->
<gw:data id="shab00020_2" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="prod.sp_pro_shab00020_2" > 
                <input>
                    <input bind="lstOrg" /> 
                </input> 
                <output>
                    <output bind="lstWG" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------------->
<gw:data id="shab00020_3"> 
    <xml> 
        <dso  type="grid" function="prod.sp_sel_shab00020_3"> 
            <input> 
                <input bind="lstOrg" /> 
                <input bind="lstWG" /> 
                <input bind="chkTemp" /> 
                <input bind="txtTemp" /> 
				<input bind="lstNation" /> 
            </input> 
            <output bind="grdEmployee" /> 
        </dso> 
   </xml> 
</gw:data> 
<!------------------------------------------------------->
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
						        <td colspan="7" align="right"><font color="black"><b >Organization &nbsp;</b></td>
						        <td colspan="15"><gw:list id="lstOrg" styles="color:black;width:100%" value="ALL" onchange="OnChangeDept()"> 
									   <data>
											<%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type='06' order by a.seq")%>|ALL|Select All
										</data>
								   </gw:list > 
						        </td>
						        <td colspan="7" align="right"><font color="black"><b>Work-Group &nbsp;</b>
						        </td>
						        <td colspan="15" > <gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                                             <data><%=Esyslib.SetListDataSQL("SELECT pk,workgroup_NM FROM hr.Thr_work_Group WHERE DEL_IF = 0 order by workgroup_id" )%>|ALL|Select All</data></gw:list>
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
						        <td colspan="7" align="right"><font color="black"><b >Nation &nbsp;</b></td>
						        <td colspan="10"><gw:list id="lstNation" styles="color:black;width:100%" value="01" onchange=""> 
									   <data>
											<%=ESysLib.SetListDataSQL("select code,CODE_NM from hr.vhr_hr_code where id='HR0009' order by code_nm")%>|ALL|Select All ...
										</data>
								   </gw:list > 
						        </td>
								<td colspan="5"></td>
						        <td colspan="7" align="right"><font color="black"><b>Search by &nbsp;</b>
						        </td>
						        <td colspan="5">
							        <gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Per ID</data> 
							        </gw:list>
						        </td>
        						
						        <td colspan="10"> 
							        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
						        <td colspan="" ></td>
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
  		    <gw:grid id='grdEmployee'
                header='_pk|Org NM|Team|Emp ID|ID Num|Full Name|Old ID|Person ID|Join DT|Social No|Tel|Present Addr|Manager Kind|Email'
                format='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                aligns='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                defaults='|||||||||||||'
                editcol='0|0|0|0|0|0|0|0|0|0|0|0|0|0'
                widths='0|1400|1400|1000|1000|1600|1000|1000|1200|1000|1000|1200|1000|1000'
                sorting='T'
                styles='width:100%; height:100%'
			    oncelldblclick ="OnSelect()" /> 
    	
  	    </td>
    </tr>
</table>
<gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtDeptData" styles="display:none"/>
    <gw:textbox id="txtUpperDept" styles="display:none"/>
    <gw:textbox id="txtGroupData" styles="display:none"/>
</body>
</html>

				
