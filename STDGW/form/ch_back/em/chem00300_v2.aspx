<!-- #include file="../../../system/lib/form.inc"  -->
<%ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
        <title>Evaluation Checking</title>
    </head>
    <script>
			var l_Eva_Period;
			var org_cal;
          var rpt_no = 0;
        var p_Organization  = 0, 
			p_Eva_Term	  = 1,
			p_Eva_Group	  = 2,
			p_Emp_ID		= 3,
			p_Emp_Name    = 4,
			p_Status		= 5,
			p_Total_Score = 6,
			p_Eva_Emp_PK  = 7;
		//-----------------------------------//
		var g_eva_emp_pk =0
			g_organization =1,
			g_work_group=2,
			g_eva_term=3,
			g_eva_group=4,
			g_emp_id=5,
			g_emp_name=6,
			g_eva_status=7,
			g_hr_status=8,
			g_eva_factor=9,
			g_weight=10,
			g_standard_score=11,
			g_hr_score=12,
			g_final_score=13,
			g_hr_opinion=14;
			

        var v_language = "<%=Session("SESSION_LANG")%>";
        function BodyInit()
        {          
            if (v_language!="ENG")
                System.Translate(document);    
           // iduser_pk.text = "<%=session("USER_PK")%>";
           // txtHr_level.text= "<%=session("HR_LEVEL")%>";   
			BindingDataList();
			dataEva_Group.Call();
			
        }
        function BindingDataList()
        {      	
			var ctrl = idGridEvaDetail2.GetGridControl();
			ctrl.MergeCells = 1;
			ctrl.MergeCol(g_eva_emp_pk) = true;
			ctrl.MergeCol(g_organization) = true;
			ctrl.MergeCol(g_work_group) = true;
			ctrl.MergeCol(g_eva_term) = true;
			ctrl.MergeCol(g_eva_group) = true;
			ctrl.MergeCol(g_emp_id) = true;
			ctrl.MergeCol(g_emp_name) = true;
			ctrl.MergeCol(g_eva_status) = true;
			ctrl.MergeCol(g_hr_status) = true;
			ctrl.MergeCol(g_hr_opinion) = true;
			
        }
        
        function auto_resize_column(obj,col1,col2,font_size)
        {
            if(font_size!=0)
                obj.GetGridControl().FontSize =font_size;   
            obj.GetGridControl().AutoSize(col1,col2,false,0);  
        }
		function OnShowPopup(m)
		{     
			var strcom;
			var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
			//var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
			var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
			if (obj!=null)
			{  
				org_cal = m;
				if(m==1)
				{
				lstOrg_Code.value = obj;
				
				}else{
				lstOrg_Code_detail.value = obj;
				
				}
				
				
			}
		}
        function OnDataReceive(obj)
        {
            if(obj.id=="dataEva_Group")
            {
				txtEva_Group.text=txtEva_Group.text+"|ALL|Select All";
				if(l_Eva_Period==0)
				{
					lstEva_Group.SetDataText(txtEva_Group.text);
					lstEva_Group.value="ALL";
				}else{
					lstEva_Group_detail.SetDataText(txtEva_Group.text);
					lstEva_Group_detail.value="ALL";
				}
            }     
            if(obj.id=="datchae00300")
            {
                //lblRecord.text=idGridEvaDetail.rows-1+" Rec(s)";
				auto_resize_column(idGridEva, 0, idGridEva.cols - 1, 9);
				idGridEvaDetail.ClearData();
            }
			if(obj.id=="datchae00300_v2")
			{
				auto_resize_column(idGridEvaDetail2, 0, idGridEvaDetail2.cols - 1, 9);
				 idGridEvaDetail2.Subtotal( 0, 2, 0, '10!12');
				//idGridEvaDetail2.ClearData();
			}
           
			
        }

        function OnSearch(val)
        {
			if(val==0)
			{
				datchae00300.Call("SELECT");
			}else{
				datchae00300_v2.Call("SELECT");
			}
        }
        function OnChangeEva_Period(val)
        {
			
				l_Eva_Period = val;
			dataEva_Group.Call();
        }
		function OnChangeOrg()
		{
			datGet_workgroup.Call();
		}
		function OnToggle()
		{
			if (imgEvaDetail.status == "expand")
			{
				imgEvaDetail.status = "collapse";
				EvaDetial.style.display = "none";
				imgEvaDetail.src = "../../../system/images/iconmaximize.gif";
				imgEvaDetail.alt = "Show Eva Detail";

			}
			else
			{

				imgEvaDetail.status = "expand";
				EvaDetial.style.display = "";
				imgEvaDetail.src = "../../../system/images/close_popup.gif";
				imgEvaDetail.alt = "Close Eva Detail";
			}
			
		}
		
		function OnPrint(objrp)
		{
			var url=System.RootURL;
				switch (objrp)
				{
				
					case 1:
					{
						url=url + '/reports/ch/em/'+ lstReportType.value+'?p_Org_Code=' + lstOrg_Code.value + '&p_Grp_Code=' + lstGrp_Code.value + '&p_Searchby=' + lstTemp.value + '&p_Search=' + txtTemp.text + '&p_EvaMaster=' + lstEvaMaster.value + '&p_Eva_Group=' + lstEva_Group.value + '&p_Status=' + lstStatus.value;
						break;
					}
					case 2:
					{
						url=url + '/reports/ch/em/'+ lstReportType2.value+'?p_Org_Code=' + lstOrg_Code_detail.value + '&p_Grp_Code=' + lstGrp_Code_detail.value + '&p_Searchby=' + lstTemp_detail.value + '&p_Search=' + txtTemp_detail.text + '&p_EvaMaster=' + lstEvaMaster_detail.value + '&p_Eva_Group=' + lstEva_Group_detail.value + '&p_Status=' + lstStatus_detail.value;
						break;
					}
					
				}
				
				window.open(url); 
		}
    </script>
    <body style=" margin-bottom:0; margin-top:0; margin-right:0; margin-left:0" >
				   
	  <!-------------------data control----------------------->			   
    <gw:data id="dataEva_Group" onreceive="OnDataReceive(this)"  > 
	    <xml> 
		    <dso  type="list" procedure="hr_sel_eva_group_v2" > 
			    <input>
				    <input bind="lstEvaMaster" /> 
			    </input> 
			    <output>
				    <output bind="txtEva_Group" />
			    </output>
		    </dso> 
	    </xml> 
    </gw:data> 
	
    <!------------------------------------------>
	<gw:data id="datchae00300" onreceive="OnDataReceive(this)" > 
            <xml> 
                <dso  type="grid"  parameter="" function="hr_sel_chem00300_v2" procedure=""> 
                    <input bind="idGrid" >
                        <input bind="lstOrg_Code" />  
                        <input bind="lstGrp_Code" />  
                        <input bind="lstTemp" />  
                        <input bind="txtTemp" />  
                        <input bind="lstEvaMaster" />  
                        <input bind="lstEva_Group" />  
                        <input bind="lstStatus" />  		
                    </input>
                    <output  bind="idGridEva" />
                </dso> 
            </xml> 
    </gw:data>
	<gw:data id="datchae00300_v2" onreceive="OnDataReceive(this)" > 
            <xml> 
                <dso  type="grid"  parameter="" function="hr_sel_chem00300_detail_v2" procedure=""> 
                    <input bind="idGrid" >
                        <input bind="lstOrg_Code_detail" />  
                        <input bind="lstGrp_Code_detail" />  
                        <input bind="lstTemp_detail" />  
                        <input bind="txtTemp_detail" />  
                        <input bind="lstEvaMaster_detail" />  
                        <input bind="lstEva_Group_detail" />  
                        <input bind="lstStatus_detail" />  		
                    </input>
                    <output  bind="idGridEvaDetail2" />
                </dso> 
            </xml> 
    </gw:data>
    
