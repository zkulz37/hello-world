<!-- #include file="../../../system/lib/form.inc"  -->
 <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var startTime,interval_time
var v_language = "<%=Session("SESSION_LANG")%>";
var p_month="<%=Request.querystring("p_month")%>";
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
     iduser_pk.text = "<%=session("USER_PK")%>";
      txtHr_level.text= "<%=session("HR_LEVEL")%>";
      //dtMonth.SetEnable(false);
    txtTemp.GetControl().focus();
    grdEmployee.GetGridControl().ScrollTrack=true;
    var data = "<%=ESysLib.SetGridColumnDataSQL(" select code,code_nm from vhr_hr_code where id='HR0056' order by code_nm " ) %> ";       
    grdEmployee.SetComboFormat(18,data);   
    data = "<%=ESysLib.SetGridColumnDataSQL(" select code,code_nm from vhr_hr_code where id='HR0017' order by code_nm " ) %> ";       
    grdEmployee.SetComboFormat(19,data);   
   
   // dtMonth.value=p_month;
      if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
       datUser_info.Call(); 
}
//----------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj
        txtUpperDept.text=obj;
        //datDeptData.Call();
    }
    
}
//----------------------------------

//----------------------------------
function OnDataReceive(obj_data)
{
    var obj;
       if (obj_data.id=="datShortTermAbsPopup")
       {
            lblRecord.text=grdEmployee.rows-1 + " record(s)";
	   }
	   else if (obj_data.id=="datUser_info")
       {
            //datGroupData.Call();
       }
}  
//------------------------------------------------------------------------------------
function OnSearch()
{
    datShortTermAbsPopup.Call("SELECT");
}
//------------------------------------------------------------------------------------
function OnCheckAll()
{	
    var tmp;
    if( chkSelectAll.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
		 var ctrl = grdEmployee.GetGridControl();
    
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    grdEmployee.SetGridText(row,0,tmp);
			    }
		    }
	}
}
//--------------------------------------------------------------------------
function OnSelect()
{
    
    var aData =new Array();
    var j;
    j=0;
    var bSelect=false;
    for (var i=1;i<grdEmployee.rows;i++)
    {
        if (grdEmployee.GetGridData(i,0)=='-1')
        {   
            var aRow=new Array();
            bSelect=true;
            aRow[0]=grdEmployee.GetGridData(i,1) //
            aRow[1]=grdEmployee.GetGridData(i,2) //
            aRow[2]=grdEmployee.GetGridData(i,3) //
            aRow[3]=grdEmployee.GetGridData(i,4) //
            aRow[4]=grdEmployee.GetGridData(i,5) //
            aRow[5]=grdEmployee.GetGridData(i,6) //
            aRow[6]=grdEmployee.GetGridData(i,7) //
            aRow[7]=grdEmployee.GetGridData(i,8) //
            aRow[8]=grdEmployee.GetGridData(i,9) //
            aRow[9]=grdEmployee.GetGridData(i,10) //
            aRow[10]=grdEmployee.GetGridData(i,11) //
            aRow[11]=grdEmployee.GetGridData(i,12) //
            aRow[12]=grdEmployee.GetGridData(i,13) //
            aRow[13]=grdEmployee.GetGridData(i,14) //
            aRow[14]=grdEmployee.GetGridData(i,15) //
            aRow[15]=grdEmployee.GetGridData(i,16) //
            aRow[16]=grdEmployee.GetGridData(i,17) //
            aRow[17]=grdEmployee.GetGridData(i,18) //
            aRow[18]=grdEmployee.GetGridData(i,19) //
            aRow[19]=dtMonth.value+'01' //
            
            aData[j]=aRow;
            j=j+1;
             
        }
        
    }
    
    window.returnValue = aData; 			
	this.close();
}
//---------------------------------------------------
function OnSelectAll()
{  var aData =new Array();
    var j;
    j=0;
    var bSelect=false;
    for (var i=1;i<grdEmployee.rows;i++)
    {
        
            var aRow=new Array();
            bSelect=true;
            aRow[0]=grdEmployee.GetGridData(i,1) //
            aRow[1]=grdEmployee.GetGridData(i,2) //
            aRow[2]=grdEmployee.GetGridData(i,3) //
            aRow[3]=grdEmployee.GetGridData(i,4) //
            aRow[4]=grdEmployee.GetGridData(i,5) //
            aRow[5]=grdEmployee.GetGridData(i,6) //
            aRow[6]=grdEmployee.GetGridData(i,7) //
            aRow[7]=grdEmployee.GetGridData(i,8) //
            aRow[8]=grdEmployee.GetGridData(i,9) //
            aRow[9]=grdEmployee.GetGridData(i,10) //
            aRow[10]=grdEmployee.GetGridData(i,11) //
            aRow[11]=grdEmployee.GetGridData(i,12) //
            aRow[12]=grdEmployee.GetGridData(i,13) //
            aRow[13]=grdEmployee.GetGridData(i,14) //
            aRow[14]=grdEmployee.GetGridData(i,15) //
            aRow[15]=grdEmployee.GetGridData(i,16) //
            aRow[16]=grdEmployee.GetGridData(i,17) //
            aRow[17]=grdEmployee.GetGridData(i,18) //
            aRow[18]=grdEmployee.GetGridData(i,19) //
            aRow[19]=dtMonth.value+'01' 
          
            aData[j]=aRow;
            j=j+1;
             
        
        
    }
    
    window.returnValue = aData; 			
	this.close();
}
//--------------------------------------------------
function OnExit()
{
    window.returnValue = null; 		
	this.close();
}
//---------------------------------------------------
function EXITOnClick()
{
	OnExit();
}
</script>

