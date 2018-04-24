<!-- #include file="../../../system/lib/form.inc"  -->
 <%ESysLib.SetUser(Session("APP_DBUSER"))%>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<script>
var strcodereturn;
var user;
var v_language = "<%=Session("SESSION_LANG")%>";
var dis_pk="";
function BodyInit()
{       
	datAllowance.Call("SELECT");
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 10 ,  "select code,CODE_NM from vhr_hr_code where id='HR0022' order by code_nm ") %>; 
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 13 ,  "select code,CODE_NM from vhr_hr_code where id='HR0002' order by code_nm ") %>; 
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 16 ,  "select code,CODE_NM from vhr_hr_code where id='HR0021' order by code_nm ") %>; 
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 17 ,  "select code,CODE_NM from vhr_hr_code where id='HR0009' order by code_nm ") %>; //nation
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 21 ,  "select code,CODE_NM from vhr_hr_code where id='HR0011' order by code_nm ") %>; //edu type
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 24 ,  "select code,CODE_NM from vhr_hr_code where id='HR0014' order by code_nm ") %>; //place id
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 26 ,  "select code,CODE_NM from vhr_hr_code where id='HR0015' order by code_nm ") %>; //ethnic id
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 27 ,  "select code,CODE_NM from vhr_hr_code where id='HR0016' order by code_nm ") %>; //religion id
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 32 ,  "select code,CODE_NM from vhr_hr_code where id='HR0001' order by code_nm ") %>; //contract type
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 35 ,  "select code,CODE_NM from vhr_hr_code where id='HR0017' order by code_nm ") %>; //emp type
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 37 ,  "select code,CODE_NM from vhr_hr_code where id='HR0020' order by code_nm ") %>; //bank type
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 38 ,  "select code,CODE_NM from vhr_hr_code where id='HR0010' order by code_nm ") %>; //job type
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 39 ,  "select code,CODE_NM from vhr_hr_code where id='HR0008' order by code_nm ") %>; //pos type
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 40 ,  "SELECT pk,WorkGroup_NM FROM Thr_work_Group WHERE DEL_IF = 0 order by workGroup_NM") %>; //group 
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 41 ,  "SELECT A.PK,A.ORG_NM FROM TCO_ORG A WHERE A.DEL_IF=0 CONNECT BY PRIOR  A.PK=A.P_PK START WITH NVL(A.P_PK,0)=0") %>; //dept
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 56 ,  "select code,CODE_NM from vhr_hr_code where id='HR0013' order by code_nm ") %>; //social place
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 60 ,  "select code,CODE_NM from vhr_hr_code where id='HR0012' order by code_nm ") %>; //health place
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 62 ,  "select code,CODE_NM from vhr_hr_code where id='HR0004' order by code_nm ") %>; //resign
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 63 ,  "select code,CODE_NM from vhr_hr_code where id='HR0023' order by code_nm ") %>; //paytype
	<%=ESysLib.SetGridColumnComboFormat( "grdEmpHis" , 79 ,  "select code,CODE_NM from vhr_hr_code where id='HR0040' order by code_nm ") %>; //Kind money			    
	lstTemp.SetEnable(false);
	txtTemp.SetEnable(false);
}

function setGridHeader()
{
    if(grdAllowance.GetGridData(1,8)=="0")
	    grdEmpHis.GetGridControl().ColHidden(45)=true;
    else
        grdEmpHis.SetGridText(0,45,grdAllowance.GetGridData(1,0));	    
    if(grdAllowance.GetGridData(1,9)=="0")
	    grdEmpHis.GetGridControl().ColHidden(46)=true;
    else
        grdEmpHis.SetGridText(0,46,grdAllowance.GetGridData(1,1));	    
    if(grdAllowance.GetGridData(1,10)=="0")
	    grdEmpHis.GetGridControl().ColHidden(47)=true;
    else
        grdEmpHis.SetGridText(0,47,grdAllowance.GetGridData(1,2));	    
    if(grdAllowance.GetGridData(1,11)=="0")
	    grdEmpHis.GetGridControl().ColHidden(48)=true;
    else
        grdEmpHis.SetGridText(0,48,grdAllowance.GetGridData(1,3));	    
    if(grdAllowance.GetGridData(1,12)=="0")
	    grdEmpHis.GetGridControl().ColHidden(49)=true;
    else
        grdEmpHis.SetGridText(0,49,grdAllowance.GetGridData(1,4));	    
    if(grdAllowance.GetGridData(1,13)=="0")
	    grdEmpHis.GetGridControl().ColHidden(50)=true;
    else
        grdEmpHis.SetGridText(0,50,grdAllowance.GetGridData(1,5));	    
    if(grdAllowance.GetGridData(1,14)=="0")
	    grdEmpHis.GetGridControl().ColHidden(51)=true;	    	  
    else
        grdEmpHis.SetGridText(0,51,grdAllowance.GetGridData(1,6));	      	    	    	    	    
    if(grdAllowance.GetGridData(1,15)=="0")
	    grdEmpHis.GetGridControl().ColHidden(52)=true;	    
    else
        grdEmpHis.SetGridText(0,52,grdAllowance.GetGridData(1,7));/**/
}
//----------------------------------

