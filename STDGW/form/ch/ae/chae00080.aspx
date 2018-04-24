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

function BodyInit()
{
    txtOrg_tmp_pk.text="<%=Session("COMPANY_PK")%>";
    
    if (v_language!="ENG")
        System.Translate(document);
	/* su dung tren employee info
	*/
	txt_popup_yn.text="<%=request.QueryString("p_popup_yn")%>";
	txt_popup_emppk.text="<%=request.QueryString("p_emp_pk")%>";
	if(txt_popup_yn.text == 'y' && txt_popup_emppk.text !='')
	{
        idLeftDiv.style.display="none";
		imgArrow.style.display="none";
        //imgArrow.status = "collapse";
        //imgArrow.src = "../../../system/images/next_orange.gif";
	}
	/* end su dung tren employee info
	*/
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    grdEmployee.GetGridControl().ScrollTrack=true;
    grdExperience.GetGridControl().ScrollTrack=true;
    grdFamily.GetGridControl().ScrollTrack=true;
    grdOther.GetGridControl().ScrollTrack=true;

    ChangeColorItem(lstOrg.GetControl());

   if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	{
        datUser_info.Call();     	    
	}
	else
	{
	    datSal_security.Call();
	}
}

//-----------------------------------------------

 function ChangeColorItem(lstctl) 
 {
        var slevel1, slevel2, slevel3,slevel4;
        for (var i = 0; i < lstctl.options.length; i++)
        {
            slevel1 = lstctl.options.item(i).text.substr(0, 1);
            slevel2 = lstctl.options.item(i).text.substr(0, 3);
            slevel3 = lstctl.options.item(i).text.substr(0, 5);
            slevel4 = lstctl.options.item(i).text.substr(0, 7);
            if (slevel4 != ".......")
            {
                if(slevel3==".....")
                {
                    lstctl.options.item(i).style.color = "0066CC";
                }
                else  
                {
                    if (slevel2 == "...")
                    {
                        lstctl.options.item(i).style.color = "FF4500";
                    }
                    else
                    {
                        if (slevel1 == ".")
                            lstctl.options.item(i).style.color = "FF00FF";  //FF3333
                    }
                }                
            }
        }
    }

//-------------------------------

