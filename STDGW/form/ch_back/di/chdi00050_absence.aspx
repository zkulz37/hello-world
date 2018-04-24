<!-- #include file="../../../system/lib/form.inc"  -->
 <% ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var binit=true;
var tab2=false;
var flag2=false;
var startTime,interval_time
var v_language = "<%=Session("SESSION_LANG")%>";
function BodyInit()
{
   grdAbsence.GetGridControl().FrozenCols =5;
   grdAbsence.GetGridControl().ScrollTrack=true;
   if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
      txtHr_level.text= "<%=session("HR_LEVEL")%>";
      
   dtMonth.value="<%=Request.QueryString("p_month") %>";
   dtFromDate.value="<%=Request.QueryString("p_from_dt") %>";
   dtToDate.value="<%=Request.QueryString("p_to_dt") %>";
   txtCompany_PK.text ="<%=Request.QueryString("p_company_pk") %>";

   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
          datUser_info.Call();   
  
}
function OnSearch()
{
    datSickRegPopup.Call("SELECT");
}
function OnDataReceive(obj)
{
   if(obj.id=='datSickRegPopup')
   {
    lblRecord.text = grdAbsence.rows-1 +" record(s)"
   }
}

//--------------------------------------------------------------------------
function OnSelect()
{
    
    var aData =new Array();
    var j;
    j=0;
    if (CheckValid(0))
    {
        for (var i=1;i<grdAbsence.rows;i++)
        {
            if (grdAbsence.GetGridData(i,0)=='-1')
            {   
                var aRow=new Array();
                aRow[0]=grdAbsence.GetGridData(i,1) //get emp pk
                aRow[1]=grdAbsence.GetGridData(i,2) //get group
                aRow[2]=grdAbsence.GetGridData(i,3) //get emp id
                aRow[3]=grdAbsence.GetGridData(i,4) //get full name
                aRow[4]=grdAbsence.GetGridData(i,5) //get social no
                aRow[5]=grdAbsence.GetGridData(i,6) //get abs date
                aRow[6]=grdAbsence.GetGridData(i,7) //get absence type nm
                aRow[7]=grdAbsence.GetGridData(i,8) //get sick type nm 
                aRow[8]=grdAbsence.GetGridData(i,9) //get absence time
                aRow[9]=grdAbsence.GetGridData(i,10) //get remark
                aRow[10]=grdAbsence.GetGridData(i,11) //get month
                aRow[11]=grdAbsence.GetGridData(i,12) //get from date
                aRow[12]=grdAbsence.GetGridData(i,13) //get to date
                aRow[13]=grdAbsence.GetGridData(i,14) //get abs_pk
                aRow[14]=grdAbsence.GetGridData(i,15) //get sick type
                aRow[15]=grdAbsence.GetGridData(i,16) //get abs type
                aRow[16]=grdAbsence.GetGridData(i,17) //get remark list
                aRow[17]=grdAbsence.GetGridData(i,18) //get remark
                aData[j]=aRow;
                j=j+1;
            }
            
        }
      
    window.returnValue = aData; 			
	this.close();
	}  
}
//---------------------------------------------------
function OnSelectAll()
{
    var aData =new Array();
    var j;
    j=0;
    if (CheckValid(1))
    {
        for (var i=1;i<grdAbsence.rows;i++)
        {
            var aRow=new Array();
             aRow[0]=grdAbsence.GetGridData(i,1) //get emp pk
            aRow[1]=grdAbsence.GetGridData(i,2) //get group
            aRow[2]=grdAbsence.GetGridData(i,3) //get emp id
            aRow[3]=grdAbsence.GetGridData(i,4) //get full name
            aRow[4]=grdAbsence.GetGridData(i,5) //get social no
            aRow[5]=grdAbsence.GetGridData(i,6) //get abs date
            aRow[6]=grdAbsence.GetGridData(i,7) //get absence type
            aRow[7]=grdAbsence.GetGridData(i,8) //get sick type
            aRow[8]=grdAbsence.GetGridData(i,9) //get absence time
            aRow[9]=grdAbsence.GetGridData(i,10) //get remark
            aRow[10]=grdAbsence.GetGridData(i,11) //get month
            aRow[11]=grdAbsence.GetGridData(i,12) //get from date
            aRow[12]=grdAbsence.GetGridData(i,13) //get to date
            aRow[13]=grdAbsence.GetGridData(i,14) //get abs_pk
            aRow[14]=grdAbsence.GetGridData(i,15) //get sick type code 
            aRow[15]=grdAbsence.GetGridData(i,16) //get absence type code
            aRow[16]=grdAbsence.GetGridData(i,17) //get remark list
            aRow[17]=grdAbsence.GetGridData(i,18) //get remark
            aData[j]=aRow;
            j=j+1;
            
        }
    window.returnValue = aData; 		
	this.close();
    }
	
}
//--------------------------------------------------------------------------
function OnClickGrid()
{
    var aData =new Array();
    var i;
    i=grdAbsence.row;
    var aRow=new Array();
    aRow[0]=grdAbsence.GetGridData(i,1) //get emp pk
    aRow[1]=grdAbsence.GetGridData(i,2) //get group
    aRow[2]=grdAbsence.GetGridData(i,3) //get emp id
    aRow[3]=grdAbsence.GetGridData(i,4) //get full name
    aRow[4]=grdAbsence.GetGridData(i,5) //get social no
    aRow[5]=grdAbsence.GetGridData(i,6) //get abs date
    aRow[6]=grdAbsence.GetGridData(i,7) //get absence type nm
    aRow[7]=grdAbsence.GetGridData(i,8) //get sick type nm 
    aRow[8]=grdAbsence.GetGridData(i,9) //get absence time
    aRow[9]=grdAbsence.GetGridData(i,10) //get remark
    aRow[10]=grdAbsence.GetGridData(i,11) //get month
    aRow[11]=grdAbsence.GetGridData(i,12) //get from date
    aRow[12]=grdAbsence.GetGridData(i,13) //get to date
    aRow[13]=grdAbsence.GetGridData(i,14) //get abs_pk
    aRow[14]=grdAbsence.GetGridData(i,15) //get sick type
    aRow[15]=grdAbsence.GetGridData(i,16) //get abs type
    aRow[16]=grdAbsence.GetGridData(i,17) //get remark list
    aRow[17]=grdAbsence.GetGridData(i,18) //get remark
    aData[0]=aRow;
    window.returnValue = aData; 			
	this.close();
}

