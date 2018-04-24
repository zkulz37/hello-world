<!-- #include file="../../../system/lib/form.inc"  -->
<%  ESysLib.SetUser(Session("APP_DBUSER"))%>
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var v_language = "<%=Session("SESSION_LANG")%>";
var p_status="<%=Request.querystring("p_status")%>";
var p_request="<%=Request.querystring("p_request")%>";
var p_flag=true;



var g_pk = 0;
    g_id = 1,
    g_fullname =2,
    g_sex =3,
    g_birth_dt = 4,
    g_birth_place =5,
    g_personal_id =6,
    g_issue_dt = 7,
    g_place_id =8,
    g_ethenic =9,
    g_cur_address =10,
    g_per_address =11,
    g_hand_phone = 12,
    g_home_phone = 13,
    g_other_contact =14,
    g_email =15,
    g_education = 16,
    g_graduation_school =17,
    g_major =18,
    g_graduation_kind = 19,
    g_other_certificate = 20,
    g_foreign_language = 21,
    g_language_certifiate = 22,
    g_other_language = 23,
    g_computer_skill =24,
    g_experience = 25,
    g_other_description =26,
    g_organization =27,
    g_position =28,
    g_job = 29,
    g_salary = 30,
    g_other_request= 31,
    g_receive_dt = 32,
    g_introduction = 33,
    g_expiry_dt = 34,
    g_full_profile= 35,
    g_profile_note =36,
    g_itv_dt1 = 37,
    g_result1 = 38,
    g_remark1 = 39,
    g_itv_dt2 = 40,
    g_result2 = 41,
    g_remark2 = 42,
    g_itv_dt3 = 43,
    g_result3 = 44,
    g_remark3 = 45,
    g_pass = 46,
    g_working_dt = 47,
    g_emp_type=48,
    g_nation =49,
    g_rec_pk =50,
    g_close_yn = 51 ,
    g_status_get =52, 
	g_province = 53,
	g_ncountry =54,
	g_marital_status = 55,
	g_intro_pk =56,
	g_intro_nm = 57;



