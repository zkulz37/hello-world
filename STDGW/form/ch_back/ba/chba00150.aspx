<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var startTime,interval_time
var old_abs;
var v_language = "<%=Session("SESSION_LANG")%>";
/*grdShortTermAbs*/
var 
g_short_org         =0,
g_short_group       =1,
g_short_emp_id      =2,
g_short_emp_nm      =3,
g_short_emp_shift   =4,
g_short_ale_remain  =5,
g_short_emp_abs_type =6,

g_short_abs_dt      =7,
g_short_desc        =8,
g_short_abs_time    =9,
g_short_com_flag    =10,
g_short_com_rate    =11,
g_short_ins_flag    =12,

g_short_ins_rate    =13,
g_short_pk          =14,
g_short_emp_pk      =15,
g_short_wg_pk       =16,
g_short_abs_reg_pk  =17,

g_short_ws_pk       =18,
g_short_com_allow   =19


     
function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
      txtHr_level.text= "<%=session("HR_LEVEL")%>";
    txtTemp_S.GetControl().focus();
    grdShortTermAbs.GetGridControl().FrozenCols =6;
    grdShortTermAbs.GetGridControl().ScrollTrack=true;
   
    InitButton(ibtnSave_S,ibtnDelete_S,ibtnUnDelete_S,false);
   
    Ctrl=grdShortTermAbs.GetGridControl();	
    Ctrl.ColEditMask(10)="999%";
    Ctrl.ColEditMask(12)="999%";
    var data = "<%=ESysLib.SetGridColumnDataSQL(" select code,code_nm from vhr_hr_code where id='HR0003' order by code_nm " ) %> ";       
    grdShortTermAbs.SetComboFormat(g_short_emp_abs_type,data);   
        
   
    if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
        datUser_info.Call();     	    
    

}