function OnSearch()
{
    txtTemp.text=Trim(txtTemp.text);
    //alert(txtTemp.text);
    if(txtTemp.text=="" )
    {
        alert("Please input data for filtering ");
        txtTemp.text="";
        return;
    }
    datEmpHis.Call("SELECT");
}

function OnDataReceive(obj)
{
    if(obj.id=="datEmpHis")
    {
        lblRecord.text=grdEmpHis.rows-1 + " record(s)";
        for(var i=2; i<grdEmpHis.rows;i++)
        {
            for(var j=0;j<80;j++)
            if(grdEmpHis.GetGridData(i,j)!=grdEmpHis.GetGridData(i-1,j))
            {
                grdEmpHis.SetCellBgColor(i,j,i,j,0x0000FF);
            }
        }
        auto_resize_column(grdEmpHis,0,grdEmpHis.cols-1,11);
    }
    if(obj.id=="datAllowance")
    {
        setGridHeader();
    }
}

function auto_resize_column(obj,col1,col2,font_size)
{
    if(font_size!=0)
        obj.GetGridControl().FontSize =font_size;   
  obj.GetGridControl().AutoSize(col1,col2,false,0);  
}

function Trim(sString)
{
    while (sString.substring(0,1) == ' ')
    {
    sString = sString.substring(1, sString.length);
    }
    while (sString.substring(sString.length-1, sString.length) == ' ')
    {
    sString = sString.substring(0,sString.length-1);
    }
    return sString;
}

function OnShowPopup()
{
     var strcom;
    var fpath = System.RootURL + "/form/ch/ae/chae00010_search_emp.aspx" ;
    var obj  = System.OpenModal(  fpath , 900 ,600, 'resizable:yes;status:yes;');
    if (obj!=null)
        txtTemp.text=obj[1];	                       
}

function OnPopup()
{
    var url='/form/hd/ah/hdah00050_01.aspx';
    var arr=new Array();
	arr = System.OpenModal( System.RootURL + url , 500 , 600 , 'resizable:no;status:yes') ;
	if(arr!=null)
	{
        for(var i=1; i<arr.length+1;i++)
        {   
            if(arr[i]=='-1')            
                grdEmpHis.GetGridControl().ColHidden(i-1)=false;
            else           
                grdEmpHis.GetGridControl().ColHidden(i-1)=true;
        }
    }
}

</script>
<body >
<!-------------------data control----------------------->

<gw:data id="datAllowance" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="grid" function="hr_sp_sel_allowance_salary" > 
                <input bind="grdAllowance" >
                </input>
                <output  bind="grdAllowance" />
            </dso> 
        </xml> 
</gw:data>

<!------------------------------------------>
<gw:data id="datEmpHis" onreceive="OnDataReceive(this)" > 
        <xml> 
            <dso  type="grid"  function="HR_SEL_70010005"> 
                <input bind="grdEmpHis" >                    
                    <input bind="lstTemp" />
                    <input bind="txtTemp" />    
                    <input bind="dtFrom_Date" />
                    <input bind="dtTo_Date" />
                </input>
                <output  bind="grdEmpHis" />
            </dso> 
        </xml> 
</gw:data>
<!------------------------------------------------>
<gw:data id="datFind_Report" onreceive="OnDataReceive(this)"  > 
        <xml> 
            <dso  type="process" procedure="hr_sp_pro_find_report" > 
                <input>
                    <input bind="txtReport_tmp" /> 
                </input> 
                <output>
                    <output bind="txtReport_tmp" />
                </output>
            </dso> 
        </xml> 