function BodyInit()
{ 	
    grdEmployee.GetGridControl().ScrollTrack=true;
    if (v_language!="ENG")
        System.Translate(document);
     iduser_pk.text = "<%=session("USER_PK")%>";
     txtHr_level.text= "<%=session("HR_LEVEL")%>";
      txtHr_level.text= "<%=session("HR_LEVEL")%>";
       lstPass.value= "<%=session("p_status")%>";
    lstPass.value=p_status+"";
	lstRequest.value=p_request+"";
	
	if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
          datUser_info.Call();     	    
	else if(p_request!="ALL")
    {
        tblabel.style.display="none";
        p_flag=false;
        datEmployeePopup.Call();
    
    }
    
    BindingDataList();
	
}
function BindingDataList()
{
    var tmp="#M;Male|#F;Female";
    grdEmployee.SetComboFormat(g_sex,tmp);//sex

    var t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0021' order by code_nm")%>";
       grdEmployee.SetComboFormat(g_birth_place ,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0021' order by code_nm")%>";
       grdEmployee.SetComboFormat(g_birth_place ,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0017' order by code_nm")%>";
       grdEmployee.SetComboFormat(g_emp_type ,t1);
       t1 = "<%=ESysLib.SetGridColumnDataSQL("select pk,org_nm from tco_org where del_if=0 order by org_nm")%>";
       grdEmployee.SetComboFormat(g_organization ,t1);  //organization

       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0014' order by code_nm")%>";
       grdEmployee.SetComboFormat(g_place_id ,t1); // place id

       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0021' order by code_nm")%>";
       grdEmployee.SetComboFormat(g_birth_place ,t1); // birth place

        t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0010' order by code_nm")%>";
       grdEmployee.SetComboFormat(g_job ,t1); // job

       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>";
       grdEmployee.SetComboFormat(g_position ,t1); // position

       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm")%>";
       grdEmployee.SetComboFormat(g_nation ,t1); // Nation

       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0015' order by code_nm")%>";
       grdEmployee.SetComboFormat(g_ethenic ,t1); // Ethnic

       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0011' order by code_nm")%>";
       grdEmployee.SetComboFormat(g_education ,t1); // Education

       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0159' order by code ")%>";
       grdEmployee.SetComboFormat(g_result1,t1);

       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0159' order by code ")%>";
       grdEmployee.SetComboFormat(g_result2,t1);

       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0159' order by code ")%>";
       grdEmployee.SetComboFormat(g_result3,t1);

       t1 = "<%=ESysLib.SetGridColumnDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0159' order by code ")%>";
       grdEmployee.SetComboFormat(g_pass ,t1);
}
function OnSearch()
{
    datEmployeePopup.Call("SELECT");
}
function OnSelect()
{ if(p_flag==true)
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
    }    
    else 
    {
        obj=null;
    }
	window.returnValue = obj; 
	window.close();
}
function OnAdd()
{
    var row = event.row;
    var data = Array();
    for(var i =0 ; i< grdEmployee.cols ; i++)
    {
        data[i] = grdEmployee.GetGridData(row,i);
    }
    if ( data !=null )
    {
		window.returnValue =  data;
		window.close();
	}

}
function EXITOnClick()
{   
	OnExit();
}
//------------------------------------------------------------------------------------
function OnDataReceive(obj)
{
    if(obj.id=="datUser_info")
    {
        if(p_request!="ALL")
        {
            tblabel.style.display="none";
            p_flag=false;
            datEmployeePopup.Call();
        
        }
    }
    if(obj.id=="datEmployeePopup")
    {
       auto_resize_column(grdEmployee,0,grdEmployee.cols-1,10);   
       lblRecord.text= (grdEmployee.rows -1)+" records";

       for(var i=1; i<grdEmployee.GetGridControl().rows; i++)
       {
            if(grdEmployee.GetGridData(i,g_status_get)=="Y")
            {
                grdEmployee.SetCellBgColor(i,g_pk,i ,g_status_get,0xFFCC66);
            }
       }
    }   
}     
function OnChangeDept()
{
    
}
function auto_resize_column(obj,col1,col2,font_size)
{
  if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

//----------------------------------------------------
function OnShowPopup()
{

        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:10;dialogTop:330;edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {
			lstOrg.value = obj;
            //txtUpperOrg.text=obj;
            //datOrgData.Call();
            
        }
}
//----------------------------------------------------

</script>
<body bottommargin="0" topmargin="0" leftmargin="0" rightmargin="0" >
<!-- MainTable -->
<gw:data id="datUser_info" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="list" procedure="HR_SP_SEL_USER_ROLE2"  > 
                <input>
                    <input bind="iduser_pk" />
                </input> 
                <output>
                    <output bind="lstOrg" />
                </output>
            </dso> 
        </xml> 
</gw:data>

<gw:data id="datEmployeePopup" onreceive="OnDataReceive(this)" > 
    <xml> 
        <dso  type="grid" function="HR_SEL_REC_EMP_POPUP"> 
            <input> 
                <input bind="lstOrg" /> 
                <input bind="lstPosition" /> 
                <input bind="chkTemp" /> 
                <input bind="txtTemp" /> 
				<input bind="lstJob" />
				<input bind="lstPass" />
				<input bind="lstRequest" />
				<input bind="dtReceiveFrom" />
				<input bind="dtReceiveTo" />
				<input bind="dtExpiryFrom" />
				<input bind="dtExpiryTo" />
				<input bind="dtInterview1From" />
				<input bind="dtInterview1To" />
				<input bind="dtInterview2From" />
				<input bind="dtInterview2To" />
				<input bind="dtInterview3From" />
				<input bind="dtInterview3To" />
				<input bind="lstClose" />
				
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
						        <td colspan="7" align="right"><font color="black"><b >Organization</b></td>
						        <td colspan="15"><gw:list id="lstOrg" styles="color:black;width:100%" value="ALL" > 
									   <data>
											<%=ESysLib.SetListDataSQL("select a.pk,a.org_nm from tco_org a where a.del_if=0 and a.org_type='06' order by a.seq")%>|ALL|Select All
										</data>
								   </gw:list > 
						        </td>
						        <td colspan="5" align="right"><font color="black"><b>Position </b>
						        </td>
						        <td colspan="10" > <gw:list  id="lstPosition" value='ALL' maxlen = "100" styles='width:100%' >
                                             <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm")%>|ALL|Select All
                                             </data></gw:list>
                                             </td>
                                <td colspan="4" align="right">
							        Status Rec
						        </td>
						        <td colspan= "4" >
                                    <gw:list  id="lstClose" value="N" styles='width:100%' onchange=""> 
									        <data>LIST|Y|Yes|N|No|ALL|Select ALL</data> 
							        </gw:list>
                                </td>
						        
						        <td colspan="3" align="right" >
                                    <gw:imgBtn id="ibtnSearch" alt="Search" img="Search" text="Search" onclick="OnSearch()" />
                                </td>
						        <td colspan="3" align="right">
							       <gw:imgBtn id="ibtnExit" alt="Exit" img="Cancel" text="Exit" onclick="OnExit()" />
						        </td>
					        </tr>
							<tr>   
						        <td colspan="7" align="right"><font color="black"><b >Job </b></td>
						        <td colspan="15"><gw:list id="lstJob" styles="color:black;width:100%" value="ALL" onchange=""> 
									   <data>
											<%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0010' order by code_nm")%>|ALL|Select All ...
										</data>
								   </gw:list > 
						        </td>
								
						        <td colspan="5" align="right"><font color="black"><b>Search by </b>
						        </td>
						        <td colspan="5">
							        <gw:list  id="chkTemp" value="2" styles='width:100%' onchange=""> 
									        <data>LIST|1|Name|2|Emp ID|4|Per ID</data> 
							        </gw:list>
						        </td>
        						
						        <td colspan="5"> 
							        <gw:textbox id="txtTemp" onenterkey   ="OnSearch()" styles='width:100%'/>
						        </td>
                                 <td colspan="4" align="right"> 
							        <b>Pass </b>
						        </td>
						         
						        <td colspan="4">
							        <gw:list  id="lstPass" value="ALL" styles='width:100%' onchange=""> 
									        <data>
                                                <%= ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0159' order by code")%>|ALL|Select All
                                            </data> 
							        </gw:list>
						        </td>
                                <td colspan="5" align="right"><font color="black">
						        </td>
        						
					        </tr>
					        <tr>   
						        <td colspan="7" align="right" style="white-space:nowrap"><font color="black"><b >Rec Request </b></td>
						        <td colspan="15"><gw:list id="lstRequest" styles="color:black;width:100%" value="ALL" onchange=""> 
									   <data>
											<%=ESysLib.SetListDataSQL("select a.pk,app_no || ' - ' || (select v.code_nm from vhr_hr_code v where  v.id='HR0008' and v.code=a.pos_type )from thr_rec_request t ,thr_rec_request_detail  a where a.del_if=0 and t.del_if=0 and a.thr_rec_request_pk =t.pk and nvl(a.app_status,'01')='03' order by t.app_no ")%>|ALL|Select All ...
										</data>
								   </gw:list > 
						        </td>
						     <td colspan="5" align=right style="white-space:nowrap"> Recieve DT</td>
						         <td colspan="4" style="white-space:nowrap"> 
							        <gw:datebox id="dtReceiveFrom"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
							       <td align=center> ~</td>
							    <td colspan=4> <gw:datebox id="dtReceiveTo"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
						        </td>
						        <td colspan="14" style="white-space:nowrap" align=right> Expiry DT
						        <gw:datebox id="dtExpiryFrom"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
						        ~ <gw:datebox id="dtExpiryTo"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
						        </td>
    
					        </tr>
					        
					        
					          <tr>   
					            
						        <td colspan="10" align="right"><font color="black"><b >Interview DT1</b></td>
						        <td colspan="5" style="white-space:nowrap"> 
							        <gw:datebox id="dtInterview1From"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
							       <td colspan="2" align=center> ~</td>
							    <td colspan=5> <gw:datebox id="dtInterview1To"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
						        <td colspan="5" align="right" style="white-space:nowrap"><font color="black"><b >Interview DT2</b></td>
						        <td colspan="4" style="white-space:nowrap"> 
							        <gw:datebox id="dtInterview2From"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
							       <td colspan="1" align=center> ~</td>
							    <td colspan=4> <gw:datebox id="dtInterview2To"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
						        
						        <td colspan="14" style="white-space:nowrap" align=right>
						        <font color="black"><b >Interview DT3</b>
						        <gw:datebox id="dtInterview3From"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
						        ~
						        <gw:datebox id="dtInterview3To"  maxlen = "10" text="" styles='width:100%'lang="<%=Session("Lang")%>" nullaccept onchange="" />
						        </td>
						          
						       
					        </tr>
					        <tr>   
						        <td colspan="30" id="tblabel" align="left" valign="middle"><font color="black"><b style="color=#FF00CC; font-size:14">Double click on row to select</b></td>
						        <td colspan="20"><gw:label id="lblRecord" text="0 record(s)" styles="width:100%" ></gw:label></td>
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
			    header="_pk|ID|Full Name|Sex|Birth DT|Birth Place|Personal ID|Issue DT|Place ID|Ethnic|Permanent Address|Current Address|Hand Phone|Home Phone|Other Contact|Email|Education |Graduation School|Major|Graduation Kind|Other Certificate|Foreign Language|Language Certificate|Other Language|Computer  Skill|Experience|Other Description|Organization|Position|Job|Salary|Other Request|Receive DT|Introduction |Expiry DT|Full Profile| Profile Note|Interview DT1|Result 1|Remark 1|Interview DT2|Result 2|Remark 2|Interview DT3|Result 3|Remark 3|Pass |Working DT|Emp Type|Nation|_REC_PK|CLOSE_YN|_STATUS_GET|_PROVINCE|_NCOUNTRY|_MARITAL|_INT_PK|_INT_NM "   
			    format="0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|0|0|0|0|0|0"  
			    aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    defaults="|||||||||||||||||||||||||||||||||||||||||||||||||||||||||"  
			    editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
			    widths="1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|0|0|0|0|0|0"  
			    styles="width:100%; height:100%"   
			    sorting="T"   
			    autosize="true"
                acceptnulldate='T'
			    oncelldblclick ="OnAdd()" /> 
    	
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

				
