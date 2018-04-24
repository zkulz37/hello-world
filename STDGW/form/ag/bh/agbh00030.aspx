﻿<!-- #include file="../../../system/lib/form.inc"  -->
<html xmlns="http://www.w3.org/1999/xhtml" >
<%  ESysLib.SetUser("hr")%>
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{   
   System.Translate(document); 
    if (v_language!="ENG")
        System.Translate(document);
        iduser_pk.text = "<%=session("USER_PK")%>";
        txtHr_level.text= "<%=session("HR_LEVEL")%>";
        //<%=ESysLib.SetGridColumnComboFormat( "grdListGroup" , 1 , "select pk, dept_nm from tco_dept a where a.dept_type='06' and del_if=0 order by dept_id") %>;        
		lstDept.value="ALL";
		if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
                datUser_info.Call(); 
        else        
            <%=ESysLib.SetGridColumnComboFormat( "grdListGroup" , 1 , "select pk, dept_nm from comm.tco_dept a where nvl(a.child_yn,'Y')='N' and del_if=0 order by dept_id") %>;            	    
    } 
    function OnShowPopup()
    {
        var fpath = System.RootURL + "/form/ch/ae/chae00010_dept.aspx?";      
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:250;dialogTop:270;edge:sunken;scroll:no;unadorned:yes;help:no');
        if (obj!=null)
        {
            txtDept.text=obj;
            datDeptData.Call();            
        }
    }
    function SearchOnClick()
    {      
        datListGroup.Call("SELECT");  
    }
    function UpdateOnClick()
    {
        if(confirm("Do you want to save?\nBạn đã chắc chắn save?"))
        {
            for(var i=1;i<grdListGroup.rows;i++)
            {
                if(grdListGroup.GetGridData(i,0)=="")
                   grdListGroup.SetRowStatus(i,48); 
            }
            datListGroup.Call();
        }   
    }
    function OnDataReceive(obj)
    {
       if (obj.id=="datDeptData")
       {
            if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            lstDept.SetDataText(txtDeptData.text);
            
            txtDept.text=lstDept.value;
            dat_dept_grid2.Call();
            
       }
       else if(obj.id=="datUser_info")
       {
            dat_dept_grid.Call();
       }
       else if(obj.id=="dat_dept_grid")
       {
            var t=txtDept_tmp.text;
            var s="";
            t=t.substring(5,t.length);
            var arr=t.split("|");
            var i=0;
            while(i<arr.length)
            {
                s+="#"+arr[i]+";"+arr[i+1]+"|";
                i+=2;
            }
            
            s=s.substring(0,s.length-1);
            grdListGroup.SetComboFormat(1,s);
           
       }
       else if(obj.id=="dat_dept_grid2")
       {
            var t=txtDept_tmp.text;
            var s="";
            t=t.substring(5,t.length);
            var arr=t.split("|");
            var i=0;
            while(i<arr.length)
            {
                s+="#"+arr[i]+";"+arr[i+1]+"|";
                i+=2;
            }
            s=s.substring(0,s.length-1);
            grdListGroup.SetComboFormat(1,s);
            datListGroup.Call("SELECT"); 
           
       }
      
    }
    function AddOnClick()
    {
        var ctrl=grdListGroup.GetGridControl();
        grdListGroup.AddRow();
		grdListGroup.SetGridText(grdListGroup.rows-1,7,'-1');
		ctrl.TopRow = ctrl.rows;
		//var t="1;2|3;4";
		//grdListGroup.SetComboFormat(1,t);
    }
    function DelOnClick()
    {
        if (confirm("Do you want to delete this group?"))
        {
            grdListGroup.DeleteRow();
        }        
    }
    function UnDelOnClick()
    {
        grdListGroup.UnDeleteRow();
    }
    function OnDataError(oData)
    {
      //alert(eval(oData).errmsg);
        if (eval(oData).errno == 20001)
        {
		        alert("Database problem 1: "+ eval(oData).errmsg);
        }
        else if (eval(oData).errno == 20002)
        {
		    alert("Database problem 2: "+ eval(oData).errmsg);
        }
	    else if (eval(oData).errno > 0)
	    {
		    alert("Unexpected error: "+ eval(oData).errmsg);
	    }    	
    }
    function OnChange_Dept()
    {
        txtDept.text=lstDept.value;
        dat_dept_grid2.Call();
    }
	function PrintOnClick()
    {
        var url="/reports/ag/bh/rpt_group_entry.aspx?dept_pk="+lstDept.value;
        //alert("tai day");
        window.open(System.RootURL+url);
    }