function OnDataReceive(obj)
{
    if (obj.id=="datOrgData")
    {
            if(txtHr_level.text=="6")
                txtOrgData.text=txtOrgData.text+"|ALL|Select All";
            lstOrg.SetDataText(txtOrgData.text)    ;
            
              obj=lstOrg.GetControl()
		    if (obj.options.length ==2)
			    obj.options.selectedIndex=0;
		    else
			    obj. options.selectedIndex=0;
    
        
        //datGroupData.Call();
    }
   else if (obj.id=="datEmployee_Detail_Search")
   {
        imgFile.SetDataText(txtPhoto_PK.text);
        datExperience.Call("SELECT");
   }
   else if (obj.id=="datExperience")
   {
   
        datEdu.Call("SELECT");
   }
   else if (obj.id=="datEdu")
   {
   
        datFamily.Call("SELECT");
   }
   else if (obj.id=="datFamily")
   {
        datOther.Call("SELECT");
   }
   else if (obj.id=="datUser_info")
   {
        ChangeColorItem(lstOrg.GetControl());
		datSal_security.Call();
   }
	else if (obj.id=="datSal_security")
   {   
		check_init=1;
		/*su dung tren employee info*/
		if(txt_popup_yn.text == 'y' && txt_popup_emppk.text !='')
		{
			txtEmpPK.text = txt_popup_emppk.text;
			imgFile.MasterPK = txtEmpPK.text;
			datEmployee_Detail_Search.Call("SELECT");
		}
		/*end su dung tren employee info*/
   }
   else if (obj.id=="datFind_Report")
   {
        
        var url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?emp_pk=' + emp_pk_list+'&p_sal_security='+ txt_sal_security.text  ;
        window.open(url); 
   }    
}
//------------------------------------------------
function OnChangeOrg()
{
    txtOrg.text=lstOrg.value ;
    

}
//----------------------------------------------------
function ChoseList_box(obj_list,value)
{
    obj_list.SetDataText(value )    ;
    obj=obj_list.GetControl()
	if (obj.options.length ==2)
		obj.options.selectedIndex=0;
	else
		obj.options.selectedIndex=obj.options.length-1;
}
//----------------------------------
function OnShowPopup()
{
    var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
    var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:yes;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+ window.event.screenY +';edge:sunken;scroll:yes;unadorned:yes;help:no');
    if (obj!=null)
    {
        lstOrg.value=obj;
    }
    
}
//-----------------------------------------------
function OnToggle()
{
    if(imgArrow.status == "expand")
    {
        idLeftDiv.style.display="none";
        imgArrow.status = "collapse";
        imgArrow.src = "../../../system/images/next_orange.gif";
    }
    else
    {
        idLeftDiv.style.display="";
        imgArrow.status = "expand";
        imgArrow.src = "../../../system/images/prev_orange.gif";
    }
    
}
//------------------------------------------------
function OnSearch()
{
	if(check_init==1)
	{
		//datEmployee_Detail_Search.StatusInsert();
		grdExperience.ClearData();
		grdFamily.ClearData();
		grdOther.ClearData();
		datEmployee_Main_Search.Call("SELECT");
	}	
}
//-------------------------------------------------
function OnClickRow()
{
    var col=grdEmployee.GetGridControl().col
    if(col!=1)
    {
        txtEmpPK.text=grdEmployee.GetGridData(grdEmployee.row,0);
        imgFile.MasterPK = txtEmpPK.text;
        datEmployee_Detail_Search.Call("SELECT");
    }    
}
//--------------------------------------------------
function OnReport()
{
	if(check_init==1)
	{
		emp_pk_list="";
                for (var i=1;i<=grdEmployee.rows-1;i++)
                    {
                        if (grdEmployee.GetGridData(i,1)=="-1")
                        {
                            emp_pk_list = emp_pk_list + grdEmployee.GetGridData(i,0) + ",";                        
                        }   
                    }
                    if (emp_pk_list=="")
                        alert("Please choose employees to print");
                    else
                    {
                        emp_pk_list=emp_pk_list.substr(0,emp_pk_list.length-1);
                         txtReport_tmp.text=lstReport_Type.value;
						 txtOrg_tmp_pk.text=lstOrg.value; 
                         datFind_Report.Call();
                    }
	}				
}
</script>
<body >
<!-------------------data control----------------------->
<gw:data id="datSal_security" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="hr_pro_10010003_sal_display"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="txt_sal_security" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmployee_Main_Search" > 
        <xml> 
            <dso  type="grid"   function="HR_SEL_10010008_EMP_SEARCH" > 
                <input bind="grdEmployee" >
                    <input bind="lstOrg" />
                    <input bind="dtFrom_JoinDate" />
                    <input bind="dtTo_JoinDate" />
                    <input bind="chkTemp" />
                    <input bind="txtTemp" />
					<input bind="lstNation" />
					<input bind="lstStatus" />
					
                </input>
                <output  bind="grdEmployee" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------->
<gw:data id="datEmployee_Detail_Search" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="control" function="HR_SEL_10010008_EMP_DETAIL" > 
                <inout>
                    <inout bind="txtEmpPK" /> 
                    <inout bind="txtEmpID" /> 
                    <inout bind="txtOldCode" /> 
                    <inout bind="txtPhoto_PK" /> 
                    <inout bind="txtFullName" /> 
                    <inout bind="txtCardID" /> 
                    <inout bind="txtCurAdd" /> 
                    <inout bind="txtPerAdd" /> 
                    <inout bind="txtOrganization" /> 
                    <inout bind="txtGroup" /> 
                    <inout bind="txtEmpType" /> 
                    <inout bind="txtTel" /> 
                    <inout bind="txtSex" /> 
                    <inout bind="txtStatus" /> 
                    <inout bind="txtJoinDate" /> 
                    <inout bind="txtLeftDate" /> 
                    <inout bind="txtNation" /> 
                    <inout bind="txtBirthPlace" /> 
                    <inout bind="txtBirthDate" /> 
                    <inout bind="txtPersonID" /> 
                    <inout bind="txtPersonIDPlace" /> 
                    <inout bind="txtIssuedDate" /> 
                    <inout bind="txtPos" /> 
                    <inout bind="txtJob" />
                    <inout bind="txtEdu" />
                    <inout bind="txtEthnic" />
                    <inout bind="txtReligion" />
                    <inout bind="txtMarital" />
                </inout> 
            </dso> 
        </xml> 
</gw:data>
<!---------------------expand employee tab data control------------------>
<gw:data id="datExperience" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_sel_10010008_experience" > 
                <input bind="grdExperience" >
                    <input bind="txtEmpPK" />
                </input>
                <output  bind="grdExperience" />
            </dso> 
        </xml> 