<body>
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


<!--------------------------------------------------------------->
<gw:data id="datShortTermAbsPopup" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr_sel_10030020_increase_popup" > 
                <input bind="grdEmployee">
                    <input bind="lstOrg" /> 
                    <input bind="lstWG" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" /> 
                    <input bind="dtMonth" />
                    
                </input> 
                <output bind="grdEmployee"/>
            </dso> 
        </xml> 
</gw:data>
<!----------------------main table------------------------------->
<table name="Absence"  style='margin-left:10px' id="Absence" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
        <tr  style="width:100%;height:100%" valign="top">
            <td  style="width:100%;height:100%">
                <table width="100%" id="tblexp" style="height:10%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%" valign="middle"  >
                        <td width="7%"  align="right" ><a title="Click here to show z" onclick="OnShowPopup()" href="#tips" >Organization</a>                  
                        </td>
                        <td width="20%"  align="left" >
                         <gw:list  id="lstOrg" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM TCO_ORG A WHERE A.DEL_IF=0 CONNECT BY PRIOR  A.PK=A.P_PK START WITH NVL(A.P_PK,0)=0")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td width="10%"  align="right" >Work Group</td>
                        <td width="15%" align="left" >
                         <gw:list  id="lstWG" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0" )%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                       
                        <td width="8%" style="border:0" align="right" valign="middle">Search by</td>
				       <td width="7%" style="border:0">
				            <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
						            <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
				            </gw:list>
			            </td>
			            <td  width="9%" colspan=2 style="border:0"> 
				            <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
			            </td>
			            <td width="6%"  align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="select" id="ibtnSelect"    alt="Select"  onclick="OnSelect()"/>
                        </td>
                        <td width="3%"  align="right" >
                         <gw:imgBtn img="selectall" id="ibtnSelectAll"   alt="Select All"  onclick="OnSelectAll()"/>
                        </td>
                        <td width="3%"  align="right" >
                         <gw:imgBtn img="cancel" id="ibtnExit"   alt="Exit"  onclick="OnExit()"/>
                        </td>
                    </tr>
				    <tr align=top >
						<td align="center" ><gw:checkbox id="chkSelectAll" value="F" onclick="OnCheckAll()" ></gw:checkbox ></td>
						<td align=left  ><font color="black">Select</td>
						<td align=right  ><font color="black"></td>
						<td>                    </td>
						
						<td    align=right><font color="black">Month</td>
						<td   ><gw:datebox id="dtMonth"  styles='width:80%'    lang="<%=Session("Lang")%>" type='month' />  </td>						
			            <td  width="1%" align=center></td>
			            <td  width="10%">  </td>
						
						<td colspan=5 align=center><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
					</tr>
			    </table>
                 <table cellspacing=0 cellpadding=0 style="height:90%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                            
					        <gw:grid   
                                id="grdEmployee"   
                                header="select|Organization|W-Group|Emp ID|Full Name|Join Date|Postion|Level 1|Level 2|Confirm DT|_Allow1|_Allow2|_Allow3|_Allow4|_allow5|_Allow6|_Allow7|_Allow8|Salary Type|Employee Type"
                                format="3|0|0|0|0|4|0|1|1|4|1|1|1|1|1|1|1|1|2|2"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                defaults="|||||||||||||||||||"  
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                widths="1000|2000|2000|2000|2000|2000|2000|2000|2000|2000|1500|1500|1500|1500|1500|1500|1500|1500|2000|2000|2000"
                                styles="width:100%; height:100%" 
                                sorting="T" acceptNullDate   
                                oncelldblclick=""
                                /> 
                                  

                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>	
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
</body>
</html>

