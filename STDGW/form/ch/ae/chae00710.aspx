<!-- #include file="../../../system/lib/form.inc"  -->
  <%  ESysLib.SetUser(Session("APP_DBUSER"))%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var arr;
var p_job_01=5;
var p_job_02=6;
var p_job_03=7;
var p_job_04=8;
var p_job_05=9;
var v_language = "<%=Session("SESSION_LANG")%>";


function BodyInit()
{
    if (v_language!="ENG")
        System.Translate(document);	
    grdData.GetGridControl().ScrollTrack=true;
    var tmp="#Y;Yes|#N;No";
    grdData.SetComboFormat(6,tmp);//money keeper
    iduser_pk.text = "<%=session("USER_PK")%>";
    txtHr_level.text= "<%=session("HR_LEVEL")%>";
    menu_id.text=System.Menu.GetMenuID();
    ChangeColorItem(lstOrg_Code.GetControl());

    datCheck_View.Call();
    	    
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
//----------------------------------

function OnDataReceive(obj)
{
        if(obj.id == "datCheck_View")
        {
            if(txtFlag_View.text == 'Y')
            {
                ibtnDel.style.display = "none";
                ibtnSave.style.display = "none";                
            }
            if((Trim(iduser_pk.text)!="")&&(txtHr_level.text=="1")) //QUYEN BI GIOI HAN 
	        {
                datUser_info.Call();     	    
	        }
        }
       else if (obj.id=="datJob_Desc")
       {
            lblRecord.text=grdData.rows-1 + " record(s).";
       }       
       else if (obj.id=="datFind_Report")
        {
            var url;
            url =System.RootURL + '/reports/ch/ae/'+txtReport_tmp.text+'?p_user=' + user + '&p_org=' + lstOrg_Code.value + '&p_ExistLag=' + lstExist_Flag.value;
        }
}     
//------------------------------------------------------------------------------------

function OnSearch()
{
    datJob_Desc.Call("SELECT");  
  
}

 //------------------------------------------
function OnSave()
{
    if (confirm("Do you want to save?"))
        datJob_Desc.Call();
}
 //------------------------------------------
function OnDelete()
{
    if (confirm("Do you want to delete?"))
        grdData.DeleteRow();
}

//--------------------
function OnSetHeader()
{
    
    var ctrl = lstJob_Pos.GetControl();
    for ( var i =  0 ; i < ctrl.length ; i++ )
	{
		var tmp;
		tmp=ctrl.options.item(i).text;
		grdData.SetGridText(0,i+p_job_01,tmp);
	}
}
//----------------------------------
function OnShowPopup(m)
{     
        var strcom;
        var fpath = System.RootURL + "/form/ch/ae/chae00010_org.aspx?";
        //var obj  = System.OpenModal(  fpath , 300 , 200 , 'resizable:yes;status:yes');
        var obj=window.showModalDialog(fpath,this,'titleb:0;resizable:no;status:no;dialogWidth:20;dialogHeight:20;dialogLeft:'+window.event.screenX+';dialogTop:'+window.event.screenY+';edge:sunken;scroll:yes;unadorned:yes;help:no');
        if (obj!=null)
        {  
			lstOrg_Code.value = obj;
            txtUpperOrg.text=obj;
            datOrgData.Call();						            
        }
}

function OnSetGrid(obj)
{
    ctrl=grdData.GetGridControl();
    var scol;
    var svalue;    
    if(obj==1)
    {             
        scol=lstYN.value;
        svalue=lstYN_Flag.value;

        if(scol==1)
        {
            scol=g_existed_lag;
        }
         if(scol==2)
        {
            scol=g_noxious_flag;
        }               
    }
    else
    {
        scol=lstText.value;
        svalue=txtInput.text;

        if(scol==1)
        {
            scol=g_job_description;
        }
         if(scol==2)
        {
            scol=g_remark;
        }         
    }
    
    if(grdData.rows>1)
    { 
           
        if (ctrl.SelectedRows>0) 
        {              
            for(var i=0;i<ctrl.SelectedRows;i++)
            {                                    
                    grdData.SetGridText(ctrl.SelectedRow(i),scol,svalue);                    
            }
        }
    }             
}


function OnReport()
{
    txtReport_tmp.text="rpt_job_description.aspx";
    datFind_Report.Call();
}



</script>

<body>
<gw:data id="datJob_Desc" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  parameter="0,1,2,3,5,6,7,8,9" function="HR_sp_sel_job_desc " procedure="HR_sp_upd_job_desc " > 
                 <input bind="grdData" >
                    <input bind="lstOrg_Code" />
                     <input bind="lstExist_Flag" /> 
                </input>
                <output  bind="grdData" />
            </dso> 
        </xml> 
</gw:data>
<!-------------------data control----------------------->

<gw:data id="datCheck_View" onreceive="OnDataReceive(this)"  > 
        <xml>
            <dso  type="process" procedure="sp_pro_check_view"  > 
                <input>
                    <input bind="iduser_pk" />
                    <input bind="menu_id" />
                </input> 
                <output>
                    <output bind="txtFlag_View" />
                </output>
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
                    <output bind="lstOrg_Code" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<!------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="HR_PRO_FIND_REPORT_2" > 
                <input>
                    <input bind="txtReport_tmp" />
                    <input bind="lstOrg_Code" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>


<table name="Summary" style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1" >
    <tr  style="width:100%;height:100%" cellpadding="0" cellspacing="0" align="top" border="1">
        <td>
	        <table id="Table1" style="width:100%;height:100%" cellpadding="0" cellspacing="0" valign="top" border="1" >	
	            <tr style="height:5%">
	                <td  style="border:0" align="right" width="15%"> <a title="Click here to show Organization" onclick="OnShowPopup()" href="#tips" >Oganization</a></td>
	                <td id="Td5"  style="border:0" align="left" width="15%">
				        <gw:list  id="lstOrg_Code" value='ALL' maxlen = "100" styles='width:100%' >
                             <data>
                                <%=ESysLib.SetListDataSQL("select a.pk,lpad('.',level*2-1,'.')|| a.org_nm from tco_org a  where a.del_if = 0 and (a.tco_company_pk=nvl('" + session("COMPANY_PK") + "',a.tco_company_pk) or '" + session("HR_LEVEL") + "'='6')  AND NVL(A.END_DATE,TO_CHAR(SYSDATE+1,'YYYYMMDD')) >  TO_CHAR(SYSDATE,'YYYYMMDD') connect by prior a.pk = a.p_pk start with nvl(a.p_pk,0)=0 order siblings by a.org_id")%>|ALL|Select All
                            </data>
                        </gw:list>
			        </td>
                    <td id="Td22" style="border:0" align="left" width="5%">
                       
                    </td>
			         <td id="Td7"  style="border:0" align="right" width="10%">Existed Flag</td>
			        <td id="Td6"  style="border:0" align="left" width="10%">
			         <gw:list  id="lstExist_Flag" value='Y' maxlen = "100" styles='width:100%' >
                            <data>|Y|Yes|N|No|ALL|Select All</data></gw:list>
                       </td>  
                     <td  align="left"  style="border:0" width="15%"></td>
                   
			         <td id="Td8" style="border:0" align="left" width="5%">
                        
                    </td>
                      <td id="Td15"  style="border:0" align="center" width="10%">
				        
			        </td>
			        <td id="Td3"  style="border:0" align="center" width="4%">
				        <gw:imgBtn id="ibtnSearch" alt="Search" img="search" text="" onclick="OnSearch()" />
			        </td>
			        <td id="Td9"  style="border:0" align="center" width="4%">
				        <gw:imgBtn id="ibtnDel" alt="Delete" img="delete" text="" onclick="OnDelete()" />
			        </td>
			        <td id="Td4"  style="border:0" align="center" width="4%">
				        <gw:imgBtn id="ibtnSave" alt="Save" img="save" text="" onclick="OnSave()" />
			        </td>
                     <td id="Td9"  style="border:0" align="center" width="4%">
				        <gw:imgBtn id="ibtnReport" alt="Excel Report" img="excel" text="" onclick="OnReport()" />                        
			        </td>
                    <td id="Td10"  style="border:0" align="center" width="4%">				                               
			        </td>

			    </tr>	

                <tr style="height:5%">
	                <td  style="border:0" align="right" width="15%">
                        <gw:list  id="lstYN" value="1" styles='width:60%' onchange=""> 
							        <data>LIST|1|Existed Flag|2|Noxious Flag</data> 
					     </gw:list></td>
	                <td id="Td11"  style="border:0" align="left">
				       <gw:list  id="lstYN_Flag" value='Y' maxlen = "100" styles='width:100%' >
                            <data>|Y|Yes|N|No</data></gw:list>
			        </td>
                    <td id="Td21" style="border:0" align="left" width="5%">
                        <gw:imgBtn img="set" id="ibtnSet1"   alt="Set Grid"  onclick="OnSetGrid(1)"/>
                    </td>
			         <td id="Td12"  style="border:0" align="right" width="8%">
                          <gw:list  id="lstText" value="1" styles='width:100%' onchange=""> 
							        <data>LIST|1|Job Description|2|Remark</data> 
					     </gw:list></td>
			        <td id="Td13"  colspan=2 style="border:0" align="left" width="25%">
			            <gw:textbox id="txtInput" onenterkey   ="OnSearch()" styles="width:100%"/>
                       </td>                         
                    <td id="Td14" style="border:0" align="left" width="5%">
                        <gw:imgBtn img="set" id="ibtnSet2"   alt="Set Grid"  onclick="OnSetGrid(2)"/>
                    </td>
			        
			        <td id="Td2" colspan=5 style="border:0" align="right" width="20%">
				        <gw:label   id="lblRecord" text="" styles="width:100%" ></gw:label>
			        </td>			    

			    </tr>

        	    <tr style="height:95%">
			        <td id="Td1" width="100%" colspan=12 >
				         <gw:grid   
						id="grdData"  
						header="_Job_Desc_PK|_Org_PK|Organization|_Pos Code|Pos Name|Pos - Section|Existed Flag|Job Description|Noxious Flag|Remark"   
						format="0|0|0|0|0|0|2|0|2|0"  
						aligns="0|0|0|0|0|0|1|0|1|0"  
						defaults="|||||||||||"  
					   editcol="1|0|1|1|1|1|1|1|1|1"  
						widths="2500|0|2000|0|2100|3000|1200|3000|1200|2000"  
						styles="width:100%; height:100%"   
						sorting="T"   
						 acceptNullDate />
			        </td>
		        </tr>	
        		
	        </table>
	    </td>
	</tr>
</table>
<gw:textbox id="txtUpperOrg" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="menu_id" text="" styles="display:none"  />
<gw:textbox id="txtFlag_View" text="" styles="display:none"  />
</body>
</html>