//--------------------------------------------------
function InitButton(savObj,delObj,undelObj,flag)
{
    savObj.SetEnable(flag);
    delObj.SetEnable(flag);
    undelObj.SetEnable(flag);
}
//-------------------------------------------------
function OnShowPopup(num)
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:25;dialogHeight:25;dialogLeft:10;dialogTop:240;edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        if(num==1)
        {
            lstOrg_S.value=obj
        }
       
    }
    
}
//-------------------------------------------------
function OnChangeDept(depObj)
{
    txtDept.text=depObj.value;
    //datGroupData.Call();
}
//-------------------------------------------------
function OnDataReceive(obj)
{
    var obj_lst;
       if (obj.id=="datDeptData")
       {
            if(txtHr_level.text=="6")
                txtDeptData.text=txtDeptData.text+"|ALL|Select All";
            
            switch (tabMain.GetCurrentPageNo())
            {
                case 0:
                {
                    lstOrg_S.SetDataText(txtDeptData.text);
                    txtDept.text=lstOrg_S.value;
                    break;
                }
               
            }  
            //datGroupData.Call();
       }
       else if (obj.id=="datShortTermAbs")
       {
            if (grdShortTermAbs.rows>1)
                InitButton(ibtnSave_S,ibtnDelete_S,ibtnUnDelete_S,true);
            else
                InitButton(ibtnSave_S,ibtnDelete_S,ibtnUnDelete_S,false);
            lblRecord_S.text=grdShortTermAbs.rows -1 + " record(s)";
            SetColor();
       }
       else if (obj.id=="datUser_info")
       {
            lstOrg_S.SetDataText(txtdept_temp.text);            
            lstOrg_L.SetDataText(txtdept_temp.text);
            lstOrg_C.SetDataText(txtdept_temp.text);
            txtDept.text=lstOrg_S.value;
            //datGroupData.Call();
       }
     
}   
//------------------------------------------------------------  
function OnSearch(obj)
{
    obj.Call("SELECT");
}
//------------------------------------------------------------
function OnPopup(obj,dept_obj,grp_obj,temp_lst_obj,temp_txt_obj,abs_type_obj,fromdate_obj,todate_obj)
{
	var rowid,k,tmp;
	if (obj==1)//short term tab
	    var url = "/form/ch/ba/chba00150_01.aspx";
	var aData=new Array();
	aData = System.OpenModal( System.RootURL+ url , 900 , 600 , 'resizable:yes;status:yes') ;
	if ( aData != null )
	{  	 
		var len=aData.length;
		var i;
		for (i=0;i<len-1;i++)		
		{
	        if (obj==1)//short term tab
            {
                grdShortTermAbs.AddRow();
		        var irow=grdShortTermAbs.rows-1;
		        aRow=aData[i];
		        grdShortTermAbs.SetGridText(irow,g_short_org,aRow[0]);		// department
		        grdShortTermAbs.SetGridText(irow,g_short_group,aRow[1]);		// group
		        grdShortTermAbs.SetGridText(irow,g_short_emp_id,aRow[2]);		// emp id
		        grdShortTermAbs.SetGridText(irow,g_short_emp_nm,aRow[3]);		// full name
		        grdShortTermAbs.SetGridText(irow,g_short_emp_abs_type,aRow[4]);		// abs type
		        grdShortTermAbs.SetGridText(irow,g_short_abs_dt,aRow[5]);		// abs date
		        grdShortTermAbs.SetGridText(irow,g_short_ale_remain,aRow[6]);		// remain ALE
		        grdShortTermAbs.SetGridText(irow,g_short_emp_pk,aRow[7]);		// emp pk
		        grdShortTermAbs.SetGridText(irow,g_short_emp_shift,aRow[8]);		// work shift name
		        grdShortTermAbs.SetGridText(irow,g_short_wg_pk,aRow[9]);		// wgroup pk
		        grdShortTermAbs.SetGridText(irow,g_short_ws_pk,aRow[10]);		// work shift pk
			}
			
		}
		if (len!=0)
		{
		    
		    dept_obj.SetDataText("<%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM TCO_ORG A WHERE A.DEL_IF=0 CONNECT BY PRIOR  A.PK=A.P_PK START WITH NVL(A.P_PK,0)=0")%>" + '|ALL|Select All');    
            grp_obj.SetDataText("<%=Esyslib.SetListDataFUNC("SELECT F_COMMONCODE('COEO0030','','') FROM DUAL" )%>" + '|ALL|Select All');
 		    aRow=aData[len-1];
		    dept_obj.value=aRow[0]; //dept
		    grp_obj.value=aRow[1]; //grp
		    temp_lst_obj.value=aRow[2]; //lsttemp
		    temp_txt_obj.text=aRow[3]; //temp
		    abs_type_obj.value=aRow[4];//abs type
		    fromdate_obj.value=aRow[5];//from date
		    todate_obj.value=aRow[6];//to date
		    if (obj==1)
		        InitButton(ibtnSave_S,ibtnDelete_S,ibtnUnDelete_S,true);
		    
		}
	}	
}
//----------------------------------
function OnSave(obj_data)
{
    if (confirm("Do you want to save?"))
    {
            obj_data.Call();
    }
}
//--------------------------------------
function OnDelete(grdObj,delObj,undelObj)
{
    if (confirm("Do you want to delete this record?"))
    {
        grdObj.DeleteRow();
        delObj.SetEnable(false);
        undelObj.SetEnable(true);
    }
}
//--------------------------------------
function OnUnDelete(grdObj,delObj,undelObj)
{
    if (confirm("Do you want to delete this record?"))
    {
        grdObj.UnDeleteRow();
        delObj.SetEnable(true);
        undelObj.SetEnable(false);
    }
}
//------------------------------------------
function CheckButton(grdObj,delObj,undelObj)
{
    var rownum 	= grdObj.row;
    var rownums 	= grdObj.rows;
    
    if(rownum > 0 && rownums>1)
    {
        if(grdObj.GetRowStatus(rownum) >= 64  )
        {
            delObj.SetEnable(false);
            undelObj.SetEnable(true);
        }
        else
        {
            delObj.SetEnable(true);
            undelObj.SetEnable(false);
        }
    }
    if ( grdObj==grdShortTermAbs)
        if (grdObj.GetGridData(rownum,g_short_abs_reg_pk)>0)
        {
            delObj.SetEnable(false);
            undelObj.SetEnable(false);
        }
}
//---------------------------
function CheckData()
{   
    var ivalue;
    var irow=grdShortTermAbs.row;
    var icol=grdShortTermAbs.col;
    if (((icol==g_short_com_rate)|| (icol==g_short_ins_rate)) && (irow !=0))
    {
        ivalue=grdShortTermAbs.GetGridData(irow,icol);
        if (ivalue > 100)
        {
            alert("Have to input value from 1 to 100!");
            grdShortTermAbs.SetGridText(irow,icol,0 + "%");
        }
        else
            grdShortTermAbs.SetGridText(irow,icol,ivalue + "%");
        
    }
    if ((icol==g_short_abs_time)&& (irow !=0))
    {
        ivalue=grdShortTermAbs.GetGridData(irow,icol);
        if (isNaN(ivalue))
			{
				alert("Please enter absence time with number at row " + irow);
				grdShortTermAbs.SetGridText(irow,icol,"");    
			}
    }
}
//---------------------------
function CheckValue()
{   
    var ivalue;
    var irow=grdShortTermAbs.row;
    var icol=grdShortTermAbs.col;
    
    if (((icol==g_short_com_flag)|| (icol==g_short_ins_flag)) && (irow !=0))
    {
        if (grdShortTermAbs.GetGridData(irow,icol)==-1)
            grdShortTermAbs.SetGridText(irow,icol+1,"100" + "%");
        else
            grdShortTermAbs.SetGridText(irow,icol+1,"0" + "%");    
    }
    
}
//-----------------------------------------------------
function SetColor()
{
    for(var i=1;i<=grdShortTermAbs.rows-1;i++)
    {
        if (grdShortTermAbs.GetGridData(i,g_short_abs_reg_pk)>0) //long term
            grdShortTermAbs.SetCellBgColor(i,0,i,g_short_com_allow,0xccffcc);
    }
}