</script>
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr.sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstDept" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:data id="dat_dept_grid" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR.sp_sel_dept_grid"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtDept_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="dat_dept_grid2" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR.sp_sel_dept_grid2"  > 
                <input>
                    <input bind="txtDept" />
                </input> 
                <output>
                    <output bind="txtDept_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datDeptData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="comm.sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtDept" /> 
                </input> 
                <output>
                    <output bind="txtDeptData" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datListGroup" >
    <xml>
        <dso id="1" type="grid" parameter="0,1,2,4,3,5,6,7,8,9,10,11,12" function="hr.sp_sel_thr_group" procedure="hr.sp_upd_group">            
            <input bind="grdListGroup"> 
                <input bind="lstDept" />
            </input>           
            <output bind ="grdListGroup"/>          
        </dso>
    </xml>
</gw:data>
<table width="100%" cellpadding="0" cellspacing="0" height="100%" align="top" border="1">
<tr>
	<td>
		<table  style=" height:6%" align="top" width="100%"  cellpadding="0" cellspacing="0" border="0"> 	
			<tr>
				<td align="right" width="5%" ></td>
				<td width="15%"></td>
				<td width="5%"><p class=title><font color="black" >
				    <a title="Click here to show department" onclick="OnShowPopup()" href="#tips" style="text-decoration : none; color:#0000FF"><b>Department</b></a>
				</td>
				<td width="10%">
					<gw:list  id="lstDept" styles='width:100%' onchange="OnChange_Dept()"> 
					    <data><%=ESysLib.SetListDataSQL("select a.pk,a.dept_nm from comm.tco_dept a where a.del_if=0 connect by prior  a.pk=a.p_pk start with nvl(a.p_pk,0)=0")%>|ALL|Select ALL</data>
					</gw:list>
				</td>
				
				<td align="right" width="5%"></td>
				<td width="15%"></td>
				<td align=""><b><gw:label id="idRecord" styles="color:blue"></gw:label></b></td>
				<td align=right width="2%"><gw:imgBtn id="iBtnSearch" alt="Search" img="Search" text="Search" onclick="SearchOnClick()" /></td>								
				<td align=right width="2%"><gw:imgBtn id="iBtnAdd" alt="Add New" img="new" text="" onclick="AddOnClick()" /></td>
				<td align=right width="2%"><gw:imgBtn id="iBtnUpdate" img="save" alt="Update" text="Update" onclick="UpdateOnClick()"/></td>										
				<td align=right width="2%"><gw:imgBtn id="iBtnDelete" img="delete" alt="Delete" text="Delete" onclick="DelOnClick()"/> </td>					
				<td width="2%" align=right><gw:imgBtn img="udelete" alt="undelete" id="ibtnDelete1" onclick="UnDelOnClick()" /></td>
				<td width="2%" align=right><gw:imgBtn img="excel" alt="print" id="ibtnPrint" onclick="PrintOnClick()" /></td>
			</tr>
		</table>	
		<table style=" height:94%" width="100%" cellpadding="0" cellspacing="0" border="1">
			<tr>
				<td width="100%">
					<gw:grid   
					id="grdListGroup"  
					header="_PK|Department|Group ID|Group Name|Group Fname|Group Kname|Start date|_End date|Use|Remark|Seq|Fix Shift|_Special Rule"   
					format="0|0|0|0|0|0|4|4|3|0|0|3|3"  
					aligns="0|0|0|0|0|0|0|0|0|0|0|0|0"  
					defaults="||||||||||||"  
					editcol="0|1|1|1|1|1|1|1|1|1|1|1|1"  
					widths="0|2000|2000|2000|2000|1500|1500|1000|2000|1000|900|900|1500"  
					styles="width:100%; height:100%;border:1"   
					sorting="T"   
					acceptNullDate />
				</td>
			</tr>
		</table>			
	    </td>
    </tr>	
</table>    	
    <gw:textbox id="txtDept_tmp" text=""  style="display:none"/>
    <gw:textbox id="txtDept" text=""  style="display:none"/> 
    <gw:textbox id="txtDeptData" text=""  style="display:none"/> 
    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>

</body>
</html>