//--------------------------------------------------
function CheckValid(objid)
{
    for (var i=1;i<grdAbsence.rows;i++)
    {
        var scheck=grdAbsence.GetGridData(i,0);   
        var sins_pk=grdAbsence.GetGridData(i,19); // regulation pk
       if ((grdAbsence.GetGridData(i,0)=='-1' && Number(sins_pk) > 0 && objid==0  ) || ( Number(sins_pk) > 0 && objid==1  ))
        {
            alert("Data of row " + i + " had been adding with regulation leave \n Dữ liệu tại dòng " + i + " đã được chọn nghỉ chế độ" );
            return 0;
        }
    }
        return 1;
    
}
//------------------------
function OnExit()
{
    window.returnValue = null; 		
	this.close();
}
//---------------------------------------------------
function EXITOnClick()
{
	OnExit();
}//------------------------------------------------

//-----------------------------------------------
function OnChangeMonth()
{
    datGetSickPeriod.Call();
}
//----------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screeny+';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg_Code.value=obj;
        
    }
    
}
//------------------------------------------------------------------------------------
function OnSetGrid(obj_checkbox,obj_grd,obj_col)
{	
    var tmp;
    if( obj_checkbox.GetData()=='T')
		tmp=-1;
	else
		tmp=0;
    var ctrl = obj_grd.GetGridControl();
    
    if (ctrl.SelectedRows>0)
    {
	    for ( var i =  0 ; i < ctrl.SelectedRows ; i++ )
		    {
			    var row = ctrl.SelectedRow(i);
			    if ( row > 0 )
			    {		
				    obj_grd.SetGridText(row,obj_col,tmp);
			    }
		    }
	}
	else
	{
	    for ( var i =  1 ; i < ctrl.rows ; i++ )
				    obj_grd.SetGridText(i,obj_col,tmp);
	}
}
//----------------------------------
</script>
<body >
<!-------------------data control----------------------->
<gw:data id="datGetSickPeriod" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_sick_get_from_to" > 
                <input>
                    <input bind="txtCompany_PK" />
                    <input bind="dtMonth" /> 
                </input> 
                <output>
                    <output bind="dtFromDate" />
                    <output bind="dtToDate" />
                    <output bind="txtresult" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<!-------------------data control----------------------->


<!-------------------data control----------------------->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="hr_sp_sel_user_role2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!--------------------------------------------------------------->
<gw:data id="datSickRegPopup" onreceive="OnDataReceive(this)"  > 
        <xml> 
           <dso  type="grid"  function="HR_SEL_10040005_POP" > 
                <input bind="grdAbsence">
                    <input bind="txtCompany_PK" /> 
                    <input bind="lstOrg_Code" /> 
                    <input bind="lstGrp_Code" /> 
                    <input bind="lstTemp" /> 
                    <input bind="txtTemp" /> 
                    <input bind="lstAbs_Type" /> 
                    <input bind="dtMonth" /> 
                    <input bind="dtFromDate" />
                    <input bind="dtToDate" />
                   
                </input> 
                <output bind="grdAbsence"/>
            </dso> 
        </xml> 