</gw:data>

<!---------------------expand employee tab data control------------------>
<gw:data id="datEdu" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10010008_SEL_EDU" > 
                <input bind="grdEDU" >
                    <input bind="txtEmpPK" />
                </input>
                <output  bind="grdEDU" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datFamily" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10010008_FAMILY_SEARCH" > 
                <input>
                    <input bind="txtEmpPK" />
                </input>
                <output  bind="grdFamily" />
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<gw:data id="datOther" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="HR_SEL_10010008_OTHER" > 
                <input>
                    <input bind="txtEmpPK" />
                </input>
                <output  bind="grdOther" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------>
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
<!------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report_2" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                    <input bind="txtOrg_tmp_pk" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<!----------------------------------->
<table  border="1" width="100%" height="100%" cellpadding="0" cellspacing="0" >
    <tr> 
        <td  id="idLeftDiv" valign="top" width="30%" height="100%">
        
            <table width="100%" height="100%" cellpadding=0 cellspacing=0 border=0 class="itable">
			    <tr   style="border:0;height:5%">
			        <td width="20%" style="border:0"  align="right" valign="middle">Nation</td>
				    <td colspan=2 width="25%" style="border:0" >
					    <gw:list  id="lstNation" value='01' maxlen = "100" styles='width:100%' >
                            <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by seq")%>|ALL|Select All</data></gw:list>
				    </td>
				    <td width="16%" align=right>Status</td>
				    <td colspan=3 width="44%"><gw:list  id="lstStatus" value='A' maxlen = "100" styles='width:100%' >
                            <data><%=Esyslib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0022' order by seq" )%>|ALL|Select All</data></gw:list>
                     </td>
				    <td width=5%></td>
				    <td width=5%></td>
			    </tr>
				<tr style="border:0;height:5%">
			        <td style="border:0"  align="right" valign="middle"><a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Organization</a></td>
				    <td style="border:0" colspan=6>
					    <gw:list  id="lstOrg" value="ALL" styles='width:100%' onchange=""> 
					    <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data></gw:list>
				    </td>
				    <td ></td>
				    <td ></td>
				    
				    
			    </tr>
				<tr  style="border:0;height:5%" >
					<td  style="border:0" align="right">Join DT</td>
				    <td colspan=2 style="border:0" ><gw:datebox id="dtFrom_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				    <td ></td>
				    <td colspan=4 style="border:0" ><gw:datebox id="dtTo_JoinDate" nullaccept styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				    <td ></td>
				    <td ></td>
				    
				</tr>
				<tr  style="border:0;height:5%">
		            <td style="border:0" align="right" >Search by</td>
		            <td colspan=2 style="border:0">									
			            <gw:list  id="chkTemp" value="2" styles="color:blue;width:100%" onchange=""> 
					            <data> LIST|1|Full Name|2|Emp ID|3|Card ID|4|Person ID</data> 
			            </gw:list>
		            </td>
		            <td colspan=4 style="border:0"><gw:textbox id="txtTemp" styles="color:blue;width:100%"  onenterkey ="OnSearch()"  /></td>
		            <td colspan=2 style="border:0" align="right"><gw:imgBtn id="ibtnSearch"  alt="Search"  img="search" text="Search"  onclick="OnSearch()" /></td>
		            
				</tr >
				<tr  style="border:0;height:5%">
		            <td colspan=1 style="border:0" align="right" >Report Type</td>
		            <td colspan=6 style="border:0"><gw:list  id="lstReport_Type" value="rpt_Emp_Record.aspx" styles="color:blue;width:100%" onchange=""> 
					             <data><%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chae00080' order by seq")%></data>
			            </gw:list></td>
		            <td colspan=2 style="border:0" align="right"><gw:imgBtn id="ibtnReport" alt="C.V Report" img="excel" onclick="OnReport()" /> </td>
		            
				</tr >
		        <tr  style="border:1;height:90%">
		            <td colspan=9 style="width:100%;height:100%">
		               <table border=1 width=100% style="height:100%" cellspacing=0 border=0>
		                    <tr>
		                        <td>
		                            <gw:grid   
			                        id="grdEmployee"  
			                        header="_PK|V|Full Name|Emp ID|Join DT|PERSON ID"
			                        format="0|3|0|0|4|0"  
			                        aligns="0|0|0|0|0|0"
			                        defaults="|||||"  
			                        editcol="0|1|0|0|0|0"  
			                        widths="0|300|2000|1200|1200|1200"  
			                        styles="width:100%; height:100%"   
			                        sorting="T"   oncellclick ="OnClickRow()"
			                        param="0,1,2,3,4,5"   />
		                        </td>
		                    </tr>
		               </table>
		            </td>
		        </tr>
	        </table>
	    </td>     
        <td  id="idRightDiv" align="top" height="100%">
         
            <table  valign="top" border=0 cellpadding=0 cellspacing=0 width='100%' style="height:100%" > 
			    <tr style="height:5%" >
				    <td width="18%" align="right">Emp ID</td>
				    <td width="20%"> <gw:textbox id="txtEmpID"  styles='width:100%' /></td>
				    <td width="15%"  align="right">Old Code</td>
				    <td width="17%"> <gw:textbox id="txtOldCode" styles='width:100%' /></td>
				    <td width="30%" style="border:0" colspan="2" rowspan="5" align="center"><gw:image id="imgFile" table="TC_FSBINARY" procedure="hr_insert_image_emp" 
                         view="/binary/ViewFile.aspx" post="/binary/PostFile.aspx" styles="width:120;height:120"  /> </td>
			    </tr>
			    <tr style="height:5%" >
				    <td  align="right"> Full Name</td>
				    <td > <gw:textbox id="txtFullName"  styles='width:100%' /></td>
				    <td   align="right">Card ID</td>
				    <td > <gw:textbox id="txtCardID" styles='width:100%' /></td>
			    </tr>
			    <tr style="height:5%" >
				    <td  align="right">Current Address</td>
				    <td colspan=3> <gw:textbox id="txtCurAdd"  styles='width:100%' /></td>
			    </tr>
			    <tr style="height:5%" >
				    <td   align="right">Permanent Address</td>
				    <td colspan=3> <gw:textbox id="txtPerAdd"  styles='width:100%' /></td>
			    </tr>
			    
    			<tr style="height:5%" >
				    <td align="right"> Organization</td>
				    <td > <gw:textbox id="txtOrganization"  styles='width:100%' /></td>
				    <td   align="right">Work Group</td>
				    <td > <gw:textbox id="txtGroup" styles='width:100%' /></td>
			    </tr>
			    <tr style="height:5%" >
				    <td  align="right">Emp Type</td>
				    <td > <gw:textbox id="txtEmpType"  styles='width:100%' /></td>
				    <td   align="right">Tel</td>
				    <td > <gw:textbox id="txtTel" styles='width:100%' /></td>
				    <td width="15%"  align="right">Sex</td>
				    <td width="15%"> <gw:textbox id="txtSex" styles='width:100%' /></td>
			    </tr>
			    <tr style="height:5%" >
				    <td align="right">Status</td>
				    <td > <gw:textbox id="txtStatus"  styles='width:100%' /></td>
				    <td   align="right">Join Date</td>
				    <td > <gw:textbox id="txtJoinDate" styles='width:100%' /></td>
				    <td   align="right">Left Date</td>
				    <td > <gw:textbox id="txtLeftDate" styles='width:100%' /></td>
			    </tr>
    			<tr style="height:5%" >
				    <td  align="right">Nation</td>
				    <td > <gw:textbox id="txtNation"  styles='width:100%' /></td>
				    <td  align="right">Birth Place</td>
				    <td > <gw:textbox id="txtBirthPlace" styles='width:100%' /></td>
				    <td align="right">Birth Date</td>
				    <td > <gw:textbox id="txtBirthDate" styles='width:100%' /></td>
			    </tr>
			    <tr style="height:5%">
				    <td align="right">Person ID</td>
				    <td> <gw:textbox id="txtPersonID"  styles='width:100%' /></td>
				    <td  align="right">Person ID Place</td>
				    <td > <gw:textbox id="txtPersonIDPlace" styles='width:100%' /></td>
				    <td align="right">Issued Date</td>
				    <td > <gw:textbox id="txtIssuedDate" styles='width:100%' /></td>
			    </tr>
			    <tr style="height:5%" >
				    <td  align="right">Position</td>
				    <td > <gw:textbox id="txtPos"  styles='width:100%' /></td>
				    <td align="right">Job</td>
				    <td > <gw:textbox id="txtJob" styles='width:100%' /></td>
				    <td align="right">Education</td>
				    <td > <gw:textbox id="txtEdu" styles='width:100%' /></td>
			    </tr>
			    <tr style="height:5%">
				    <td align="right">Ethnic</td>
				    <td > <gw:textbox id="txtEthnic"  styles='width:100%' /></td>
				    <td align="right">Religion</td>
				    <td > <gw:textbox id="txtReligion" styles='width:100%' /></td>
				    <td   align="right">Marital Status</td>
				    <td > <gw:textbox id="txtMarital" styles='width:100%' /></td>
			    </tr>
			    <tr  style="height:50%">
			        <td colspan=6 >
			            <gw:tab id="idTab"  >
				            <table  name="Experience" align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
					            <tr> 
					                <td align = top  >
						                <gw:grid   
                                            id="grdExperience"  
                                            header="_PK|_EMP_PK|NO|COMPANY'S NAME|START DATE|END DATE|POSITION|DUTIES|SALARY|REMARK"   
                                            format="0|0|0|0|0|0|0|0|1|0"  
                                            aligns="1|0|1|0|0|0|0|0|0|0"  
                                            defaults="||||||||"  
                                            editcol="0|0|0|1|1|1|1|1|1|1"  
                                            widths="1000|2500|1000|2500|1500|1500|1500|1500|1500|1500"  
                                            styles="width:100%; height:100%"   
                                            sorting="T"   
                                            param="0,1,2,3,4,5,6,7,8" /> 
					                </td> 
					            </tr>
				            </table>
				            <table  name="Education" align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
					            <tr> 
					                <td align = top  >
						                <gw:grid   
                                            id="grdEDU"  
                                            header="_PK|_EMP_PK|NO|SCHOOL NAME/MAJOR|START DATE|END DATE|MAJOR|RESULT|REMARK"   
                                            format="0|0|0|0|0|0|0|0|0"  
                                            aligns="1|0|1|0|0|0|0|0|0"  
                                            defaults="|||||||"  
                                            editcol="0|0|0|1|1|1|1|1|1"  
                                            widths="1000|500|500|3000|1500|1500|2000|2000|1500"  
                                            styles="width:100%; height:100%"   
                                            sorting="T"   
                                            /> 
					                </td> 
					            </tr>
				            </table>
				            <table  name="Family" align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
					            <tr> 
					                <td align = top  >
						                <gw:grid   
                                             id="grdFamily"  
                                            header="_PK|_EMP_PK|NO|NAME|RELATION|BIRTH DATE|JOB|SALARY|REMARK"   
                                            format="0|0|0|0|0|0|0|1|0"  
                                            aligns="1|0|1|0|0|0|0|0|0"  
                                            defaults="|||||||"  
                                            editcol="0|0|0|1|1|1|1|1|1"  
                                            widths="1000|2000|1000|2500|2000|2500|2000|1700|2000"  
                                            styles="width:100%; height:100%"   
                                            sorting="T"   
                                       /> 
						            </td>
						        </tr>
				            </table>
				            <table   name="Note" align = top  cellspacing=0 cellpadding=0 border=1 style="width:100%;height:100%;" >
					            <tr> 
					                <td align = top  >
						               <gw:grid   
                                           id="grdOther"  
                                            header="_PK|_EMP_PK|NO|NOTE 1|NOTE 2|NOTE 3|NOTE 4|NOTE 5"   
                                            format="0|0|0|0|0|0|0|0"  
                                            aligns="1|0|1|0|0|0|0|0"  
                                            defaults="||||||"  
                                            editcol="0|0|0|1|1|1|1|1"  
                                            widths="1000|2500|1000|2500|2500|2500|2500|2500"  
                                            styles="width:100%; height:100%"   
                                            sorting="T"   
                                            param="0,1,2,3,4,5,6,7" /> 
					                </td> 
					            </tr>
				            </table>
				        </gw:tab>
			        </td>
			    </tr>
			</table> 
        </td>
    </tr>
</table>
	<img status="expand" id="imgArrow" src="../../../system/images/prev_orange.gif" style="cursor:hand;position:absolute;left:0;top:0;" onclick="OnToggle()"  /> 
<gw:textbox id="txtEmpPK" styles="display:none"/>
<gw:textbox id="txtOrg" styles="display:none"/>	
<gw:textbox id="txtOrgData" styles="display:none"/>
<gw:textbox id="txtUpperOrg" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="txtPhoto_PK" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txt_sal_security" styles="display:none"/>
<gw:textbox id="txtOrg_tmp_pk" text="" styles="display:none"  />
<gw:textbox id="txt_popup_yn" styles="display:none"/>
<gw:textbox id="txt_popup_emppk" text="" styles="display:none"  />
</body>
</html>