</gw:data>  
<!-------------------data control----------------------->
   <table id="management" width="100%" cellpadding="0" cellspacing="0" border=1 style="width:100%;height:100%;">
        <tr style="width:100%;height:100%" valign="top">
            <td>
               <table width="100%" id="tblexp" style="height:100%" border=1 cellpadding="0" cellspacing="0">
                    
                    <tr style="border:0;width:100%;height:5%" valign="middle" >
                        <td  style="border:0" align="right" valign="middle"></td>
					    <td  style="border:0; width:8%" align=right>
					        <gw:list  id="lstTemp" value="2" styles='width:100%;display:none' visible="F" onchange=""> 
							        <data>LIST|1|Name|2|Emp ID|3|Card ID|4|Personal ID|5|Old Code</data> 
					        </gw:list>
					        <a title="Click here to choose" onclick="OnShowPopup()" href="#tips" >Emp ID</a>
				        </td>
                        <td colspan=1  style="border:0; width:10%"> 
					        <gw:textbox id="txtTemp" onenterkey="OnSearch()" styles='width:100%'/>
				        </td>           
				        
                        <td style="border:0" align="center">
                           
                        </td>                                     
                        <td style="border:0; width:8%" align="left">
                           
                        </td>
                        <td  style="border:0;" align="center">From</td>
				        <td  style="border:0; width:10%"><gw:datebox id="dtFrom_Date" styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td  style="border:0;" align="center">To</td>
				        <td  style="border:0;"><gw:datebox id="dtTo_Date" styles="width:100%" lang="<%=Session("Lang")%>" /></td>
				        <td style="border:0;" align="right" ></td>
				         <td colspan=2 style="border:0" align="right"><gw:label id="lblRecord"  text="0 record(s)" maxlen = "100" styles="color:red;width:90%;font-weight: bold;font-size:12" />
                        </td>
                        <td  style="border:0;" align="right" >                            
                            <gw:imgBtn img="popup" id="ibtnPopup"   alt="Choose Grid Column"  onclick="OnPopup()"/>                            
                        </td>
                       
                        <td style="border:0" align="center">                           
                           <gw:imgBtn img="search" id="ibtnSearch"   alt="Search"  onclick="OnSearch()"/>
                        </td>
                    </tr>
                    
                   
                    <tr style="border:1;width:100%;height:80%" valign="top">
                        <td colspan=15 style="width:100%;height:100%;"> 
                             <gw:grid   
                                id="grdEmpHis"  
                                header="_PK|_THR_EMP_PK|EMP_ID|OLD_ID|ID_NUM|FULL_NAME|_FULL_FNAME|_F_NAME|_L_NAME|_PHOTO_PK|STATUS|JOIN_DT|LEFT_DT|PROB_TYPE|SEX|BIRTH_DT|PLACE_BIRTH|NATION|TEL|PERMANENT_ADDR
    |PRESENT_ADDR|EDU_TYPE|PERSON_ID|ISSUE_DT|PLACE_PER_ID|MARRIED_YN|ETHNIC_TYPE|RELIG_TYPE|BEGIN_CONTRACT|END_CONTRACT|BEGIN_PROBATION
    |END_PROBATION|CONTRACT_TYPE|CONTRACT_NO|ALE_DAY_IN_YEAR|EMPLOYEE_TYPE|OT_YN|BANK_TYPE|JOB_TYPE|POS_TYPE
    |_TABLE_SALARY_PK|BASIC_SAL|PRO_SAL|ALLOW_AMT1|ALLOW_AMT2|ALLOW_AMT3|ALLOW_AMT4|ALLOW_AMT5|ALLOW_AMT6|ALLOW_AMT7|ALLOW_AMT8|UNION_YN|SOCIAL_YN
    |SOCIAL_NO|SOCIAL_PLACE|SOCIAL_DT|HEALTH_YN|HEALTH_NO|HEALTH_PLACE|HEALTH_DT|RESIGN_TYPE|PAY_TYPE|ACCOUNT|_TAC_ABPLCENTER_PK|SALARY_YN|REMARK
    |PASS_PORT_NO|PASS_PORT_DT|DEL_IF|_CRT_DT|_CRT_BY|MOD_DT|MOD_BY|CONTRACT_TIMES|_THR_SALARY_MANAGE_PK|_FULL_KNAME|CONFIRM_DT|LEVEL1_SAL|NET_SALARY_YN|MONEY_KIND" 

                                format="0|0|0|0|0|0|0|0|0|0|0|4|4|0|0|0|0|0|0|0|0|0|0|4|0|0|0|0|4|4|4|4|0|0|1|0|0|0|0|1|1|1|1|1|1|1|1|1|1|1|1|0|0|0|0|4|0|0|0|4|0|0|0|0|0|0|0|4|1|0|0|1|0|1|1|0|4|1|1|0"  
                                aligns="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                defaults="||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"  
                                editcol="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
                                widths="0|0|1000|1000|1000|2500|1500|1400|1500|1500|1500|1500|1500|1500|0"  
                                styles="width:100%; height:100%" 
                                sorting="T"    oncellclick=""
                                /> 
                        </td>
                    </tr>
               </table> 
            </td>
        </tr>
    </table>
</body>
<gw:textbox id="txtDeptData" styles="display:none"/>
<gw:textbox id="txtUpperDept" styles="display:none"/>
<gw:textbox id="txtGroupData" styles="display:none"/>
<gw:textbox id="iduser_pk" styles="display:none"/>
<gw:textbox id="txtReport_tmp" styles="display:none"/>
<gw:textbox id="txtHr_level" styles="display:none"/>
<gw:grid   
    id="grdAllowance"  
    header="Code Name 1|Code Name 2|Code Name 3|Code Name 4|Code Name 5|Code Name 6|Code Name 7|Code Name 8|Display 1|Display 2|Display 3|Display 4|Display 5|Display 6|Display 7|Display 8"
    format="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"  
    aligns="0|2|2|1|0|0|1|1|2|1|0|0|0|0|0|0"  
    defaults="||||||||||||||"  
    editcol="0|0|0|0|0|1|1|1|1|1|0|0|0|0|0|0"  
    widths="0|1500|1600|1000|2500|1500|1700|1500|1700|1500|1500|1200|1200|1200|1200|1200"  
    styles="display:none;width:100%" 
    sorting="T"    
/>
</html>