//--------------------------------------------------------
function ShowAbs()
{
    var col=event.col;
    if(col==5 && Number(grdShortTermAbs.GetGridData(event.row,g_short_abs_reg_pk))<=0)
    {
        var abs_code,flag;
        abs_code=grdShortTermAbs.GetGridData(event.row,g_short_emp_abs_type);
        flag=1;
        var fpath = System.RootURL + "/form/ch/ba/chba00020_03.aspx?abs_code=" + abs_code + "&flag=" + flag; 
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:30;dialogHeight:25;dialogLeft:300;dialogTop:230;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
            if(obj[0]!=abs_code)
            {
                grdShortTermAbs.SetGridText(event.row,col,obj[0]);
                grdShortTermAbs.SetCellBgColor(event.row, col,event.row, col, 0xcc99ff );
                grdShortTermAbs.SetCellBold(event.row,col,event.row,col,true);
            }
        }
           
    }
}

function OnSetToGrid(lstobj,colobj)
{
    ctrl=grdShortTermAbs.GetGridControl();
//    if (col_abs!="")
//    {
//        if (col_abs.value=="02")
//            colobj += 1;//cot actual absence type
//    }    
    var svalue;
    svalue=lstobj.value
    //alert(svalue);
        if(grdShortTermAbs.rows>1)
        {  
             if (ctrl.SelectedRows>1) 
             {
                   for(var i=0;i<ctrl.SelectedRows;i++)
                   {
                       if (grdShortTermAbs.GetGridData(ctrl.SelectedRow(i),g_short_abs_reg_pk)==0)
                            grdShortTermAbs.SetGridText(ctrl.SelectedRow(i),colobj,svalue);
                    }
             }
         }
}
</script>

<body style=" margin-bottom:0; margin-top:0; margin-right:0" >
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txtdept_temp" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!--------------------------------------------------------------->
<gw:data id="datShortTermAbs" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="hr_sel_10020016_abs_adj" procedure="hr_upd_10020016_abs_adj" parameter="2,6,7,8,9,10,11,12,13,14,15,16,18,19"> 
                <input bind="grdShortTermAbs">
                    <input bind="lstOrg_S" /> 
                    <input bind="lstWG_S" /> 
                    <input bind="lstTemp_S" /> 
                    <input bind="txtTemp_S" /> 
                    <input bind="lstAbs_Type_S" /> 
                    <input bind="lstNation_S" /> 
                    <input bind="dtFromDate_S" />
                    <input bind="dtToDate_S" />
                    <input bind="lst_abs_adj" />
                    
                   
                </input> 
                <output bind="grdShortTermAbs"/>
            </dso> 
        </xml> 
</gw:data>