</gw:data>

<!-------------------table----------------------->
   <table name="Current Sal" id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td width="10%" align="right" style="border:0;"><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Organization</a>                  
                        </td>
                        <td width="13%" align="left" style="border:0;">
                         <gw:list  id="lstOrg_Code" maxlen = "100" styles='width:100%' >
                            <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk)  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>
                            </data>
                        </gw:list>
                        </td>
                        <td width="6%" align="right" style="border:0;">Group</td>
                        <td width="13%"  align="left" style="border:0;">
                         <gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("SELECT pk,workGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0   order by  workGroup_NM")%>|ALL|Select All</data></gw:list>
                        </td>
                        <td  width="8%"  align="right" valign="middle" style="border:0;">Search by</td>
					    <td   width="10%" style="border:0;">
					        <gw:list  id="lstTemp" value="2" styles='width:100%' onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID</data> 
					        </gw:list>
				        </td>
                        <td width="10%" align=center style="border:0" > 
					        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:95%'/></td>
				        <td width="4%" style="border:0;" align="right" ></td>
				        <td width="4%" style="border:0;" align="right" >
                         <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/></td>
                        <td width="4%" style="border:0" align="right">
                         <gw:imgBtn img="select" id="ibtnSelect"   alt="Select"  onclick="OnSelect()"/></td>
                        <td width="4%" style="border:0" align="right">
                        <gw:imgBtn img="selectall" id="ibtnSelectAll"   alt="Select All"  onclick="OnSelectAll()"/>
                        </td>
                        <td width="4%" style="border:0" align="right">
                        <gw:imgBtn img="cancel" id="ibtnExit"   alt="Exit"  onclick="OnExit()"/>
                        </td>
                    </tr>
                    <tr style="border:1;width:100%;height:5%" valign="center" >
                        <td  align="right" style="border:0;">
                        <gw:checkbox id="chkCheckReport" value="F" onclick="OnSetGrid(chkCheckReport,grdAbsence,0)" ></gw:checkbox >
                            &nbsp;&nbsp;Absence           
                        </td>
                        <td  align="left" style="border:0;">
                         <gw:list  id="lstAbs_Type" value='ALL' maxlen = "100" styles='width:100%'onchange="" >
                            <data>
                                <%=ESysLib.SetListDataSQL("select code,code_nm from vhr_hr_code where id='HR0003'")%>|ALL|Select All
                            </data>
                        </gw:list>
                        </td>
                        <td align="right" style="border:0;">Month</td>
                        <td align="left" style="border:0;">
                            <gw:datebox id="dtMonth" type="month" styles='width:100%' onchange="OnChangeMonth()"  lang="<%=Session("Lang")%>"/>
                        </td>
                        <td   align="right" valign="middle" style="border:0;">From Date</td>
					    <td   style="border:0;">
					         <gw:datebox id="dtFromDate" type="date" styles='width:100%' onchange=""  lang="<%=Session("Lang")%>"/>
				        </td>
                        <td align=right style="border:0" > To Date </td>
					       
				        <td colspan=3 style="border:0;" align="left" > <gw:datebox id="dtToDate" type="date" styles='width:100%' onchange=""  lang="<%=Session("Lang")%>"/>
				        </td>
                        <td colspan=2 style="border:0" align="right">
                        <gw:label id="lblRecord"  text="0 rec(s)" maxlen = "100" styles="color:red;width:100%;font-weight: bold;font-size:12" /></td>
                    </tr>
                    <tr style="border:1;width:100%;height:85%" valign="top">
                        <td colspan=12  style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdAbsence"  
                                header="Select|_EMP_PK|Organization|Emp ID|Full Name|Social No|Date|Absence Type|Sick Type|Absence Time|_Regulation Seq|Month|_From Date|_To Date|_Abs PK|_Sick_Type|_Abs Type|_Remark list|_Remark|_Ins PK"
                                format="3|0|0|0|0|0|0|0|1|1|1|0|0|1|1|0|0|0|0|0"  
                                aligns="0|0|0|0|1|0|0|0|2|0|2|0|0|0|0|0|0|0|0|0"  
                                defaults="|||||||||||||||||"  
                                editcol="0|0|0|0|0|0|0|0|0|1|1|1|1|1|1|1|0|0|0|0"  
                                widths="0|0|1500|1000|2500|1500|1200|1700|2000|1700|2000|1200|1200|1500|1700|1500|0"  
                                styles="width:100%; height:100%" 
                                sorting="T" acceptNullDate   
                                oncelldblclick="OnClickGrid()"
                                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
    
</body>
<gw:textbox id="txtresult" styles="display:none"/>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>  
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtCompany_PK" styles="display:none"/>
</html>
