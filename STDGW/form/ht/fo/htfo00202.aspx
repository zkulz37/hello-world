<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml">
<%  ESysLib.SetUser("crm")%>
<head>
    <title>Get Staff</title>
    <script type="text/javascript" language="javascript">
//-------------------------------------------------
    function BodyInit()
    {
        OnSearch();
    }
 //------------------------------------------------

    function OnSearch()
    {
        data_htfo00202.Call("SELECT")    
    }
    //-------------------------------------------------

    function RowDbClick()
    {
        var code_data=new Array()
	    var ctrl = grdEmployee.GetGridControl();
	    var index, rowNo
	    index =0;
	    rowNo = 0
	    if(ctrl.SelectedRows == 0)
        {
               return ;
        }
        else
	    {
	         for(i=0;i<ctrl.SelectedRows;i++)
			    {	  
		            rowNo = ctrl.SelectedRow(i)
		            for(j=0;j< grdEmployee.cols -1; j++)
		            {
	                    code_data[index] = grdEmployee.GetGridData(rowNo , j );
	                    index ++;
                    } 
                    
			    }
	    }
	    window.returnValue = code_data; 
	    this.close(); 	
    }
    //-------------------------------------------------

</script>
</head>
<body>
    <!----------------------------------------------------->
    <gw:data id="data_htfo00202"  onreceive=""> 
        <xml> 
            <dso  type="grid" function="crm.sp_sel_htfo00200_pop_staff" > 
                <input bind="grdEmployee" >
                    <input bind="lstOrg_Code" />
                    <input bind="chkTemp" />
                    <input bind="txtTemp" />
					<input bind="lstNation" />
                </input>
                <output  bind="grdEmployee" />
            </dso> 
        </xml> 
    </gw:data>
    <!-- --------------------------------------------------  -->
    <table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
		    <tr style="border:0;height:5%">
		        <td width="13%" style="border:0"  align="right" valign="middle">Department&nbsp;</td>
			    <td width="30%" style="border:0">
				    <gw:list  id="lstOrg_Code" value="ALL" styles='width:100%' onchange="OnSearch()"> 
				    <data><%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from comm.tco_org a where a.del_if=0 and a.org_type='06' order by a.seq")%>|ALL|Select All</data></gw:list>
			    </td>
			    <td align="center" width="13%">Nation</td>
			    <td align="left" width="35%">
				    <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%'  onchange="OnSearch()">
						<data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
				</td>
			    <td width="4%">&nbsp;</td>
		    </tr>
			<tr  style="border:0;height:5%" >
				<td style="border:0" align="right">Search by&nbsp;</td>
				<td >
				    <gw:list  id="chkTemp" value="2" styles="color:blue;width:100%"> 
				        <data> LIST|1|Full Name|2|Emp ID|3|Card ID|4|Person ID</data> 
		            </gw:list>
				</td>
				<td colspan="2">&nbsp;<gw:textbox id="txtTemp" styles="color:blue;width:98%"  onenterkey ="OnSearch()"  /></td>
				<td><gw:imgBtn id="ibtnSearch"  alt="Search"  img="search" text="Search"  onclick="OnSearch()" /></td>
			</tr>
	        <tr  style="border:0;height:85%">
	            <td colspan="5">
                    <gw:grid   
                    id="grdEmployee"  
                    header="_PK|Full Name|Emp ID|Join DT|PERSON ID"
                    format="0|0|0|4|0"  
                    aligns="0|0|1|1|1"
                    defaults="||||"  
                    editcol="0|0|0|0|0"  
                    widths="0|3500|1000|1500|1000"  
                    styles="width:100%; height:100%"   
                    sorting="T"
                    param="0,1,2,3,4"   
                    oncelldblclick="RowDbClick()" />
	            </td>
	        </tr>
    </table>
</body>
</html>