<!----------------------main table------------------------------->
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate=""  > 
<table name="Absence Adjustment" id="Absence" class="itable" width="100%" cellpadding="0"  cellspacing="0" border=1 style="height:100%;">
        <tr  style="width:100%;height:100%" valign="top">
            <td  style="width:100%;height:100%">
                <table width="100%" id="tblexp" style="height:15%" border=0 cellpadding="0" cellspacing="0">
                    <tr style="border:0;width:100%" valign="middle"  >
                        <td width="8%"  align="right" ><a title="Click here to show department" onclick="OnShowPopup(1)" href="#tips" >Organization</a>                  
                        </td>
                        <td width="25%"  align="left" >
                         <gw:list  id="lstOrg_S" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("SELECT A.PK,A.ORG_NM FROM TCO_ORG A WHERE A.DEL_IF=0 ORDER BY NVL(A.SEQ,9999)")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td align=left width="2%" ></td>
                        <td width="6%"  align="right" >WGroup</td>
                        <td width="15%" align="left" >
                         <gw:list  id="lstWG_S" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select pk, workgroup_nm from thr_work_group where del_if=0" )%>|ALL|Select All
                            </data>
                            </gw:list>
                        </td>
                       <td align=left width="2%" ></td>
                        <td width="6%" style="border:0" align="right" valign="middle">Search by</td>
				       <td width="6%" style="border:0">
				            <gw:list  id="lstTemp_S" value="2" styles='width:100%' onchange=""> 
						            <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
				            </gw:list>
			            </td>
			            <td  width="11%" colspan=2 style="border:0"> 
				            <gw:textbox id="txtTemp_S" onenterkey   ="OnSearch(datShortTermAbs)" styles='width:100%'/>
			            </td>
			            <td width="4%"  align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch_S"   alt="Search"  onclick="OnSearch(datShortTermAbs)"/>
                        </td>
                        <td width="3%" style="border:0" align="right">
                         <gw:imgBtn img="save" id="ibtnSave_S"    alt="Save"  onclick="OnSave(datShortTermAbs)"/>
                        </td>
                        <td width="3%"  align="right" >
                         <gw:imgBtn img="delete" id="ibtnDelete_S"   alt="Delete"  onclick="OnDelete(grdShortTermAbs,ibtnDelete_S,ibtnUnDelete_S)"/>
                        </td>
                        <td width="3%"  align="right" >
                         <gw:imgBtn img="udelete" id="ibtnUnDelete_S"   alt="UnDelete"  onclick="OnUnDelete(grdShortTermAbs,ibtnDelete_S,ibtnUnDelete_S)"/>
                        </td>
                         <td width="3%"  align="right" >
                         <gw:imgBtn img="popup" id="ibtnPopup_S"   alt="Add"  onclick="OnPopup(1,lstOrg_S,lstWG_S,lstTemp_S,txtTemp_S,lstAbs_Type_S,dtFromDate_S,dtToDate_S)"/>
                        </td>
                    </tr>
				    <tr align=top >
						<td align="right" ><font color="black">Absence Type</td>
						<td >
							<gw:list id="lstAbs_Type_S"  value="ALL" styles='width:100%'>	
								<data><%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0003' order by code_nm")%>|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td align=left width="2%" ></td>
						<td align=right  ><font color="black">Nation</td>
						<td>
						   <gw:list  id="lstNation_S" value='01'  styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm" )%>|ALL|Select All</data></gw:list>
                        </td>
						<td align=left width="2%" ></td>
						<td    align=right><font color="black">Date</td>
						<td   ><gw:datebox id="dtFromDate_S"  styles='width:80%'   lang="<%=Session("Lang")%>"/>  </td>						
			            <td  width="1%" align=center><b>~</b></td>
			            <td  width="10%"> <gw:datebox id="dtToDate_S"  styles='width:80%' lang="<%=Session("Lang")%>"/>  </td>
						
						<td colspan=5 align=center><gw:label id="lblRecord_S"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" /></td>
					</tr>
					<tr align=top >
						<td align="right" ><font color="black">Absence Ajust</td>
						<td >
							<gw:list id="lst_abs_adj"  value="ALL" styles='width:100%'>	
								<data>|Y|Y|N|N|ALL|Select All</data>
							</gw:list > 										
						</td>
						<td align=left width="2%" ></td>
						<td align=right  ></td>
						<td>                        </td>
						<td   width="2%"> </td>				
						
						
						<td colspan=7 align=center></td>
					</tr>
			    </table>
                 <table cellspacing=0 cellpadding=0 style="height:85%" width=100% border=1>
                    <tr style="border:1;width:100%;height:100%" valign="top">
                        <td  style="width:100%;height:100%;"> 
                            <gw:grid   
						        id="grdShortTermAbs"  
						        header="Organization|Work Group|Emp ID|Full Name|Work Shift|Remain Ale|Absence Type|Absent Date|Description|Absence Time|Company Pay Flag|Company Pay Rate|Insurance Pay Flag|Insurance Pay Rate|_PK|_EMP_PK|_WG_PK|_absence_reg_pk|_thr_ws_pk|Company Allow"   
					            format="0|0|0|0|0|0|2|4|0|0|3|0|3|0|0|0|0|0|0|3"  
					            aligns="0|0|1|0|0|0|0|0|0|1|1|1|0|1|0|0|0|0|0|0"  
					            defaults="||||||||||||||||||||"  
					            editcol="0|0|0|0|0|0|1|0|1|1|1|1|1|0|0|0|0|0|0|1"  
					            widths="1300|1500|900|2300|1500|1200|2000|2000|1400|1800|1800|1800|1800|1500|1300|0|1000|0|0|0|800"  
					            styles="width:100%; height:100%"   
					            sorting="T"   oncellclick="CheckButton(grdShortTermAbs,ibtnDelete_S,ibtnUnDelete_S);CheckValue()" oncelldblclick="ShowAbs()" onafteredit="CheckData()"  
					             /> 

                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>

</gw:tab>
<gw:textbox id="txtDept" styles="display:none"/>	
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>	
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtdept_temp" styles="display:none"/>
</body>
</html>