<gw:data id="datOrgData" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="list" procedure="sp_pro_dept_data_all" > 
                <input>
                    <input bind="txtUpperOrg" /> 
                </input> 
                <output>
                    <output bind="txtOrgData" />
                </output>
            </dso> 
        </xml> 
</gw:data>
<gw:tab id="tabMain"  border=1 style="width:100%;height:100%;" onpageactivate=""  >   
      <table name="Eva Checking Summary" width="100%" cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;">
            <tr style="width:100%;height:1%">
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            </tr>
            <tr style="width:100%;height:5%" valign="center" >                            
                            <td colspan=10 style= "height:5%" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(1)" href="#tips" >Oganization</a></td>  
                            <td colspan=15 align="left" style="width=15%" >
                                <gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeOrg()" >
                                    <data>
                                        <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk)  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                    </data>
                                </gw:list>
                            </td>
                            <td  colspan=10 align="right" >WorkGroup</td>
                            <td  colspan=10 align="left" style="width=10%" ><gw:list  id="lstGrp_Code" value='ALL' maxlen = "100" styles='width:100%' >
                                <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data></gw:list>
                            </td>
                            <td colspan=10 align="right" >Search By</td>
                            <td colspan=10 style="width=15%">
					            <gw:list  id="lstTemp" value="1" styles='width:100%' onchange=""> 
							            <data>LIST|1|Emp ID|2|Name</data> 
					            </gw:list>
				            </td>
                            <td colspan=15 style="width=15%" > 
					            <gw:textbox id="txtTemp" onenterkey   ="OnSearch(0)" styles="width:100%"/>
				            </td>
                            <td colspan=5>
                                <gw:icon id="btnSearch" img="in" text="Search" onclick="OnSearch(0)" />
                            </td>
                            <td colspan=15>&nbsp;</td>
                           
              </tr>
                <tr style="border:0;width:100%;height:5%" valign="center" >
                        <td  colspan=10 align="right" >Eva Period</td>
                        <td colspan=15 >
					        <gw:list  id="lstEvaMaster" styles='width:100%' onchange="OnChangeEva_Period(0)"> 
							        <data><%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where  del_if=0 order by 2 desc")%></data> 
					        </gw:list>
				        </td>
                           
                        <td colspan=10  align="right" >Eva.Group</td>
                        <td colspan=10  align="left" >
                            <gw:list  id="lstEva_Group" value='ALL' styles='width:100%'><data>|ALL|Select All</data></gw:list>
                        </td>
					    <td colspan=10 align="right">Status</td>
				        <td colspan=10 >
                            <gw:list  id="lstStatus" value="ALL" styles='width:98%' onchange=""> 
							        <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0103' order by code")%>|ALL|Select All</data> 
					        </gw:list></td>
                        </td>
						
                        <td colspan=15 align=right><gw:list  id="lstReportType" styles="color:blue;width:100%" onchange=""> 
					             <data><%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chem00300_v2' and char_4='1' order by seq")%></data>
			                    </gw:list>
                        </td>	
					    <td colspan=5 align=center>
                            <gw:imgbtn id="btnPrint" img="excel" alt="Print" text="Print" onclick="OnPrint(1)" />
                        </td>
                        <td colspan=15 >&nbsp;</td>
						    
                </tr>
                           
                <tr style="border:1;width:100%;height:89%" valign="top">
                    <td colspan=100  style="width:100%"> 
                            <gw:grid   
                            id="idGridEva"  
                            header="Organization|Work Group|Eva Term|Eva Group|Emp ID|Emp Name|Eva Status|Total Score |_Eva_Emp_PK"   
                            format ="0|0|0|0|0|0|0|0"  
                            aligns ="0|0|0|0|0|0|0|0"
                            defaults="|||||||"
                            editcol="|0|0|0|0|0|0|0"
                            widths="2000|1500|1500|1500|1500|1500|1500|1500"
                            styles="width:100%; height:100%"   acceptNullDate
							oncellclick="ShowDetailEva();"
							oncelldblclick =""
                            sorting="T"
									
							/> 
                    </td>
                </tr>
        </table>
 <table name="Eva Checking Detail" width="100%" cellpadding="0" cellspacing="0" border=0 style="width:100%;height:100%;">
            <tr style="width:100%;height:1%">
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
                <td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td><td width="1%"></td>
            </tr>
            <tr style="width:100%;height:5%" valign="center" >                            
                           <td colspan=10 style= "height:5%" align="right" ><a title="Click here to show Organization" onclick="OnShowPopup(2)" href="#tips" >Oganization</a></td>  
                            <td colspan=15 align="left" style="width=15%" >
                                <gw:list  id="lstOrg_Code_detail" value='ALL' maxlen = "100" styles='width:100%'onchange="OnChangeOrg()" >
                                    <data>
                                        <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk)  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                                    </data>
                                </gw:list>
                            </td>
                            <td colspan=10  align="right" >WorkGroup</td>
                            <td colspan=10 align="left" style="width=10%" ><gw:list  id="lstGrp_Code_detail" value='ALL' maxlen = "100" styles='width:100%' >
                                <data><%=ESysLib.SetListDataSQL("select a.PK,a.WORKGROUP_NM from thr_work_group a where a.del_if=0 order by a.WORKGROUP_NM")%>|ALL|Select All</data></gw:list>
                            </td>
                            <td colspan=10 align="right" >Search By</td>
                            <td colspan=10 style="width=10%">
					            <gw:list  id="lstTemp_detail" value="1" styles='width:100%' onchange=""> 
							            <data>LIST|1|Emp ID|2|Name</data>
					            </gw:list>
				            </td>
                            <td colspan=15  style="width=10%" > 
					            <gw:textbox id="txtTemp_detail" onenterkey   ="OnSearch(1)" styles="width:100%"/>
				            </td>
                           
                            <td colspan=5 >
                                <gw:imgbtn id="btnSearch_detail" img="search" alt="Search" onclick="OnSearch(1)" />
                            </td>
                            <td colspan=15 >&nbsp;</td>
                            
               </tr>
                <tr style="border:0;width:100%;height:3%" valign="center" >
                    <td colspan=10  align="right" >Eva Period </td>
                    <td colspan=15 >
					    <gw:list  id="lstEvaMaster_detail" styles='width:100%' onchange="OnChangeEva_Period(1)"> 
							    <data><%=ESysLib.SetListDataSQL("select pk,EVA_YYYY ||'-'|| EVA_SEQ from thr_eva_master where  del_if=0 order by 2 desc")%></data> 
					    </gw:list>
				    </td>
                           
                    <td colspan=10  align="right" >Eva.Group</td>
                    <td colspan=10  align="left" >
                        <gw:list  id="lstEva_Group_detail" value='ALL' styles='width:100%'><data>|ALL|Select All</data></gw:list>
                    </td>
					<td colspan=10 align="right">Status</td>
				    <td colspan=10 >
                        <gw:list  id="lstStatus_detail" value="ALL" styles='width:95%' onchange=""> 
							    <data><%=ESysLib.SetListDataSQL("select code,CODE_NM from vhr_hr_code where id='HR0103' order by code")%>|ALL|Select All</data> 
					    </gw:list></td>
                    </td>

                    <td colspan=15 align=right><gw:list  id="lstReportType2" styles="color:blue;width:100%" onchange=""> 
					             <data><%=ESysLib.SetListDataSQL("select char_2,CODE_NM from vhr_hr_code where id='HR0156' and char_1='chem00300_v2' and char_4='2' order by seq")%></data>
			            </gw:list></td>

					<td colspan=5 >
                        <gw:imgbtn id="btnPrint_detail" img="excel" alt="Print" text="Print" onclick="OnPrint(2)" />
                    </td>
					<td colspan=15 >&nbsp;</td>
              
                </tr>
                           
                <tr style="border:1;width:100%;height:70%" valign="top">
                    <td colspan=100  style="width:100%"> 
                            <gw:grid   
                            id="idGridEvaDetail2"  
                            header="_Eva_Emp_PK|Organization|Work Group|Eva Term|Eva Group|Emp ID|Emp Name|Eva Status|HR Status|Eva Factor|Weight|Standard Score|HR Score|_FinalScore|HR Opinion"   
                            format ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                            aligns ="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                            defaults="||||||||||||||"
                            editcol="|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
                            widths="2000|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500|1500"
                            styles="width:100%; height:100%"   acceptNullDate
							oncellclick="ShowDetailEva();"
							oncelldblclick =""
                            sorting="T"
									
							/> 
                    </td>
                </tr>
        </table>			
</gw:tab>		
    </body>

    <gw:textbox id="iduser_pk" styles="display:none"/>
    <gw:textbox id="txtHr_level" styles="display:none"/>
    <gw:textbox id="txtReport_tmp" styles="display:none"/>
    <gw:textbox id="txtOrg_tmp_pk" styles="display:none"/>
	<gw:textbox id="txtEvaemp" value="" styles="display:none"/>
	<gw:textbox id="txtEva_Group" value="" styles="display:none"/>
	 <gw:textbox id="txtOrgData" styles="display:none"/>
	<gw:textbox id="txtUpperOrg" styles="display:none"/>
</html>
